use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.

def get_secret(name, bytes) do
  home = System.get_env("HOME")
  :ok  = File.mkdir_p("#{home}/.config/efserv")
  path = "#{home}/.config/efserv/#{name}"

  unless File.exists?(path) do
    secret = Base.encode16(:crypto.rand_bytes(bytes))
    :ok = File.write(path, secret)
  end

  {:ok, data} = File.read(path)
  String.strip(data)
end

config :efserv, Efserv.Endpoint,
  secret_key_base: get_secret("secret_key", 32)

# Configure your database
config :efserv, Efserv.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "efserv",
  password: get_secret("dbpass", 6),
  database: "efserv_prod",
  pool_size: 20
