module Elasticsearch
  module DSL
    module Search
      module Filters

        # Indices filter
        #
        # @example
        #
        # @see http://elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-indices-filter.html
        #
        class Indices
          include BaseComponent

          option_method :indices

          # DSL method for building the `filter` part of the query definition
          #
          # @return [self]
          #
          def filter(*args, &block)
            @filter = block ? Filter.new(*args, &block) : args.first
            self
          end

          # DSL method for building the `no_match_filter` part of the query definition
          #
          # @return [self]
          #
          def no_match_filter(*args, &block)
            @no_match_filter = block ? Filter.new(*args, &block) : args.first
            self
          end

          # Converts the query definition to a Hash
          #
          # @return [Hash]
          #
          def to_hash
            hash = super
            if @filter
              _filter = @filter.respond_to?(:to_hash) ? @filter.to_hash : @filter
              hash[self.name].update(filter: _filter)
            end
            if @no_match_filter
              _no_match_filter = @no_match_filter.respond_to?(:to_hash) ? @no_match_filter.to_hash : @no_match_filter
              hash[self.name].update(no_match_filter: _filter)
            end
            hash
          end
        end

      end
    end
  end
end
