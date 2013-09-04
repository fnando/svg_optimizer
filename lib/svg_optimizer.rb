require "nokogiri"

require "svg_optimizer/version"
require "svg_optimizer/plugins/base"
require "svg_optimizer/plugins/cleanup_attribute"
require "svg_optimizer/plugins/cleanup_id"
require "svg_optimizer/plugins/remove_comment"
require "svg_optimizer/plugins/remove_metadata"
require "svg_optimizer/plugins/remove_empty_container"
require "svg_optimizer/plugins/remove_editor_namespace"
require "svg_optimizer/plugins/remove_hidden_element"
require "svg_optimizer/plugins/remove_raster_image"
require "svg_optimizer/plugins/remove_empty_attribute"
require "svg_optimizer/plugins/remove_empty_text_node"
require "svg_optimizer/plugins/remove_unused_namespace"

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
    RemoveEmptyTextNode
    RemoveEmptyContainer
  ]

  def self.optimize(contents)
    xml = Nokogiri::XML(contents)
    PLUGINS.each do |plugin_name|
      Plugins.const_get(plugin_name).new(xml).process
    end

    xml.root.to_xml
  end

  def self.optimize_file(path, target = path)
    contents = optimize(File.read(path))

    File.open(target, "w") {|file| file << contents }
    true
  end
end
