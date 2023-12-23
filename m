Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21D15EAC;
	Sat, 23 Dec 2023 20:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+UCuHfa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0BA1BC433C7;
	Sat, 23 Dec 2023 20:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703362870;
	bh=Pp6Ff+44Gh4QtIn+FMTbYm+uXyY5nOGRCkalUw/K8YM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=f+UCuHfaragTMr47SfN4rIS2PBoEziIB+M2HrbK2P/9GafT8ycQ8XlHf9XfsbSixs
	 4JM3N3+GEsYCbLyApWOzy+bEP3PtSY2phIY0Mu6ejxkLcwhRM7FHu1rTqj078YOq+U
	 WByuPLbYgRoWgbxN3AH/OTgKwyJfXiyr+dwTR2dOwPjn10JxB1j/hvmZGippQuf4Vn
	 o/F0xq/bXiKT8m5I3B4p9cRVB7bVNsQHQgwm1sOjcXljAgVJqkfSzHmP+DvQAvs97O
	 p+2fAgsojx/kc1AN2mpY8KOLoZDeETFWuRZZNvl8VfCE3rmMjx5dHC34iMa34DYTbq
	 YCOwajEK7/oGA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE41DC561EE;
	Sat, 23 Dec 2023 20:21:09 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.7-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZYaQvgIr99ixMKBS@google.com>
References: <ZYaQvgIr99ixMKBS@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZYaQvgIr99ixMKBS@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.7-rc6
X-PR-Tracked-Commit-Id: ea3715941a9b7d816a1e9096ac0577900af2a69e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa655abe42c65e7e4ad52baf280dadfb571c110e
Message-Id: <170336286996.28590.643465141376069811.pr-tracker-bot@kernel.org>
Date: Sat, 23 Dec 2023 20:21:09 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 22 Dec 2023 23:48:14 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.7-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa655abe42c65e7e4ad52baf280dadfb571c110e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
