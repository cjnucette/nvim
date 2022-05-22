return {
  settings = {
    json = {
      format = { enable = true },
      schemas = vim.list_extend({
        {
          description = 'Deno tsconfig replacement',
          name = 'deno.json[c]',
          fileMatch = { 'deno.json', 'deno.jsonc' },
          url = 'https://deno.land/x/deno/cli/schemas/config-file.v1.json',
        },
      }, require(
      'schemastore'
      ).json.schemas()),
    },
  }
}
