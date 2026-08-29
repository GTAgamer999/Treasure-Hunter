import { prisma } from "@/lib/prisma";

export const dynamic = "force-dynamic";

export default async function Admin() {
  const teams = await prisma.team.findMany({
    orderBy: { createdAt: "asc" },
    include: { members: true },
  });

  return (
    <div className="hunt-shell">
      <section className="panel">
        <div className="eyebrow">Control Center</div>
        <h1 className="text-4xl font-black mt-2 mb-8">LIVE TEAMS</h1>

        <div className="overflow-x-auto">
          <table className="w-full text-left">
            <thead className="text-zinc-400 text-sm">
              <tr>
                <th className="py-3">Team</th>
                <th>Members</th>
                <th>Stage</th>
                <th>Status</th>
                <th>Started</th>
              </tr>
            </thead>
            <tbody>
              {teams.map((team) => (
                <tr key={team.id} className="border-t border-white/10">
                  <td className="py-4 font-bold">{team.teamName}</td>
                  <td>{team.members.map((m) => m.name).join(", ")}</td>
                  <td>{team.currentStage}</td>
                  <td>{team.status}</td>
                  <td>{team.createdAt.toLocaleTimeString()}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </section>
    </div>
  );
}
