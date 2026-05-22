Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE58639D6E5;
	Fri, 22 May 2026 07:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435313; cv=none; b=gww1zpw+j6gFOlSd+f1A4sIn038tm9NLfASscy4ISGxVYPWEWzkVEkRyVLNNZKIrtKjTnJm+WDyF5SzyRnGYg8Y6V4TlBKJi1hEmBcK5iyd9SsGQ5mpA8kOrrwm4NuHlDCLGat5buLGPyX//yLT1R+qTRqagFypegWrZf72Owdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435313; c=relaxed/simple;
	bh=RZPkyybxnShyzTWlFTPx9yqqWtEY46+afZF7baTpOYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NU8tB6EoTAoChwKw++K6KWQbGVaDfzfwVZOv/PH/Od/9z0YkN0i+bkQ/xv0vZufTCfrCsvVEiyl4b+t0ZF+r0z9IU1bn09AsBkHX8BtHA3U9Sru9YHy+M9MjfmSQImDVMaVg/nmsh5H05jqBOX/iZTt+D5XE0zkw3DF16y8J5/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pnrYqqk2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=908v2MRd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pnrYqqk2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="908v2MRd"
Date: Fri, 22 May 2026 09:35:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779435310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YUppRxB2i4LUyyDiOz6SUGJ5H5tEZHI3ItGS3cIlnM0=;
	b=pnrYqqk2tSWn6FinUxDFO9kSOTZiANyjV4QPowPabErhexR3FRklC57b6q3VH8dFWsECA3
	o6EsjP3UWgRuncNqEcn7S6gXcSZ5yeBJ04fBdpwBXF1W0HFeyrAqCI3uqZXVr358u/LJNR
	CihIn/Yg0qFLkhJUyBRZlOqNj3yqC7hwnNen6P7996Ar1Q8Eq6Oq4Q0JRFk7atfDKc3LpR
	dfLFkOuMkGHxsCnZiTiTMkrrcQgMacYKUM/b2HWjaKbymvYAoOlBPML4zOaqCmmq4RjnM/
	LeW5Ba43emk6awJcqwXWA942KTz0cADtmkZntWSAMiqGbZqZXLhxP17qIzKgTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779435310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YUppRxB2i4LUyyDiOz6SUGJ5H5tEZHI3ItGS3cIlnM0=;
	b=908v2MRda1rJzyDdqL9nZOsCVXdlUTcO990byVhC+y8w0RSFmm6s2fArUhhAV3d6CBuU9I
	/TfjwdXS4TZau2BA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+b5d7ab56d43de3fd5aac@syzkaller.appspotmail.com>,
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [input?] possible deadlock in tasklet_action_common (2)
Message-ID: <20260522073508.VfBubDl8@linutronix.de>
References: <20260522063938.ewKum8vW@linutronix.de>
 <20260522072144.934-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260522072144.934-1-hdanton@sina.com>

On 2026-05-22 15:21:43 [+0800], Hillf Danton wrote:
> > > On RT spinlock is replaced with mutex, and softirq can be raised in the
> > > irq that could come any moment after spin_lock_irqsave().
> > 
> > That is true on the other hand. That means having raised another tasklet
> > could lead to the backtrace. But it would have been two different locks,
> > not blocking on each other.
> >
> The last question, by two different locks, do you mean that the
> tasklet_sync_callback.cb_lock is per cpu?

Yes, it is but this does not matter. kbd_led_trigger_activate() does
tasklet_disable(&keyboard_tasklet) so you can't have kbd_bh() running
and led_set_brightness() which would kick the softirq again. Not from
kbd_led_trigger_activate().

Even if another component would raise a softirq in that window, you
could run tasklets, yes, but never kbd_bh(). Not in this window.

So the kbd_led_trigger_activate() -> input_inject_event() needs to be a
different event device than kbd_propagate_led_state() -> event. I don't
see how you could unfold this.

I *think* lockdep observed all this possible interactions and sketched
this possibility but it does not know about tasklet_disable().

I do have an idea how to avoid alloc_skb() invoking softirqs if someone
else raised them while alloc_skb() was preempted. This could avoid this
kind of splat.

Sebastian
