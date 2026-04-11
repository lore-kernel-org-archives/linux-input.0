Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CA93BB9F4;
	Sat, 11 Apr 2026 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775937557; cv=none; b=jv//A4TCd2Z195kQTLl5xvGFwW35OLfL6HZ795cqVF9lLj7uy+AUROzjfZQ9v7LRYVmiusyepSp6T7oND8ms2yakAD/fve1AE9nb+ZlZOQHOtM+kbUUlh1whr4ogNlFOXtBndDdlZ7HnpBXGBBJJNnG1nV8hU0LNDo5/NnZQc2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775937557; c=relaxed/simple;
	bh=dbgNXploHiRCQEtB0WhcGM/eZWWYnJJZ3wDJudPkBVY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=CIBDv5Fpp+sADfeLtiBIE/gslK5bWAz1DfLrdZgv5blj6UHhIX95GaYBUtyEhjaZV/kX+3zeDRsetfCGYF/EdGoDzly9dtxUS1fN6CR6y3717f6LbYLPziHcjNLOE3Lt93+V+GetgiEtKDW52LtAC4ewJ3o9BKy88Sh2N8O1fAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aavXqYzx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aavXqYzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56299C2BCAF;
	Sat, 11 Apr 2026 19:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775937557;
	bh=dbgNXploHiRCQEtB0WhcGM/eZWWYnJJZ3wDJudPkBVY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=aavXqYzxafHPePfvYIAVVGftzCcxTA4lLXGqhl6BAJ5gc2eyID5Rm5c5fEuhdwf8y
	 rrxEfIk+Mnux4o+jdUn8KuZZknYKBS5nvMQ3jUnr8dmcBmUXITes/nMCnYVLtxk+VX
	 eR7MvgWAk2bzzGqpI/eT6JcmrR6nAZThPd7q95F5n0DEgdvosjjFd6sYHJp+s7ZQkn
	 Sq0IeU9K30Y9UrGmJQwPNUqjzG/qltIVevRynTevtWUSOMFvykVHIVq2nSrXEKJanO
	 a5giR1SrSLNJdKR/rbux8SLqEJm3/5eTrBMiFEJCNswca6NB0prfhRNcvt7iuhs2ei
	 QA/WqYc/ThgBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C613809A8B;
	Sat, 11 Apr 2026 19:58:52 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.0-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <adnMg9E_ZAjxcv1k@google.com>
References: <adnMg9E_ZAjxcv1k@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <adnMg9E_ZAjxcv1k@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.0-rc7
X-PR-Tracked-Commit-Id: ff14dafde15c11403fac61367a34fea08926e9ee
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 778322a06e217e768ba3dc550a6f599f73ed781d
Message-Id: <177593753047.3064778.13591729872194140219.pr-tracker-bot@kernel.org>
Date: Sat, 11 Apr 2026 19:58:50 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 10 Apr 2026 21:23:07 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/778322a06e217e768ba3dc550a6f599f73ed781d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
