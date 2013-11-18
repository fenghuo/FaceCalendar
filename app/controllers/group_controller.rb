require 'Groups_model.rb'
require 'User_model.rb'

class GroupController < ApplicationController

    # SHOW MY OWN GROUPS
  	def show
  		show_own
  	end

    # SHOW MY OWN GROUPS
  	def show_own
      #@my_uid = session[:user_id];
    	@my_uid = 1;
         
      @my_own_group_ids_ = nil;
      @my_own_group_ids = [];
      @my_own_group_names = [];
      @my_own_group_info = [];
      @my_own_group_num = 0;
      group_info = nil;

      if (@my_uid != nil)
        @my_own_group_ids_ = Group.FindOnesGroup(@my_uid);
        if (@my_own_group_ids_ != nil)
          @my_own_group_num = @my_own_group_ids_.count;
          @my_own_group_ids_.each do |row|
            @my_own_group_ids << row["id"];
            #@my_joined_group_sizes << group_info["size"];
            @my_own_group_info << Group.GetById(row["id"]).first;
          end
        end
      end

      if (params[:page_id] == nil)
        @pid = 1;
      else
        @pid = Integer(params[:page_id]);
      end
    #render 'group/test'
    show_own_page
    end

    # SET @group_per_page
  	def show_own_page
      @group_per_page = 5;
  	end

    # SHOW MY JOINED GROUP
  	def show_joined
      #@my_uid = session[:user_id];
  		@my_uid = 1;
      
  		if (params[:page_id] == nil)
  			@pid = 1;
  		else
  			@pid = Integer(params[:page_id]);
  		end

			#@my_uid = session[:user_id];		
			#@my_joined_groups = nil;
			@my_joined_group_ids = [];
			@my_joined_group_names = [];
      @my_joined_group_info = [];
			group_info = nil;

			if (@my_uid != nil)
				#@my_joined_groups = Group.FindOnesJoinedGroup(@my_uid);
        @my_joined_groups_with_name = Group.FindOnesJoinedGroupWithGroupName(@my_uid);
				@my_joined_groups_with_name.each do |row|
					@my_joined_group_ids << row["id"];
					@my_joined_group_names << row["name"];
          #@my_joined_group_sizes << group_info["size"];
          @my_joined_group_info << Group.GetById(row["id"]).first;
				end
			end
		#render 'group/test'
		show_joined_page
  	end

    # SET @group_per_page
  	def show_joined_page
  		@group_per_page = 5;
  	end

    # SHOW GROUP MEMBERS
  	def get_members
  		@member_ids = nil;
      @member_info = [];
      @member_userid = [];
  		@user_per_page = 12;
  		if (@gid != nil)
        @member_ids = Group.FindGroupMembers(@gid);
        @member_ids.each do |user|
          @member_info << User.Get(user["userid"]);
          @member_userid << user["userid"];
        end
		  end
		  return @member_ids;
  	end

    # SHOW GROUP PROFILE
  	def show_profile
  		@gid = Integer(params[:group_id]);
  		@ginfo = nil;
  		if (@gid != nil)
  			@ginfo = Group.GetById(@gid);
  			get_members;
  		end  

  		@pid = nil;
  		if (params[:page_id] == nil)
  			@pid = 1;
  		else
  			@pid = Integer(params[:page_id]);
  		end
  	end

    # SEARCH USERS
  	def search_user
      if (@gid == nil)
        @gid = Integer(params[:group_id]);
      end

      @ginfo = nil;
      @member_ids = nil;
      @member_userid = [];
      if (@gid != nil)
        @ginfo = Group.GetById(@gid);
        @member_ids = Group.FindGroupMembers(@gid);
        @member_ids.each do |user|
          @member_userid << user["userid"];
        end
      end

      @user_per_page = 12;

      if (params[:page_id] == nil)
        @pid = 1;
      else
        @pid = Integer(params[:page_id]);
      end     

      @rs_search_name = params[:search_uname];
      if (@rs_search_name == nil)
        @rs_search_name = params[:add_uname];
      end

      @rs_search = nil;
      @rs_search_info = [];
      @rs_search_ids = [];
      @rs_membership = [];

      if(@rs_search_name != nil)
        @rs_search = User.Search(@rs_search_name);  
        @rs_search.each do |row|
          @rs_search_info << row;
          @rs_search_ids << row["id"];
          @rs_membership << @member_userid.include?(row["id"]);
        end
      end
  	end

    # SEARCH GROUPS
  	def search_group
      @grs_search_name = params[:search_gname];
      @pid = params[:page_id];

      if (@grs_search_name == nil)
        @grs_search_name = params[:gname];
      end

      if (params[:page_id] == nil)
        @pid = 1;
      else
        @pid = Integer(params[:page_id]);
      end     

      @grs_search = nil;
      @grs_search_info = [];
      if(@grs_search_name != nil)
        @grs_search = Group.SearchByName(@grs_search_name);  
        @grs_search.each do |row|
          @grs_search_info << row;
        end
      end    
  	end

    # ADD A MEMBER TO A GROUP
  	def add_member
  		#@my_uid = session[:user_id];
  		@my_uid = 1;
  		@add_to_gid = Integer(params[:add_to_group_id]);
  		Group.AddMember(@add_to_gid, @my_uid, 'description');
  		redirect_to '/group/show_joined'
  	end

    def add_other_member
      @add_uid = Integer(params[:add_user_id]);
      @add_to_gid = Integer(params[:add_to_group_id]);
      Group.AddMember(@add_to_gid, @add_uid, 'description');
      redirect_to '/group/show_profile/' + @add_to_gid.to_s
    end


    # DELETE A MEMBER FROM A GROUP
    def delete_member
      @delete_uid = Integer(params[:delete_user_id]);
      @delete_from_gid = Integer(params[:delete_from_group_id]);
      Group.DeleteMember(@delete_from_gid, @delete_uid);
      redirect_to '/group/show_profile/' + @delete_from_gid.to_s
    end

    # QUIT A GROUP BY ONESELF
    def quit_group
      #@my_uid = session[:user_id];
      @my_uid = 1;
      @quit_gid = Integer(params[:quit_group_id]);
      Group.DeleteMember(@quit_gid, @my_uid);
      redirect_to '/group/show_joined'
    end

    # CREATE A GROUP
    def create_group     
      @grs_create_name = params[:gname];
      @grs_create_category_ = params[:gcategory];
      @grs_create_category = [];
      @grs_create_description = params[:gdescription];
      @grs_create_icon = params[:gicon];
      @created_group_id = nil;

      if (@grs_create_category_ != nil)
        if (@grs_create_description != nil)
          @grs_create_description = @grs_create_description.gsub(/'/, '_Single_Quotation_Marks_Placeholder_');
        end
        if (/,/.match(@grs_create_category_) != nil )
          @grs_create_category_ = @grs_create_category_.split(','); 
          @grs_create_category_.each do |tag|
            @grs_create_category << tag.strip;
          end
        else
          @grs_create_category = @grs_create_category_;
        end
      else
        @grs_create_category = nil;
      end

      #@my_uid = session[:user_id];
      @my_uid = 1;
      @created_group_id = Group.Create(@grs_create_name, @grs_create_category_,@grs_create_description, @my_uid, 0, @grs_create_icon);
      Group.AddMember(@created_group_id, @my_uid, 'description');
      if (params[:gname] != nil)
        redirect_to '/group/show_profile/'+@created_group_id.to_s
      end
    end

end