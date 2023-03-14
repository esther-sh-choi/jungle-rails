describe("Add to cart feature", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  context("singup", () => {
    beforeEach(() => {
      cy.get("#navbarDropdownUser").click();
      cy.get("a[href='/signup']").click();
      cy.get("section.signup-new h1").should("have.text", "Signup!");

      cy.get("form").find('[type="text"][name="user[name]"]').type("Esther");
      cy.get("form")
        .find('[type="text"][name="user[email]"]')
        .type("email@email.com");
      cy.get("form")
        .find('[type="password"][name="user[password]"]')
        .type("password");
      cy.get("form")
        .find('[type="password"][name="user[password_confirmation]"]')
        .type("password");
      cy.get('[type="submit"][name="commit"]').click();
    });

    it("Redirect to homepage when signup is successful", () => {
      cy.get("#navbarDropdownUser span").should("have.text", "Esther");
    });

    it("Stay on signup page when user exist or error", () => {
      cy.get("section.signup-new h1").should("have.text", "Signup!");
    });
  });

  context("login", () => {
    it("Redirect to homepage when login is successful and logout", () => {
      cy.get("#navbarDropdownUser").click();
      cy.get("a[href='/login']").click();
      cy.get("section.login-new h1").should("have.text", "Login");

      cy.get("form").find('[type="text"]#email').type("email@email.com");
      cy.get("form").find('[type="password"]#password').type("password");
      cy.get('[type="submit"][name="commit"]').click();

      cy.get("#navbarDropdownUser span").should("have.text", "Esther");
      cy.get("#navbarDropdownUser").click();
      cy.get("a[href='/logout']").click();

      cy.get("section.login-new h1").should("have.text", "Login");
    });

    it("Redirect to homepage when login is successful and logout with an existing user", () => {
      cy.get("#navbarDropdownUser").click();
      cy.get("a[href='/login']").click();
      cy.get("section.login-new h1").should("have.text", "Login");

      cy.get("form").find('[type="text"]#email').type("bob@email.com");
      cy.get("form").find('[type="password"]#password').type("password");
      cy.get('[type="submit"][name="commit"]').click();

      cy.get("#navbarDropdownUser span").should("have.text", "Bob");
      cy.get("#navbarDropdownUser").click();
      cy.get("a[href='/logout']").click();

      cy.get("section.login-new h1").should("have.text", "Login");
    });
  });
});
