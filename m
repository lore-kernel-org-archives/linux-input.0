Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D35B3254B0;
	Wed, 24 Jun 2026 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782339428; cv=none; b=GLgmU6vmbGu/0WV5+tqkBjXXv17VZjOqzSWeWQSJ0pOEZ6esTAmULr5fuqxgHMThJCwllk3KGZn549ZiTYI9OHe/TH+qZPQAgf+tWd1oz4ztxBwgUwRB3IqmYBKNCGNuBZYJo1qWQiFmU1VhGdKaUIZhbkteILKuwBDYpXlFvrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782339428; c=relaxed/simple;
	bh=lk6q7tFG176EW+iRDyin9o2QJCt44QA3KgSzbOU8AgA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=N3P6X9SDEM0KbiTkorz5IoEvmdQH8rzwtZODSIqsFiSAZNe2aTAJBf2bEF93rrERnpYbKuWhf5Arl9WuokKHEFNpRTC6YMUkMQ5UFh85GODg4jLH5Prq/Dx1fAy1xqzLK9Oi860Nh5/D9Sv4QIUw3dpFtI90/WV7bloOr84KAKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUAzOHDU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUAzOHDU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347D31F000E9;
	Wed, 24 Jun 2026 22:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782339427;
	bh=AitTbXsK7yMGvnAV+s5RKsL0fGXrJ9TM36oo4gh2xaU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=mUAzOHDU1drZR+sNAU16p8ntKe2RbF7KSDc3KgztPamf3Htas1TsW6xaJ0fb9COmL
	 r2jZbSGjZHQ4sdREotfeI7mTo4uqHdg6IBBSQOfgJeK6WN4JXYRheuhLHorUwteJVz
	 CAptF6n2iCOB9HN8Z01cqkivqqrdcN+YB9jmq0uJBu7wzmYPsZMUP13hF1R12AmiDW
	 YRd/g18RraAnkcXNWk6wJCnTjLrkdgfFTjqdnjQNR82JfSbzlh6XX0FOnhRdA2rxeI
	 +2j5Qfjuu2Op9SMEGlOCMjlJhuG0Gec1on8AQiydBo8O7CayIwx50WBN5PtOFT0QUH
	 iyhTGLVuTYbug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CC03AA6A7A;
	Wed, 24 Jun 2026 22:16:56 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.2-rc0
From: pr-tracker-bot@kernel.org
In-Reply-To: <ajs_Hmo3Zo4aEFZ7@google.com>
References: <ajs_Hmo3Zo4aEFZ7@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <ajs_Hmo3Zo4aEFZ7@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.2-rc0
X-PR-Tracked-Commit-Id: 7a0e692a0381254b2f77c54dec100cd3325a6fdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e1611017870fa1582b5ff9ec0edc09542318daa6
Message-Id: <178233941551.3002918.6116338049586495523.pr-tracker-bot@kernel.org>
Date: Wed, 24 Jun 2026 22:16:55 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 23 Jun 2026 19:21:25 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.2-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e1611017870fa1582b5ff9ec0edc09542318daa6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
