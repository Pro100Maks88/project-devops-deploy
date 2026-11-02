import { expect, test } from "@playwright/test";

// Бэкенд не нужен: несовместимые версии пакетов роняют админку до первого запроса к API.
test("админка открывается без ошибок", async ({ page }) => {
  const errors: string[] = [];
  page.on("pageerror", (error) => errors.push(error.message));

  await page.goto("/");

  // Кнопка тулбара списка появляется, только когда список отрисовался.
  await expect(page.getByRole("link", { name: "Create" })).toBeVisible();
  await expect(page.getByText("Something went wrong")).toHaveCount(0);
  expect(errors).toEqual([]);
});
