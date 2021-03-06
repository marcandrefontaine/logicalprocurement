# Copyright (C) 2007  Coupa Software Incorporated http://www.coupa.com
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

require File.dirname(__FILE__) + '/../test_helper'
require 'uoms_controller'

# Re-raise errors caught by the controller.
class UomsController; def rescue_action(e) raise e end; end

class UomsControllerTest < Test::Unit::TestCase
  fixtures :roles,:users,:users_roles,:uoms

  def setup
    @controller = UomsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login(:users_001)
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'list'
  end

  def test_list
    get :list

    assert_response :success
    assert_template 'list'

    assert_not_nil assigns(:uoms)
  end

  def test_show
    get :show, :id => 1

    assert_response :success
    assert_template 'show'

    assert_not_nil assigns(:uom)
    assert assigns(:uom).valid?
  end

  def test_new
    get :new

    assert_response :success
    assert_template 'new'

    assert_not_nil assigns(:uom)
  end

  def test_create
    num_uoms = Uom.count

    post :create, :uom => {}

    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_equal num_uoms + 1, Uom.count
  end

  def test_edit
    get :edit, :id => 1

    assert_response :success
    assert_template 'edit'

    assert_not_nil assigns(:uom)
    assert assigns(:uom).valid?
  end

  def test_update
    post :update, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'show', :id => 1
  end

  def test_destroy
    assert_not_nil Uom.find(1)

    post :destroy, :id => 1
    assert_response :redirect
    assert_redirected_to :action => 'list'

    assert_raise(ActiveRecord::RecordNotFound) {
      Uom.find(1)
    }
  end
end
