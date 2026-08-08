Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191C2BE035;
	Sat,  8 Aug 2026 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786200738; cv=none; b=gNKCW7DCznnx3LDc3ETw6AanKlmGEF+aDsuWI31vM7SNDaBLCY8BEWTZ6sWMyQ/OfpEO0oKrmhP/B5xYWFyt+OPdxO1MVwDSOcDjFXF1iFZi8lUrT3vpjWk7unG6s2IkV4WpJKpetkRlLDx15ees3bjUO4Y18y8AIpbMFDY55/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786200738; c=relaxed/simple;
	bh=qs04JWIMiffRanTMuRrcIgJge1DUJ3OIpBxDlrjvFAw=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=IVMUPIbWLtjvIhessb4EMhKYVI8Yerffty4ZNtpS5DTlbNCVt9KIKbYfQfKhViZgBTM4EnCLlwngN0s/0qNscaNWCQ6Ie8CgoozFju+c87n6BRGImWsnFyAOU6p/IFlWZJlaGlCPYf4Y8mnfBouCGUaV8XCOLuS0xNAvk+P/pZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2KN/FXw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2KN/FXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F231F000E9;
	Sat,  8 Aug 2026 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786200737;
	bh=MfRNb1Wzv0N/POfYxm+/D3R4QoeADmot1yYBz9PgkZA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=V2KN/FXwSimjgLP4sVR8ld6SsAitjVZMmZ2hOVi5xRdVvp4zeAm/UH8ikzO6xbFdo
	 yKs36qWUrIxbphuvs4GCIFbEIG789ieu2YCeuKI1GdHxlD0SmVqI3+t+rs2xESfsVk
	 HX8tTq95Gh6mpPvsdPxAdLHTy/1aWbGPnDaG21hsEWNas1mF2Fmg5VuNzeFI3j3DbM
	 p77sjMeoPUswg665Of+LwqtaKJeh4QF5uT7UKy/lb8OVcsAzFYZrLTtUTt2yTxA94w
	 78tWdvUdGMP9utryMCAGKf0XgGLMVQaGfJmcxiJoDpeZBOQEBmtF87tLPwk5MbEBYB
	 QIxwaH/VNMC7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A95380CFEA;
	Sat,  8 Aug 2026 14:51:36 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.2-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ana9BNQ9VsV9CisL@google.com>
References: <ana9BNQ9VsV9CisL@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ana9BNQ9VsV9CisL@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.2-rc6
X-PR-Tracked-Commit-Id: 3abd29c61d2ef37c4102cf755b18be53bb9dbea6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7d8c681eef3e410eb6a846ef1ef777f5781b4878
Message-Id: <178620069535.2671154.11071358319168119075.pr-tracker-bot@kernel.org>
Date: Sat, 08 Aug 2026 14:51:35 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 7 Aug 2026 22:22:21 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7d8c681eef3e410eb6a846ef1ef777f5781b4878

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
