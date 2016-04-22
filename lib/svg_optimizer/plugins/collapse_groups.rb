module SvgOptimizer
  module Plugins
    class CollapseGroups < Base
      def process
        xml.css('g:not(:empty)').each do |group|
          collapse(group)
        end
      end

      private

      def collapse(group)
        collapse_attributes(group)
        group.swap(group.children) if collapse?(group)
      end

      def collapse_attributes(group)
        child = group.first_element_child
        return unless collapse_attributes?(group, child)

        group.attributes.each do |attr, val|
          if %w(transform class).include?(attr)
            child[attr] = [val, child[attr]].compact.join(' ')
          else
            child[attr] ||= val
          end
          group.delete(attr)
        end
      end

      def collapse?(group)
        group.attributes.empty? &&
          !group.element_children.map(&:name).include?('animate')
      end

      def collapse_attributes?(group, child)
        return false unless group.attributes.any?
        return false unless group.element_children.length == 1
        return false if child.has_attribute?('id')
        return false unless !group.has_attribute?('clip-path') ||
          child.name == 'g' &&
          !group.has_attribute?('transform') &&
          !child.has_attribute?('transform')
        true
      end
    end
  end
end
