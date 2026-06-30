Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6322B3E5EF3
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 09:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810395; cv=none; b=fXJm7+8HK6Wzxed+VAc7CMIaTeSiZIL2+NtXpWsdbDxInJ69q+Sd1GKzDW8o8zODxjmuLjC/4rjTxKRGMB3GZ2ZrkRE7UrXRjtFbUXeRKQxld7zKt45XMRWq08GCPL1rnVKEE+FSCEqz1ltZLuY94yGcILD/rPuBPZqVNR6vGpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810395; c=relaxed/simple;
	bh=apFMzrWtMG964I2vF2dyEYK+8531MNWrkic5aOHUwrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P4Q5B3JvLK4zXMjIKeUMdY2RP4GgFtygpCzrRIPEZvzUX6gbMcda6EQO8ToWqLR27MauMuW1F9aXOM+8FJXQDm5Mi7GQogFIt7ucptJWeta23JGCf+hautPO4xsOYLRNMHIAR7uOziNBfAdlXjeuFk0YWpwMVcoFX2/uXneSCMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8xgvnL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8xgvnL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118841F000E9;
	Tue, 30 Jun 2026 09:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782810394;
	bh=Xr/utsWOsrO4iphBr9uNOoa9imckf9o4OwZUpViXGxE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h8xgvnL9pnnM7uNPa06xSzdB9oUrhmqnJIGyQRxnIOywgF9TPljzh3trN12fGguUM
	 WfgCylsb5zmdvREqwA3AtQZYywd7cN8627tQUY2QboBoeW0DYiM0TpMXOQrwXn2XU2
	 NSA5IZPEjKanNmKnIO1/f0PTylZjbDcByDeBRtqLUBMZvt5LyQ1wqjwXGEK4aYxQWZ
	 sxrR8GsKlwPB6TiiUu6K5Ipt96kIuxtRg6NwXJBO8SFJDzD+dzjz5kYn1/OeAOrXgv
	 8EkkUnzZNxAdtxzdvH+p6UbaGTOx8qpIQ3KZWln/xYYynpfVbFoZSimG2OPntZBQg5
	 g1vCefp/La7og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] HID: nintendo: Add preliminary Switch 2
 controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260630084838.2313379-2-vi@endrift.com>
References: <20260630084838.2313379-1-vi@endrift.com>
 <20260630084838.2313379-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 09:06:32 +0000
Message-Id: <20260630090633.118841F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Missing lock release in URB error cleanup loops causes an immediat=
e self-deadlock.
- [High] Incorrect teardown sequence in USB disconnect and probe error path=
s allows use-after-free of the controller and USB context.
- [High] Calling `ida_free()` with an unallocated ID (U32_MAX) on probe fai=
lure causes a BUG_ON / kernel panic.
- [High] Devres lifecycle violation for the input device and LEDs causes a =
severe Use-After-Free during teardown.
- [High] Overwriting the active configuration pointer if multiple matching =
USB interfaces are probed leads to a kernel panic on disconnect.
- [Medium] Type Confusion in LED brightness callback when casting an `input=
_dev->dev` pointer to a `hid_device`.
- [Medium] Early returns on unhandled URB error statuses permanently leak U=
RB slots and fail to clean up state.
--

commit 7e33d97c8c5d7d9d33a04e0a368779204b06f73d
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add preliminary Switch 2 controller driver

This commit introduces a new driver for Nintendo Switch 2 controllers. It
implements a split-driver design with a main HID interface and a secondary
USB configuration interface. Support is included for basic input on Joy-Con=
 2,
Pro Controller 2, and GameCube NSO controllers.

> diff --git a/drivers/input/joystick/nintendo-switch2-usb.c b/drivers/inpu=
t/joystick/nintendo-switch2-usb.c
> index 0000000000000..632af1a8638a7
> --- /dev/null
> +++ b/drivers/input/joystick/nintendo-switch2-usb.c
[ ... ]
> +static void switch2_bulk_out(struct urb *urb)
> +{
[ ... ]
> +	switch (urb->status) {
> +	case 0:
> +		break;
> +	case -ECONNRESET:
> +	case -ENOENT:
> +	case -ESHUTDOWN:
> +		dev_dbg(&ns2_usb->udev->dev, "shutting down output urb: %d\n", urb->st=
atus);
> +		return;
> +	default:
> +		dev_dbg(&ns2_usb->udev->dev, "unknown output urb status: %d\n", urb->s=
tatus);
> +		return;
> +	}
> +
> +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
> +		if (ns2_usb->bulk_out[i].urb !=3D urb)

[Severity: Medium]
If the URB status falls into the default case, this function prints a debug
message and returns immediately. Does this skip the loop below that is supp=
osed
to free the URB slot by setting its state to NS2_URB_FREE? If this occurs
multiple times, it seems all URB slots will remain permanently in-use, lead=
ing
to -ENOBUFS errors on future attempts.

[ ... ]
> +static int switch2_usb_probe(struct usb_interface *intf, const struct us=
b_device_id *id)
> +{
[ ... ]
> +	if (ret < 0) {
> +		cancel_work_sync(&ns2_usb->message_in_work);
> +		goto err_free_out;
> +	}
> +
> +	return 0;
> +
> +err_free_out:

[Severity: High]
In this error path, cancel_work_sync() is called before the IN URBs are
killed at err_free_in. If an IN URB completes immediately after
cancel_work_sync(), could it requeue the work? This would leave the work
active while the USB device context is being destroyed, potentially leading=
 to
a use-after-free.

[ ... ]
> +	usb_kill_anchored_urbs(&ns2_usb->bulk_out_anchor);
> +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
> +		spin_lock_irqsave(&ns2_usb->bulk_out_lock, flags);
> +		urb =3D ns2_usb->bulk_out[i].urb;
> +		data =3D ns2_usb->bulk_out[i].data;
> +		if (!urb)
> +			continue;
> +
> +		ns2_usb->bulk_out[i].urb =3D NULL;

[Severity: High]
When urb is NULL, this loop executes the continue statement while the=20
bulk_out_lock is held. Will this cause the next iteration to attempt to
acquire the same spinlock and immediately deadlock the CPU?

[ ... ]
> +err_free_in:
> +	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> +		spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +		urb =3D ns2_usb->bulk_in[i].urb;
> +		data =3D ns2_usb->bulk_in[i].data;
> +		if (!urb)
> +			continue;
> +
> +		ns2_usb->bulk_in[i].urb =3D NULL;

[Severity: High]
Similarly, does this continue statement skip unlocking bulk_in_lock, causing
a deadlock on the next iteration?

[ ... ]
> +static void switch2_usb_disconnect(struct usb_interface *intf)
> +{
[ ... ]
> +	switch2_controller_detach_cfg(ns2_usb->cfg.parent);
> +
> +	usb_kill_anchored_urbs(&ns2_usb->bulk_out_anchor);
[ ... ]
> +	cancel_work_sync(&ns2_usb->message_in_work);
> +	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);

[Severity: High]
Is this teardown sequence safe? switch2_controller_detach_cfg() drops the
refcount on the controller, potentially freeing it while message_in_work is
still active. Furthermore, cancel_work_sync() is called before killing the =
IN
URBs, which might allow the IN URB completion handler to reschedule the work
after we've attempted to cancel it. This seems to create multiple race wind=
ows
for a use-after-free.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index e7302ec01ff1f..b9e2e708e28f3 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
[ ... ]
> +static int switch2_player_led_brightness_set(struct led_classdev *led,
> +					    enum led_brightness brightness)
> +{
> +	struct device *dev =3D led->dev->parent;
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct switch2_controller *ns2 =3D hid_get_drvdata(hdev);

[Severity: Medium]
The LEDs are registered with the input device as their parent, so
led->dev->parent points to the input_dev's device struct. Does using
to_hid_device() here perform an invalid cast? While hid_get_drvdata() might
accidentally work due to struct layout overlaps for the driver_data pointer,
casting an input_dev device to a hid_device looks like a strict-aliasing
violation.

[ ... ]
> +static int switch2_init_input(struct switch2_controller *ns2)
> +{
[ ... ]
> +	input =3D devm_input_allocate_device(&hdev->dev);
[ ... ]
> +		ret =3D devm_led_classdev_register(&input->dev, led);

[Severity: High]
The input device and LEDs are allocated using devm, tying their lifecycle to
the HID device. However, the physical memory for the leds array is embedded
inside the ns2 structure, which is managed via manual krefs and freed in
switch2_kref_put(). When the controller is removed, ns2 is freed immediatel=
y,
but the devres cleanup for the LEDs will run later when the HID device unbi=
nds.
Could this lead to the LED core accessing the already-freed ns2 memory?

[ ... ]
> +static int switch2_probe(struct hid_device *hdev, const struct hid_devic=
e_id *id)
> +{
[ ... ]
> +	ns2->player_id =3D U32_MAX;
> +	ret =3D ida_alloc(&nintendo_player_id_allocator, GFP_KERNEL);
> +	if (ret < 0)
> +		hid_warn(hdev, "Failed to allocate player ID, skipping; ret=3D%d\n", r=
et);
> +	else
> +		ns2->player_id =3D ret;
[ ... ]
> +err_cleanup:
> +	ida_free(&nintendo_player_id_allocator, ns2->player_id);

[Severity: High]
If ida_alloc() fails, ns2->player_id remains U32_MAX. If probe later fails
and jumps to err_cleanup, ida_free() is called unconditionally. Since
ida_free() expects a valid signed integer ID, passing U32_MAX (-1) will
trigger a BUG_ON. Should there be a check before freeing?

[ ... ]
> +static void switch2_remove(struct hid_device *hdev)
> +{
> +	struct switch2_controller *ns2 =3D hid_get_drvdata(hdev);
> +
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> +	mutex_lock(&ns2->lock);
> +	ida_free(&nintendo_player_id_allocator, ns2->player_id);

[Severity: High]
Similar to the probe error path, if the device was successfully probed but
ida_alloc() had initially failed, removing the device will call ida_free() =
on
U32_MAX, triggering a BUG_ON.

[ ... ]
> +int switch2_controller_attach_cfg(const char *phys, struct switch2_cfg_i=
ntf *cfg)
> +{
[ ... ]
> +	mutex_lock(&ns2->lock);
> +	WARN_ON(ns2->cfg);
> +	ns2->cfg =3D cfg;

[Severity: High]
If multiple USB interfaces from the same device match and trigger probes,
this function emits a warning but proceeds to overwrite ns2->cfg. This brea=
ks
the one-to-one linkage. Should this return -EBUSY instead of overwriting?

[ ... ]
> +void switch2_controller_detach_cfg(struct switch2_controller *ns2)
> +{
> +	mutex_lock(&ns2->lock);

[Severity: High]
If the active configuration pointer was overwritten due to multiple interfa=
ces,
when the first interface disconnects, it will clear the parent pointer on t=
he
second interface's config. When the second interface then disconnects, it w=
ill
pass a NULL ns2 pointer to this function, causing an immediate NULL pointer
dereference when attempting to lock ns2->lock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630084838.2313=
379-1-vi@endrift.com?part=3D1
