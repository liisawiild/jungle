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

it("There is a number on the cart icon after a product is added", () => {
  cy.visit("/");
  cy.get('.end-0').contains("My Cart (0)");
  cy.get(".btn").click();
  cy.get('.end-0').contains("My Cart (1)");
})

