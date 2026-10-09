Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98AE3AD53F;
	Fri,  9 Oct 2026 12:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549540; cv=none; b=FEhS471ewKc5SwFc96S083jla049tDSfx+6x+Cms+6Q24FOw92YOtgLztVC3J+N42/o5y65zprcSiIO32t342rAQpGfV5AKshQJXbNOlwdupNlUSerga/rYjcppbqvPg/BJ8Cwxgfk6Z6HxfggFrhWx3sHmt+LylIVc5DJ6N9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549540; c=relaxed/simple;
	bh=mYJeETVCNP2+H5ciwRB8prpvI8n8SWmD+UM2Lh8j4vE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=HE0dsQIo0GojV4ChFKOpTiRTKEp0ziqfnz9qjd+b43U2jRRE2ssUqgnAx5Hl7W/soo+4Dk56gZXcyBZEwRkGNXzyJdo2KCr7G4UotzStNVwzYTNvBZvO14sdHBLIxaMLnRv0mHIoIADUTax9w8pet/bp52AhIH0LfdbDRzQfckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nm4KH86I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nm4KH86I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3231F000FF;
	Fri,  9 Oct 2026 12:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791549532;
	bh=I6TzdPelictgj+or68X6V1FsAGHB0pBRmiHcq2fTJ5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nm4KH86IVIrg/SL7KYWCWR2LEbEEYbRP1z9k0gWk4ry02ly4WK655BRQCxzRJuaMZ
	 3oBo1vzwvO4F6D1mQI1UYYxx61Vjd1wGQUWeLg6rO+yYrAJ0F6D6sum09TtPhD2rxg
	 O4NvxBb47oSa74m6v+Rvv1Jtbw9QPs30kwgvxMSzbGdc8E1dkg56kHwr6q9+Kb+2Ph
	 2lljACrp9AOdM3VfFPx4Brk/Qljw6VwWGrIexLBML11ig1GqS9mblxzuT8ILhQb+ww
	 7M8gNU0SEQsepG2xgfI4FLDo3WO7atdLSRMRbNeagYZnanvJ1DAYWi6WrQkLL863yp
	 ULjPo5Mv2yl1w==
Message-ID: <sashiko-outbox-165548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Input: add OnePlus/OPPO Pad pogo-pin keyboard
 serdev driver
Reply-To: sashiko-reviews@lists.linux.dev
To: wyibo6109@gmail.com
Cc: conor+dt@kernel.org, robh@kernel.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261009122046.551915-3-wyibo6109@gmail.com>
References: <20261009122046.551915-1-wyibo6109@gmail.com>
 <20261009122046.551915-3-wyibo6109@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:38:51 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] input: UAF in led_work due to teardown ordering
- [High] serdev: UAF in plug_work due to active port during devres teardown
- [High] workqueue: UAF due to detect_work and hb_work cyclic dependency
- [High] workqueue: UAF due to pogo_wake_irq_enable missing synchronize_irq
- [High] input: Race between plug_work and power_off leaks input devices
- [Low] leds: Success logging in probe violates guidelines
--

commit 0ce1872d7cb39e14970c678cd47393649379aea8
Author: Yibo Wang <wyibo6109@gmail.com>

Input: add OnePlus/OPPO Pad pogo-pin keyboard serdev driver

Adds a serdev driver for the Tinno keyboard MCU used by OnePlus and OPPO
Pad smart keyboards. Communication happens over a half-duplex UART using
a custom framed protocol. The driver exposes touchpad, keys, and backlight
controls to userspace.

> diff --git a/drivers/input/keyboard/oneplus-pogo-kbd.c b/drivers/input/ke=
yboard/oneplus-pogo-kbd.c
> index 0000000000000..589f31ecef848
> --- /dev/null
> +++ b/drivers/input/keyboard/oneplus-pogo-kbd.c
> @@ -778,7 +778,7 @@
>  static void pogo_wake_irq_enable(struct pogo_kbd *kb, bool enable)
>  {
>  	if (enable =3D=3D kb->wake_irq_enabled)
>  		return;

[Severity: High]
If pogo_wake_isr() fires concurrently, sets kb->wake_irq_enabled =3D false,
and then pogo_remove() calls pogo_wake_irq_enable(kb, false), will this
return early and bypass disable_irq()?

Since disable_irq() also acts as a synchronize_irq(), missing it might
allow the preempted ISR to resume and queue detect_work after it has
already been cancelled in pogo_remove().

[ ... ]

> @@ -849,10 +849,10 @@
>  static void pogo_plug_work(struct work_struct *work)
>  {
>  	struct pogo_kbd *kb =3D container_of(work, struct pogo_kbd, plug_work);
>  	int ret;
> =20
>  	if (!kb->powered || !kb->connected)
>  		return;
> =20
>  	if (!kb->kbd) {
>  		ret =3D pogo_register_inputs(kb);

[Severity: High]
Can a race between pogo_plug_work() and pogo_power_off() leak input
devices?

If pogo_plug_work() evaluates kb->connected as true, and concurrently
pogo_power_off() sets kb->connected =3D false (unregistering nothing since
kb->kbd is still NULL):

- pogo_plug_work() would then allocate and register the input devices.
- The state becomes desynchronized: kb->connected is false, but devices
  are registered.

When the driver unbinds, pogo_remove() calls pogo_power_off(), which will
skip unregistering the devices because kb->connected is false. Will this
leave the input devices leaked and pointing to freed memory?

[ ... ]

> @@ -1074,6 +1074,6 @@
>  	/* evaluate the current attach state; enables the irq when idle */
>  	schedule_delayed_work(&kb->detect_work,
>  			      msecs_to_jiffies(POGO_DETECT_DEBOUNCE_MS));
> =20
>  	dev_info(dev, "pogo keyboard link ready (wake irq %d)\n", kb->wake_irq);

[Severity: Low]
This isn't a bug, but does this success log violate the LED subsystem
guidelines? The guidelines suggest only logging errors or warnings during
probe, to avoid cluttering the kernel log with success messages.

>  	return 0;
>  }

[ ... ]

> @@ -1084,7 +1084,7 @@
>  static void pogo_remove(struct serdev_device *serdev)
>  {
>  	struct pogo_kbd *kb =3D serdev_device_get_drvdata(serdev);
> =20
>  	pogo_wake_irq_enable(kb, false);
>  	cancel_delayed_work_sync(&kb->detect_work);
>  	cancel_delayed_work_sync(&kb->hb_work);

[Severity: High]
Because detect_work and hb_work can queue each other, and neither checks a
shared teardown flag (like kb->going_away), could hb_work re-arm
detect_work after detect_work was cancelled?

If hb_work is running concurrently during pogo_remove():
1. cancel_delayed_work_sync() for detect_work returns.
2. hb_work calls schedule_delayed_work() for detect_work.
3. cancel_delayed_work_sync() for hb_work waits for hb_work to finish.

This leaves detect_work pending after pogo_remove() returns, which would
lead to a use-after-free when devres frees the kb structure.

>  	cancel_work_sync(&kb->plug_work);

[Severity: High]
Since the serdev port is managed by devm_serdev_device_open(), the UART
receiver remains active until devres cleanup, which executes after
pogo_remove() returns.

Could an incoming UART frame trigger pogo_handle_sync() and re-queue
plug_work after this cancellation? If the work remains queued after devres
frees the kb memory, it would cause a use-after-free.

Similarly, if pogo_probe() fails after devm_serdev_device_open(), could an
incoming frame schedule the work on the error path where it is never
cancelled? Does the UART receiver need to be closed or the callback
disabled prior to work cancellation?

>  	cancel_work_sync(&kb->led_work);
>  	pogo_power_off(kb);

[Severity: High]
Because pogo_power_off(kb) is called after cancelling led_work, the input
devices are still fully registered and active during cancellation.

Can a concurrent EV_LED event routed by the input core trigger
pogo_kbd_event(), which unconditionally calls schedule_work() for
led_work? If led_work is re-armed after it was cancelled, it will execute
on freed memory once devres cleans up. Should the input devices be
unregistered before cancelling led_work?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009122046.5519=
15-1-wyibo6109@gmail.com?part=3D2
