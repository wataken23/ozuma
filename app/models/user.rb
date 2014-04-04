# -*- coding: utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :account, :email, :grade, :password, :role_id, :username, :password_confirmation, :acception, :owner#, :password_digest
  has_many :myfiles
  belongs_to :role

#=begin
  has_secure_password 
  validates_presence_of :password, :on => :create 
  validates :account, :presence => true, 
                      :uniqueness => true, 
  :format => { :with => /(\w|\d)+/,
    :message => "は半角英数字で記入して下さい" }, 
                      :on => :create
  validates :username, :presence => true, :on => :create
  validates :role_id, :presence => true, :numericality => true, :on => :create
  validates :grade, :presence => true,  
  :format => { :with => /^[A-Z]\d$/,
                         :message => "は '大文字アルファベット + 数字' で記入してください"
  },
            :on => :create
  validates :email, :presence => true,  
            :uniqueness => true, 
  :format => { :with => /^\S*\S@\S*/,
                         :message => "を確認してください. "
  },
            :on => :create
  validates :owner, :presence => true,  
  :format => { :with => /(\w|\d)+/,
                         :message => "は半角英数字で記入してください. "
  },
            :on => :create
#=end
end
