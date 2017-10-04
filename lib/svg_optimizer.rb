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
require "svg_optimizer/plugins/remove_title"
require "svg_optimizer/plugins/remove_description"

module SvgOptimizer
  DEFAULT_PLUGINS = %w[
    RemoveTitle
    RemoveDescription
    RemoveUnusedNamespace
    CleanupAttribute
    CleanupId
    RemoveComment
    RemoveMetadata
    RemoveEditorNamespace
    RemoveHiddenElement
    RemoveRasterImage
    RemoveEmptyAttribute
    CollapseGroups
    RemoveUselessStrokeAndFill
    RemoveEmptyTextNode
    RemoveEmptyContainer
  ].map {|name| Plugins.const_get(name) }

  def self.optimize(contents, plugins = DEFAULT_PLUGINS)
    xml = Nokogiri::XML(contents)
    plugins.each {|plugin| plugin.new(xml).process }
    xml.root.to_xml
  end

  def self.optimize_file(path, target = path, plugins = DEFAULT_PLUGINS)
    contents = optimize(File.read(path), plugins)
    File.open(target, "w") {|file| file << contents }
    true
  end
end
