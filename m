Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68C931714B;
	Sat,  4 Apr 2026 15:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775316893; cv=none; b=rRgV7ujeU5vdtPAKFiTeQWro4GZHGWUODWyg0SOVk582se0GziPHrHNlPKpCw3AbmDql4I0UzSEK3A9wDPxYk6+9MvlvFBC74riDMAyrUC5O/tFLx7fD1asInbHSftnVVohbIY39o/lQUmNmrTDnlonh/xh9Dixag+2k8KESdBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775316893; c=relaxed/simple;
	bh=rlaSyLIbUpfbC6JmhoURy9k1juLa8aT8XFDEmKqa0Ec=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Sz2eVwAY7U1LtUKbLbupeEL90QDXs3sGYyz8QfVHsXdKGlbpgBMm4lwuKg01CUzCnDPEZckujz1S3gUZrKUVjq70/jSXgNxx460MP59m6BpGA17zU++gPCBoClhqBE8hak4NIReuZVjNy6FkX9YeQkl6YkzRHee17fMM6gn0cWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld+zISeu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld+zISeu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E17C19421;
	Sat,  4 Apr 2026 15:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775316892;
	bh=rlaSyLIbUpfbC6JmhoURy9k1juLa8aT8XFDEmKqa0Ec=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=ld+zISeuoDYHxMC5ddXoS70j3WznNoL9E388PrdGPITw9iUbA3t+3TvzxljpUzGJT
	 owvdbnJ2V+nl0uaN6iyqeMSvTApp3MbiqucNKjhd03d6bqqyc03okiYMir8YIp6Cc+
	 ZyLJsW7t20CojU6ysY6gOsMbg9AL3hVGKl0X65PApEBLxycrabVsSkXbN4C9IvpG/3
	 jN8W7uRz4WQ1mIzbOraayey4lDgjSXs+38N/TST13vl0xlxnCTJsXKBbS0Dm+M3PUN
	 T4eFJdbT9FNOMEWmBlCYYQl/3JCkF4AkgHuqgy9hf9Ot/JNOxlsYxh+jkbQj4RAoyX
	 A9UK+2+SoT06g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D01C3809A1A;
	Sat,  4 Apr 2026 15:34:34 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.0-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <adCpWQOyfvE6E6k0@google.com>
References: <adCpWQOyfvE6E6k0@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <adCpWQOyfvE6E6k0@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.0-rc6
X-PR-Tracked-Commit-Id: 0d9363a764d9d601a05591f9695cea8b429e9be3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3aae9383f42f687221c011d7ee87529398e826b3
Message-Id: <177531687299.1703493.4563700763115050563.pr-tracker-bot@kernel.org>
Date: Sat, 04 Apr 2026 15:34:32 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 3 Apr 2026 23:02:12 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3aae9383f42f687221c011d7ee87529398e826b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
