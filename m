Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437C376BF1
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 03:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784087360; cv=none; b=sEShI8lQgc5qEVrAbOSkec2PhaGD1p+I/Thg7k+Ji50Qw2f5S1jLMYCYxrL3Vzax3E1lz7seiujdZspkodI92ZE3Wm1ixSysqYaCISbQe1tfU6XaLALORtMyECAWbcv5bD66a9XYfZRVuzjMEdS8BxR8Z1oT5I+P+8L7N5Ib8kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784087360; c=relaxed/simple;
	bh=epTchY540akWnBvVL78bJ9wHWuaQpH0N/9Iu1W5jSos=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Tu8MHHHqUs5loEUMKSmOZGoUr+Z0Kmfl/7tbO0EEHSSWQ/rcMbv2gtwiTCQAl2xPi/xh99bH+RibO9KGGEyBcCnR17PmnJFgmYdZDjkXNvmG3X+f8UHaBTsKVU/tKfBnaRouCpPx/dy2ANwPMz/KDocsc57Gq8CCZ2wDT+kx/8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BF7GC3H2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BF7GC3H2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A944F1F000E9;
	Wed, 15 Jul 2026 03:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784087358;
	bh=bFHpfzn6bubwvxsiLF7b2+Fkm1IXr8LYSGno6cnBY3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BF7GC3H2j3FI53Shu8r2BHBHg0sbYCZAdKu2kZWIXXzwoaH/AsqpW7orPYoguRVl8
	 7s/kI4SGw9lI8yAPsLIUttgn27axeD3eQxV4+NGJR3RKT+496pYLNGzBihO6NrJWcH
	 0/qAXAVFX0fhp5zuuwgOhEC/MfUQVHz+pQwjWKmF9mYHn+G/bZvrZvMih6lFJGN4uK
	 EYT7DJjqVoENatyYKvIXuTSbB9ihnHutwTRqPzzs+NBUnR60BLPEbmy6rYLSZNn+dh
	 F1VWiiiLykpRu+BaChNCG1grZYOome6oPH4dtgGuiTyuhV+jlUIFwFfcOTnQFDLN8J
	 st6CpssUr1zTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 1/3] HID: nintendo: Add preliminary Switch 2
 controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260715033409.3599913-2-vi@endrift.com>
References: <20260715033409.3599913-1-vi@endrift.com>
 <20260715033409.3599913-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 03:49:18 +0000
Message-Id: <20260715034918.A944F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Registering managed LED class devices on `&input->dev` creates a c=
ircular reference that leaks the input device and causes a Use-After-Free o=
f the controller struct (`ns2`) via sysfs attributes.
- [High] Sequentially plugging different controllers into the same USB port=
 causes a new controller to erroneously adopt the state structure of the ol=
d, logically disconnected controller.
- [High] In `switch2_remove()`, the controller structure `ns2` can be freed=
 before the HID hardware is stopped, leading to a Use-After-Free if a HID e=
vent arrives during the teardown process.
- [High] Unconditional call to `ida_free()` with an unallocated ID (`U32_MA=
X`) when `ida_alloc()` fails, triggering a kernel BUG_ON.
- [High] A scheduled USB work can access `ns2` after it has been freed duri=
ng a probe failure.
--

--- Patch [1]: [PATCH v12 1/3] HID: nintendo: Add preliminary Switch 2 cont=
roller driver ---
commit 4bbec8b8ea15115506e7b7ed2c3578458f9f8016
Author: Vicki Pfau <vi@endrift.com>
Subject: HID: nintendo: Add preliminary Switch 2 controller driver

This commit introduces preliminary driver support for the Nintendo Switch 2
controllers. It uses a split driver model, handling HID features in
hid-nintendo and USB configuration in a new nintendo-switch2-usb driver.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c

[ ... ]

> +static int switch2_player_led_brightness_set(struct led_classdev *led,
> +					    enum led_brightness brightness)
> +{
> +	struct device *dev =3D led->dev->parent;
> +	struct input_dev *input =3D to_input_dev(dev);
> +	struct switch2_controller *ns2 =3D input_get_drvdata(input);
> +
> +	if (!ns2)
> +		return -ENODEV;
> +
> +	guard(mutex)(&ns2->lock);

[Severity: High]
Does registering the LED class devices using the input device as the devres
parent create a circular reference?

Since devm_led_classdev_register takes a kobject reference to the parent
device, the devres cleanup for input->dev might never run while the LED
device exists.

If the device is unplugged, ns2 is freed, but the sysfs nodes remain active.
Could a subsequent sysfs write to the brightness attribute trigger a
use-after-free here when fetching and locking ns2?

> +	return switch2_set_leds(ns2);
> +}

[ ... ]

> +static struct switch2_controller *switch2_get_controller(const char *phy=
s)
> +{
> +	struct switch2_controller *ns2;
> +
> +	guard(mutex)(&switch2_controllers_lock);
> +	list_for_each_entry(ns2, &switch2_controllers, entry) {
> +		if (strncmp(ns2->phys, phys, sizeof(ns2->phys)) =3D=3D 0) {
> +			if (kref_get_unless_zero(&ns2->refcount))
> +				return ns2;
> +		}
> +	}

[Severity: High]
Could matching controllers solely by their physical USB path cause issues if
an old device is unplugged but kept alive by an open evdev file descriptor?

If a new controller is plugged into the same USB port, it will have the same
phys string and might erroneously attach to the old controller's state
structure, polluting the open userspace handles and corrupting state.

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
> +

[ ... ]

> +static void switch2_remove(struct hid_device *hdev)
> +{
> +	struct switch2_controller *ns2 =3D hid_get_drvdata(hdev);
> +
> +	switch2_controller_put(ns2);
> +	mutex_lock(&ns2->lock);
> +	ns2->hdev =3D NULL;
> +	ida_free(&nintendo_player_id_allocator, ns2->player_id);

[Severity: High]
If ida_alloc fails during switch2_probe, player_id remains U32_MAX.

Since switch2_remove unconditionally calls ida_free with this value, could
this trigger the BUG_ON inside the IDA subsystem, since U32_MAX casts to a
negative integer?

> +	mutex_unlock(&ns2->lock);
> +	kref_put(&ns2->refcount, switch2_kref_put);
> +	hid_hw_close(hdev);
> +	hid_hw_stop(hdev);
> +}

[Severity: High]
Is it safe to drop the kref on ns2 before stopping the hardware?

If the last reference is dropped and ns2 is freed here, an asynchronous inp=
ut
report could still arrive before hid_hw_stop finishes. Would this cause a
use-after-free in switch2_event when it retrieves ns2 via hid_get_drvdata?

> diff --git a/drivers/input/joystick/nintendo-switch2-usb.c b/drivers/inpu=
t/joystick/nintendo-switch2-usb.c
> --- /dev/null
> +++ b/drivers/input/joystick/nintendo-switch2-usb.c
> @@ -0,0 +1,475 @@

[ ... ]

> +static int switch2_usb_probe(struct usb_interface *intf, const struct us=
b_device_id *id)
> +{
[ ... ]
> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +	ns2_usb->bulk_in[0].state =3D NS2_URB_OUT;
> +	usb_anchor_urb(ns2_usb->bulk_in[0].urb, &ns2_usb->bulk_in_anchor);
> +	ret =3D usb_submit_urb(ns2_usb->bulk_in[0].urb, GFP_ATOMIC);
> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> +
> +	if (ret < 0)
> +		goto err_free_out;
> +
> +	ret =3D switch2_controller_attach_cfg(phys, &ns2_usb->cfg);

[Severity: High]
Is there a race condition here if the URB completes immediately?

The bulk IN URB is submitted before switch2_controller_attach_cfg finishes
attaching the controller. If the attach sequence fails and frees ns2, could
the scheduled message_in_work worker thread access a partially attached and
subsequently freed ns2 structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715033409.3599=
913-1-vi@endrift.com?part=3D1
