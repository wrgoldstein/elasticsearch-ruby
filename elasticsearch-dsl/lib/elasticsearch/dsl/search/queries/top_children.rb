module Elasticsearch
  module DSL
    module Search
      module Queries

        # TopChildren query
        #
        # @example
        #
        # @see http://elasticsearch.org/guide/en/elasticsearch/reference/current/query-dsl-top-children-query.html
        #
        class TopChildren
          include BaseComponent

          option_method :type
          option_method :score
          option_method :factor
          option_method :incremental_factor
          option_method :_scope

          # DSL method for building the `query` part of the query definition
          #
          # @return [self]
          #
          def query(*args, &block)
            @query = block ? @query = Query.new(*args, &block) : args.first
            self
          end

          # Converts the query definition to a Hash
          #
          # @return [Hash]
          #
          def to_hash
            hash = super
            if @query
              _query = @query.respond_to?(:to_hash) ? @query.to_hash : @query
              hash[self.name].update(query: _query)
            end
            hash
          end
        end

      end
    end
  end
end
