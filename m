Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F58367B89
	for <linux-input@vger.kernel.org>; Wed,  1 Jul 2026 03:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782876814; cv=none; b=knJERH9pK7hDfHHRFHT/q5zfErBecDGnt3CX4LM6Dt7STazGV03bNfsnI/XbXLULibIW1oxvEtxjgssU9AMTqiMcddB4fJ0RS3D1IP1gmEuGch4A4RWlAxXy9kNzRUtNHbZCQrO6iLsBcz9JOU6CgJh2vNXKMRsJa5rcozsIfLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782876814; c=relaxed/simple;
	bh=B3EI7OL1t2g1GUWs/K3JaZuNn+Eakb/9T5e4TH6gVfs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KvjV8Q4MCv98EjTPmv7M8/ClRk0Ttw/AnvpiB5qWPIadUB1kjd1MYFhO9Eh93JgQXxg2uZC7DYq86XQ9qLXOq2AjHt3nyk54m7VkGXKVBwknldCFlPBjGsHaRMluyKsoKi59SzfqpdMbtGsXiIV86KYZOB74XEJjXRcmYnbGCOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxYU8xgb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxYU8xgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFCB1F000E9;
	Wed,  1 Jul 2026 03:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782876812;
	bh=TnE52KI45C3RpQf3BzGsiTp9EgRQvUhEPcI0UuC8Aig=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AxYU8xgbEptU5ROhyYS8GOoGB500oO6ZeK+1FWZHiWbXgtWhgUBFzLB705ZURnU/r
	 AefGmWqCVQclZCE622Xj5xsc4MvJJco3XScrPl1gWPgCn+hkBfxTycZCM12Ns915Ww
	 TqjY6am7G6E3Sep8iYWwmBO5HkWH5UlMKFlEQnn9kjLBnh8l+Bzrp6rblHm5lrKxEj
	 ju9u+nmIUtd6TFRS04v/D/ovz+1Z9F4ZeS+mZUb3fQcKEPE9s80+yHkg1X0JG8+LOS
	 2SIEkerz+zLd9Rh2ZhXxSMvd4jElM0lG9u3/mAHpBsBNiMmgVwgPlsQ/qLXe2kY8Zn
	 fj1zRAMCGoIqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/3] HID: nintendo: Add rumble support for Switch 2
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260701031513.3068035-3-vi@endrift.com>
References: <20260701031513.3068035-1-vi@endrift.com>
 <20260701031513.3068035-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 03:33:32 +0000
Message-Id: <20260701033332.AEFCB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Explicitly calling input_free_device() on a devm-managed input=
 device in error paths leads to a double-free.
- [High] ABBA deadlock between ns2->lock and ns2->rumble_work during device=
 removal or probe failure.
- [High] Teardown race allows hid_hw_output_report() to execute on a stoppe=
d HID device.
- [High] The rumble delayed work loop fails to bound catch-up scheduling, c=
ausing permanent zero-delay spam.

Pre-existing issues:
- [Critical] Double spinlock acquisition causing a deadlock in the error pa=
th of switch2_usb_probe.
--

commit 8dfb25ac3f59c21072ff7262dbfd49faf2095c2d
Author: Vicki Pfau <vi@endrift.com>
Subject: HID: nintendo: Add rumble support for Switch 2 controllers

This commit adds rumble support for Switch 2 controllers. It handles both
HD Rumble LRAs for Joy-Cons and Pro Controllers, and eccentric rotating
mass haptics for GameCube controllers. Since evdev lacks a full LRA API,
it simulates basic rumble effects.

> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 20e5b18039b85..00ab4bee3dabc 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c

[ ... ]

> @@ -3205,6 +3259,125 @@ static void switch2_kref_put(struct kref *refcoun=
t)
>  	kfree(ns2);
>  }
> =20
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)

[ ... ]

> +static int switch2_play_effect(struct input_dev *dev, void *data, struct=
 ff_effect *effect)
> +{
> +	struct switch2_controller *ns2 =3D input_get_drvdata(dev);

[ ... ]

> +	schedule_delayed_work(&ns2->rumble_work, 0);

[Severity: High]
Does this create a race condition with device teardown?

During hot-unplug, switch2_remove() calls cancel_delayed_work_sync() and
hid_hw_stop(hdev). However, because the input device is not unregistered
until switch2_controller_put() is called under ns2->lock, userspace could
still send EV_FF events via ioctl.

If switch2_play_effect() is invoked during this window, it schedules
ns2->rumble_work unconditionally.

> +
> +	return 0;
> +}
> +
> +static void switch2_rumble_work(struct work_struct *work)
> +{
> +	struct switch2_controller *ns2 =3D container_of(to_delayed_work(work),
> +						      struct switch2_controller, rumble_work);

[ ... ]

> +	if (active) {
> +		unsigned long interval =3D msecs_to_jiffies(4);
> +		uint64_t current_jiffies =3D get_jiffies_64();
> +
> +		if (!ns2->last_rumble_work)
> +			ns2->last_rumble_work =3D current_jiffies;
> +		else
> +			ns2->last_rumble_work +=3D interval;
> +
> +		/* Reschedule a little early to make sure the buffer never underruns */
> +		interval +=3D msecs_to_jiffies(2);
> +		if (ns2->last_rumble_work + interval >=3D current_jiffies)
> +			schedule_delayed_work(&ns2->rumble_work,
> +				ns2->last_rumble_work + interval - current_jiffies);
> +		else
> +			schedule_delayed_work(&ns2->rumble_work, 0);

[Severity: High]
Can this loop get stuck in a permanent zero-delay spam?

If the worker gets delayed by system load or if hid_hw_output_report() takes
longer than 4ms, ns2->last_rumble_work falls behind current_jiffies. The
code adds a fixed 4ms to last_rumble_work and calls schedule_delayed_work()
with a 0 delay to catch up.

If the worker continuously takes more than 4ms to run, current_jiffies
advances alongside last_rumble_work. Without a cap or reset mechanism, could
this flood the hardware and monopolize a workqueue thread indefinitely?

> +	} else {
> +		ns2->last_rumble_work =3D 0;
> +	}
> +
> +	mutex_lock(&ns2->lock);

[Severity: High]
Could this lead to an ABBA deadlock?

In switch2_remove(), we take ns2->lock and then call
switch2_controller_put(), which calls input_unregister_device(). This will
synchronously invoke the driver close callback, switch2_input_deref().

If switch2_input_deref() calls cancel_delayed_work_sync(), it will wait
for this worker to finish while holding ns2->lock. If switch2_rumble_work()
is currently executing, it will attempt to acquire ns2->lock here, resulting
in a deadlock.

> +	if (!ns2->hdev) {
> +		cancel_delayed_work(&ns2->rumble_work);
> +	} else {
> +		ret =3D hid_hw_output_report(ns2->hdev, ns2->rumble_buffer, 64);

[Severity: High]
Can this execute hid_hw_output_report() on a stopped device?

If switch2_play_effect() schedules rumble_work after switch2_remove()
called hid_hw_stop(), this worker will run, acquire ns2->lock, and pass the
!ns2->hdev check because ns2->hdev has not yet been set to NULL.

> +		/*
> +		 * Don't log on ENODEV, ESHUTDOWN, or EPROTO, which can happen
> +		 * mid-hotplug. Also cancel any further work on ENODEV or
> +		 * ESHUTDOWN as they're clear indications that the endpoint
> +		 * is dead.
> +		 */

[ ... ]

> @@ -3275,6 +3448,9 @@ static void switch2_input_deref(struct input_dev *i=
nput)
>  {
>  	struct switch2_controller *ns2 =3D input_get_drvdata(input);
> =20
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	cancel_delayed_work_sync(&ns2->rumble_work);

[Severity: High]
Can this cause a deadlock during device removal?

switch2_remove() calls mutex_lock(&ns2->lock) followed by
switch2_controller_put(ns2). This eventually triggers the input core to
synchronously call this callback (switch2_input_deref).

Calling cancel_delayed_work_sync() while the removal thread holds ns2->lock
will deadlock if switch2_rumble_work() is simultaneously trying to acquire
ns2->lock.

> +#endif
>  	kref_put(&ns2->refcount, switch2_kref_put);
>  }

[ ... ]

> @@ -3346,6 +3522,20 @@ static int switch2_init_input(struct switch2_contr=
oller *ns2)
>  		return -EINVAL;
>  	}
> =20
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	ns2->rumble_buffer =3D devm_kzalloc(&input->dev, 64, GFP_KERNEL);
> +	if (!ns2->rumble_buffer) {
> +		input_free_device(input);
> +		return -ENOMEM;
> +	}
> +	input_set_capability(input, EV_FF, FF_RUMBLE);
> +	ret =3D input_ff_create_memless(input, NULL, switch2_play_effect);
> +	if (ret) {
> +		input_free_device(input);

[Severity: Critical]
Will calling input_free_device() here lead to a double-free?

The input device was allocated earlier using devm_input_allocate_device().
By explicitly calling input_free_device() in this error path, the reference
count drops and the memory is freed.

When the probe entirely fails and the devres cleanup triggers
(devm_input_device_release()), it will attempt to call input_put_device() on
the already freed memory.

> +		return ret;
> +	}
> +#endif
> +
>  	hid_info(ns2->hdev, "Firmware version %u.%u.%u (type %i)\n", ns2->versi=
on.major,

[ ... ]

> @@ -4018,6 +4226,9 @@ static void switch2_remove(struct hid_device *hdev)
>  {
>  	struct switch2_controller *ns2 =3D hid_get_drvdata(hdev);
> =20
> +#if IS_ENABLED(CONFIG_NINTENDO_FF)
> +	cancel_delayed_work_sync(&ns2->rumble_work);
> +#endif
>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);

[Severity: High]
Does this cancellation leave a window for the worker to be rescheduled?

The input device is not unregistered until switch2_controller_put()
is called later in this function. Userspace can still send EV_FF events via
ioctl, which could invoke switch2_play_effect() and unconditionally
reschedule ns2->rumble_work after the device has been stopped.

>  	mutex_lock(&ns2->lock);

Additionally, there is a finding in a separate file:

[Severity: Critical]
This isn't a bug introduced by this patch, but could the error handling in
switch2_usb_probe() cause a deadlock?

During probe, if usb_alloc_urb() or usb_alloc_coherent() fails in the
NS2_IN_URBS loop, the code jumps to the err_free_in label:

drivers/input/joystick/nintendo-switch2-usb.c:switch2_usb_probe() {
    ...
    if (!urb) {
        spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
        continue;
    }
    ...
}

It incorrectly calls spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags) again
instead of spin_unlock_irqrestore(), causing an immediate double-lock deadl=
ock
when trying to free the URBs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701031513.3068=
035-1-vi@endrift.com?part=3D2
