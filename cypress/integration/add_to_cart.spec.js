describe("Add to cart feature", () => {
  beforeEach(() => {
    cy.visit("/");
    cy.get("div.products").scrollIntoView().should("be.visible");
  });

  it("My Cart item count increases when clicking on 'Add' button", () => {
    cy.get(".products form button.btn").first().click({ force: true });
    cy.get("a[href='/cart']").should("include.text", "1");
  });

  it("My Cart item count does not increase when clicking on 'Add' button for sold out product", () => {
    cy.get(".products form button.btn").last().click({ force: true });
    cy.get("a[href='/cart']").should("include.text", "1");
  });
});
