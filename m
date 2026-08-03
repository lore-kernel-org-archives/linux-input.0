Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C585B3C1F;
	Mon,  3 Aug 2026 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783896; cv=none; b=fJ/Vbt/Mgv1BfK5iTPolfx8MPxIhhECqz4SzhfNu/9+EVYEvnTA5y0HC/hSiQsPPswg18zFrQUwUAwDoq+41pBWcqxj4B6IIXBUmLdwdUSMZwNWcd3ERadSlQMguoEQCdjOBPYB1gVllMXGjgTDWi5JUdkne08tDxSwBtdIrIEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783896; c=relaxed/simple;
	bh=NqesO0KkOsFbxiuMi9WA+FeZpLzBh8k/dod7FS+Izjs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qyeLXvTakMpn8kbEOD7GVrhv1YPM3u8NGchQSh8ZD6cE32yXoY6PZIkBwIlVYs3VOt6lSHW5FfOURJKwWfcU6ZafYcYompZlOuhbTkMPYxrwJLtmwQaKj7BUfYu9bqd9qLJ8Vn63qE2KIDe9PRBLpiWAgKB2naWA9EucGpgrnE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYQpVqQO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYQpVqQO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABF31F000E9;
	Mon,  3 Aug 2026 19:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785783895;
	bh=LXDAtqExoSYV1Rj5yln61l2BXwuNwjB5gIyR23QC0Rw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=BYQpVqQOY34aNm6ju7uipUVRWc8e6A8THAXl9kyEqlutn2J2TTm8WFwYMiYBtLqde
	 ni3t/sRI9L/8V1ETNzbN4TBkEfipolr+xpuGJJLRrUspAjNSiDkQPZG3f56v5YY4AM
	 5iNQc4ndj+qFO8D4JT/UUKQDk+cdtybXAzhJupwEGGDmpL9HAT6cWcL5fD2KTbyjRz
	 Uh0ag3JKxu5+7JFfndrWeSNqQjtjlGjPCqM5CelK2h0ol/1NgAnJjgyKGLQcf59hnl
	 w8vJZ2qB7ZvNG0/rm8tpySg+lRtPf7JLorrECgapfynnVCFroo2G40VBVcIzQXR+p7
	 DeHivv3wRJM8g==
Date: Mon, 3 Aug 2026 21:04:52 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
    Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
    Frederic Weisbecker <frederic@kernel.org>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Michal Hocko <mhocko@suse.com>, Benjamin Tissoires <bentiss@kernel.org>, 
    "Derek J. Clark" <derekjohn.clark@gmail.com>
Subject: Re: [PATCH RFC 0/2] HID: Replace system_wq with system_dfl_wq
In-Reply-To: <20260707145327.313292-1-marco.crivellari@suse.com>
Message-ID: <93161p47-3sn5-r588-o6o5-6n895365387o@xreary.bet>
References: <20260707145327.313292-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 7 Jul 2026, Marco Crivellari wrote:

> Hi,
> 
> Currently the code uses the per-cpu workqueue system_wq to schedule
> delayed works.
> 
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Another good reason to have this unbound,
> is the "queue_delayed_work()" function, used to enqueue the work item.
> 
> ~~~ Details about queue_delayed_work ~~~
> 
> system_wq is a per-cpu workqueue and it is used as a parameter of
> mod_delayed_work(). This function schedule an item that it will later
> be enqueued (once the timer will fire). __queue_delayed_work() does the job
> receiving as "cpu" WORK_CPU_UNBOUND:
> 
>     if (housekeeping_enabled(HK_TYPE_TIMER)) {
>     //      [....]
>     } else {
>             if (likely(cpu == WORK_CPU_UNBOUND))
>                     add_timer_global(timer);
>             else
>                     add_timer_on(timer, cpu);
>     }
> 
> The timer is global, so can fire everywhere, and the work item will be
> enqueued where the timer fired.
> 
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change the
> workqueue with system_dfl_wq, so that the used workqueue is now unbound
> and can benefit from scheduler task placement.

This definitely is a step in a right direction, thanks! Now applied (and 
sorry for the delay).

-- 
Jiri Kosina
SUSE Labs

