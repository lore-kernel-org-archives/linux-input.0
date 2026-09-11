Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349B34D4E9;
	Fri, 11 Sep 2026 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138485; cv=none; b=tTzLL8ZdzEKY479UoEnTup8FOL7CB3CNuIqcrw0gWM577qeWf8jJK8pBOcfvDGq27bS8PAk0Kei0tmtnpMpMbZklOcL4bMEk2SkNmq0JBI0EP2EJr/4rzYPJ4OjPz/2VoBDbxqesyLPViGyrhEso/MDtyNumIRhl1c/7u2l4Yp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138485; c=relaxed/simple;
	bh=Ct5xPWit20lfRZZPpHb2H9nQ+btY5AuzqCysPk9gcDQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QHX7jh3GWdguO2gDJvklW5GYMIbATHBCUH27yl1pga5lN+DnSOPJW1qsPRpi6v9ReP2NKURoBRMu7KINtQjbDWYjeEjhXe/t1ITNhxHVODsOsezyMK6WQaWUX6/fZZkWNWQTBa50MjzPB5xKBeJRm+SYhb4QGADBOkLvjiuGORc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea8wSyiP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea8wSyiP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60E11F000FF;
	Fri, 11 Sep 2026 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138483;
	bh=qcFUC+ZurgT0gvwGInLnLwG6QKnEPHYzFiSizJq/bNw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=ea8wSyiPTUC0ThzJq9QuRyqSVel2CyNHNYz4V27ZIk/vYqlluy1q34GvYDLhtb/TS
	 8bfWPM6/5L0SrW3u+bt2kQD0arGVL9sMwDERyQ+0+m98PwhVjw3Sd29W4CMpDG4HLE
	 Ruvf/vDgO59Y300zTLN81v4d7hs3zlBu4YCLW9M4Bdmt5IO9ighH/Oy0neTYeSsB9I
	 mE1WAhF603NYQbRbEwdzBhLjYJhiXkcIS4mR+05OsxGzW/vJSZIB7g4HU4RGPeK9zP
	 95BAKcvbd8Oa60U5ufuhTuSIhYirq99ZjFL0xSUotT7VFCIM61mVy5HFnuX6Brekzm
	 mrDVNlr+6+uNw==
Date: Fri, 11 Sep 2026 16:54:40 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: co <co+b240dc164119a46c@bugs.sh>
cc: linux-input@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
    Andrej Shadura <andrew.shadura@collabora.co.uk>, 
    linux-kernel@vger.kernel.org
Subject: Re: [BUG] drivers/hid: use-after-free in u2fzero_recv()
In-Reply-To: <UFZgYBPFzraRy8BQcngd1LpE4nCofXZsBVbb@bugs.sh>
Message-ID: <2r7082oo-1qoo-4r04-6nnn-r193s5n91rns@xreary.bet>
References: <UFZgYBPFzraRy8BQcngd1LpE4nCofXZsBVbb@bugs.sh>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 27 Aug 2026, co wrote:

> We found a bug reachable in:
> 
>     path    drivers/hid
>     crash   use-after-free in u2fzero_recv()
>     commit  6f232446a629 ("Linux 6.12.77")
> 
> Config, environment, the sanitizer report and a C reproducer follow.
> 
> == Notes ===============================================================
>     If you patch the bug based on our artifacts, a tag would be
>     appreciated:
> 
> Reported-by: co+b240dc164119a46c@bugs.sh
> 
>     Everything in this mail is validated by the reproducer below.
> 
>     We also hold an LLM-generated root-cause analysis and a candidate
>     patch. The patch passes an A/B test: the same reproducer panics the
>     unpatched kernel and runs clean on the patched one. Neither has had
>     human review, so both still require validation before you send or
>     apply them. Available on:
> 
>         patch.diff  https://bugs.sh/b/b240dc164119a46c/patch.diff
>         report.md   https://bugs.sh/b/b240dc164119a46c/report.md
> 
>     This is an open science project. The code and the full set of PoCs
>     are not public at this moment, as we intend to disclose our findings
>     in an ethical way.
> 
>     Happy to test patches. Complaints and suggestions about our work
>     are welcome at:
> 

Could you please submit this as a proper patch [1] so that you can 
properly creditted for the fix?

Thanks.

[1] Documentation/process/submitting-patches.rst

-- 
Jiri Kosina
SUSE Labs

