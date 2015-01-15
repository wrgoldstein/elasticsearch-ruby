require 'test_helper'

module Elasticsearch
  module Test
    class SearchOptionsTest < ::Test::Unit::TestCase
      subject { Elasticsearch::DSL::Search::Options.new }

      context "Search options" do
        should "combine different options" do
          subject.from 10
          subject.size 20
          subject.version true
          subject.highlight foo: 'bar'

          assert_equal({from: 10, size: 20, version: true, highlight: { foo: 'bar' }}, subject.to_hash)
        end

        should "encode from" do
          subject.from 10
          assert_equal({from: 10}, subject.to_hash)
        end

        should "encode size" do
          subject.size 20
          assert_equal({size: 20}, subject.to_hash)
        end

        should "encode _source" do
          subject._source false
          assert_equal( { _source: false }, subject.to_hash )

          subject._source 'foo.*'
          assert_equal( { _source: 'foo.*' }, subject.to_hash )

          subject._source ['foo', 'bar']
          assert_equal( { _source: ['foo', 'bar'] }, subject.to_hash )

          subject._source include: ['foo.*'], exclude: ['bar.*']
          assert_equal( { _source: { include: ['foo.*'], exclude: ['bar.*'] } }, subject.to_hash )

          subject.source false
          assert_equal( { _source: false }, subject.to_hash )
        end

        should "encode fields" do
          subject.fields ['foo']
          assert_equal( { fields: ['foo'] }, subject.to_hash )
        end

        should "encode script_fields" do
          subject.script_fields ['foo']
          assert_equal( { script_fields: ['foo'] }, subject.to_hash )
        end

        should "encode fielddata_fields" do
          subject.fielddata_fields ['foo']
          assert_equal( { fielddata_fields: ['foo'] }, subject.to_hash )
        end

        should "encode highlight" do
          subject.highlight foo: 'bar'
          assert_equal( { highlight: { foo: 'bar' } }, subject.to_hash )
        end

        should "encode rescore" do
          subject.rescore foo: 'bar'
          assert_equal( { rescore: { foo: 'bar' } }, subject.to_hash )
        end

        should "encode explain" do
          subject.explain true
          assert_equal( { explain: true }, subject.to_hash )
        end

        should "encode version" do
          subject.version true
          assert_equal( { version: true }, subject.to_hash )
        end

        should "encode indices_boost" do
          subject.indices_boost foo: 'bar'
          assert_equal( { indices_boost: { foo: 'bar' } }, subject.to_hash )
        end

        should "encode min_score" do
          subject.min_score 0.5
          assert_equal( { min_score: 0.5 }, subject.to_hash )
        end
      end
    end
  end
end
