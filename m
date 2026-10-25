Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792907423;
	b=49H5nW45vB6gmUuYcF56ilp0L/SFV7KV7OmjRf4hRkB/NJpf1AQ3qu5D+CfUYhFHY9H1
	 sE5yLaTJBJKwg23zx4+Xn+elbxDXjehfo06dVdxtL1KLnPpvYa76jplwiDm8Ol7ZUiiXf
	 HBBWvhVOA54gUFYfvctkCWu7FaqkEhne1Mhi95velmfxzuDzjL0NUuYkbT5vFvwNpsHkq
	 6U27TgwXcUqjnXkjMpKwTXMNg9/ZmerrkGAU8nZIJXYZaWmrddAvg8E2sczRDP6IqVq/V
	 dIOpfVDUazYl6kn9CkKS4xqb1hvgwSl0ttabDoCLkoixHkn+iFiPoAf+N8wRZFVQ8+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792907423;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=XvV4f81x2a1Hly/IxbxrwfphHPAP/UZBIfpHdVhkGPY=;
	b=PwlU/tWLxlaWWJmFVa058QLjLcKCyqgOP3Aniq/pv3Msf51VrMvtkW0QIJPnGzmJaRTv
	 gE+BIXc2ZvZSTGSEvLBwUdjJ5iH+y3GUb+Ky0Pzj0e8R8dWr45tQVV/HeSPnRQJ+6SPY3
	 Gt+gu9YCCVudesJv8j5K9/4pGJADvE3JWQEFG2MZ7sdXDIKiCZ1LhS/yA9FiClR65T90p
	 E0HAQruM6lW6CIip3QR9yJfW15l7VVMM1vxMExa5B04vyq2Zl8IshXKaHf9cjFSstGunf
	 cQq8csFg54AyOQW/Lh63GG4QG9xx5dr/gsOuKI53AiwNIEm/sEQ4EH71WyVwaWXOnUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSAsQ0zJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FE2606A326;
	Sun, 25 Oct 2026 05:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSAsQ0zJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4B3B1F01829;
	Sun, 25 Oct 2026 05:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792907422;
	bh=XvV4f81x2a1Hly/IxbxrwfphHPAP/UZBIfpHdVhkGPY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=dSAsQ0zJEi/Dvhoxzt8JD24mZdsEf60zMYkuuP7vJbxHGOrgINq61xM9SejhhRKbQ
	 vyVk81AM3fp8UqOM0q6Y0kQSbJO8lpSCl2nn+Or9j/zRyeO5yI0OT3OPdn6qVyZ5vq
	 QN1OurljeR97tbBivsV+PhvUde5y28O+p8viHcIIEbp2Hc7BIyi69GQjJ6JksYyu34
	 N21QZnkXRveJe5MODvZsqB5LmeQe3d3a4AcDFiJVBr9LG3qDwbBneSr2KqiB0uegcP
	 3Wm2Y6JzuvVYnqSFCn6cF/078nFuOY7SAe8gIyjK7eM9Wlb64fBiNjvlyhzNscixDA
	 K/PdtL+aR2H6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D7920392ED67;
	Sun, 25 Oct 2026 05:50:22 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.4-rc0
From: pr-tracker-bot@kernel.org
In-Reply-To: <at1kDafUvUUJTnPr@google.com>
References: <at1kDafUvUUJTnPr@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <at1kDafUvUUJTnPr@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.4-rc0
X-PR-Tracked-Commit-Id: f57202d55333f750a18e21c3b3f35f48ef14a61e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a32e63a613aa80dfdb9acc0a09efab940e96054f
Message-Id: <179290742174.1990210.1160715775053525493.pr-tracker-bot@kernel.org>
Date: Sun, 25 Oct 2026 05:50:21 +0000
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

The pull request you sent on Sat, 24 Oct 2026 19:07:02 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.4-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a32e63a613aa80dfdb9acc0a09efab940e96054f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
