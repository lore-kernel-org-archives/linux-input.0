Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB2D2EDD4D;
	Sun, 25 Jan 2026 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769363647; cv=none; b=fJ3T0+IW8hDB1UjXTUndbjsx8ojDoZBv1p6yufJuHCJMbCz1DKUC0J4iSWvuc+yyEyK1AWapfiSwP3HZu26j7OPOsaLPBZP/8W75ZiLPxePXVclIGV0a/6gi2Jctad01Em/dmCInJgoNloChbH39tD36SWa59Gb1ttu6/Uzsnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769363647; c=relaxed/simple;
	bh=H8EbQMA3OefoQd6rTJCffy96nWa94PvXdz5QH2KmB1o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=OqsrwVuk7yJeOrI17y1s8QMEgSGkYBevsBT0aB3KYy4rt2wP3k+IY27G64cGewgaKh03avuz+vC7ivjxXX+Uj62gWPMkhzFWpmMtvKiTpn/OGlSFzOEIi2j/MxWhh0ktj+2gCTkfSkRHhjR04z68x7CKiavYaUGHNdSxFHqfwX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjoBbL/d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjoBbL/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEF8C4CEF1;
	Sun, 25 Jan 2026 17:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769363646;
	bh=H8EbQMA3OefoQd6rTJCffy96nWa94PvXdz5QH2KmB1o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=VjoBbL/dGzOnpNeb82BQ7ieie6Lk1X8Hw00plP5x94QJpeUl3hEeXySxAlov9V+Z6
	 Co44B1vidZHHbhoHj8lwe92h0NSywpg1G7+Qcikbeq0BQK8HS+pstRP/1EaLsfvNLe
	 KMik/XKsnt29diHreaQ/jdcSHal9b5xlkf4GAmXTz3ATp0KcENpfK1Hz45ioMmhzGO
	 x8BOVqx3TtBabnxgqJ8GkHKULdLvUdA50Asjiu0lnHRBWySDoFuEqkZ5uWaYb/U1J1
	 F4WsnxptoMltdXaGelqguuJ86EmjYldgcj+GyLXPbqNqMj5EjGhmVpDQdOzD+QticH
	 yshF30B2BXYiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11B623809A0D;
	Sun, 25 Jan 2026 17:54:03 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.19-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <kj4hg5eeu5pab5tmxoc7465s2pgoqh5pm4iedjmfd73j4vmzxk@77eh6hgaxlra>
References: <kj4hg5eeu5pab5tmxoc7465s2pgoqh5pm4iedjmfd73j4vmzxk@77eh6hgaxlra>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <kj4hg5eeu5pab5tmxoc7465s2pgoqh5pm4iedjmfd73j4vmzxk@77eh6hgaxlra>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.19-rc6
X-PR-Tracked-Commit-Id: 19a5d9ba6208e9006a2a9d5962aea4d6e427d8ab
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c1a5135e60f1a026f135c6b0964cc8f4e1c4a8bb
Message-Id: <176936364154.3551274.2943835257859733164.pr-tracker-bot@kernel.org>
Date: Sun, 25 Jan 2026 17:54:01 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 24 Jan 2026 22:00:02 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.19-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c1a5135e60f1a026f135c6b0964cc8f4e1c4a8bb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
