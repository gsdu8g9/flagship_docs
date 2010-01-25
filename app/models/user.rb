class User < ActiveRecord::Base

  #Validations
  validates_presence_of :username, :full_name

  #Relationships
  has_and_belongs_to_many :groups
  has_many :revisions
  has_many :documents
  has_many :groups_led, :class_name => 'Group' , :foreign_key => 'group_leader_id'

  #Authenticates Access
  #is_admin can only be set by an admin
  authenticates_writes_to :is_admin, :with_accessor_method => :is_admin
  #users can only be saved by self or an admin.
  authenticates_saves :with => :allow_owner
  authenticates_saves :with_accessor_method => :is_admin
  has_owner :self

  #Determine if a user is in a group or not
  def in_group
    !self.groups.nil?
  end

end
