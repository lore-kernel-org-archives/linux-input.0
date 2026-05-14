Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387B64C92
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778717711; cv=none; b=UZ1cHaiKcKX0z134XovP3hTp8tnJRag2GfbGw1Etq7KPGGlx+rwdZBptIAJKsqWr9JFvUjikVUoWZbyEpzbbKxLmiWOha700/Ea70rCnHcMnNySQZK4PiwN9P0RA8tyscd5U8OUCA7li02lK7A675xHGOVV5R6khO8n//TZuu/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778717711; c=relaxed/simple;
	bh=wSyPy1AfTElWhsKYTfKk3t0KgfODG4XyMQlvlNTJLMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uaJvkbAklHyuoQ1oA2OF45jk2UZmrLUUZ7QYSZrzLfaX1J9gyFeGAlmvJdvWEH22wAo9wda0Jts+daQ2FJczrStepytRsF75/WWvVNpCy8Csl26k37pkod+ZD7dUnwWr8ccnORPEO54xQggh6rWdByvLdtLWhZ6/M719UXCvEFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NP4SUnpp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NP4SUnpp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964E7C19425;
	Thu, 14 May 2026 00:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778717710;
	bh=wSyPy1AfTElWhsKYTfKk3t0KgfODG4XyMQlvlNTJLMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=NP4SUnppCxwNLJEmwmvrqXS6ZW2G431i2yGy9cX19pjqWkHBeqMMBSKIDepNh2Zhr
	 mKClGQ73mB9XGLwKxhqgqHjiTfgfLOVTXJuTmLLRfsnTPCyLgOVdVYfolrprdj7UC4
	 57Ks9dFI+nn/kdrHqo6oZzMq0iqMZdX6LIFBcmtZfsdx0zIHsezxa2CU9kmTsC1Zn8
	 qs6KZ8ruqYGmbDOA+55j9kQtc3nzabaYO1lcvphqC2hOgM6l1tEEukU6hsBx8YWXLc
	 FK3DqNlzy+MAWrsMIjNRv1rrztaWFuerbgP7uxLaKK1Cr/iNBAv9dhTROFbRXdSXe+
	 lhnxSV1x092cw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] HID: nintendo: Add preliminary Switch 2
 controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260512200051.2534081-2-vi@endrift.com>
References: <20260512200051.2534081-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:15:10 +0000
Message-Id: <20260514001510.964E7C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [High] Sleeping in atomic context and AB-BA deadlock in `switch2_usb_disc=
onnect`
- [High] Race condition in IN URB tracking causes permanent starvation
- [High] Dangling pointers and use-after-free on probe failure
- [High] Memory corruption and double free due to incorrect devm input life=
cycle management
- [High] NULL pointer dereference in USB probe error path
- [High] Division by zero crash from unvalidated trigger calibration data
- [High] BUG_ON kernel panic when `ida_free` is called with U32_MAX
- [High] Out-of-bounds read when parsing NS2_CMD_FW_INFO response
- [High] Race condition due to URB submission before initialization of sync=
hronization primitives
- [Medium] Infinite USB retry storm on protocol errors
- [Medium] Unaligned memory access on byte array casts
--

commit 00cb7265ad5983144c6923702e2ee2c3c047d29e
Author: Vicki Pfau <vi@endrift.com>
Subject: HID: nintendo: Add preliminary Switch 2 controller driver

This adds a new driver for the Switch 2 controllers. The Switch 2 uses an
unusual split-interface design such that input and rumble occur on the main
HID interface, but all other communication occurs over a "configuration"
interface.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 29008c2cc5304..2193afcdefabc 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
[ ... ]
> +static int switch2_init_input(struct switch2_controller *ns2)
> +{
[ ... ]
> +	input =3D devm_input_allocate_device(&hdev->dev);
> +	if (!input)
> +		return -ENOMEM;
[ ... ]
> +	ret =3D input_register_device(input);
> +	if (ret < 0) {
> +		hid_err(ns2->hdev, "Failed to register input; ret=3D%d\n", ret);
> +		input_free_device(input);

Calling input_free_device or input_unregister_device on a devm-managed
input device can cause double frees when devres cleanup fires. Can this
lead to memory corruption?

> +		return ret;
> +	}
[ ... ]
> +static void switch2_controller_put(struct switch2_controller *ns2)
> +{
> +	struct input_dev *input;
> +	bool do_free;
[ ... ]
> +	if (input)
> +		input_unregister_device(input);

Calling input_unregister_device on a devm-managed input device can cause
issues. If the input device remains alive (tied to the HID device devres)
and its child LEDs are not released, will reconnecting the USB cable
allocate a new input device and corrupt the LED lists by re-registering
the exact same ns2->leds structures?

> +
> +	if (do_free) {
[ ... ]
> +static void switch2_report_trigger(struct input_dev *input, uint8_t zero=
, int abs, uint8_t data)
> +{
> +	int value =3D (NS2_TRIGGER_RANGE + 1) * (data - zero) / (232 - zero);

The zero variable is loaded directly from the controller's factory calibrat=
ion
flash. If a device reports a zero point of exactly 232, will this trigger a
division by zero exception and crash the kernel?

> +
> +	input_report_abs(input, abs, clamp(value, 0, NS2_TRIGGER_RANGE));
> +}
[ ... ]
> +static int switch2_read_flash(struct switch2_controller *ns2, uint32_t a=
ddress,
> +	uint8_t size)
> +{
> +	uint8_t message[8] =3D { size, 0x7e };
> +
> +	if (!ns2->cfg)
> +		return -ENOTCONN;
> +	*(__le32 *)&message[4] =3D __cpu_to_le32(address);

The driver directly casts &message[4] to __le32. Since message is a uint8_t
array, it is only guaranteed to be 1-byte aligned. On strict architectures,
will this unaligned memory write trigger a hardware alignment fault?

> +	return ns2->cfg->send_command(NS2_CMD_FLASH, NS2_SUBCMD_FLASH_READ, mes=
sage,
> +		sizeof(message), ns2->cfg);
> +}
[ ... ]
> +int switch2_receive_command(struct switch2_controller *ns2,
> +	const uint8_t *message, size_t length)
> +{
[ ... ]
> +	header =3D (const struct switch2_cmd_header *)message;
> +	if (!(header->flags & NS2_FLAG_OK)) {
> +		ret =3D -EIO;
> +		goto exit;
> +	}
> +	message =3D &message[8];
> +	switch (header->command) {
[ ... ]
> +	case NS2_CMD_FW_INFO:
> +		if (header->subcommand =3D=3D NS2_SUBCMD_FW_INFO_GET) {
> +			if (length < sizeof(ns2->version)) {
> +				ret =3D -EINVAL;
> +				goto exit;
> +			}
> +			memcpy(&ns2->version, message, sizeof(ns2->version));

The message pointer is advanced by 8 bytes to skip the header, but length
is not decremented. The bounds check compares length against
sizeof(ns2->version). If length is exactly sizeof(ns2->version), the check
passes, but the advanced message pointer only has length - 8 valid bytes
remaining. Will the memcpy over-read into uninitialized memory?

> +			ns2->ctlr_type =3D ns2->version.ctlr_type;
> +			switch2_init_step_done(ns2, NS2_INIT_GET_FIRMWARE_INFO);
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +exit:
> +	if (ns2->init_step < NS2_INIT_DONE)
> +		switch2_init_controller(ns2);

If a command response has the NACK flag set or encounters another error,
the code jumps to exit and invokes switch2_init_controller. Since
ns2->init_step has not advanced, the state machine will immediately re-send
the exact same command. Can this cause an infinite tight feedback loop of
failures and retries, flooding the USB bus?

> +
> +	return ret;
> +}
[ ... ]
> +int switch2_controller_attach_cfg(const char *phys, struct switch2_cfg_i=
ntf *cfg)
> +{
[ ... ]
> +	guard(mutex)(&ns2->lock);
> +	WARN_ON(ns2->cfg);
> +	ns2->cfg =3D cfg;
> +
> +	if (ns2->hdev)
> +		return switch2_init_controller(ns2);

If switch2_init_controller fails here or in switch2_probe, the error is
returned immediately without unrolling the state. Will ns2->cfg or ns2->hdev
remain set, potentially leading to a use-after-free when subsequent device
events occur?

> +	return 0;
> +}
[ ... ]
> +static void switch2_remove(struct hid_device *hdev)
> +{
> +	struct switch2_controller *ns2 =3D hid_get_drvdata(hdev);
> +
> +	hid_hw_close(hdev);
> +	mutex_lock(&ns2->lock);
> +	WARN_ON(ns2->hdev !=3D hdev);
> +	ns2->hdev =3D NULL;
> +	mutex_unlock(&ns2->lock);
> +	ida_free(&nintendo_player_id_allocator, ns2->player_id);

If ida_alloc fails during probe, ns2->player_id remains at its default
value of U32_MAX. When ida_free is called, the IDA framework enforces a
check on the ID. Casting U32_MAX to a signed integer yields -1. Will this
trigger the BUG_ON and cause a kernel panic?

> +	switch2_controller_put(ns2);
> +	hid_hw_stop(hdev);
> +}
[ ... ]
> diff --git a/drivers/input/joystick/nintendo-switch2-usb.c b/drivers/inpu=
t/joystick/nintendo-switch2-usb.c
> new file mode 100644
> index 0000000000000..ebd89d852e21a
> --- /dev/null
> +++ b/drivers/input/joystick/nintendo-switch2-usb.c
[ ... ]
> +static void switch2_bulk_in(struct urb *urb)
> +{
[ ... ]
> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> +		int err;
> +		struct switch2_urb *ns2_urb;
> +
> +		if (ns2_usb->bulk_in[i].urb =3D=3D urb) {
> +			ns2_usb->message_in =3D i;

If multiple URBs complete in quick succession before the work item executes,
the message_in index is overwritten. Will this cause the work item to only
process the last completed URB, leaving earlier URBs indefinitely active
and leading to starvation of the URB pool?

> +			continue;
> +		}
[ ... ]
> +static int switch2_usb_probe(struct usb_interface *intf, const struct us=
b_device_id *id)
> +{
[ ... ]
> +	ns2_usb->bulk_in[0].active =3D true;
> +	ret =3D usb_submit_urb(ns2_usb->bulk_in[0].urb, GFP_ATOMIC);
> +	if (ret < 0)
> +		goto err_free_out;
> +
> +	init_usb_anchor(&ns2_usb->bulk_out_anchor);
> +	spin_lock_init(&ns2_usb->bulk_out_lock);
> +	init_usb_anchor(&ns2_usb->bulk_in_anchor);
> +	spin_lock_init(&ns2_usb->bulk_in_lock);
> +	INIT_WORK(&ns2_usb->message_in_work, switch2_usb_message_in_work);

usb_submit_urb is invoked for bulk_in[0] before the initialization of the
spinlocks, anchors, and work struct. If the URB completes immediately, the
completion handler will execute and attempt to use uninitialized
synchronization primitives. Can this cause a crash?

> +
> +	usb_set_intfdata(intf, ns2_usb);
[ ... ]
> +err_kill_urb:
> +	usb_kill_urb(ns2_usb->bulk_in[0].urb);
> +err_free_out:
> +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, ns2_usb->bulk_out[i].d=
ata,
> +			ns2_usb->bulk_out[i].urb->transfer_dma);
> +		usb_free_urb(ns2_usb->bulk_out[i].urb);
> +	}
> +err_free_in:
> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, ns2_usb->bulk_in[i].da=
ta,
> +			ns2_usb->bulk_in[i].urb->transfer_dma);

If usb_alloc_urb fails during the loop, it jumps to err_free_in. During
cleanup, it accesses ns2_usb->bulk_in[i].urb->transfer_dma. Since urb is
NULL for the failed index, will this trigger a NULL pointer dereference?

> +		usb_free_urb(ns2_usb->bulk_in[i].urb);
> +	}
> +	devm_kfree(&intf->dev, ns2_usb);
> +
> +	return ret;
> +}
> +
> +static void switch2_usb_disconnect(struct usb_interface *intf)
> +{
> +	struct switch2_usb *ns2_usb =3D usb_get_intfdata(intf);
> +	unsigned long flags;
> +	int i;
> +
> +	spin_lock_irqsave(&ns2_usb->bulk_out_lock, flags);
> +	usb_kill_anchored_urbs(&ns2_usb->bulk_out_anchor);

Both usb_kill_anchored_urbs and cancel_work_sync can sleep. Is it safe to
call them while holding a spinlock?

> +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, ns2_usb->bulk_out[i].d=
ata,
> +			ns2_usb->bulk_out[i].urb->transfer_dma);
> +		usb_free_urb(ns2_usb->bulk_out[i].urb);
> +	}
> +	spin_unlock_irqrestore(&ns2_usb->bulk_out_lock, flags);
> +
> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
> +	cancel_work_sync(&ns2_usb->message_in_work);

Furthermore, cancel_work_sync waits for message_in_work which attempts to
acquire bulk_in_lock. Does this cause a deadlock since the lock is already
held by the disconnecting thread?

> +	for (i =3D 0; i < NS2_IN_URBS; i++) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512200051.2534=
081-1-vi@endrift.com?part=3D1
