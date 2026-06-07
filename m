Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4A17D6;
	Sun,  7 Jun 2026 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780847341; cv=none; b=phHkhbJtYyelWmD46LUdNqspgc1m+KSBtGQWw//IDQbQeE1SkLr1MXah7Suz+SkC2mN33aWLXS33yps9TDGoM3bHuaEDZruqOcCf76a7dvemDyIhonQ8xTjJsMJ9unN3lINPuMftFj9bKKYLspPIAG1LJr/zz4FPaQurhxwq86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780847341; c=relaxed/simple;
	bh=Fi+hA9TtMafWs3tZIKPifWhucDrKnm34YYHVSrmbV+s=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=otwzq/gIwDle+4hrXxLuc5CKChP1HKqHkN4ruZJe6RgaJOca/3dPK49cnF9uo1dWIYhavczpoZDc6jlfGuhhfTQhDY7FOzV/inaEzSzWXq7Qpcbo2qB8Jm8nFLXzDpx5a6AtZNcIZ75H7ykckDYfceFUGayWhGjNxl3TQfJb1Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Izfo3aA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Izfo3aA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B803B1F00893;
	Sun,  7 Jun 2026 15:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780847339;
	bh=LYvG7olx6iCHUM5zsLIU0bs+hWt/4YHLlRLEcrAJm+4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Izfo3aA03A3oPe0JydxiAzM9bKOVimga7GTDF24T7vf3hSohxzB2xpUSW5+Je8t0X
	 osCoZaxTYXlNAPny177Iy8h61Fr/mxyOxWbVwWJ3UJolmMh857VLQzOfiPpnC6JF6R
	 nAsx1XdQVlXAzvgw3sGfd2AhomNVYfDn5oHNzzRndFiMKWTIRNFmqX1t1e8xjjPKCm
	 CiYsOJV1lrxH6A3FAWqQOgjkL5Bic00Gkxa+qGS1IPpDRws/3NvLgfCWGGKRYvBWPq
	 V3FQXJ4FLX5PDagMMPN0K9PUWgBwgpDweBB6Y4zL6+grUGdiHlfdlqW/eM2EQoff1T
	 YpzT+LYQLw1zQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A5F3930C94;
	Sun,  7 Jun 2026 15:49:00 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.1-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <aiT7-939zBREw3FG@google.com>
References: <aiT7-939zBREw3FG@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <aiT7-939zBREw3FG@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.1-rc6
X-PR-Tracked-Commit-Id: fb402386af4cdce108ff991a796386de55439735
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33d8d8ec31b591952ded59d596c2f3db45004937
Message-Id: <178084733901.240884.5185561831501103434.pr-tracker-bot@kernel.org>
Date: Sun, 07 Jun 2026 15:48:59 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 6 Jun 2026 22:05:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33d8d8ec31b591952ded59d596c2f3db45004937

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
