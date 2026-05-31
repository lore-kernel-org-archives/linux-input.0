Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6615A349CE8;
	Sun, 31 May 2026 21:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780262036; cv=none; b=kQIZUsF53++Miy5VtgVSrksFoJIsY6S9Cxmiyu6jeJVcXaKS8eMzGO1me1He58d/X/065fRFi23YU2NcalY7k3wJJUXCKAdg6H2Y0zny+z9erEqmJMLz0HpzqcFLbRnigeEFcKiPaSZaHGVdm+VkmecZx2eV+XcG6uHjdiKkeEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780262036; c=relaxed/simple;
	bh=00f6GbFxjxCw6GMN4+gaLzjOZO8Gl9XY+vFOE4AJku4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Dkr1M4+3PRsQlbDFTyX3XG3xfo4frunudVYEj3i4nlQ2DL9zl8r4Frweox+Mx3mRQQsZMDo9lpoqgnFqXqLrbqbJmTwOEdutDp0+M25dhz6/lKSh0YL90ScExBTO/c3M2WZE3WOcsBliRYFVhRtl/R6OF0MFBC3MCPorg/PSp/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXsmm6fb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXsmm6fb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DE681F00893;
	Sun, 31 May 2026 21:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780262035;
	bh=5CFja4EwelXzpf+s+MY+MOQoyFrnI1A0S0cGOARCqz4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=GXsmm6fbA3Muk8vi+Zx7R5YUcGK7WzHKb65LYlnKUiIzfZNJx+O9j7Ox3b6nMLoZU
	 IRQKwoOv+X0b/PVPsaOPQDbPOi4sKF5ani3Z/AsHOMc24EKIvjosEHG9W+QWzfYGVo
	 Gm3iuWKMFCNZICHNBR8nUch9Ik12a0SkDPT0HwNBSwVbLW0hFkHurZbIqjxxuALMZ3
	 srsrOZUvT1CkueXjuAzeViVrBZsZ7knBBn5qiqA39BMqq982QIxdvK5+vvP+IthZD6
	 b++y/Fmq0T9jxzysDof9jnhvR01Ql81OHdENs2Qvtau2h5kKJ286nhzUa4GWwuDxT+
	 Bdb3lvAVXKX+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C9839302F7;
	Sun, 31 May 2026 21:13:59 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.1-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <ahvBdJ_vd3xuf-Rd@google.com>
References: <ahvBdJ_vd3xuf-Rd@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ahvBdJ_vd3xuf-Rd@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.1-rc5
X-PR-Tracked-Commit-Id: dab48a7e74e6a394f3aa0461a2b1fb0c7b38fcb8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 227abb780c68687d6800cf9eafaff0cbeca4bf45
Message-Id: <178026203784.2979054.6898498108511903186.pr-tracker-bot@kernel.org>
Date: Sun, 31 May 2026 21:13:57 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 30 May 2026 22:09:55 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/227abb780c68687d6800cf9eafaff0cbeca4bf45

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
