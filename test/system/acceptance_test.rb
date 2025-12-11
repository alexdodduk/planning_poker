require "application_system_test_case"

class AcceptanceTest < ApplicationSystemTestCase
  test "Creating a room" do
    visit root_path
    click_on "Create a room"
    assert_text "You are the host"
  end

  test "Entering a new room as a player" do
    # host's session
    visit root_path
    click_on "Create a room"
    assert_text "You are the host"
    room_url = current_path

    using_session("player's session") do
      visit room_url
      assert_text "Waiting for players to join"

      fill_in "player_name", with: "Alice"
      click_button "Join room"

      assert_text "Alice"
    end
  end

  test "Multiple players" do
    # host's session
    visit root_path
    click_on "Create a room"
    assert_text "You are the host"
    room_url = current_path

    using_session("player 1's session") do
      visit room_url
      assert_text "Waiting for players to join"

      fill_in "player_name", with: "Alice"
      click_button "Join room"

      assert_text "Alice"
    end

    using_session("player 2's session") do
      visit room_url

      fill_in "player_name", with: "Bob"
      click_button "Join room"

      assert_text "Alice"
      assert_text "Bob"
    end
  end

  test "Visiting room 2 after joining room 1" do
    # host's session
    visit root_path
    click_on "Create a room"
    assert_text "You are the host"
    room_url = current_path

    using_session("player's session") do
      visit room_url
      assert_text "Waiting for players to join"
      assert_text "Name"

      fill_in "player_name", with: "Alice"
      click_button "Join room"

      assert_text "Alice"
    end

    # host's session
    visit root_path
    click_on "Create a room"
    assert_text "You are the host"

    using_session("player's session") do
      visit room_path 2
      assert_text "Waiting for players to join"
      assert_text "Name"
    end
  end

  test "Revealing scores and resetting room" do
    # host's session
    visit root_path
    click_on "Create a room"
    assert_text "You are the host"
    room_url = current_path

    using_session("player 1's session") do
      visit room_url
      assert_text "Waiting for players to join"

      fill_in "player_name", with: "Alice"
      click_button "Join room"

      assert_text "Score (Alice)"

      # Cast a vote
      find("label[for='player_score_8']").click
    end

    # Host reveals votes
    click_on "Reveal"
    assert_selector ".card.revealed", text: "8"

    # Host resets votes
    click_on "Reset"
    assert_no_selector ".revealed"
  end

  test "host can end the game" do
    # host's session
    visit root_path
    click_on "Create a room"
    assert_text "You are the host"
    room_url = current_path

    using_session("player 1's session") do
      visit room_url
      fill_in "player_name", with: "Alice"
      click_button "Join room"

      find("legend", text: "Score (Alice)")
    end

    # host's session
    assert_text "Alice"
    click_on "End game"
    find("#notice", text: "Game has ended, thanks for playing!")
  end
end
