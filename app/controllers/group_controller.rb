require 'group.rb'

class GroupController < ApplicationController

	def show_frame
	end

	def show_own
		#@my_uid = session[:user_id];
		@my_uid = 1;

		@my_own_groups = nil;
		@my_own_group_names = [];
		
		if (@my_uid != nil)
			@my_own_groups = Group.find_ones_group(@my_uid);
			@my_own_groups.each do |row|
				gid = row[:groupid];
				@my_own_group_names << Group.find_group_name(gid);
			end
		end
	end

	def show_joined
		#@my_uid = session[:user_id];
		@my_uid = 1;
		
		@my_joined_groups = nil;
		@my_joined_group_names = [];
		
		if (@my_uid != nil)
			@my_joined_groups = Group.find_ones_joined_group(@my_uid);
			@my_joined_groups.each do |row|
				gid = row[:groupid];
				@my_joined_group_names << Group.find_group_name(gid);
			end
		end
	end

	def show_members
		@rs = nil;
		if (params[:groupid] != nil)
			@rs = Group.find_group_members(params[:groupid]);
		end
		return @rs;
	end

end