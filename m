Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0B43769E6
	for <linux-input@vger.kernel.org>; Tue,  6 Oct 2026 06:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791268202; cv=none; b=mPqjZsg5UbYiMHu1wHPVHCFURmI2xAFVXLBGmNGMvQovDrJ31RmhOvrBecIaCISFPUNYMi9uWnfROrGOsWRe9soob+UDxl8hiKQaIaXs7yNMDjKeSt0K077CY+Egfk+VPrB+Zn+F+D+AuW6feKp3k4fZT+dYh9eWWgxcRIZdL6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791268202; c=relaxed/simple;
	bh=kN8Nx1lpVFmg85Qu7tkLGJ+k/RYhZtCpceMsvSs5ot0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XCs8dKeU1iV4WO9Jf3XvjE1pcwovq6fCMQpklWqJyKiyhCmMVzOzsd4Jz9ri/6numJ1b2m76q4WFIc7k9YYu2qr+PjwymJcnYOpMNDUsmWD+rxUsUXEx1EsE6rFalpnXnUjWZLfqZ+BIpYr6FUftgmKu8Ymf6XeuP2N9wW0E0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEg3HZ9t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEg3HZ9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0B821F000FF;
	Tue,  6 Oct 2026 06:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791268200;
	bh=ZV4aLI4VVEHM37CY2wfr7GC46GyFpJZ65eUxFodWDbM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cEg3HZ9tvWa0il8lZ/4rhHp4kbJ/OfT/lB7GZDDmMj9kVzPu7KxqVNZ/8dg09AHpw
	 EDSkqlFl2UHPWjg8ayZWba7thdoFALEJ9IbXHRxeKpGFbv+zWowmeHwwAbEZe1OfVT
	 TjdSeW2vHFkj1qVf2CGo5yE8odaWmE94OZOC2HAuheXwzFqBMnJeZVCv3rXAIvpsGF
	 xHDsFDbT7YzuhEAZ3lZIq6M6MRz/z5ATPELUluffBKl3Se/m0ZEJqfUEWxn/arEpGp
	 D5OyPopaz00HBgoEb88TE+Kvo2GRK0LPSPX+fzsTXr14ZhY/u8GPncUwxSpPTbDWU7
	 ak7rbzfOVsL+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 1/4] HID: nintendo: Add preliminary Switch 2
 controller driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20261006061619.2005967-2-vi@endrift.com>
References: <20261006061619.2005967-1-vi@endrift.com>
 <20261006061619.2005967-2-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 06:30:00 +0000
Message-Id: <20261006063000.A0B821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] hid: cyclic dependency in devm_led_classdev_register causes memory=
 leak and UAF
- [High] usb: teardown ordering allows concurrent schedule_work to cause Us=
e-After-Free
- [High] hid: AB-BA deadlock between ns2->lock and cancel_work_sync during =
detach
--

commit dd9a3840e4c8766d649b2e556df7f9b3f872ec43
Author: Vicki Pfau <vi@endrift.com>

HID: nintendo: Add preliminary Switch 2 controller driver

This commit adds a new preliminary driver for Nintendo Switch 2 controllers.
It introduces a split-driver approach handling standard HID events alongside
an unusual configuration interface over USB. Support includes general inputs
for various Nintendo controllers but defers IMU, rumble, and battery setups.

> diff --git a/drivers/hid/hid-nintendo-switch2-usb.c b/drivers/hid/hid-nin=
tendo-switch2-usb.c
> new file mode 100644
> index 0000000000000..8b3b6841035d0
> --- /dev/null
> +++ b/drivers/hid/hid-nintendo-switch2-usb.c
[ ... ]
> +static void switch2_bulk_in(struct urb *urb)
> +{
[ ... ]
> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> +
> +	if (schedule)
> +		schedule_work(&ns2_usb->message_in_work);
> +}
[ ... ]
> +static void switch2_usb_free_in_urbs(struct switch2_usb *ns2_usb)
> +{
[ ... ]
> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +	ns2_usb->shutdown =3D true;
> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> +
> +	cancel_work_sync(&ns2_usb->message_in_work);
> +
> +	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);

[Severity: High]
Does the current teardown ordering in switch2_usb_free_in_urbs() allow a
concurrent URB completion to queue work after cancellation?

In switch2_bulk_in(), if a completion handler reads ns2_usb->shutdown as
false but gets preempted before calling schedule_work(), the teardown path
could proceed to call cancel_work_sync(). Since the work isn't queued yet,
cancel_work_sync() returns immediately.

Then usb_kill_anchored_urbs() waits for the URB completion, which finally
resumes and queues the work using schedule_work().

When this work executes later, could it access freed ns2_usb memory and
cause a use-after-free?

[ ... ]
> +static void switch2_usb_shutdown(struct switch2_cfg_intf *intf)
> +{
[ ... ]
> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> +	ns2_usb->shutdown =3D true;
> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> +
> +	cancel_work_sync(&ns2_usb->message_in_work);
> +
> +	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index b1fcf3e5767ba..c31ded267be76 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
[ ... ]
> +int switch2_receive_command(struct switch2_controller *ns2,
> +	const uint8_t *message, size_t length)
> +{
[ ... ]
> +	print_hex_dump_debug("got cmd: ", DUMP_PREFIX_OFFSET, 16, 1, message, l=
ength, false);
> +
> +	mutex_lock(&ns2->lock);
[ ... ]
> +void switch2_controller_detach_cfg(struct switch2_controller *ns2)
> +{
> +	mutex_lock(&ns2->lock);
> +	if (!ns2->cfg || WARN_ON(ns2 !=3D ns2->cfg->parent)) {
> +		mutex_unlock(&ns2->lock);
> +		return;
> +	}
> +	if (ns2->cfg->shutdown)
> +		ns2->cfg->shutdown(ns2->cfg);

[Severity: High]
Could this locking sequence lead to an AB-BA deadlock between the detach
path and the worker thread?

When switch2_controller_detach_cfg() or the error path in
switch2_controller_attach_cfg() executes, they first acquire ns2->lock.
They then call the shutdown callback, which resolves to
switch2_usb_shutdown(). This callback calls cancel_work_sync() to wait
for the message_in_work thread to finish.

However, the asynchronous switch2_usb_message_in_work() thread calls
switch2_receive_command(), which attempts to acquire ns2->lock. If the
detach path holds the lock while waiting for the work to complete, and
the work waits for the lock, will they block indefinitely?

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
[ ... ]
> +static int switch2_init_input(struct switch2_controller *ns2)
> +{
[ ... ]
> +	ns2->leds =3D devm_kcalloc(&input->dev, JC_NUM_LEDS, sizeof(*ns2->leds)=
, GFP_KERNEL);
> +	if (!ns2->leds) {
> +		input_unregister_device(input);
> +		return -ENOMEM;
> +	}
> +
> +	for (i =3D 0; i < JC_NUM_LEDS; i++) {
> +		struct led_classdev *led =3D &ns2->leds[i];
[ ... ]
> +		led->name =3D name;
> +		ret =3D devm_led_classdev_register(&input->dev, led);

[Severity: High]
Will using the unmanaged input->dev with devm_led_classdev_register()
create a cyclic dependency that leads to a memory leak and use-after-free?

The input->dev here is allocated via input_allocate_device(), meaning its
devres cleanup only triggers when its reference count drops to zero. But
led_classdev_register() creates a child device that naturally holds a
kobject reference to its parent (the input device).

Because the child keeps the parent's reference count elevated, the parent's
devres cleanup never fires. When switch2_remove() runs,
input_unregister_device() disconnects handlers, but the input device and
LED sysfs nodes remain active indefinitely.

If userspace later interacts with the leaked LED sysfs attributes, it will
trigger switch2_player_led_brightness_set(), which fetches driver data and
dereferences the ns2 object. Since ns2 is freed during switch2_remove() via
kref_put(), could this result in a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006061619.2005=
967-1-vi@endrift.com?part=3D1
