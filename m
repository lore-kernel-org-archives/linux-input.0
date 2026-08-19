Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB02E48425A;
	Wed, 19 Aug 2026 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160092; cv=none; b=Hx1V5cyydcgFqen4KCsMuvg/6W7dGxVj7jw7nDRV+C/ivRv49s2BLDlCM/+BIGEAESaUVFo0+wUDOYDc2RnhFABuqSA8Xn9XYTz9Zso8f1laFFCzp+Q43PeMTa7udfZsiCYl0Lfj5rfRTvSsKWatsEbxg/tiTWZUPFILPJTNqbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160092; c=relaxed/simple;
	bh=E8riE/MmlhvdZqP2ISM3tgXRCLX/+mVkBD2/SYICUTY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=YLjjFu01ObL8lp1FYH29p3SjNpwA5Hg7n70b6rlRXfS26RF/fecjK433KYKLTSbjPrQV/qK81E2dySi0yaH+jgCR3zO4gn+88ReHUVDqa9gC3Mu6HJWvrV1Yxmp12a7O1lfeSuCMbTerfpJa/vRA+gqoQDrER9nn4UQ/kZdqfkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCf0OaKt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCf0OaKt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D2C1F338ED;
	Wed, 19 Aug 2026 17:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787160079;
	bh=O2UJ4Nk1SaPkuGSDRBGUSS5HZVHIodCDp4u8/4ebCGE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=SCf0OaKtUSdYYrdZ3dDFWl1ojqBQrs+r/rtA8GZLa77xMNG3P5mxsGikvtP9RiZke
	 KvuAuFg3QYjVPGFGAPbNH2oUA8TlnVtmWj25jftdSfNThIbGx0RWyeDBq61uvj0kdp
	 oPI02dOAyjtEoFLV+n7WwvfW3/gIabbYOVIftYqHodcf/2QgEBJecWpF7mgnDjyKih
	 zNrYuePp39h2aqNPwDTZ0FCD9GJuNQns/kgfrGx0T6ooCO1AyMBojBTUbyWluyfFDH
	 4nJqkr3RBR6g/i+VYZECXB7ctz5lPin+J1RI5hSx425SdWIRi9tgvfRjvVr2VAQiyM
	 CQH9T/G0EejHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F3D8138119E7;
	Wed, 19 Aug 2026 17:20:31 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.3-rc0
From: pr-tracker-bot@kernel.org
In-Reply-To: <aoKAIGTdF7pVYqiu@google.com>
References: <aoKAIGTdF7pVYqiu@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <aoKAIGTdF7pVYqiu@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.3-rc0
X-PR-Tracked-Commit-Id: b4d85f863e5a6f1fa01b186001af0f68f4f5239e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1be05c6afbb2c4052d0a13fc91ddcd89aaee9614
Message-Id: <178716003078.3599392.10629864219831404507.pr-tracker-bot@kernel.org>
Date: Wed, 19 Aug 2026 17:20:30 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 16 Aug 2026 20:31:06 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.3-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1be05c6afbb2c4052d0a13fc91ddcd89aaee9614

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
