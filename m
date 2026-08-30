Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1139C2D9EED
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123920; cv=none; b=Zx9zHL9QBQqWB0FGNri3Qxrgb0TYdcoGvCl9xFMx+0KjtXhxh2lLX3IlQnk00oNh1oEAijv4h1E8iCPY/GviOZqEton8M2nNdQf1RnADc+ewtFyEmHcfiQ3s2kc8ZgmjLhmd97DpRj32BnwMWR2XB6r/lM9QCNpJPbdD48wLkZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123920; c=relaxed/simple;
	bh=CmpvIJTENZl7Hfy57sFd4FgcUf0qQHJbwKoHgC9DRNk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=duhSRKqBd48pGva7az0rey+ceBzjiqFRXPfmWI/A+RdlyeAKgSVh/bqR3rCmFnbelxz+OKF1Kmh52hwS0SAt9XynZtDPhX++QhAg5pk2GpfNa0j6fNHia2uYEnVuSYfJq8O9FiAQxFaMSSxeZh831jtnG6ruHpUohTZtDGH2Kl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+8pygxX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+8pygxX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D5A1F000E9;
	Sun, 30 Aug 2026 21:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788123918;
	bh=Isyvk5bGTaMZ1pocvQc/PZvVfKejb2EXB8Plx1cauzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f+8pygxXG7VucJt2FVVPo5zeJPlkGQuQfVZS1IAsEj8EDWbadjf1Fh7dPZAE7sVvl
	 VNQb3k41kbhT2wqpWYs0uUaGAYPAAbUqoPJ0Hbmahk5BLmmvrQ7z77THeNMxNRziTr
	 Z5uK+If4yyF/60i4wss4KKFvdVK630D5tmBpPdYFbAacUEsquigfrXk5mfBXNI4NYz
	 LS4CVqrjQbgUliA/SM0dXBtag5xSafme1y0Kgvi9NVBmlWZnqIVC4m/WZbpDOc//VR
	 kZSj7Q0m+ZAIzz68KFNYU/Wi2l/5eIvwbTh5pkvsqsZYhqgTOv3RrhiuRIl/8kucO1
	 sbMqqLhrsAlFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] Input: gscps2 - drop busy-wait and manual interrupt
 pump on transmit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260830-gscps2-v1-7-c733d4cae7f9@gmail.com>
References: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
 <20260830-gscps2-v1-7-c733d4cae7f9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 21:05:18 +0000
Message-Id: <20260830210518.77D5A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Infinite spin-loop in `gscps2_writeb_output()` waiting for receive=
 buffer to clear deadlocks the CPU if called from atomic/interrupt context.
- [High] Level-triggered interrupt storm leading to permanent IRQ disable d=
ue to `trylock` failure in `gscps2_interrupt()`.
--

commit d741b31bf7785974793010391810ed95e0a48648
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

    Input: gscps2 - drop busy-wait and manual interrupt pump on transmit
   =20
    In gscps2_writeb_output(), after writing data to GSC_XMTDATA, the driver
    explicitly executed mdelay(6) and manually called gscps2_interrupt() as=
 a
    polling mechanism to accelerate command responses (such as keyboard ACK
    or LED updates).
   =20
    On PA-RISC, the PS/2 controller asserts a level interrupt to the system
    ASIC whenever received data arrives in hardware, and the input/serio
    subsystem handles command responses asynchronously via completions.

> diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
> index 2afd53a163ffa..985539f1d0886 100644
> --- a/drivers/input/serio/gscps2.c
> +++ b/drivers/input/serio/gscps2.c
> @@ -356,13 +356,6 @@ static inline int gscps2_writeb_output(struct gscps2=
port *ps2port, u8 data)
>  	scoped_guard(spinlock_irqsave, &ps2port->lock)
>  		writeb(data, addr + GSC_XMTDATA);
> =20

[Severity: High]
This is a pre-existing issue, but I noticed an infinite spin-loop earlier in
this function:

drivers/input/serio/gscps2.c:gscps2_writeb_output() {
...
	while (gscps2_readb_status(addr) & GSC_STAT_RBNE)
		cpu_relax();
...
}

Could this loop spin indefinitely and deadlock the CPU?

If a hardware parity or frame error triggers atkbd_handle_frame_error(), it
calls serio_write(RESEND) synchronously from within the gscps2_interrupt()
handler's report loop.

If a new PS/2 byte arrives precisely before the write, GSC_STAT_RBNE is
set, and gscps2_writeb_output() will loop here indefinitely waiting for it =
to
clear.

Because the only code to drain the hardware buffer (gscps2_read_data()) is
blocked on the same thread higher up the call stack, and external interrupts
cannot run because local IRQs are disabled, would this cause a hard deadloc=
k?

> -	/* this is ugly, but due to timing of the port it seems to be necessary=
. */
> -	mdelay(6);
> -
> -	/* make sure any received data is returned as fast as possible */
> -	/* this is important e.g. when we set the LEDs on the keyboard */
> -	gscps2_interrupt(0, NULL);

[Severity: High]
This is a pre-existing issue, but since we're modifying how we handle the
interrupt pump, I noticed a potential interrupt storm in gscps2_interrupt():

drivers/input/serio/gscps2.c:gscps2_interrupt() {
...
	ACQUIRE(spinlock_irqsave_try, lock)(&gscps2_interrupt_lock);
	if (ACQUIRE_ERR(spinlock_irqsave_try, &lock))
		return IRQ_NONE;
...
}

Could this lead to a level-triggered interrupt storm that permanently disab=
les
the IRQ line?

If CPU B receives a level-triggered hardware interrupt while CPU A holds
gscps2_interrupt_lock (for example, during gscps2_open(), which manually
invokes the ISR outside of standard IRQ serialization without masking the I=
RQ
controller), CPU B fails the trylock and returns IRQ_NONE.

Because it is a level interrupt, the unhandled IRQ will immediately re-fire
on CPU B upon unmasking from handle_level_irq(), looping rapidly.

Would the generic IRQ subsystem eventually see 99,900 unhandled IRQs out of
100,000, assume nobody cared, and permanently disable the IRQ line?

> -
>  	return 1;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260830-gscps2-v1-=
0-c733d4cae7f9@gmail.com?part=3D7
