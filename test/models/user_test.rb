require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "valid factory" do
    assert FactoryGirl.build(:user).valid?
  end

  test "invalid without name" do
    assert FactoryGirl.build(:user, name: nil).invalid?
  end

  test "invalid without password if reset password nil" do
    assert FactoryGirl.build(:user, password: nil).invalid?
  end

  test "invalid without email" do
    assert FactoryGirl.build(:user, email: nil).invalid?
  end

  test "invalid without type" do
    assert FactoryGirl.build(:user, student_type: nil).invalid?, "Student type can't be nil"
  end

  test "check email and password on login" do
    user = FactoryGirl.create(:user, password: 'something', password_confirmation: 'something')
    assert_equal user, User.find_by(email: user.email).authenticate('something')
    assert User.login(user.email, 'something'), 'login with email and password fail'
  end

  test "password" do
    user = FactoryGirl.create(:user, password: 'something clear', password_confirmation: 'something clear')
    assert_not_equal 'something clear', user.password_digest
  end

  test "remote? true when remote student" do
    user = FactoryGirl.create(:user, student_type: User::REMOTE)
    assert user.remote?
  end

  test "remote? false when remote student" do
    user = FactoryGirl.create(:user, student_type: User::LOCAL)
    assert ! user.remote?
  end

  test "local? true when presential student" do
    user = FactoryGirl.create(:user, student_type: User::LOCAL)
    assert user.local?
  end

  test "local? false when presential student" do
    user = FactoryGirl.create(:user, student_type: User::REMOTE)
    assert ! user.local?
  end

  test "generate reset_password_key!" do
    user = FactoryGirl.create(:user, reset_password_key: nil)
    user.generate_reset_password_key!
    assert_not_nil user.reset_password_key
  end

  test "reset_password" do
    user = FactoryGirl.create(:user, reset_password_key: nil)
    User.reset_password(user.email)
    assert_not_nil user.reload.reset_password_key
  end

  test "reset_password false if user not found" do
    assert ! User.reset_password('fakeemail@laposte.net'), "reset password should return false"
  end

  test "update_password" do
    user = FactoryGirl.create(:user, reset_password_key: 'ert')
    user.update_password('truc', 'truc')
    assert_equal '', user.reload.reset_password_key
    assert user.authenticate('truc')
  end

  test "inscription remote" do
    assert_nil User.find_by(email: 'an@email.net')
    result = User.inscription('an@email.net')
    assert_kind_of User, result
    user = User.find_by(email: 'an@email.net')
    assert_not_nil user.reset_password_key
    assert user.remote?, "User was not created as remote user"
  end

  test "inscription local" do
    assert_nil User.find_by(email: 'an@email.net')
    result = User.inscription_local('an@email.net')
    assert_kind_of User, result
    user = User.find_by(email: 'an@email.net')
    assert_not_nil user.reset_password_key
    assert user.local?, "User was not created as local user"
  end

  test "list only authors" do
    author = FactoryGirl.create(:user, student_type: User::LOCAL)
    staff = FactoryGirl.create(:user, student_type: User::STAFF)
    remote = FactoryGirl.create(:user, student_type: User::REMOTE)
    assert_equal [author], User.authors
  end

  test "staff? " do
    user = FactoryGirl.create(:user, student_type: User::STAFF)
    assert user.staff?
    user = FactoryGirl.create(:user, student_type: User::REMOTE)
    assert !user.staff?
  end

  test "login without case" do
    FactoryGirl.create(:user, email: 'rogercyr.aplogan@gmail.com', password: 'tructruc', password_confirmation: 'tructruc')
    assert User.login('RogerCyr.Aplogan@gmail.com', 'tructruc')
  end

  test "can validate for chapter when type present" do
    user = FactoryGirl.create(:user, student_type: User::LOCAL)
    chapter = FactoryGirl.create(:chapter)
    assert user.can_validate_for?(chapter), "Present user can validate submission"
  end

  test "can validate for chapter where self submission already validated" do
    user = FactoryGirl.create(:user)
    chapter = FactoryGirl.create(:chapter)
    FactoryGirl.create(:submission, chapter: chapter, user: user, first_validation_status: true, second_validation_status: true)
    assert user.can_validate_for?(chapter), "Remote user can validate when self submission have been validated"
  end

  test "has many chapters" do
    user = FactoryGirl.create(:user)
    chapter = FactoryGirl.create(:chapter, authors: [user])
    FactoryGirl.create(:chapter)
    assert_equal [chapter], user.chapters
  end

end
