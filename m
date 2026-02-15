Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D112A4A21;
	Sun, 15 Feb 2026 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771174680; cv=none; b=SunEWLifct8TfCadBP2lZFJVOBOpyL71RTc/XoNk6S+o/kOnirgi4jwpt74aJvk14/SX0nOqRLvis+fOl4JP6wwTnvRLBKx0bC53oS4yMo0t1r7KUgMQi3+Kfoa2VX9iPFsLHNdWVxG72vYm489taiZadmIXcIsROpsFfiouXM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771174680; c=relaxed/simple;
	bh=bxtQJSV1WHxK6paL0pGOYlpVPkzlGQi9hadY3A+5tYw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=foBfC3+5U4yB9GT/23qWi0/HDkLnA2ZxOQ86tPNCvS63bC2Dqb2XaiHogtaj3kEsi0ywgTBQ2uQi+LyRKDagXTBS3WxoIRjaZVmJ0kXp7eLeaP8xzO9n/b2agO1AtF+u/7HGF3QJaPrnAsN9PORFFJEy+YannQ86s+H8BUnQED8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wddo8yp6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wddo8yp6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B14C4CEF7;
	Sun, 15 Feb 2026 16:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771174680;
	bh=bxtQJSV1WHxK6paL0pGOYlpVPkzlGQi9hadY3A+5tYw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Wddo8yp6vqGYao2qQZ+LMvZNNbGsMYQsCIWa3VhKyR3SPoxbeercMX31nxe1i7HnM
	 WgT818D3UnEa+ayPj+Us7a2NHVb+hxwUzakweZTa3ztzefEf8OmF/UtWDdegBq4FMw
	 d1hX1W9BrP72Jf4/TgBQoSpNh4EaENtXutCGmFAhOfvT9liSKMfY36uMQTMyjucyXB
	 3esF5D/KK8VTzXWlvpbmJLvLL7yIUnIOeh0nnGO1x+nTqqxT3nUS2In8h+WSoE/OJe
	 BXJnPRZpRGq7LIZFAWOv7vtGgfaA2LDklrB8DtIuJnLvgj3Ru043Z1X2SW9O7NxDMG
	 qazbKeYJbtRAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 854243930925;
	Sun, 15 Feb 2026 16:57:54 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.20-rc0
From: pr-tracker-bot@kernel.org
In-Reply-To: <aZE_tkCsDuCAH3Ux@google.com>
References: <aZE_tkCsDuCAH3Ux@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <aZE_tkCsDuCAH3Ux@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.0-rc0
X-PR-Tracked-Commit-Id: 273a171dee33cb77070d7259c469d9440548c7df
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 348e77b8145676184fb49063d5543e054fd74909
Message-Id: <177117467318.3131369.3142488043229285807.pr-tracker-bot@kernel.org>
Date: Sun, 15 Feb 2026 16:57:53 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 14 Feb 2026 19:39:37 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.0-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/348e77b8145676184fb49063d5543e054fd74909

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
