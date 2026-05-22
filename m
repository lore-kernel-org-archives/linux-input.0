Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720A62F9DA1;
	Fri, 22 May 2026 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779431982; cv=none; b=YsqgYCPxUbN8pAJLwcIUWrwRlVOtbRwUEqUdG/llbyXrJOUTc2m+u6QyEAnMeuPl7Rv4ngwdAZIRESCXvVU79AZnaHy89tEDUTDz14/iYprsVVxuVrhAekrU1kSbAasK57ltV6niwKROse1Dj9x3G05Xk3iKVqbtRVVRuGVNQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779431982; c=relaxed/simple;
	bh=703zF7HBvZ2JTBuCPZFPHaTRq/i90mJArth8pf2OHgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jg32pdP1HczhAWLSKqt+X49FVPjCBIQ3YPCGJhfrG0Xl/GTrCV/r/08QpSeSzgwpGdKFyRr9nhxQ6SneQgGG7JyHqDvmNy62b/nsGtJjzY6hkYIFiNnZj759bDsFaxtUCpOrq0bYnSy+MSaQmivjGUsVxhLJBXxI+hmLrJNJ620=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Idn2oeCg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CPRLMPMs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Idn2oeCg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CPRLMPMs"
Date: Fri, 22 May 2026 08:39:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779431979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/l2/+QR8HVrHFaNkD6+BCH5+pWHydvpdx1MExEACOc=;
	b=Idn2oeCgXMxTp0T+VsvM9NdwNl3dykq8jgLV3f7DPAW9KZ7AhjeKmjBlmn7AudHRcFkgG4
	x10ltSd2SJnjutYReLD2O+3A8FHaUlXBz1pgtzaFKiNp9JyGJEOngCU65JAupM3JOhfP/K
	KDRO7wmHfwLW01MWQHtTiv5kw3ciKXIBLM7qI78+FXkV+UnItlp0Uqicb9uVBgBFmC2zIe
	x6KkWScEBk1kpiGE41miPQb0MSl6hFg6ZL33f4XMFfqB+fiowytN+Urb61E/AJlmXAWYxR
	Jt3H+pNF/rROYgjVv3asFyGcoL3h8MFI8XUOipR8BxdZjYpTLunDL+gLtaFp8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779431979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5/l2/+QR8HVrHFaNkD6+BCH5+pWHydvpdx1MExEACOc=;
	b=CPRLMPMsC/TfH2YjxmAp0Q3ULoax+Mue+/cV0c8RsYLATymGpBCbIEd3UBQsWUwVVkjKuv
	zbpXRcztTvn4PzCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+b5d7ab56d43de3fd5aac@syzkaller.appspotmail.com>,
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] possible deadlock in tasklet_action_common (2)
Message-ID: <20260522063938.ewKum8vW@linutronix.de>
References: <20260521143414.P7XZgsrN@linutronix.de>
 <20260521223516.914-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260521223516.914-1-hdanton@sina.com>

On 2026-05-22 06:35:14 [+0800], Hillf Danton wrote:
> input_inject_event() is invoked in the brightness_set callback [1] for
> example.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/input/input-leds.c#n142
> 
> > Now, input_inject_event() does spin_lock_irqsave() and alloc_skb() does
> > local_bh_disable()/ local_bh_enable(). On !RT this is not legal. On RT
> 
> Can you please specify why that is illegal on !RT?

So if you do
	spin_lock_irq();
	local_bh_disable();

then the
	local_bh_enable();

has lockdep_assert_irqs_enabled() which will yell. Then there is also
this local_irq_enable() which will enable interrupts before the unlock
which bad, again. Also, should softirqs been raised within this section,
the this enable will invoke the required callback which again, enable
interrupts.

> > it is okay but then local_bh_enable() here should not invoke any
> > softirqs because none were raised within the section (alloc_skb()).
> 
> On RT spinlock is replaced with mutex, and softirq can be raised in the
> irq that could come any moment after spin_lock_irqsave().

That is true on the other hand. That means having raised another tasklet
could lead to the backtrace. But it would have been two different locks,
not blocking on each other.

Sebastian
