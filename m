Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F3442255C;
	Fri, 16 Oct 2026 12:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792154904; cv=none; b=bn7eKESaE/dhDDVjKXjiUjmE0w+fOKmkxzJr8dfupWJhj+mfGKdYuy6PaeZnb/dTSCppCcHxeUe6n6kboQE6V0UNf6lTOz80sh179cpMhb/d+/a5e5JozKsY3JtjQsT7j1PQuEdpmufvJmMDbX7EZ6mRE6TLHZphxPCegEcBYns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792154904; c=relaxed/simple;
	bh=qU12tj8p7u7skpU5hRNEVT39qvwiNkjHDUcgx7zoMgg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uoP57Y4WSt9NOKP9F5qK2mImRa85hfMcxB2u1Yr4BMCTLqOef5w01H0zQL2ORuVABqxs0KPjWnG2L/COt1fHsVwHAMmSJgQjmWcqINsZzjOQzgON+ApSLHjHl+FS+jfLBlr3CtC2lQXWPmeLoV/wHkkycC+3DlVQmriay7eCQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJhTBoWh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJhTBoWh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AD21F000C4;
	Fri, 16 Oct 2026 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792154902;
	bh=Kw6xhQRZUlb6mIq2a8+bPsVtYGPmFMZQpbR1ZD2B79o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cJhTBoWhMqLCTDZNC1+hrUKRiYBxlIU6ImQcn5CngJEu7Dh3DOA/YF8+QsPTdBdmw
	 Q5R7DdRt3bUJEC4Oo6hddAZ09ySJOmQ1euqV9+P2BNOw6Ofvt8fq8ng3tVmlBBd0RR
	 A/Xk+JgS50l4X83ojRH5tfR8634zuQWGRTKS+t0ZNnbILi5GI0jUuLyW4uKLFFVdhQ
	 k9jxpai8bOxunk2uf4q0dVlZnWzrOk0KDuLs2gKytzVT7Rf1orGeCEFYtAp7tSc7V8
	 wuwosqdZ714NLKBTcNgvac0abYpNEqEXgXkFvHzk2jccyKW2vhtrZzawiAxrNrxe2c
	 pjm8OV+WQrRww==
Message-ID: <sashiko-outbox-174334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] Input: add OnePlus/OPPO Pad pogo-pin keyboard
 serdev driver
Reply-To: sashiko-reviews@lists.linux.dev
To: wyibo6109@gmail.com, linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261016123334.1019257-3-wyibo6109@gmail.com>
References: <20261015110859.203989-1-wyibo6109@gmail.com>
 <20261016123334.1019257-1-wyibo6109@gmail.com>
 <20261016123334.1019257-3-wyibo6109@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:48:21 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] input: missing irq synchronization in teardown causes UAF
- [High] input: TOCTOU race in work scheduling during remove causes UAF
- [Medium] input: data race on rx response buffer during concurrent replies
- [Medium] input: missing select TOUCHSCREEN_PROPERTIES in Kconfig
- [Medium] input: data race on link state variables between rx and workqueue
--

commit cfd6c4eb0ba7d1e7dd71a926b7629e2bc8db3a2e
Author: Yibo Wang <wyibo6109@gmail.com>
Subject: Input: add OnePlus/OPPO Pad pogo-pin keyboard serdev driver

This patch introduces a clean-room serdev driver for the Tinno keyboard
MCU used by OnePlus and OPPO smart keyboards. The driver communicates via a
framed one-wire bus protocol over a half-duplex UART and exposes standard
input and LED interfaces.

> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kcon=
fig
> index d8c64f333462c..f3931b7fbe748 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -768,4 +768,17 @@ config KEYBOARD_CYPRESS_SF
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cypress-sf.
> =20
> +config KEYBOARD_ONEPLUS_POGO
> +	tristate "OnePlus/OPPO Pad pogo-pin keyboard"
> +	depends on SERIAL_DEV_BUS && GPIOLIB
> +	depends on LEDS_CLASS
> +	select INPUT_MT

[Severity: Medium]
Is a select TOUCHSCREEN_PROPERTIES dependency missing here?

The driver relies on touchscreen_parse_properties() to parse standard
Device Tree touchscreen overrides. Without this select statement, if the
config is not enabled elsewhere in the kernel build, the stub version from
the header is compiled instead. This silently ignores the DT properties
intended for the touchpad.

[ ... ]

> diff --git a/drivers/input/keyboard/oneplus-pogo-kbd.c b/drivers/input/ke=
yboard/oneplus-pogo-kbd.c
> new file mode 100644
> index 0000000000000..afe87d9616174
> --- /dev/null
> +++ b/drivers/input/keyboard/oneplus-pogo-kbd.c
> @@ -382,10 +382,10 @@ static int pogo_xfer(struct pogo_kbd *kb, u8 cmd, c=
onst u8 *payload, u8 len,
>  		if (wait_for_completion_timeout(&kb->resp_done,
>  				msecs_to_jiffies(POGO_RESP_TIMEOUT_MS))) {
>  			unsigned int n =3D min(kb->resp_len, resp_size);
> =20
>  			/* stop the RX path before copying the reply out */
>  			WRITE_ONCE(kb->tx_pending, false);
>  			memcpy(resp, kb->resp, n);
>  			ret =3D n;
>  			break;
>  		}

[Severity: Medium]
Could this cause a data race on the kb->resp buffer during concurrent
replies?

Because kb->tx_pending is cleared after wait_for_completion_timeout()
returns, if the MCU sends a duplicate reply frame or if the TX thread wakes
up due to a timeout just as a delayed frame is received, the serdev RX thre=
ad
will enter pogo_handle_frame().

The RX thread would evaluate kb->tx_pending as true, since the TX thread
hasn't cleared it yet, and start copying data into kb->resp. If the TX
thread executes memcpy(resp, kb->resp, n) concurrently, it will read
corrupted data.

Should kb->tx_pending be cleared atomically inside the RX handler when the
first valid reply is consumed instead?

[ ... ]

> @@ -714,10 +714,10 @@ static void pogo_handle_sync(struct pogo_kbd *kb, c=
onst u8 *p, unsigned int len)
>  		kb->brand =3D p[3];
>  		memcpy(kb->mac, &p[4], POGO_MAC_LEN);
>  		kb->hb_seen =3D true;
>  	}
> =20
>  	if (!kb->connected || replug) {
>  		kb->connected =3D true;
>  		kb->hb_seen =3D false;
>  		kb->retry_ms =3D POGO_RETRY_MIN_MS;

[Severity: Medium]
Does this mutate the link state variables without holding kb->state_lock?

pogo_power_off() and pogo_power_on() safely modify kb->connected and
kb->powered while holding the mutex. However, the RX path here modifies
these variables directly. If this runs simultaneously with pogo_power_off(),
a race condition occurs. This can leave the driver state machine inconsiste=
nt
(for example, kb->connected is true while kb->powered is false).

>  		if (!READ_ONCE(kb->quitting))
>  			schedule_work(&kb->plug_work);
>  	}
>  }

[Severity: High]
Can this lockless check lead to a use-after-free during device removal?

The serdev port remains open until devres cleanup, which happens after
pogo_remove() returns. An active RX thread could evaluate
!READ_ONCE(kb->quitting) as true, and then stall or get preempted before
actually calling schedule_work().

Concurrently, pogo_remove() would set kb->quitting to true and run
cancel_work_sync(&kb->plug_work). Because the work isn't queued yet, the
cancellation returns immediately. When the preempted RX thread resumes, it
queues the work. Devres then frees the kb struct, leaving the queued work
item to execute on freed memory.

[ ... ]

> @@ -861,7 +861,7 @@ static void pogo_wake_irq_enable(struct pogo_kbd *kb,=
 bool enable)
>  {
>  	if (enable =3D=3D kb->wake_irq_enabled)
>  		return;

[Severity: High]
Does this optimization incorrectly bypass the disable_irq() synchronization
barrier during teardown?

If the hardware IRQ fires concurrently, pogo_wake_isr() immediately calls
disable_irq_nosync() and sets kb->wake_irq_enabled to false. When
pogo_remove() subsequently calls pogo_wake_irq_enable(kb, false), it
sees the flag is already false and returns early.

This completely bypasses the standard disable_irq() call that would
otherwise wait for the executing ISR to finish. pogo_remove() will
proceed to cancel the delayed works, but the still-running ISR can
afterward queue detect_work using its own bypassed lockless checks,
leading to a use-after-free once devres cleans up the kb struct.

[ ... ]

> @@ -1181,9 +1181,9 @@ static void pogo_remove(struct serdev_device *serde=
v)
>  	/*
>  	 * Stop the world first: with quitting set, the RX path and the
>  	 * works stop queueing each other, so the cancels below cannot be
>  	 * undone again.  The wake IRQ is disabled (and any in-flight ISR
>  	 * finished) before detect_work is cancelled.
>  	 */
>  	WRITE_ONCE(kb->quitting, true);
>  	pogo_wake_irq_enable(kb, false);
>  	cancel_delayed_work_sync(&kb->detect_work);
>  	cancel_delayed_work_sync(&kb->hb_work);
>  	cancel_work_sync(&kb->plug_work);

(The teardown code above is the other side of the high-severity races
identified in pogo_wake_irq_enable() and pogo_handle_sync() where background
threads queue work on freed memory).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016123334.1019=
257-1-wyibo6109@gmail.com?part=3D2
