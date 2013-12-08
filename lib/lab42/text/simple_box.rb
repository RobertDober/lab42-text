require 'lab42/core/kernel'

module Lab42
  module Text
    class SimpleBox
      def render options = {}
        set_options! options
        [ 
          header_line,
          *bordered_lines,
          footer_line
        ]
      end

      private
      def bordered_lines
        @__bordered_lines__ ||=
          @lines.map{ | line | "#{lhs_border} #{line}#{" " * ( max_len - line.size )} #{rhs_border}" }
      end

      def footer_line
        @__footer_line__ ||=
          "#{left_upper_corner}#{upper_border * max_len.succ.succ}#{right_upper_corner}"
      end

      def header_line
        @__header_line__ ||=
          "#{left_lower_corner}#{lower_border * max_len.succ.succ}#{right_lower_corner}" end

      def initialize lines
        @lines = lines.dup
      end
      
      def left_lower_corner 
        @__left_lower_corner__ ||=
          @options.values_at( :left_lower_corner, :lower_corner, :left_corner, :corner, :border ).compact.first || '+'
      end

      def left_upper_corner 
        @__left_upper_corner__ ||=
          @options.values_at( :left_upper_corner, :upper_corner, :left_corner, :corner, :border ).compact.first || '+'
      end

      def lhs_border
        @__lhs_border__ ||=
          @options.values_at( :lhs_border, :lateral_border, :border ).compact.first || '|'
      end

      def lower_border
        @__lower_border__ ||=
          @options.values_at( :lower_border, :vertical_border, :border ).compact.first || '-'
      end

      def max_len
        @__max_len__ ||= @lines.max_by(&sendmsg(:size)).size
      end

      def rhs_border
        @__rhs_border__ ||=
          @options.values_at(:rhs_border, :lateral_border, :border ).compact.first || '|'
      end

      def right_lower_corner 
        @__right_lower_corner__ ||=
          @options.values_at( :right_lower_corner, :lower_corner, :right_corner, :corner, :border ).compact.first || '+'
      end

      def right_upper_corner 
        @__right_upper_corner__ ||=
          @options.values_at( :right_upper_corner, :upper_corner, :right_corner, :corner, :border ).compact.first || '+'
      end
      
      def set_options! options; @options = options.dup end

      def upper_border
        @__upper_border__ ||=
          @options.values_at( :upper_border, :vertical_border, :border ).compact.first || '-'
      end
    end
  end # module Text
end # module Lab42
