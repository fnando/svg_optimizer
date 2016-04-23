# frozen_string_literal: true
require "nokogiri"

require "svg_optimizer/version"
require "svg_optimizer/plugins/base"
require "svg_optimizer/plugins/cleanup_attribute"
require "svg_optimizer/plugins/cleanup_id"
require "svg_optimizer/plugins/collapse_groups"
require "svg_optimizer/plugins/remove_comment"
require "svg_optimizer/plugins/remove_metadata"
require "svg_optimizer/plugins/remove_empty_text_node"
require "svg_optimizer/plugins/remove_empty_container"
require "svg_optimizer/plugins/remove_editor_namespace"
require "svg_optimizer/plugins/remove_hidden_element"
require "svg_optimizer/plugins/remove_raster_image"
require "svg_optimizer/plugins/remove_empty_attribute"
require "svg_optimizer/plugins/remove_unused_namespace"
require "svg_optimizer/plugins/remove_useless_stroke_and_fill"

module SvgOptimizer
  PLUGINS = %w[
    CleanupAttribute
    CleanupId
    RemoveComment
    RemoveMetadata
    RemoveEditorNamespace
    RemoveHiddenElement
    RemoveUnusedNamespace
    RemoveRasterImage
    RemoveEmptyAttribute
    CollapseGroups
    RemoveUselessStrokeAndFill
    RemoveEmptyTextNode
    RemoveEmptyContainer
  ]

  def self.optimize(contents, opts = {})
    opts = { without: [] }.merge(opts)

    normalize_opt!(opts, :with)
    normalize_opt!(opts, :without)

    selected_plugins = (opts[:with] || opts[:without]).map do |plugin_name|
      plugin_name.to_s.capitalize.gsub(/_([a-z]{1})/){ $1.capitalize }
    end

    plugins = PLUGINS.reject do |plugin_name|
      plugin_included = selected_plugins.include?(plugin_name)

      opts[:with] ? !plugin_included : plugin_included
    end

    xml = Nokogiri::XML(contents)
    plugins.each do |plugin_name|
      Plugins.const_get(plugin_name).new(xml).process
    end

    xml.root.to_xml
  end

  def self.optimize_file(path, target = path, opts = {})
    contents = optimize(File.read(path), opts)

    File.open(target, "w") {|file| file << contents }
    true
  end

  private
  def self.normalize_opt!(opts, key)
    opt = opts[key]
    opts[key] = [opt] if opt && ( opt.is_a?(String) || opt.is_a?(Symbol) )
  end
end
