describe("product details page", () => {
  beforeEach(() => {
    cy.visit("/");
    cy.get(".products article a").first().click();
  });

  it("displays the product image", () => {
    cy.get(".product-detail img");
  });

  it("displays the product title", () => {
    cy.get(".product-detail div h1").should("have.text", "Scented Blade");
  });

  it("displays the product description", () => {
    cy.get(".product-detail div p").should(
      "include.text",
      "The Scented Blade is an extremely rare, tall plant and can be found mostly in savannas. It blooms once a year, for 2 weeks."
    );
  });

  it("displays the product quantity and price", () => {
    cy.get(".product-detail div div.quantity").should(
      "include.text",
      "18 in stock"
    );
    cy.get(".product-detail div div.quantity").should("include.text", "$24.99");
  });
});
