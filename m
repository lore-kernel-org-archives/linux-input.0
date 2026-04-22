Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ECC221F2F
	for <linux-input@vger.kernel.org>; Wed, 22 Apr 2026 06:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776837672; cv=none; b=eh4icaWIoluUvGiLKhKUdIs43Zbl9hC0An3E3IMvAy9SfkGoRm/8wHdfhJTS4ezWri+DOvpgadJeC1/+rSgEBxedRVLeeeBOp5ov5yUPCQoHenqdWmEJdGJY9aT6QV9zsUlxw/QRRQm9sg6ntYZ1dZZXjsch5+W93MKgLw+NtcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776837672; c=relaxed/simple;
	bh=96+fqpJOt/DP5U220RpPJUeLZW6cS4SNc2ypis77Dns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ir7R1XOMNA/l40O/Uh8YNWgdVsuMrzdMpxe9ZHm0xv1tQqHqsDI/1ptusBRuK5vxrn7DfYhnHLLImbbpMAjVUZwfl8aDHxcXTuK5BNkBJCdZcnZzVWsIFehKAuUsBiG7K/V5mVuiQ5DzDDxJCDIbF/t7Q98fgJgCf/VbeRucOtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=QbA2o5gD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="QbA2o5gD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b4583f0a1aso31416135ad.3
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2026 23:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1776837667; x=1777442467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTPAd7gTWT6PXMVUqnAHcWVYkcg1X7/gNnL/J+fsQmI=;
        b=QbA2o5gDAcFEgosw//E1hAQpYonnvPBEN3FFrhv/e7olJxFDtA/+K4gCjcnec9m3iH
         MPEDJvLjrofpweInHCjlXQH6oxUVMh757LiUOmNlnTH2EqKHsHpLf8H3pR0/Ll/2O1UB
         IR7D39YJ2qyNSZbjGf8LJQ1w5CR7rNRqzfess=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776837667; x=1777442467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTPAd7gTWT6PXMVUqnAHcWVYkcg1X7/gNnL/J+fsQmI=;
        b=V8GGdZZrL8oBCNcPfSkm0tbWBvO7q8JxQZVCpzhIukryOjqKXrCcXTK3lDgnsuTUP5
         5nBNwagLLTW6R8KKX2jj1TN6FRDEXmFP4sNW6yEv4PMp3UqkeKIkIC1RtL3CxwRaZSBI
         cZrDUIdOoNuUpIIMw53utxfX4gys9rwUWXziVzAz5Rqi+ocp3xojCf0An2ZUGXX25uPI
         TZyQcS4WsqSW8Muq7tQYkZaeEOIBhAidrue1b5jL3FskU8Tsa5v5uBY7g1vhstdXuRf/
         ogpXtQFFbW29sUODbSS0WpAN6mD3Y5vM48fJ7wZZWGCL4LmTPuosI5Xye7XXySWAv1j7
         OkyA==
X-Forwarded-Encrypted: i=1; AFNElJ80+biWwH31lfnQK3YjaUF/W/XNNladpToTdoDEsVH3K2jlJxqtAIHsg2+8G+0Sd1m8E+mxj3uHyFHiLw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUAHxIs9b1Z9BB357qU89FOXk7mA4BV7we0l7YX/mSIU4bbpmY
	Cp7g9Z8RHSaVwjGRCLdhdC6cRg2rFL2OAjYJfb/Hfb15q/PAnVGC1n3tCtlk8AViumMUtaRG87B
	PdnrS7KCUxQ==
X-Gm-Gg: AeBDieuVX0aR41EPC4aYeNeIA1phea5MoUwVFbU5lz1C93oMuSoVwiY+KBNnYzELDrb
	t6lAusxbjjdit6TS2C42zzHHIy7jqxBB+NmueyACxR1DqhQFP6e/Mu8dWwSbqBNAs5Mqy/Hd+X5
	iUbair27geJu8JO3BLLQ3scDcVtX0+W0H0Lc44kzjGvvix2/oyVBsloKogAr2B+pO7j0P+HX7FC
	H348G7HZ/t+MhyGPM81iEtG3162Z7ca6fupD7Oi7q1KMYx6MND0VfQGJXEZPbJ8L24lJ1HMJbyg
	KrIHV1OB/6aJiPVUk6S+JnKjYmFo8NOwgsmP79ecp5gDQXUxUmzJ5fIzlF6QHdylsOxpwrk96/M
	g61opMwzR7n/TNK61MsxJtGzmWtH+1iQDUkZyNP4SNbg1ldyyeGNPBDcGo+ySBkKUJK9wSmrDrE
	4TScJbpDud8XHNNWfvlNSvBs1GP5u/8/9Ei7rKV5z+Us0qnodkilFfxhBrJlEskoLltTBeNbWgB
	4bZNEkvhxi9
X-Received: by 2002:a17:903:1b03:b0:2b2:5637:1480 with SMTP id d9443c01a7336-2b5f9ff44d3mr216431115ad.40.1776837667015;
        Tue, 21 Apr 2026 23:01:07 -0700 (PDT)
Received: from localhost (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20ae4sm188195875ad.61.2026.04.21.23.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 23:01:06 -0700 (PDT)
Date: Wed, 22 Apr 2026 15:01:04 +0900
From: Sangyun Kim <sangyun.kim@snu.ac.kr>
To: Aditya Garg <gargaditya08@live.com>
Cc: jikos@kernel.org, bentiss@kernel.org, qasdev00@gmail.com,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: appletb-kbd: fix UAF and mutex-in-atomic in
 inactivity timer
Message-ID: <20260422060104.jbimo4nm6pat3f53@nunu>
References: <20260420051318.1411671-1-sangyun.kim@snu.ac.kr>
 <MAUPR01MB115460F44776CC8E5E5EE7DC4B82F2@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <MAUPR01MB115460F44776CC8E5E5EE7DC4B82F2@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>

On Mon, Apr 20, 2026 at 06:17:36 PM +0530, Aditya Garg wrote:

>
>
>On 4/20/26 10:43, Sangyun Kim wrote:
>>This series addresses two defects in hid-appletb-kbd's inactivity
>>timer subsystem.  The two patches target different bugs and are
>>logically independent; they are sent together because they touch the
>>same tear-down code and because the same maintainer will review both.
>>
>>Patch 1 fixes a slab use-after-free with two related tear-down windows
>>introduced by commit 38224c472a03 ("HID: appletb-kbd: fix slab
>>use-after-free bug in appletb_kbd_probe"):
>>
>>   A) Within "if (kbd->backlight_dev)" the order was
>>      put_device() then timer_delete_sync().  A concurrent
>>      hid_appletb_bl unbind between those two calls can drop the last
>>      devm reference and free the backlight_device; the still-armed
>>      inactivity timer softirq then dereferences the freed object
>>      through backlight_device_set_brightness() -> mutex_lock(&ops_lock).
>>
>>   B) The "if (kbd->backlight_dev)" block ran before
>>      hid_hw_close()/hid_hw_stop(), so even after window A is closed a
>>      late ".event" callback from the HID core (USB URB completion on
>>      real hardware) can arrive between timer_delete_sync() and
>>      put_device(), reach reset_inactivity_timer(), re-arm the timer
>>      via mod_timer(), and reopen the same UAF.
>>
>>Both windows produce the same KASAN slab-use-after-free on the object
>>allocated by devm_backlight_device_register().  Patch 1 closes them
>>together by moving hid_hw_close()/hid_hw_stop() before the backlight
>>cleanup and, inside that cleanup block, calling timer_delete_sync()
>>before put_device().  Shipping both as one commit avoids leaving
>>stable kernels in a half-fixed state where only window A is closed.
>>
>>Patch 2 fixes a separate "sleeping function called from invalid
>>context" bug in the same subsystem.  The inactivity timer is a
>>struct timer_list, so the callback runs in softirq context and calls
>>backlight_device_set_brightness() -> mutex_lock() from atomic
>>context; reset_inactivity_timer() has the same issue on the
>>brightness-restore path (it is called from appletb_kbd_hid_event()
>>and appletb_kbd_inp_event(), which run in softirq/IRQ context on
>>real USB hardware).  Convert the inactivity timer to a delayed_work
>>and defer the brightness-restore call to a dedicated work_struct so
>>both sleeping calls run in process context.
>>
>>Sangyun Kim (2):
>>   HID: appletb-kbd: fix UAF in inactivity-timer cleanup path
>>   HID: appletb-kbd: run inactivity autodim from workqueues
>>
>>  drivers/hid/hid-appletb-kbd.c | 56 ++++++++++++++++++++++-------------
>>  1 file changed, 36 insertions(+), 20 deletions(-)
>>
>
>I had a very weird bug just once. And that was when I pressed fn key, 
>upon releasing, the touchbar mode did not restore to normal.
>
>Although it was just once, and I was never able to reproduce it again.
>
>Have you tested it on your Machine btw?
>
>

Hi,

I have not tested this series on actual Apple Touch Bar hardware on my
side, as I do not have access to such a machine locally. All testing on
my side was done under QEMU with a uhid-based setup.

Because of that, I cannot say much about the one-off case where the
Touch Bar did not restore the normal mode after releasing Fn. I have not
been able to reproduce that specific behavior in my setup.

For patch 1, however, I was able to reproduce the teardown UAF in the
uhid/QEMU setup and got the following KASAN report.

[   56.040407] ==================================================================
[   56.042444] BUG: KASAN: slab-use-after-free in __run_timer_base.part.0+0x861/0x910
[   56.044962] Write of size 8 at addr ffff88801b7e8958 by task swapper/0/0
[   56.049092] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G                 N  7.0.0-dirty #2 PREEMPT(full)
[   56.049967] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   56.050843] Call Trace:
[   56.051146]  <IRQ>
[   56.052394]  __run_timer_base.part.0+0x861/0x910
[   56.053123]  run_timer_softirq+0xd1/0x190

[   56.075012] Allocated by task 11:
[   56.077221]  devm_kmalloc+0x70/0x1d0
[   56.077545]  appletb_kbd_probe+0x65/0x470 [hid_appletb_kbd]
[   56.085606]  uhid_device_add_worker+0x3b/0x100

[   56.088719] Freed by task 11:
[   56.091296]  devres_release_group+0x1fd/0x3d0
[   56.091844]  hid_device_probe+0x4db/0x7d0
[   56.096916]  uhid_device_add_worker+0x3b/0x100

[   56.123572]  backlight_device_set_brightness+0x77/0x280
[   56.123902]  appletb_inactivity_timer+0xe9/0x190 [hid_appletb_kbd]
[   56.123967]  call_timer_fn+0x163/0x4a0
[   56.124338]  __run_timer_base.part.0+0x575/0x910
[   56.124711]  run_timer_softirq+0xd1/0x190

Patch 2 also matches what I saw in the same setup. On the unpatched
tree, I can reproduce:

[   56.120488] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:591
[   56.121118] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/0
[   56.123080]  __mutex_lock+0xda/0x21c0
[   56.123572]  backlight_device_set_brightness+0x77/0x280
[   56.123902]  appletb_inactivity_timer+0xe9/0x190 [hid_appletb_kbd]
[   56.124338]  __run_timer_base.part.0+0x575/0x910
[   56.124711]  run_timer_softirq+0xd1/0x190

After applying patch 2, that warning no longer appeared in the timer
reproducer in my uhi/QEMU runs. I also added a small UHID input trigger
to exercise appletb_kbd_hid_event(), and in that setup brightness
restored from 1 back to 2 in 5/5 iterations after the synthetic key
event.

The limitation is that this is still UHID-only coverage. I do not have
native Touch Bar hardware, and pure UHID does not model a real internal
Apple keyboard/trackpad closely enough for me to claim coverage of the
appletb_kbd_inp_event() path or real USB IRQ-context behavior.

Thanks,
Sangyun
