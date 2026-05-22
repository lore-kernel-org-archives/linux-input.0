Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6A31E834E
	for <linux-input@vger.kernel.org>; Fri, 22 May 2026 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422456; cv=none; b=OvUEST7tCrBCfnfZuqcjdOMISZIqZNr+Q5hemslZtNi/peymKH2u3k64vAIPTLcZE/zsZEdxtvYWmoRBCdYfw71CDsnGEg0upq1KeMAbesS4VaCKpAYK4j7jXgn1c+fieV5MBPRi7lMAUl9bvtTIJMXWAxHHHunFGeEYSCNZSM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422456; c=relaxed/simple;
	bh=ZeQ1FpwsAlAMHaSW2w++O0fUYyAj8oAI3i3yAwG5IN4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bt6wVggCB32HOg2w4v/vkuRiHfljGD+OojD6UNWyOk1DdqdlFfZuUuEq7Da/1pEuc14X9+q8Hvfxh3UiWd7THyGxo3sAlaOqr6i9CBf5FWPBn0pnEYbdYnaivS+4vYxRjOy1v7yI6HE8DjczstnULo6JLgLXyc+QTSsNCdwe+/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeY8Zgyb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeY8Zgyb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05631F000E9;
	Fri, 22 May 2026 04:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779422455;
	bh=a6bMZkGfr8iR8TCRykvmPSDvIFjgr28DnedmZs3S6/Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aeY8ZgybqEXA7u2Wj6NFP8XDeKFXKC0XgwZ5AjeP04bgmzu03UGiBr2mhsCfrGafF
	 nn26Fg7/VYxtTzq/CSVDYIPC2pD2VG6S4eYRllSg0Y/qAU+LuIkqTFUv68CCwmsbUc
	 U0bLj+li6vccTFYaNgsF6Qtp5FxGXmbs9C1uKaICdOX1knB+kjl7CdzyhkDRCzBGgj
	 dwnCqOJnps9IdaYxpx+L56AdTCqiJKCNsB3V9wrI+MI2ZUTuZkO8Q3eGu8IY+lnB2e
	 PpCuwKFJkrAPpOpC7TQd2ciWYs6Y8UdLY3w6sUzWTozzr4P4UcG3OIvNKj/u9LSNk8
	 LtEaX7N9utFdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/4] HID: hid-msi: Add RGB control interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260522015518.1111290-4-derekjohn.clark@gmail.com>
References: <20260522015518.1111290-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 04:00:54 +0000
Message-Id: <20260522040054.F05631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Explicitly unregistering a devm-managed LED class device causes a =
double unregister and list corruption upon device teardown.
- [High] Calling sleepable functions that allocate memory with GFP_KERNEL o=
r take sleeping locks while holding a spinlock.
- [High] Race condition between sysfs/LED attributes and `claw_remove()` al=
lows `rgb_queue` to be scheduled after cancellation.
- [High] Missing cancellation of the `rgb_queue` delayed work during system=
 suspend can cause USB I/O to a suspended device.
--

commit 34d0916b058e394f024a63889da5c0fbe434c516
Author: Derek J. Clark <derekjohn.clark@gmail.com>

    HID: hid-msi: Add RGB control interface

    Adds RGB control interface for MSI Claw devices. The MSI Claw uses a
    fairly unique RGB interface with 9 total zones, supporting up to 8
    sequential frames of RGB zone data. The driver mirrors the effects
    available in Windows while keeping effect names consistent with Lenovo
    drivers.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index b9901869075f6..0b875603dbb32 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> +static ssize_t effect_store(struct device *dev,
> +			    struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
> +	struct led_classdev_mc *led_mc =3D container_of(led_cdev, struct led_cl=
assdev_mc, led_cdev);
> +	struct claw_drvdata *drvdata =3D container_of(led_mc, struct claw_drvda=
ta, led_mc);
> +	int ret;
> +
> +	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
> +		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context=
 */
> +		if (!smp_load_acquire(&drvdata->rgb_registered))
> +			return -ENODEV;
> +	}
> +
> +	ret =3D sysfs_match_string(claw_rgb_effect_text, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	drvdata->rgb_effect =3D ret;
> +	mod_delayed_work(system_wq, &drvdata->rgb_queue, msecs_to_jiffies(50));

[Severity: High]
Can mod_delayed_work() here race with claw_remove()?

If claw_remove() runs concurrently, it acquires the registration_lock, sets
rgb_registered to false, drops the lock, and calls
cancel_delayed_work_sync(&drvdata->rgb_queue).

It then calls device_remove_group(), which blocks until this sysfs store
completes. Once device_remove_group() returns, devres frees drvdata.

However, since this sysfs store function already checked rgb_registered and
dropped the lock, it will continue executing and call mod_delayed_work(),
re-arming the workqueue. Will this lead to the delayed work executing on
freed memory?

> +
> +	return count;
> +}

[ ... ]

> +static void cfg_setup_fn(struct work_struct *work)
> +{
[ ... ]
> +try_gamepad:
> +	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
> +		/* Pairs with smp_store_release from below */
> +		if (!smp_load_acquire(&drvdata->gamepad_registered) && gamepad_ready) {
> +			ret =3D devm_device_add_group(&drvdata->hdev->dev, &claw_gamepad_attr=
_group);

[Severity: High]
Does devm_device_add_group() sleep?

It allocates memory using GFP_KERNEL inside devres_alloc() and acquires
the sleeping kernfs_mutex during sysfs group creation. Calling this inside a
spinlock block with interrupts disabled will trigger a scheduling while ato=
mic
panic. Can this be called outside the spinlock?

> +			if (ret) {
> +				dev_err(&drvdata->hdev->dev,
> +					"Failed to create gamepad attrs: %d\n", ret);
> +				goto try_rgb;
> +			}
> +
> +			/* Pairs with smp_load_acquire in attribute show/store functions */
> +			smp_store_release(&drvdata->gamepad_registered, true);
> +		}
>  	}
> -	scoped_guard(spinlock_irqsave, &drvdata->registration_lock)
> -		/* Pairs with smp_load_acquire in attribute show/store functions */
> -		smp_store_release(&drvdata->gamepad_registered, true);
> =20
> -	kobject_uevent(&drvdata->hdev->dev.kobj, KOBJ_CHANGE);
> +try_rgb:
> +	/* Add and enable RGB interface once we have the device state */
> +	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
> +		/* Pairs with smp_store_release from below */
> +		if (!smp_load_acquire(&drvdata->rgb_registered) && rgb_ready) {
> +			ret =3D devm_led_classdev_multicolor_register(&drvdata->hdev->dev,
> +								    &drvdata->led_mc);

[Severity: High]
Does devm_led_classdev_multicolor_register() also sleep?

Similar to devm_device_add_group(), this registers a device which takes
sleeping locks and allocates memory with GFP_KERNEL. Should this be called
outside of the spinlock block?

> +			if (ret) {
> +				dev_err(&drvdata->hdev->dev,
> +					"Failed to create led device: %d\n", ret);
> +				goto update_kobjects;
> +			}
> +
> +			ret =3D device_add_group(drvdata->led_mc.led_cdev.dev, &claw_rgb_attr=
_group);
> +			if (ret) {
> +				dev_err(&drvdata->hdev->dev,
> +					"Failed to create RGB attrs: %d\n", ret);
> +				led_classdev_unregister(&drvdata->led_mc.led_cdev);

[Severity: High]
Does this manual unregister cause a double-free on device teardown?

Since devm_led_classdev_multicolor_register() attaches a devres cleanup
action, manually calling led_classdev_unregister() here leaves the devres
action queued. When the driver is unbound, devres will execute
led_classdev_unregister() a second time on the same LED class device pointe=
r.
Will this result in list corruption and use-after-free?

> +				goto update_kobjects;
> +			}
> +
> +				/* Pairs with smp_load_acquire in attribute show/store functions */
> +				smp_store_release(&drvdata->rgb_registered, true);
> +		}
> +	}

[ ... ]

> @@ -971,9 +1593,11 @@ static int claw_probe(struct hid_device *hdev, u8 e=
p)
>  	spin_lock_init(&drvdata->cmd_lock);
>  	spin_lock_init(&drvdata->mode_lock);
>  	spin_lock_init(&drvdata->profile_lock);
> +	spin_lock_init(&drvdata->frame_lock);
>  	init_completion(&drvdata->send_cmd_complete);
>  	INIT_DELAYED_WORK(&drvdata->cfg_resume, &cfg_resume_fn);
>  	INIT_DELAYED_WORK(&drvdata->cfg_setup, &cfg_setup_fn);
> +	INIT_DELAYED_WORK(&drvdata->rgb_queue, &claw_rgb_queue_fn);

[Severity: High]
Is the rgb_queue delayed work properly cancelled during system suspend?

In claw_suspend(), the driver cancels cfg_resume and cfg_setup, but it does
not appear to cancel the newly introduced rgb_queue delayed work. Because
rgb_queue is queued on system_wq (which is not freezable), could it execute
after the device has been suspended? This might lead to USB I/O errors and
possible hardware lockups.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522015518.1111=
290-1-derekjohn.clark@gmail.com?part=3D3
