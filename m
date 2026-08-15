Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3373032142B;
	Sat, 15 Aug 2026 05:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786770004; cv=none; b=d005PsmrjQLojaZnM9h3u7z8LQuy/J6fZqfv/LRC2WPjAw1pXoY8Aju96rGccB9fsLC846piHnyLwJMJdSNYICl/jEobbDN6kCYxhJLG/f5fDPHzc6KGiz88tvL1UIJyW+SXm+kRNqwauOAWVcL4Zezwc4JLJz+BhNRBOUtyb2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786770004; c=relaxed/simple;
	bh=8R7B6azo5wCufSDNJw0x5ezZOzxogYPQJU+vR9tbxyA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Au8/MCWYHOto0XV0mJHdFOThPRRob6yGZEvE5YQ+w13gPqDSxdKAw8puVGvfTBKwF35N/0wREx0ue1RpzPnpGkOMUQoE9X6jVMUCfUiUFmpu35TJ55wpFkT4jGZL++8uc2ws5tzaX9/T61VBUjLne8I3Uy2QXBKFZjMgWhny7vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bux1CnK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bux1CnK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9EF1F000E9;
	Sat, 15 Aug 2026 05:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786770002;
	bh=zparzOJzvbsTKWCeTDI3dmNyvm7Ydh0FAwTpm+y3HxU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=bux1CnK+ed9UDr57phTI14nhs+L5VBReWzeyZHE5WNv5Spbs9c2XVAYkWu9NE4d1z
	 Rx9rKUo41CTFRJfQ3JkCd3q7dFvJRUf/PdEMc2xghIbyqo5MP9neU4qGCRW6yANHuB
	 U/EtluVXMBYgBKTCpmy4J2l0x6lFSTcyENIiOi2dS4uZz/XqmdwNEtZ2mi++AMX139
	 i2Jhgg/fxsKub+LzEjYjLASyyUGbrEc1VKifOXphxtOM40kRNf3BGOwcw/Kk99FVB0
	 JnUMf4BPAGIBmNNsodfuLmQoycdA/p+oCW+IkX++/226CW+3tN8lfCEu1S1jCvgycA
	 kErNSIzESyg0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BD73924474;
	Sat, 15 Aug 2026 04:59:16 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.2-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <an_qS8vOe05Vhcaa@google.com>
References: <an_qS8vOe05Vhcaa@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <an_qS8vOe05Vhcaa@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.2-rc7
X-PR-Tracked-Commit-Id: 062dc4693e2c10d77de06f61e6f3faf37c0a8383
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15ef2f78c49d20d53ec7c0f1c9b40b02e089f2d6
Message-Id: <178676995551.4077513.15877694489223481507.pr-tracker-bot@kernel.org>
Date: Sat, 15 Aug 2026 04:59:15 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 14 Aug 2026 21:25:54 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15ef2f78c49d20d53ec7c0f1c9b40b02e089f2d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
