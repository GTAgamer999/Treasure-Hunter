-- CreateEnum
CREATE TYPE "Stage" AS ENUM ('WELCOME', 'REGISTRATION', 'CLUE_1', 'CLUE_2', 'CLUE_3', 'CLUE_4', 'CLUE_5', 'AWAITING_ADMIN', 'WINNER');

-- CreateEnum
CREATE TYPE "ProgressStatus" AS ENUM ('STARTED', 'COMPLETED');

-- CreateEnum
CREATE TYPE "TeamStatus" AS ENUM ('ACTIVE', 'AWAITING_ADMIN', 'WINNER');

-- CreateTable
CREATE TABLE "Team" (
    "id" TEXT NOT NULL,
    "teamName" TEXT NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "currentStage" "Stage" NOT NULL DEFAULT 'REGISTRATION',
    "status" "TeamStatus" NOT NULL DEFAULT 'ACTIVE',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" TIMESTAMP(3),

    CONSTRAINT "Team_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CrewMember" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,

    CONSTRAINT "CrewMember_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StageProgress" (
    "id" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "stage" "Stage" NOT NULL,
    "status" "ProgressStatus" NOT NULL,
    "startedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completedAt" TIMESTAMP(3),

    CONSTRAINT "StageProgress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Clue2Question" (
    "id" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "question" TEXT NOT NULL,
    "response" TEXT NOT NULL,
    "valid" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Clue2Question_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Clue3Attempt" (
    "id" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "imageRef" TEXT NOT NULL,
    "matched" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Clue3Attempt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Clue4Message" (
    "id" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "participantText" TEXT NOT NULL,
    "aiResponse" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Clue4Message_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Clue4Attempt" (
    "id" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "questionId" INTEGER NOT NULL,
    "choiceId" TEXT NOT NULL,
    "correct" BOOLEAN NOT NULL,
    "penaltySeconds" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Clue4Attempt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Clue5Question" (
    "id" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "questionId" TEXT NOT NULL,
    "answer" TEXT NOT NULL,
    "correct" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Clue5Question_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Clue5Attempt" (
    "id" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "questionId" INTEGER NOT NULL,
    "choiceId" TEXT NOT NULL,
    "correct" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Clue5Attempt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdminEvent" (
    "id" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AdminEvent_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Team_sessionToken_key" ON "Team"("sessionToken");

-- AddForeignKey
ALTER TABLE "CrewMember" ADD CONSTRAINT "CrewMember_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StageProgress" ADD CONSTRAINT "StageProgress_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Clue2Question" ADD CONSTRAINT "Clue2Question_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Clue3Attempt" ADD CONSTRAINT "Clue3Attempt_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Clue4Message" ADD CONSTRAINT "Clue4Message_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Clue4Attempt" ADD CONSTRAINT "Clue4Attempt_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Clue5Question" ADD CONSTRAINT "Clue5Question_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Clue5Attempt" ADD CONSTRAINT "Clue5Attempt_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AdminEvent" ADD CONSTRAINT "AdminEvent_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "Team"("id") ON DELETE CASCADE ON UPDATE CASCADE;
