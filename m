Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085E21D3F5;
	Sat, 11 Jul 2026 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783810163; cv=none; b=jcosutrwQ5irLUCdhHxWemnUi85OGvUgf+O/XzVzsWmkbvyWDKxkOhcbepcLxlFJ+d7kOGcpgPwxdS87sPFj192ZXJkBOg4gklCguq+Pqm/FKugrb+hRD2A8z4fDYNvtN6iC6iaTeY9Ay1rAD+JkkgVi1+7sF+g6fm4u6ALZf7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783810163; c=relaxed/simple;
	bh=6ePL9lF+wI2OPePkUIc4Y55rdqTY+lPK232ixi++m0Q=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=qbboap0akwVv7c+SWV0pQ1kDzRVyGSpDwcDw1B9Z6zPzkCqSDLoaeFv7pRWAeVFj5ETjI7JriV7BhFMfMVeItzgx1sxrNFpuA/6kfJjwRi02coyUOgICAB3l9BsPVpUPUfaKeeG51qRXIW5jF9SQ4EnoWJvp8yvVsDtW3o6zrxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P91PSEtt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P91PSEtt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680D91F000E9;
	Sat, 11 Jul 2026 22:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783810162;
	bh=H90R/87cWK/NAZ8VH2NqBMnXbY15sWueSv4XQ/9ZzVA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=P91PSEttji7FPyhPVcwl7gl81ldJsNFhFtZpZBAz0e4NRdNRn5J6v+bqnPgXo7b12
	 +RDzeqYFvrirZoEMGimSlecBSTtiYfTzzv7xiLB8URUWP/ZlbsZvBiJk8lAFUG+xpb
	 /NH9nSq4T/tY3WUfYj7zYwn/4n1Jr+yQFsID6P7tdxqWK/gA+UNCZy6Gs8ka7Rlog7
	 uyWnl5Xm06h+tUqd6YouF88dPurHoomB8nLhgTewwyjWHFGyKQQ7rRzXMVTrWVj1mv
	 41o/76n6G0tcrk5JXe9H7BdkQwppdyu42m9b8JHE/3Bv7zWvVD5GkPBW7p6309YZA2
	 XdWN+QoMbrD2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BC53924A1A;
	Sat, 11 Jul 2026 22:49:00 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.2-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <alLFtWOLPlPPPQEn@google.com>
References: <alLFtWOLPlPPPQEn@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <alLFtWOLPlPPPQEn@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.2-rc2
X-PR-Tracked-Commit-Id: adea84ee6cdea611146c4251d3c1616f5a09feca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44696aa3a489d2baf58efa61b37833f100072bee
Message-Id: <178381013884.1228502.10140842227706445655.pr-tracker-bot@kernel.org>
Date: Sat, 11 Jul 2026 22:48:58 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 Jul 2026 15:37:44 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44696aa3a489d2baf58efa61b37833f100072bee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
