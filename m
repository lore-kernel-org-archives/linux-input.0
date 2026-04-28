Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808982DF717;
	Tue, 28 Apr 2026 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393986; cv=none; b=QopI1KfSKxkG10RlMdzSfXViE9KZsEXQHLXCGrVOnTTVOpVrYQ8oj7ufmIFiQUsX8Ky9+rz6Iycq6nhulxbaAcpx6zg3/CJk/0/NF9AGMM4e21p4uuoviMOdq2LzRZgK3v30i6oSmk+Ngteo7ifUlje0mUfVe2RrPHiPkr1WtcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393986; c=relaxed/simple;
	bh=YKxf73qnf5x7bmwlyY2LY3KgYCdLEVWQmWC46xsbSxw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=FuNnqF8oZ9PSrxhV1G2VrJLOxt9RsgIOaSYmMHWvnOXv/Ah5jcXzuvlI4qR6+X3QO3E6bWeaCaVxmPQbq15/v5CUR/sOiWQY3Jf/fs0Ua8+Zek9KqCSwSe2F6CzGE+ZslJsFW5K9eYxZ/MKVbfeOV8qwRgbESNJ8Dwnubf4snu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7b8uVMV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7b8uVMV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D347C2BCB5;
	Tue, 28 Apr 2026 16:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777393986;
	bh=YKxf73qnf5x7bmwlyY2LY3KgYCdLEVWQmWC46xsbSxw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=l7b8uVMVbii3jPPBZMDu7/rWtCpfwtgWPFBSSqZcLo4wyHFRJ87QRvXr/yDLBHgPX
	 wg6lev1uS+2DLEH6JB73reRkDsnX/V/UDgaK4/PP7BdMMWAkkAPN5woCNS/uIjv1/E
	 nggrIEhVqH0pin6Ky+ctcclg52zRKTe8rayxjNFkxTwe1cnGGaEvS51aJymD00JNyT
	 UUW46ASvN20nt8lXqf3ebNUFIqodZh1WsTACM+lqhCMqAv/U1YFkZYqmkMMT/WDhr/
	 Bkc6NsIldyoLjfCVoj6y/RUsP5KHGLLE/DNB/5VgYFZm989Ozniu+x0eT3CrL52wcj
	 EFtrUd0XQBy+w==
Date: Tue, 28 Apr 2026 18:33:03 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Aditya Garg <gargaditya08@live.com>
cc: Sangyun Kim <sangyun.kim@snu.ac.kr>, bentiss@kernel.org, 
    qasdev00@gmail.com, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: appletb-kbd: fix UAF and mutex-in-atomic in
 inactivity timer
In-Reply-To: <MAUPR01MB115460F44776CC8E5E5EE7DC4B82F2@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <s3qr2s36-n156-4srp-771s-20130s13760r@xreary.bet>
References: <20260420051318.1411671-1-sangyun.kim@snu.ac.kr> <MAUPR01MB115460F44776CC8E5E5EE7DC4B82F2@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 20 Apr 2026, Aditya Garg wrote:

> > This series addresses two defects in hid-appletb-kbd's inactivity
> > timer subsystem.  The two patches target different bugs and are
> > logically independent; they are sent together because they touch the
> > same tear-down code and because the same maintainer will review both.
> > 
> > Patch 1 fixes a slab use-after-free with two related tear-down windows
> > introduced by commit 38224c472a03 ("HID: appletb-kbd: fix slab
> > use-after-free bug in appletb_kbd_probe"):
> > 
> >    A) Within "if (kbd->backlight_dev)" the order was
> >       put_device() then timer_delete_sync().  A concurrent
> >       hid_appletb_bl unbind between those two calls can drop the last
> >       devm reference and free the backlight_device; the still-armed
> >       inactivity timer softirq then dereferences the freed object
> >       through backlight_device_set_brightness() -> mutex_lock(&ops_lock).
> > 
> >    B) The "if (kbd->backlight_dev)" block ran before
> >       hid_hw_close()/hid_hw_stop(), so even after window A is closed a
> >       late ".event" callback from the HID core (USB URB completion on
> >       real hardware) can arrive between timer_delete_sync() and
> >       put_device(), reach reset_inactivity_timer(), re-arm the timer
> >       via mod_timer(), and reopen the same UAF.
> > 
> > Both windows produce the same KASAN slab-use-after-free on the object
> > allocated by devm_backlight_device_register().  Patch 1 closes them
> > together by moving hid_hw_close()/hid_hw_stop() before the backlight
> > cleanup and, inside that cleanup block, calling timer_delete_sync()
> > before put_device().  Shipping both as one commit avoids leaving
> > stable kernels in a half-fixed state where only window A is closed.
> > 
> > Patch 2 fixes a separate "sleeping function called from invalid
> > context" bug in the same subsystem.  The inactivity timer is a
> > struct timer_list, so the callback runs in softirq context and calls
> > backlight_device_set_brightness() -> mutex_lock() from atomic
> > context; reset_inactivity_timer() has the same issue on the
> > brightness-restore path (it is called from appletb_kbd_hid_event()
> > and appletb_kbd_inp_event(), which run in softirq/IRQ context on
> > real USB hardware).  Convert the inactivity timer to a delayed_work
> > and defer the brightness-restore call to a dedicated work_struct so
> > both sleeping calls run in process context.
> > 
> > Sangyun Kim (2):
> >    HID: appletb-kbd: fix UAF in inactivity-timer cleanup path
> >    HID: appletb-kbd: run inactivity autodim from workqueues
> > 
> >   drivers/hid/hid-appletb-kbd.c | 56 ++++++++++++++++++++++-------------
> >   1 file changed, 36 insertions(+), 20 deletions(-)
> > 
> 
> I had a very weird bug just once. And that was when I pressed fn key, upon
> releasing, the touchbar mode did not restore to normal.

You mean with this patch applied, correct?

-- 
Jiri Kosina
SUSE Labs

