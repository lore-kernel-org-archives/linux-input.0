Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FCA3A0B3F;
	Sun, 20 Sep 2026 15:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789917102; cv=none; b=Jg7RhPiihh/NxlVY0i7RNLRCdv7iWsNa9PLa05Mqf4pXyuAP4L52kkT+WirNDCT9/YeX0ILT0cG2wnGPUtrHZgsXrbYuT031UnCS2wxxDBkdgWZizWlb4C2UgXGhloNfyIy1BxYYmr6IA4GbS8CHWUXQPFKQsd9nX4hqtZ+jhiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789917102; c=relaxed/simple;
	bh=az1zW0/vXNvDB3krk8VWeB72iFsRyOsnKMiUQEQPZTg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=EIk05EL9T7crhGqkd//EMRzvI93HOD/2WmY8ynyXZkiTDL+Ly1fX58zFU4V8ZYp46XrHjw98TvIeUVz91+7T/KFCh6r2YxzxlEAF6wrkUrGO2NNGUd/YT7+dNUhg9cJbfnzEIf0ZoBJxEQGsZEN/nGQsyqjfdU7NehAg/Y46HNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFBAR0S+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFBAR0S+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7121B1F000FF;
	Sun, 20 Sep 2026 15:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789917101;
	bh=DEAyRJaU0FdMryFVMBx7szaQyFZRWQTFAaGAybzMuoE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=XFBAR0S+M7lLeSN2Ue8x6YJjhSjMJkRW01Ajybb9zUlSNFlQ9hRaawt81GLNh4ijQ
	 cbPnekHKosieRvTxkGQD3YSODqpEtAy1D2tPm1XEd0YUU6pDYMUZiCE3JpkBbNSVaN
	 cdRLFzMOjt5oi1p43zw6fjoMa9pRM84SZ8wgIoPHyoEBzzLX1z+df/6o1LI3FpKWdK
	 tnvpw+8m0FT1hDl8Q1WwKCy3aQYRx3e9C+/7nhUJUzrMTLCIsNO74ulgvHZn0Z/xSK
	 lbX3dpvLIFEYzx2E7gvh+4Q0PLpiO0WkK6EhVMv//w4ESEtZ8PdrLGQiDD0LaMrcpO
	 CubTybizGZuYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A8239253CF;
	Sun, 20 Sep 2026 15:10:34 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.3-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aq9kRuJbKqBe6-_z@google.com>
References: <aq9kRuJbKqBe6-_z@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <aq9kRuJbKqBe6-_z@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.3-rc3
X-PR-Tracked-Commit-Id: 309731e95917125bbd13626a7a5600490a5bf44f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b12dd0fa481f6914f9375155865a04c3f9f9d800
Message-Id: <178991703342.1703482.11956907068714814056.pr-tracker-bot@kernel.org>
Date: Sun, 20 Sep 2026 15:10:33 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 19 Sep 2026 21:43:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.3-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b12dd0fa481f6914f9375155865a04c3f9f9d800

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
