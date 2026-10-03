Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E6934BA24;
	Sat,  3 Oct 2026 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791041014; cv=none; b=OoYyQbSBCWtpnavqIrYUvrsjYoyuiBrJ+r/GqFndzWBzwtH/DfUKjL3ihlHTr3rpdN8nJroJdxo71J0GqQfmsvOBUXz2Ca0A7vSJep+SbVx3fJGaZtlqkQ0Xo3LarbrnpIkzXi3cQTKuWiz5OvnUBNLDLH5K0BRnsj3jDQVU91E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791041014; c=relaxed/simple;
	bh=2e+FPhnk7TCKbZNW1J2I5ni6LnEjLyix7vL4u4Zw5tM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=n4XHqHze/EfmCXaS5GBq6Oe8WcNK5qZJqb4Yh5nAIJmSHPF7BWxk7+k6aDsw9eJWHk3qr4pDuLWaE7UvGQV9vc2hyj8V9vQbmr/2Qr/PmVy38t+boiDhLYqmCl8MDmJ7wc8DoZBkw7179xuE22naQbvjg/aGpSo71JlzWUoxqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rtb4iCAr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rtb4iCAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F17A1F0089B;
	Sat,  3 Oct 2026 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791041013;
	bh=whRt+kBUVi5PMNiXEI6D/CsC+OJZVM2SreWtvg6Qp/A=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Rtb4iCArz/3yQ2in1aYh7ZOWQj5SIgK2mHbwYq3ALJBq5zYOrDc9WgXH1Gq2vwVMF
	 U8bjXXy44q8efBHYl2LUTSGK0ltn4KduTWpWKLcqCcxOc1OzsfeYHWL619HhNTbpT6
	 JA3LUkA2lNk6rS8PkQp/+rYb2u2Whcijlie3q9p3khQBT8SCn528lBhA9CoOO8xe+T
	 zzASacYcONV9T46ueQilxYsS+24nqQVoJLjXjUVoAxgjzbhw/wt3Emy+q9mT6gDBCz
	 qEzCIGZzrikHVr09dLphJNYLK/sNIUoL2em6cuuJUw/uzYWToP+WLiXojCur2eaPVy
	 IrenVlOExxBAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774FA3924470;
	Sat,  3 Oct 2026 15:23:33 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.3-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <asCSdpnXizdBEOtE@google.com>
References: <asCSdpnXizdBEOtE@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <asCSdpnXizdBEOtE@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.3-rc5
X-PR-Tracked-Commit-Id: 3bf8d603fd45649c106cae6290a10f20b1bbb569
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8623551a424d34a311bab3fb9243535c98e08c26
Message-Id: <179104101199.114271.14030891195562563970.pr-tracker-bot@kernel.org>
Date: Sat, 03 Oct 2026 15:23:31 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Oct 2026 22:28:38 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.3-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8623551a424d34a311bab3fb9243535c98e08c26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
