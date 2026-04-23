Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3193739DBC4;
	Thu, 23 Apr 2026 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961147; cv=none; b=ao7bRc9d5gZwwvCntiMEWiSxJNLHx9bh/AqmcmnHWRiye2hXTb5swPI4PEQiEFVY2ej74gZ8y3jA4ebwVkcN06HFpICgllm+/3Ycp/5rv4AEOL2qYeEsLadsih8LIG1dVP/pykTO0KzIeQgzmPNCDdSpNdgZD4/25MO7jz9JDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961147; c=relaxed/simple;
	bh=C+Ast6DSl38aixhs26XsZG8cyikdky8t+aaGa9AjO1M=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=o5yfL5W6EDGb71n1fP5K5QVSmMqrMTpXpka6U2Nj6MfVWTB++HYrS4tl3OKOQ6UsLZ3stc+uHv9f9doZC/pG7RH3v0HdhDbshH6Bgh25A6okTckKG8nka34ZXaEWjyTqad8kJK4ZhqBKVaB27OJEqQIN63UcYMoSgbALF8YvUBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U652/YEe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U652/YEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FE1C2BCAF;
	Thu, 23 Apr 2026 16:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776961147;
	bh=C+Ast6DSl38aixhs26XsZG8cyikdky8t+aaGa9AjO1M=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=U652/YEewMQl2ryD1zwNqn3ILcNcM5Fob3c6anbLOYMQstWJEmyMJ5nk5j+xXN0nm
	 18NVK9ehvSa+PuZG85M5yvJrXs0xA92Lioxzksohqq1+4WfZq2YMyhDZVcCnxtV/tV
	 hTLS+AwQaFA9bvvejMC2OahT5ejOYe3W+a0/cP1FDSgPIrKRtkTIjzeLB/DPbLIdj0
	 2p79XVYoUQvz//EBXj52MYhL6cq0Pz8cpyx3EJbYGvAVBZh/rbW28ZzfODwXcGkxor
	 5J665yODYP+QQIPWuvH/Jmz6W5HmIQqxk9CPla1C7PxPsZh6SsxzYDdsXuXfCXlkzh
	 69U5uTYswraew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA07C38111CE;
	Thu, 23 Apr 2026 16:18:29 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.1-rc0
From: pr-tracker-bot@kernel.org
In-Reply-To: <aejjiyVgBhKsw2-4@google.com>
References: <aejjiyVgBhKsw2-4@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aejjiyVgBhKsw2-4@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.1-rc0
X-PR-Tracked-Commit-Id: f4b369c6fe0ceaba2da2daff8c9eb415f85926dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 429e6c7f90d12a8551b3eaa9faca7cfaefd99b1d
Message-Id: <177696110824.655676.3346888340111869381.pr-tracker-bot@kernel.org>
Date: Thu, 23 Apr 2026 16:18:28 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 22 Apr 2026 08:05:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.1-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/429e6c7f90d12a8551b3eaa9faca7cfaefd99b1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
