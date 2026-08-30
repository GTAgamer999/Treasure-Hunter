"use client";

import { FormEvent, useState } from "react";
import { useRouter } from "next/navigation";

export default function AdminLoginPage() {
  const router = useRouter();

  const [key, setKey] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  async function handleSubmit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault();

    setError("");
    setLoading(true);

    try {
      const response = await fetch("/api/admin/login", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ key }),
      });

      const data = await response.json();

      if (!response.ok) {
        setError(data.error || "Invalid admin key.");
        return;
      }

      router.push("/admin");
      router.refresh();
    } catch {
      setError("Unable to connect to the server.");
    } finally {
      setLoading(false);
    }
  }

  return (
    <main className="hunt-shell">
      <section className="panel max-w-xl">
        <div className="eyebrow">
          Restricted Access
        </div>

        <h1 className="title">
          ADMIN LOGIN
        </h1>

        <p className="body-copy mb-8">
          Enter the administrator key to access the treasure hunt
          control center.
        </p>

        <form onSubmit={handleSubmit} className="space-y-5">
          <div>
            <label
              htmlFor="admin-key"
              className="mb-2 block text-sm font-bold text-zinc-300"
            >
              ADMIN KEY
            </label>

            <input
              id="admin-key"
              type="password"
              value={key}
              onChange={(event) => setKey(event.target.value)}
              placeholder="Enter admin key"
              className="input"
              autoComplete="off"
              required
            />
          </div>

          {error && (
            <div className="rounded-xl border border-red-400/20 bg-red-400/10 p-4 text-sm font-bold text-red-300">
              {error}
            </div>
          )}

          <button
            type="submit"
            disabled={loading}
            className="button w-full"
          >
            {loading ? "VERIFYING..." : "ENTER CONTROL CENTER"}
          </button>
        </form>
      </section>
    </main>
  );
}