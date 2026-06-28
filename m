Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CE036F91B;
	Sun, 28 Jun 2026 11:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782647055; cv=none; b=uPXpl7pA2NhAVinV35ib9CJHqiyCTyKRLeGW7OhZxUdXxZhFn+eoZDjTiGzsNpOnbAWiZmeNgwqI4j2W1ai0H1Xc6XHg98LrKuDiY2pcZyxmucyyuVA0LFWC6lLSH69fDHjGMiqfcavMf7rwX0k352ta6q91StmAkbWoOqMOs2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782647055; c=relaxed/simple;
	bh=VO62tfkQ+FKNdvG1fxGp2DDsldDVXAMgBxORsINfXFE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=g49E8lRe8+Q53AK7vGJlmw9mRs6CCQHNae5tgwLy5BpQU1fJKgG42HazXDTXTVOXzWmmZpjDitRdRlEDZe6wfQBDP4geh5nY/VBcymwIAl67VZH4uyZVtvac+ggqUlgT1dA8vDduI/AUdrDLLhrCQ+aHlujyHF1/OEak2/MaIuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3FZzr3r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3FZzr3r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8731F000E9;
	Sun, 28 Jun 2026 11:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782647054;
	bh=zB4u1u5JU35H/8HbWPZalE4MRu+pgyYvIti+Db/WSSk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=f3FZzr3rJ4JJCuzHHjXh97xTBkLxFp9VCXCaOjZiOqd/Kly2vjRmzwHa9GHIEnkFx
	 QT6wVDkL45D7NhMhIrfktZFoCAUofBWluioGPeK9M2U7bmtYOdFCIY/N2J6L/TLc0n
	 C0pY8NNJBgGdf9CK+cb6KxMJiGkyL30cea1is1PaxCtEKxgLS99gvQPExuHsxmzfAg
	 UOs2MHN5i2TTIZ27ziE1NE3WvIytfV1MZOLzW4k4fZAZKqUFizBXIgn0XCObSJTdK1
	 8/2zfUXQkdtZcSkq1S8ntWUpFOWzIzB8yKikoEHXKzE3S2ANw9YngfeleQ2spELVmM
	 +NbpuR40uso3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C893938463;
	Sun, 28 Jun 2026 11:44:00 +0000 (UTC)
Subject: Re: [git pull] Input updates for v7.2-rc0 (part 2)
From: pr-tracker-bot@kernel.org
In-Reply-To: <akCs9sqkWvpJnCpK@google.com>
References: <akCs9sqkWvpJnCpK@google.com>
X-PR-Tracked-List-Id: <linux-input.vger.kernel.org>
X-PR-Tracked-Message-Id: <akCs9sqkWvpJnCpK@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.2-rc0-2
X-PR-Tracked-Commit-Id: d86d4f8cbb5a55a3b9b86f7b5ab8c4cdda600a3f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b69c047587112f7bcb4b0d83f2729d8dd29ebe2
Message-Id: <178264703950.1603139.17266780663299015504.pr-tracker-bot@kernel.org>
Date: Sun, 28 Jun 2026 11:43:59 +0000
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 27 Jun 2026 22:11:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v7.2-rc0-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b69c047587112f7bcb4b0d83f2729d8dd29ebe2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
