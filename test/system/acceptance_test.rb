require "application_system_test_case"

class AcceptanceTest < ApplicationSystemTestCase
  test "Creating a room" do
    visit root_path
    click_on "Create a room"
    assert_text 'You are the host'
  end

  test "Entering a new room as a player" do
    using_session("host's session") do
      visit root_path
      click_on "Create a room"
      assert_text 'You are the host'
    end

    using_session("player's session") do
      visit room_path 1
      assert_text 'Waiting for players to join'

      fill_in 'player_name', with: 'Alice'
      click_button 'Join room'

      assert_text 'Alice'
    end
  end

  test "Multiple players" do
    using_session("host's session") do
      visit root_path
      click_on "Create a room"
      assert_text 'You are the host'
    end

    using_session("player 1's session") do
      visit room_path 1
      assert_text 'Waiting for players to join'

      fill_in 'player_name', with: 'Alice'
      click_button 'Join room'

      assert_text 'Alice'
    end

    using_session("player 2's session") do
      visit room_path 1

      fill_in 'player_name', with: 'Bob'
      click_button 'Join room'

      assert_text 'Alice'
      assert_text 'Bob'
    end
  end

  test "Visiting room 2 after joining room 1" do
    using_session("host's session") do
      visit root_path
      click_on "Create a room"
      assert_text 'You are the host'
    end

    using_session("player's session") do
      visit room_path 1
      assert_text 'Waiting for players to join'
      assert_text 'Name'

      fill_in 'player_name', with: 'Alice'
      click_button 'Join room'

      assert_text 'Alice'
    end

    using_session("host's session") do
      visit root_path
      click_on "Create a room"
      assert_text 'You are the host'
    end

    using_session("player's session") do
      visit room_path 2
      assert_text 'Waiting for players to join'
      assert_text 'Name'
    end
  end
end
