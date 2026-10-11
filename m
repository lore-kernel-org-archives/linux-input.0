Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A90455175;
	Sun, 11 Oct 2026 15:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791731646; cv=none; b=d6nOnUtF1IjUR5AMGNSte/ja4zXLEjX/+dZn/PTX0/vNFeUk/z4LAebtIcuVDh+9WMKSI3EvDbAb7G7v5iyBvk5aUeC3JL7BvEOYtEm/zQi9wcsvPDM65fc3WRBrPUXetkU5eQRE0nECta2tsv2bTD77AQpCiwN/mKx3xPzc5vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791731646; c=relaxed/simple;
	bh=C6X1DAVuH9YMkghWAQFvlSlr9Cj2+AFsHYkgQKsHLME=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rF7BoiuIwJr2pAu8ZcEBE/WhBfJNU2fBjaAlMIkf+1Y/GrKbQsLgtFDVgYDhN1BI/X9oWeW4UIHSWbokK5WZVmbUkptjGmPEB/dKIhwm2nhIx9mbjUWNHpqlNSf6STA9nmg3D4XUTv6Rlq8BfMcCwdS0MyAqP1osmdVSiOwIsRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jih+CeBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jih+CeBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE431F0089B;
	Sun, 11 Oct 2026 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791731644;
	bh=5zXnYprVq1nNCdtAgnl/QNxubBgabTeHXNA1qTQIue0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Jih+CeBGxa8lqLn2VuktmxJ50YA8emDXuvdfIv8cAFu6vNfsp/Mpe9iPIVThlirB/
	 b/7gluj2Cmc5LgZiCtBiu96sNpCISav9coD8B8H7ykpir7ay3MWx3KEYF4QJGzRae8
	 69x2T0ptqWFC60x/RzLgaIv7rJTSrIoDvVCAyk3rVIHRJ3gFuj4tybeKMIRwDv3bQF
	 VMRgZno+5P7CyXk40/CVNVOUbDF/1yEYh7O7cA4SzchSeDdC9uiDYNqofVg7Zh1pf/
	 Kq+Dxpod8hPT3TqlZVNrhZP5DtnqMS6bGhcdo7W1K6zC1hBObYxA4zh9To0n2zvUS2
	 DVMZuyPJZwfdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B468A38119C4;
	Sun, 11 Oct 2026 15:14:04 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.3-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <asr3A-2qdU6MSCTZ@google.com>
References: <asr3A-2qdU6MSCTZ@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <asr3A-2qdU6MSCTZ@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.3-rc6
X-PR-Tracked-Commit-Id: 41363c27b8509bd4efcba244803edac9ba25d1b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b88c841d11641923fa3a4da011d7202cd89df68a
Message-Id: <179173164330.2080702.8882988715559478368.pr-tracker-bot@kernel.org>
Date: Sun, 11 Oct 2026 15:14:03 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 10 Oct 2026 19:40:13 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b88c841d11641923fa3a4da011d7202cd89df68a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
