Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7338E8D2;
	Tue, 12 May 2026 15:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601481; cv=none; b=ksqmbQT1TKNPdkO6LtU5Y8+3eJtPVwJTRVQFWeHh/5ASybiZXaAGWZEhynPTAxOUKlSDOyXXEs8t/N7jwk91WdoRTEoPjjvEDNztuqry9RjbLVsRU367tb6DTz+sw+DOef2mudwRInrabDVepUSsoFSRebGCdfG0RVq7NcOzEy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601481; c=relaxed/simple;
	bh=Y6IcuyhXRDfs6AJDoMN/xWrVYOOiTEHwmAUTk8WPC+E=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RoNJdbTBp7QgV7U3FrlZiQzJpefNLV2W+dGIQFdsslVDKgZ6xaA9T78PL2mLX7kwstXoNG8f0hicXaWu7hlJJvo/k4H09kRgxM2Hz4igG13tGw4gYHIA7YouoXrAFCpQ1+igZTRNSdArCtREKzlgT1Kmt1uwy+I0IIDSJHYLyyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSn+gwYO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSn+gwYO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463A4C2BCB0;
	Tue, 12 May 2026 15:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778601480;
	bh=Y6IcuyhXRDfs6AJDoMN/xWrVYOOiTEHwmAUTk8WPC+E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=nSn+gwYOCz4BXkbiWXykO9U3xxzEW4MbLz2JWx8vFqZ3+miyb36yHs6ji35Cph6Ud
	 I0yjMmhDO4orBzcRRnal5hnqe+pnMu1G9ySM2RGJq2OQpI2FDgld4cCpYjVvjIFDlY
	 05AqRZ8Rb6HnwmZLJjeLrurzl4EiPcQiBYZ6N1ZuxE3W5JkBk2lWhuKYkCA2S/Rqa/
	 EGXYm7nHOpwViCKcXM02vOWe4VqzRtrCCADYZAkKy4NdcPoz7x3Fx9r9Q0hiZ525+8
	 +OOs6lEBcZG/kzQdHXyKu5QV+2yMq6hABhu/P4X4Zy1zJ4QpXVHyL911QMq+wpCm2C
	 sKlUzGmgFPzEA==
Date: Tue, 12 May 2026 17:57:58 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Sangyun Kim <sangyun.kim@snu.ac.kr>
cc: bentiss@kernel.org, qasdev00@gmail.com, gargaditya08@live.com, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: appletb-kbd: fix UAF and mutex-in-atomic in
 inactivity timer
In-Reply-To: <20260420051318.1411671-1-sangyun.kim@snu.ac.kr>
Message-ID: <po64s18s-27rr-9o3q-0pqo-2552nn6448sp@xreary.bet>
References: <20260420051318.1411671-1-sangyun.kim@snu.ac.kr>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Apr 2026, Sangyun Kim wrote:

> This series addresses two defects in hid-appletb-kbd's inactivity
> timer subsystem.  The two patches target different bugs and are
> logically independent; they are sent together because they touch the
> same tear-down code and because the same maintainer will review both.
> 
> Patch 1 fixes a slab use-after-free with two related tear-down windows
> introduced by commit 38224c472a03 ("HID: appletb-kbd: fix slab
> use-after-free bug in appletb_kbd_probe"):
> 
>   A) Within "if (kbd->backlight_dev)" the order was
>      put_device() then timer_delete_sync().  A concurrent
>      hid_appletb_bl unbind between those two calls can drop the last
>      devm reference and free the backlight_device; the still-armed
>      inactivity timer softirq then dereferences the freed object
>      through backlight_device_set_brightness() -> mutex_lock(&ops_lock).
> 
>   B) The "if (kbd->backlight_dev)" block ran before
>      hid_hw_close()/hid_hw_stop(), so even after window A is closed a
>      late ".event" callback from the HID core (USB URB completion on
>      real hardware) can arrive between timer_delete_sync() and
>      put_device(), reach reset_inactivity_timer(), re-arm the timer
>      via mod_timer(), and reopen the same UAF.
> 
> Both windows produce the same KASAN slab-use-after-free on the object
> allocated by devm_backlight_device_register().  Patch 1 closes them
> together by moving hid_hw_close()/hid_hw_stop() before the backlight
> cleanup and, inside that cleanup block, calling timer_delete_sync()
> before put_device().  Shipping both as one commit avoids leaving
> stable kernels in a half-fixed state where only window A is closed.
> 
> Patch 2 fixes a separate "sleeping function called from invalid
> context" bug in the same subsystem.  The inactivity timer is a
> struct timer_list, so the callback runs in softirq context and calls
> backlight_device_set_brightness() -> mutex_lock() from atomic
> context; reset_inactivity_timer() has the same issue on the
> brightness-restore path (it is called from appletb_kbd_hid_event()
> and appletb_kbd_inp_event(), which run in softirq/IRQ context on
> real USB hardware).  Convert the inactivity timer to a delayed_work
> and defer the brightness-restore call to a dedicated work_struct so
> both sleeping calls run in process context.
> 
> Sangyun Kim (2):
>   HID: appletb-kbd: fix UAF in inactivity-timer cleanup path
>   HID: appletb-kbd: run inactivity autodim from workqueues

Both applied to hid.git#for-7.1/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

