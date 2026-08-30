import Link from "next/link";

export default function Home() {
return ( <div className="hunt-shell"> <section className="panel text-center"> <div className="eyebrow">The Hunt Begins</div>


    <h1 className="title">WELCOME, CREW.</h1>

    <p className="body-copy">
      A treasure capable of granting a single wish has disappeared.
      Its trail was scattered behind riddles, deception and secrets.
    </p>

    <div className="mt-8 flex flex-col items-center gap-3">
      <Link
        className="button inline-block"
        href="/story"
      >
        ENTER THE HUNT
      </Link>

      <Link
        href="/admin/login"
        className="inline-flex rounded-xl border border-white/10 bg-white/5 px-5 py-3 text-sm font-bold text-white transition hover:bg-white/10"
      >
        ADMIN LOGIN
      </Link>
    </div>
  </section>
</div>


);
}
