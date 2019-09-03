require_relative "../lib/board.rb"

describe "CREATE A PROJECT" do
  before do
    Board.delete_all
  end

  it "a project has a title" do
    board = Board.new(title: "test")
    expect(board.title).to eq("test")
  end

  it "you can create a project on the project page" do
    expect(Board.all.count).to eq(0)

    visit "/boards"
    fill_in(:title, with: "New test board")
    click_button "Create Board +"
    expect(page).to have_text("New test board")
    expect(Board.all.count).to be(1)
  end
end