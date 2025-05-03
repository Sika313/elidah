# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Elidah.Repo.insert!(%Elidah.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Elidah.ROLES
alias Elidah.EMPLOYEES

roles = [
  %{name: "ADMIN", description: "SUPERUSER"},
  %{name: "TEACHER", description: "Teacher"},
  %{name: "COUNSELOR", description: "Counselor"},
  %{name: "LIBRARIAN", description: "Librarian"},
]

admin = %{
  fname: "Elidah",
  lname: "Sakala",
  gender: "F",
  phone: "0770344777",
  password: "12345",
  role_id: 1
}

for role <- roles do
  ROLES.create_role(role)
end
EMPLOYEES.create_employee(admin)


