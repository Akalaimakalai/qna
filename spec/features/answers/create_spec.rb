# Пользователь, находясь на странице вопроса, может написать ответ на вопрос
# (т.е. форма нового ответа должна быть прямо на странице вопроса, без перехода на другую страницу)

require 'rails_helper'

feature 'User can write answer', %q{
  In order to answer the question
  As an authenticated user
  I'd like to be able to write an answer below the question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  describe 'Authenticated user' do

    background do
      sign_in(user)

      visit question_path(question)
    end

    scenario 'tries to add answer with valid params' do
      fill_in 'Body', with: 'Answer text'
      click_on 'Add answer'

      expect(page).to have_content(question.body)
      expect(page).to have_content('Answer text')
    end

    scenario 'tries to add answer with invalid params' do
      fill_in 'Body', with: ''
      click_on 'Add answer'

      expect(page).to have_content(question.body)
      expect(page).to have_content('Save was not successful')
    end
  end

  scenario 'Unauthenticated user tries to add answer' do
    visit question_path(question)

    expect(page).to_not have_content 'Body'
    expect(page).to_not have_content 'Add answer'
  end
end
