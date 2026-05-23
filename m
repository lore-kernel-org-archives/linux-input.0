Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2362F8EA2
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 19:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779564124; cv=none; b=DFKtAgbdJ8B9uMDEceIzJXeJa1nOIhEHyUO3XdAsVHbl3axYwSuklqieUejIPnE3BW3VcVRZ6MYwFueCapmg4uxYaxmJtcxCHMgCi67l3Wgxrdn4wd3OmnNkn2BJf6YnQ7IUD3wCIwWd/sC1tD/IFxyMqdpSrtNNqD8pj87oFPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779564124; c=relaxed/simple;
	bh=Qi1cKD48gCY2y8NURF+96CXY7Rx4S2C30Nzcs3+wm8M=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=hCTiB54EEEDEz8V8Xzi76JLxAkwQHdLV2raROkWhCi+LRaCWAN3k0OMSZOAVQLkOrnTd5SGCD2hvnBiUf6l/2p8RD3vj6Ea9w89dVcKpzVGAY4B9PYyfjNvqIH3/utuw8SOf6jxUUW37eTZRXubpVvR330mHsyVKEmdE56nOxhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBpso2XV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBpso2XV"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43d73422431so5956057f8f.2
        for <linux-input@vger.kernel.org>; Sat, 23 May 2026 12:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779564121; x=1780168921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1nyil2UrybGod099ae7Fu+qN7s7Wzz/PUhg4kbNilFU=;
        b=CBpso2XVlF23hH6JkmyCgJePqBE3aVzxpetQKtbWz3PExTgD8Uz7cH6gHLC74hyha/
         i7Q15x0A82up8j0XsUnwjjbRiQ2+JcEKseJqzi3ZMR+FyFecC8LqQW5i8PHYsuRJSAXi
         bARlN/u5eFOCZbCcH7v2hMu2OsqYh3EXWMwSCAsSYmqBH7jV6cr0rMbbCyqCWOLsEWpW
         4Tv1HqB7fMK/EZ7JaReu3hRpnOYGmX4u5k6jWYvNwE6WpMoOyWdQEDt+p1Typg2FcXQP
         GZdfY2ZhMjk/K+JBnll5IK2d/lbvnYSHXEnQKM5DKC0QPz1ZpkOmNTNKABmeqZx0Rcjc
         malw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779564121; x=1780168921;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nyil2UrybGod099ae7Fu+qN7s7Wzz/PUhg4kbNilFU=;
        b=dlbiFNo+fCcHv9GommMW5hwpdxgeyiFnbquRz63wLKx4Jn/cRZoe3KNWff4GvI8kXR
         sUiknwk3ocbnEUeLVYvbKc/mIM+WwqsjFEQSR98Vl1347b/GZtuhM+Ih7hhgAScIryCz
         xSCMm7wHS+aBTQzAtNpHqU3POCQO4XWddcK8U73z2A1a999zurlKvy4yVH55+SKycYMF
         LLewtqMlLNAM8ZRxpftSytI3JaUPZ9cyYV6gsGzr7ZRn5EdJy3Xl8CKZPOcUDqw+uA+t
         XG4AMOZuEWVs/nK4s6PDe/GDTWGYqRvmkKtMMMGIr6l8iLORz34iP8xGQakcvWDBqShv
         4hcg==
X-Forwarded-Encrypted: i=1; AFNElJ9h+fF2zKllx1l7rV0tgPMtm4FpkCmEHQrXUnA+2IZqy7vQu9Umib5PnxQ6Di1WmwZdnWf04z6hFxRrXg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx++CbRv6M0a3ncPV0Hu5qeCw1H6ju6L0ujdYdb5XewXdD6dIBT
	S++Gb8vElwhMLrknwRDy4HGjNyuvgDlnH1odfyJfdiW5pAaFkvl30QJ6
X-Gm-Gg: Acq92OGEfKo9eplvpGxjecexe6hYS2cY3iXthoqfGdCXOVTYn5xsG2HvEB+yM+87e5w
	kyM7Jo5sHeITnoBlA+HVGyQdtRRbXNyc3VzVlCg8L3IvQnakJbv0Ggw/o2IAyU/S+0zjSLG7JFn
	txmNRk0FyQFoCZlQ2JGMoauDxWY7RBInaCqa+cEq2SFZj2g6FhHOuGqzJjzTY1X9NkUWlSjm8RM
	TInEn8/9RJnKyb2EFMl96TcebGO2eO70ddefFHoJt6290bbgIMKSjcFu3iw1ApH+gwt0mPh5hRi
	4bFW2CrAmyKC/b6vFmOB3frkYpHtMcelqOC+KOu0inc6aiLV77lQpbhSpdJ1qkpeyDFaSbATiat
	uZkuummX/9crhHNWlsYvLfnRo0/E/zVcyZXu9Zdu5FKHJIinmh7bJoVTm25EZpRVopdvdYKIsFg
	hmy7fs3Sr4Qsuv0jKIaRgUE2gB
X-Received: by 2002:a05:6000:4283:b0:44d:261:54c5 with SMTP id ffacd0b85a97d-45eb38b7934mr13481139f8f.30.1779564120271;
        Sat, 23 May 2026 12:22:00 -0700 (PDT)
Received: from localhost ([81.6.39.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6ccd211sm18661289f8f.10.2026.05.23.12.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 12:21:59 -0700 (PDT)
Date: Sat, 23 May 2026 10:57:55 +0200
To: sashiko-reviews@lists.linux.dev
Cc: Vicki Pfau <vi@endrift.com>, linux-input@vger.kernel.org,
 dmitry.torokhov@gmail.com
Subject: Re: [PATCH v5 1/3] HID: nintendo: Add preliminary Switch 2
 controller driver
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <20260512200051.2534081-2-vi@endrift.com>
 <20260514001510.964E7C19425@smtp.kernel.org>
In-Reply-To: <20260514001510.964E7C19425@smtp.kernel.org>
Message-Id: <25DJXAMCCCNLA.234CWZVQ8IOM4@homearch.localdomain>
User-Agent: mblaze/1.4-1-g5a69507 (2026-01-24)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Heyhey!

Below some comments regarding the findings (note that I am not an expert
on neither Linux kernel drivers in general nor USB HID specifically).

sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 11 potential iss=
ue(s) to consider:
> - [High] Sleeping in atomic context and AB-BA deadlock in `switch2_usb_di=
sconnect`
> - [High] Race condition in IN URB tracking causes permanent starvation
> - [High] Dangling pointers and use-after-free on probe failure
> - [High] Memory corruption and double free due to incorrect devm input li=
fecycle management
> - [High] NULL pointer dereference in USB probe error path
> - [High] Division by zero crash from unvalidated trigger calibration data=

> - [High] BUG_ON kernel panic when `ida_free` is called with U32_MAX
> - [High] Out-of-bounds read when parsing NS2_CMD_FW_INFO response
> - [High] Race condition due to URB submission before initialization of sy=
nchronization primitives
> - [Medium] Infinite USB retry storm on protocol errors
> - [Medium] Unaligned memory access on byte array casts
> --
>=20
> commit 00cb7265ad5983144c6923702e2ee2c3c047d29e
> Author: Vicki Pfau <vi@endrift.com>
> Subject: HID: nintendo: Add preliminary Switch 2 controller driver
>=20
> This adds a new driver for the Switch 2 controllers. The Switch 2 uses an=

> unusual split-interface design such that input and rumble occur on the ma=
in
> HID interface, but all other communication occurs over a "configuration"
> interface.
>=20
> > diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> > index 29008c2cc5304..2193afcdefabc 100644
> > --- a/drivers/hid/hid-nintendo.c
> > +++ b/drivers/hid/hid-nintendo.c
> [ ... ]
> > +static int switch2_init_input(struct switch2_controller *ns2)
> > +{
> [ ... ]
> > +	input =3D devm_input_allocate_device(&hdev->dev);
> > +	if (!input)
> > +		return -ENOMEM;
> [ ... ]
> > +	ret =3D input_register_device(input);
> > +	if (ret < 0) {
> > +		hid_err(ns2->hdev, "Failed to register input; ret=3D%d\n", ret);
> > +		input_free_device(input);
>=20
> Calling input_free_device or input_unregister_device on a devm-managed
> input device can cause double frees when devres cleanup fires. Can this
> lead to memory corruption?

I think sashiko is actually correct here, unfortunately. The documentation
for devm_input_allocate_device states that

  Managed input devices do not need to be explicitly unregistered or
  freed as it will be done automatically when owner device unbinds from
  its driver (or binding fails). ...

Looks like we can remove all the input_unregister_device and
input_free_device calls here.

>=20
> > +		return ret;
> > +	}
> [ ... ]
> > +static void switch2_controller_put(struct switch2_controller *ns2)
> > +{
> > +	struct input_dev *input;
> > +	bool do_free;
> [ ... ]
> > +	if (input)
> > +		input_unregister_device(input);
>=20
> Calling input_unregister_device on a devm-managed input device can cause
> issues. If the input device remains alive (tied to the HID device devres)=

> and its child LEDs are not released, will reconnecting the USB cable
> allocate a new input device and corrupt the LED lists by re-registering
> the exact same ns2->leds structures?

This input_unregister_device can also be removed.

>=20
> > +
> > +	if (do_free) {
> [ ... ]
> > +static void switch2_report_trigger(struct input_dev *input, uint8_t ze=
ro, int abs, uint8_t data)
> > +{
> > +	int value =3D (NS2_TRIGGER_RANGE + 1) * (data - zero) / (232 - zero);=

>=20
> The zero variable is loaded directly from the controller's factory calibr=
ation
> flash. If a device reports a zero point of exactly 232, will this trigger=
 a
> division by zero exception and crash the kernel?

Not sure this is an issue in practice, but we might want to protect the
code in any case by doing something like the below perhaps (untested).

int value =3D (NS2_TRIGGER_RANGE + 1) * (data - zero) / max_t(int, (232 - z=
ero), 1);


>=20
> > +
> > +	input_report_abs(input, abs, clamp(value, 0, NS2_TRIGGER_RANGE));
> > +}
> [ ... ]
> > +static int switch2_read_flash(struct switch2_controller *ns2, uint32_t=
 address,
> > +	uint8_t size)
> > +{
> > +	uint8_t message[8] =3D { size, 0x7e };
> > +
> > +	if (!ns2->cfg)
> > +		return -ENOTCONN;
> > +	*(__le32 *)&message[4] =3D __cpu_to_le32(address);
>=20
> The driver directly casts &message[4] to __le32. Since message is a uint8=
_t
> array, it is only guaranteed to be 1-byte aligned. On strict architecture=
s,
> will this unaligned memory write trigger a hardware alignment fault?

I assume this could be an issue and we should just use something like
the below (only compile-tested).

put_unaligned_le32(__cpu_to_le32(address), &message[4]);


>=20
> > +	return ns2->cfg->send_command(NS2_CMD_FLASH, NS2_SUBCMD_FLASH_READ, m=
essage,
> > +		sizeof(message), ns2->cfg);
> > +}
> [ ... ]
> > +int switch2_receive_command(struct switch2_controller *ns2,
> > +	const uint8_t *message, size_t length)
> > +{
> [ ... ]
> > +	header =3D (const struct switch2_cmd_header *)message;
> > +	if (!(header->flags & NS2_FLAG_OK)) {
> > +		ret =3D -EIO;
> > +		goto exit;
> > +	}
> > +	message =3D &message[8];
> > +	switch (header->command) {
> [ ... ]
> > +	case NS2_CMD_FW_INFO:
> > +		if (header->subcommand =3D=3D NS2_SUBCMD_FW_INFO_GET) {
> > +			if (length < sizeof(ns2->version)) {
> > +				ret =3D -EINVAL;
> > +				goto exit;
> > +			}
> > +			memcpy(&ns2->version, message, sizeof(ns2->version));
>=20
> The message pointer is advanced by 8 bytes to skip the header, but length=

> is not decremented. The bounds check compares length against
> sizeof(ns2->version). If length is exactly sizeof(ns2->version), the chec=
k
> passes, but the advanced message pointer only has length - 8 valid bytes
> remaining. Will the memcpy over-read into uninitialized memory?

Sounds like something that we should fix by either decreasing length or
increasing the size in the check.

>=20
> > +			ns2->ctlr_type =3D ns2->version.ctlr_type;
> > +			switch2_init_step_done(ns2, NS2_INIT_GET_FIRMWARE_INFO);
> > +		}
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +exit:
> > +	if (ns2->init_step < NS2_INIT_DONE)
> > +		switch2_init_controller(ns2);
>=20
> If a command response has the NACK flag set or encounters another error,
> the code jumps to exit and invokes switch2_init_controller. Since
> ns2->init_step has not advanced, the state machine will immediately re-se=
nd
> the exact same command. Can this cause an infinite tight feedback loop of=

> failures and retries, flooding the USB bus?

We have discussed this before and it doesn't seem to be an issue in
practice.

If we want to be on the safe side, we could pass a retry count and abort
on too many error retries, perhaps?


> > +
> > +	return ret;
> > +}
> [ ... ]
> > +int switch2_controller_attach_cfg(const char *phys, struct switch2_cfg=
_intf *cfg)
> > +{
> [ ... ]
> > +	guard(mutex)(&ns2->lock);
> > +	WARN_ON(ns2->cfg);
> > +	ns2->cfg =3D cfg;
> > +
> > +	if (ns2->hdev)
> > +		return switch2_init_controller(ns2);
>=20
> If switch2_init_controller fails here or in switch2_probe, the error is
> returned immediately without unrolling the state. Will ns2->cfg or ns2->h=
dev
> remain set, potentially leading to a use-after-free when subsequent devic=
e
> events occur?

AFAICT, since we are always checking for both ns2->cfg and ns2->hdev
before doing any processing in switch2_init_controller, there should
never be a use-after-free

It *is* true that we don't call hid_hw_{close,stop} in switch2_probe,
if the switch2_init_controller call fails though. It might make sense
to return a specific error and use it to check whether we want to give
up and call these?

>=20
> > +	return 0;
> > +}
> [ ... ]
> > +static void switch2_remove(struct hid_device *hdev)
> > +{
> > +	struct switch2_controller *ns2 =3D hid_get_drvdata(hdev);
> > +
> > +	hid_hw_close(hdev);
> > +	mutex_lock(&ns2->lock);
> > +	WARN_ON(ns2->hdev !=3D hdev);
> > +	ns2->hdev =3D NULL;
> > +	mutex_unlock(&ns2->lock);
> > +	ida_free(&nintendo_player_id_allocator, ns2->player_id);
>=20
> If ida_alloc fails during probe, ns2->player_id remains at its default
> value of U32_MAX. When ida_free is called, the IDA framework enforces a
> check on the ID. Casting U32_MAX to a signed integer yields -1. Will this=

> trigger the BUG_ON and cause a kernel panic?

ida_free seems to return early on

if ((int)id < 0)
	return;

so that should be fine as is.

>=20
> > +	switch2_controller_put(ns2);
> > +	hid_hw_stop(hdev);
> > +}
> [ ... ]
> > diff --git a/drivers/input/joystick/nintendo-switch2-usb.c b/drivers/in=
put/joystick/nintendo-switch2-usb.c
> > new file mode 100644
> > index 0000000000000..ebd89d852e21a
> > --- /dev/null
> > +++ b/drivers/input/joystick/nintendo-switch2-usb.c
> [ ... ]
> > +static void switch2_bulk_in(struct urb *urb)
> > +{
> [ ... ]
> > +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> > +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> > +		int err;
> > +		struct switch2_urb *ns2_urb;
> > +
> > +		if (ns2_usb->bulk_in[i].urb =3D=3D urb) {
> > +			ns2_usb->message_in =3D i;
>=20
> If multiple URBs complete in quick succession before the work item execut=
es,
> the message_in index is overwritten. Will this cause the work item to onl=
y
> process the last completed URB, leaving earlier URBs indefinitely active
> and leading to starvation of the URB pool?
>=20
> > +			continue;
> > +		}
> [ ... ]
> > +static int switch2_usb_probe(struct usb_interface *intf, const struct =
usb_device_id *id)
> > +{
> [ ... ]
> > +	ns2_usb->bulk_in[0].active =3D true;
> > +	ret =3D usb_submit_urb(ns2_usb->bulk_in[0].urb, GFP_ATOMIC);
> > +	if (ret < 0)
> > +		goto err_free_out;
> > +
> > +	init_usb_anchor(&ns2_usb->bulk_out_anchor);
> > +	spin_lock_init(&ns2_usb->bulk_out_lock);
> > +	init_usb_anchor(&ns2_usb->bulk_in_anchor);
> > +	spin_lock_init(&ns2_usb->bulk_in_lock);
> > +	INIT_WORK(&ns2_usb->message_in_work, switch2_usb_message_in_work);
>=20
> usb_submit_urb is invoked for bulk_in[0] before the initialization of the=

> spinlocks, anchors, and work struct. If the URB completes immediately, th=
e
> completion handler will execute and attempt to use uninitialized
> synchronization primitives. Can this cause a crash?

As the documentation for usb_submit_urb mentions that the call is async,
I assume that this is indeed a theoretical possibility.

>=20
> > +
> > +	usb_set_intfdata(intf, ns2_usb);
> [ ... ]
> > +err_kill_urb:
> > +	usb_kill_urb(ns2_usb->bulk_in[0].urb);
> > +err_free_out:
> > +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
> > +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, ns2_usb->bulk_out[i]=
.data,
> > +			ns2_usb->bulk_out[i].urb->transfer_dma);
> > +		usb_free_urb(ns2_usb->bulk_out[i].urb);
> > +	}
> > +err_free_in:
> > +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> > +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, ns2_usb->bulk_in[i].=
data,
> > +			ns2_usb->bulk_in[i].urb->transfer_dma);
>=20
> If usb_alloc_urb fails during the loop, it jumps to err_free_in. During
> cleanup, it accesses ns2_usb->bulk_in[i].urb->transfer_dma. Since urb is
> NULL for the failed index, will this trigger a NULL pointer dereference?

Yes, most likely we would need a new label for this case.

>=20
> > +		usb_free_urb(ns2_usb->bulk_in[i].urb);
> > +	}
> > +	devm_kfree(&intf->dev, ns2_usb);
> > +
> > +	return ret;
> > +}
> > +
> > +static void switch2_usb_disconnect(struct usb_interface *intf)
> > +{
> > +	struct switch2_usb *ns2_usb =3D usb_get_intfdata(intf);
> > +	unsigned long flags;
> > +	int i;
> > +
> > +	spin_lock_irqsave(&ns2_usb->bulk_out_lock, flags);
> > +	usb_kill_anchored_urbs(&ns2_usb->bulk_out_anchor);
>=20
> Both usb_kill_anchored_urbs and cancel_work_sync can sleep. Is it safe to=

> call them while holding a spinlock?

According to some googling, this indeed seems to be an isuse. The
non-sleeping way to cancel transfer requests would be to use
https://www.kernel.org/doc/html/v6.1/driver-api/usb/usb.html#c.usb_unlink_a=
nchored_urbs


>=20
> > +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
> > +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, ns2_usb->bulk_out[i]=
.data,
> > +			ns2_usb->bulk_out[i].urb->transfer_dma);
> > +		usb_free_urb(ns2_usb->bulk_out[i].urb);
> > +	}
> > +	spin_unlock_irqrestore(&ns2_usb->bulk_out_lock, flags);
> > +
> > +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> > +	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
> > +	cancel_work_sync(&ns2_usb->message_in_work);
>=20
> Furthermore, cancel_work_sync waits for message_in_work which attempts to=

> acquire bulk_in_lock. Does this cause a deadlock since the lock is alread=
y
> held by the disconnecting thread?

Yes, this looks like a real concern as well.

Cheers,
Silvan

>=20
> > +	for (i =3D 0; i < NS2_IN_URBS; i++) {
