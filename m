Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795372141;
	b=hFXSCGo3gU5KkwU8ODqRuCDEfgtcn1oxdQMynCEOsR1ReTgCZsdQbSfYFqu1aDZhFDxD
	 rLB2Yw5baUzWOD9AW4c2lDQeBLY2q3HqlfJj00Vo7DIxI4d57x8pPulTFL3KGyH7AUyAS
	 2bUQxRpYsJKhgNp1RkDhFD3Ee7MSDb28VlvX0tII9ASmbYrBXz/zvNFrVN728lxLyVZ8E
	 tK/3catF7SqT/dMXmTCgzgldJsk+AjgcpHUvnSC6ogfSdO9h4jzZ3c/HT9NuXX9o55w2C
	 2/9matl1j0a2FlJfzmUBR1/yG+ZdjaSHTODKu1x2n90ctGRhuVhCPYWtcxkisVaTSoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795372141;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=KUGssV68GP3ZLwbxmeL5eGm7pJNkC0L+Bvgn1Kw2pVg=;
	b=qUyhO7OjmSvxZebbN40viGmNWrf8ZYEFTfPJCoMNrYcw/VKWqULmLD3rrmTSLDSGDsyg
	 R2sK7KBXuPRgAp0iO/SjGfFjfrLRoszs39GOZ2KrM7whuoQlbxmZAOrUd8bysgeIORTrK
	 enWnp0+b1sbrDl+93iamrWQZXXb7LAyABPZJkLuo+yxM1HvsZcq1+82XlJX+EvU7tiZza
	 X/wd6hthYOfUMJxUQP6JW95vPJxZhwoNT31Va/4Ax6wwAKVokL+7kALHnQoipxtVFlyNe
	 /ZQ2/kixelGCHY5mcUJV1Jpk9uCtDBVr3dMlSJOPrrQ2OXdH/yICO+hGdvLvlAonyyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyhrUiZd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631B606A320;
	Sun, 22 Nov 2026 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PyhrUiZd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0643D1F000C0;
	Sun, 22 Nov 2026 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795372141;
	bh=KUGssV68GP3ZLwbxmeL5eGm7pJNkC0L+Bvgn1Kw2pVg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=PyhrUiZdEO+nqI4M8GHDR096D7fycAljneYI9OY3OewhAgfea/NWlCFipCNOykayo
	 Kkezkhxu6QwoOpFAu97pZO3f6OYdWjOUjYL6vlvrdtYJNe7W/f/qOvVJP8/fgeYeia
	 VYwq32AoVC4Cq5PCawJIDOan2h0T6I7PnLymIf6aJQCdKBayRgLgWi+XVwVN/fM+p4
	 XxG5ARnwcDgFRKdGfvKDbfm+c2+vIFEstzSd4qGDdeaWjX9128cXwbyOIANdfQOwmf
	 zwrnfvoqlMAqeQJD6FWxRrAJJTjLMLqqOSooaOLIIKdLAlzeS4bJPYDnYpT/W798Ld
	 YzCcK93w98GPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1526392ED1D;
	Sun, 22 Nov 2026 18:29:00 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.4-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <awJX_vVgR79DxVuw@google.com>
References: <awJX_vVgR79DxVuw@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <awJX_vVgR79DxVuw@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.4-rc3
X-PR-Tracked-Commit-Id: 2ae35f090d029d2d8491b0a7f98a04c5c05d0a44
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: abbf2945b788939e4df50d6f0c750409c1959960
Message-Id: <179537213962.1494759.12866436670396221902.pr-tracker-bot@kernel.org>
Date: Sun, 22 Nov 2026 18:28:59 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Sat, 21 Nov 2026 18:48:36 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/abbf2945b788939e4df50d6f0c750409c1959960

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
