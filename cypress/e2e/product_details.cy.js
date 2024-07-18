it("We visit the homepage", () => {
  cy.visit("/");
})

it("There is products on the page", () => {
  cy.visit("/");
  cy.get(".products article").should("be.visible");
});

it("There is 2 products on the page", () => {
  cy.visit("/");
  cy.get(".products article").should("have.length", 2);
})

it("When a product is clicked it leads to the product details page", () => {
  cy.visit("/");
  cy.get(".products article").first().click()
  cy.get(".product-detail" ).should("exist");
})