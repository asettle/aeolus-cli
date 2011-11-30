#   Copyright 2011 Red Hat, Inc.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

require 'spec_helper'

module Aeolus
  module CLI
    describe DeleteCommand do
      it "should delete a provider image of a given id" do
        @options = {:providerimage => "20bb51cb-a289-4331-9e56-26196df62ca8"}
        VCR.use_cassette('command/delete_command/delete_provider_image') do
          dc = DeleteCommand.new(@options)
          begin
            dc.provider_image
          rescue SystemExit => e
            e.status.should == 0
          end
          $stdout.string.should include("Provider Image: 20bb51cb-a289-4331-9e56-26196df62ca8 Deleted Successfully")
        end
      end

      it "should delete an target image of a given id" do
        VCR.use_cassette('command/delete_command/delete_target_image') do
          @options = {:targetimage => "ef7ee9be-5f3c-4695-969a-7c3fa996c048"}
          dc = DeleteCommand.new(@options)
          begin
            dc.target_image
          rescue SystemExit => e
            e.status.should == 0
          end
          $stdout.string.should include("Target Image: ef7ee9be-5f3c-4695-969a-7c3fa996c048 Deleted Successfully")
        end
      end

      it "should delete a build of a given id" do
        @options = {:build => "becc269c-8a02-4f6a-9132-2af3cb580b2b"}
        VCR.use_cassette('command/delete_command/delete_build') do
          dc = DeleteCommand.new(@options)
          begin
            dc.build
          rescue SystemExit => e
            e.status.should == 0
          end
          $stdout.string.should include("Build: becc269c-8a02-4f6a-9132-2af3cb580b2b Deleted Successfully")
        end
      end

      it "should delete an image of a given id" do
        VCR.use_cassette('command/delete_command/delete_image') do
          @options = {:image => "55bc53d9-7310-4cff-8c26-99823d79dfa6"}
          dc = DeleteCommand.new(@options)
          begin
            dc.image
          rescue SystemExit => e
            e.status.should == 0
          end
          $stdout.string.should include("Image: 55bc53d9-7310-4cff-8c26-99823d79dfa6 Deleted Successfully")
          $stdout.string.should include("N.B. The following provider content must be manually removed")
          $stdout.string.should include("mock")
        end
      end
    end
  end
end