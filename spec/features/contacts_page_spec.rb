require 'rails_helper'

include Helpers

describe "Contacts pages" do
  it "doesn't show anything if you haven't signed in!" do
    visit contacts_path
    expect(page).to have_content "You need to be signed in to see contacts"
  end

  it "doesn't show anything if you haven't signed in and there are contacts" do
    create_pekka_with_one_contact
    visit contacts_path
    expect(page).to have_content "You need to be signed in to see contacts"
  end

  it "shows users contacts with one" do
    create_pekka_with_one_contact
    visit signin_path
    sign_in(username: "Pekka", password: "salasana")
    visit contacts_path
    expect(page).to have_content "jake"
  end

  it "shows user contacts with two" do
    user = create_pekka_with_one_contact
    jaska = Contact.create name:"jaska", email:"jaska@jaska.fi", number:"1432"
    user.contacts << jaska
    visit signin_path
    sign_in(username: "Pekka", password: "salasana")
    visit contacts_path
    expect(page).to have_content "jaska"
  end

  it "doesn't show other users information" do
    create_pekka_with_one_contact
    ilkka = User.create username:"Ilkka", password:"sala", password_confirmation: "sala"
    sign_in(username: "Ilkka", password: "sala")
    visit contacts_path
    expect(page).to have_content "You dont have any contacts!"
  end

  it "show's only own contacts" do
    create_pekka_with_one_contact
    ilkka = User.create username:"Ilkka", password:"sala", password_confirmation: "sala"
    aapo = Contact.create name:"aapo", email: "aapo@aaponen.fi", number:"789"
    ilkka.contacts << aapo
    sign_in(username:"Pekka", password:"salasana")
    visit contacts_path
    expect(page).to have_content "jake"
    expect(page).not_to have_content "aapo"
  end

  it "deletes contact when signed in" do
    create_pekka_with_one_contact
    sign_in(username:"Pekka", password:"salasana")
    visit contacts_path
    click_link "Destroy"
    expect(page).to have_content "You dont have any contacts!"
  end

  it "can edit contact" do
    create_pekka_with_one_contact
    sign_in(username:"Pekka", password:"salasana")
    visit contacts_path
    click_link "Edit"
    fill_in('Name',with:'Uusi')
    click_button "Update Contact"
    expect(page).to have_content "Name: Uusi"
  end

  def create_pekka_with_one_contact
    user = User.create username:"Pekka", password: "salasana", password_confirmation: "salasana"
    jake = Contact.create name:"jake", email:"jake@jake.fi", number:"1234"
    user.contacts << jake
    user
  end

end
