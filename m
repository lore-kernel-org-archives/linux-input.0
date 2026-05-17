Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003DF70830
	for <linux-input@vger.kernel.org>; Sun, 17 May 2026 03:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778988292; cv=none; b=eV1WdYndPTAd7IoKssJGNxGpjdIHE3lfFOASTSSqehur84Sj/NFGmeuSnvHQHic5sHnAlYY4Jhtn38IOPTu3KfNLtvETX1DvJllz+EQysntt1AmRMu2hA5hmfQWmbmyM2AVnNwARMOIlvS3ZeASwqdsKvrEyUecP/oPTKIAm88g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778988292; c=relaxed/simple;
	bh=r8aGdChDVptqyN4NzPF0o5AfLcvO5a/u461NOiP9X40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cyF8hlbmXnKQQQb2he+RSJn2kcmsyfBmjSa1LakByn0fqAQ52IE23YBW3dv8Z/2bAg9erZ7Ra5rNymvmzfHonlIvKkQLqvsW2lb1DWPOU9ErQZMTVHAldgyTse5ivfm9OjJBbHMfMG3tr2eQMjVsvV6g3kqXwU8PG3aEs8z6n8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzvDwtge; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzvDwtge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6139CC2BCB7;
	Sun, 17 May 2026 03:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778988291;
	bh=r8aGdChDVptqyN4NzPF0o5AfLcvO5a/u461NOiP9X40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZzvDwtge3KRpMh/g8EGM31huJDSuhyfL9O1srrIETxSVw1TJ0bCnFNEZklpSa39SA
	 Wuyae/Eim97JQ3qQcrDxgh96FrcWn2vHHiprLgXI1v8Xd1smVoza8ElfKTUQcMc0oJ
	 Ylhpg6hvm3I8EO9c5jyB53jYEVDLt4E8IG8D7XWmov1p6hzkcji0kFahwpWSyLwk5k
	 rt9fw9PInrdNtT6A6VgwnaDbVn86wD1A53MbeD1hwnEaCKjkjMRse3T/XvkBfQ0toR
	 7dgE1KWO6P2tSo6Jb5hZtT42S0Uv0TfrW0VaFjnL1TSIvrVjdl1A5QXRXChQdoN3qH
	 qfSl1xd7tD6GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] HID: hid-msi: Add RGB control interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260517013925.3120314-4-derekjohn.clark@gmail.com>
References: <20260517013925.3120314-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 03:24:50 +0000
Message-Id: <20260517032451.6139CC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Holding `cfg_mutex` while removing sysfs attribute groups in `claw=
_remove()` deadlocks with concurrent sysfs operations.
- [High] Teardown race condition allows `rgb_queue` to be re-queued after c=
ancellation, leading to a Use-After-Free.
- [High] Unconditionally canceling the `rgb_queue` delayed work causes a cr=
ash if the setup worker has not executed.
- [Medium] Spurious timeouts due to an 8ms wait limit can break command-res=
ponse synchronization.
- [Medium] Error handling paths in device initialization log errors using a=
 NULL device pointer.
- [Medium] RGB work can be incorrectly scheduled while the device is suspen=
ded.
- [Low] Using a `break` statement inside a `scoped_guard` block creates con=
fusing control flow.
--

commit 4a725c6bd4a5cd260e20d40567af5406130e6b41
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add RGB control interface

Adds RGB control interface for MSI Claw devices, supporting 9 zones
and up to 8 sequential frames of RGB data written to MCU memory.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 991d5a25d3de0..4443f53b54cb1 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -311,15 +375,45 @@ static int claw_profile_event(struct claw_drvdata *=
drvdata, struct claw_command_
>  		for (i =3D 0; i < CLAW_KEYS_MAX; i++)
>  			codes[i] =3D (cmd_rep->data[6 + i]);
>  		break;
> +	case CLAW_RGB_PENDING:
> +		frame =3D (struct rgb_report *)cmd_rep->data;
> +		rgb_addr =3D drvdata->rgb_addr;
> +		read_addr =3D be16_to_cpu(frame->read_addr);
> +		frame_calc =3D (read_addr - rgb_addr) / CLAW_RGB_FRAME_OFFSET;
> +		if (frame_calc >=3D CLAW_RGB_MAX_FRAMES) {
> +			dev_err(drvdata->led_mc.led_cdev.dev, "Got unsupported frame index: %=
x\n",
> +				frame_calc);

Since this function is called during the initial setup in
claw_read_rgb_config() before devm_led_classdev_multicolor_register() has
run, is led_cdev.dev potentially NULL here? Will it print an obscured
"(NULL device *)" log message instead of the device name?=20

Could we use &drvdata->hdev->dev instead?

> +			drvdata->profile_pending =3D CLAW_NO_PENDING;
> +			return -EINVAL;
> +		}
> +		f_idx =3D frame_calc;
> +
> +		scoped_guard(spinlock_irqsave, &drvdata->frame_lock) {
> +			memcpy(&drvdata->rgb_frames[f_idx], &frame->zone_data,
> +			       sizeof(struct rgb_frame));
> +
> +			/* Only use frame 0 for remaining variable assignment */
> +			if (f_idx !=3D 0)
> +				break;

This isn't a bug, but using a break inside a scoped_guard escapes the
internal hidden for loop used to implement the macro. It works correctly
here because the lock is dropped and the next line is the switch statement's
own break, but it creates confusing control flow.=20

Should we use an if (f_idx =3D=3D 0) { ... } block instead?

> +
> +			drvdata->rgb_speed =3D frame->speed;
> +			drvdata->led_mc.led_cdev.brightness =3D frame->brightness;
> +			drvdata->led_mc.subled_info[0].intensity =3D frame->zone_data.zone[0]=
.red;
> +			drvdata->led_mc.subled_info[1].intensity =3D frame->zone_data.zone[0]=
.green;
> +			drvdata->led_mc.subled_info[2].intensity =3D frame->zone_data.zone[0]=
.blue;
> +		}
> +
> +		break;

[ ... ]

> @@ -769,6 +863,420 @@ static const struct attribute_group claw_gamepad_at=
tr_group =3D {
>  	.is_visible =3D claw_gamepad_attr_is_visible,
>  };
> =20
> +/* Read RGB config from device */
> +static int claw_read_rgb_config(struct hid_device *hdev)
> +{
> +	u8 data[4] =3D { 0x01, 0x00, 0x00, CLAW_RGB_FRAME_OFFSET };
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +	u16 read_addr =3D drvdata->rgb_addr;
> +	size_t len =3D ARRAY_SIZE(data);
> +	int ret, i;
> +
> +	if (!drvdata->rgb_addr)
> +		return -ENODEV;
> +
> +	/* Loop through all 8 pages of RGB data */
> +	guard(mutex)(&drvdata->profile_mutex);
> +	for (i =3D 0; i < 8; i++) {
> +		drvdata->profile_pending =3D CLAW_RGB_PENDING;
> +		data[1] =3D (read_addr >> 8) & 0xff;
> +		data[2] =3D read_addr & 0x00ff;
> +		ret =3D claw_hw_output_report(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, da=
ta, len, 8);

Does an 8ms timeout pose a risk of spurious timeouts on systems where HZ=3D=
100?

With HZ=3D100, msecs_to_jiffies(8) evaluates to 1 jiffy. If the system timer
ticks immediately after the wait begins,
wait_for_completion_interruptible_timeout() can return 0 in less than 1ms.
If this happens, does it break command synchronization since the hardware
will eventually ACK the first command?

[ ... ]

> +static void cfg_setup_fn(struct work_struct *work)
>  {
>  	struct delayed_work *dwork =3D container_of(work, struct delayed_work, =
work);
> @@ -782,6 +1290,13 @@ static void cfg_setup_fn(struct work_struct *work)
>  		return;
>  	}
> =20
> +	ret =3D claw_read_rgb_config(drvdata->hdev);
> +	if (ret) {
> +		dev_err(drvdata->led_mc.led_cdev.dev,
> +			"Failed to setup device, can't read RGB config: %d\n", ret);

Is it possible led_cdev.dev is NULL here since
devm_led_classdev_multicolor_register() has not been called yet?

> +		return;
> +	}
> +
>  	/* Add sysfs attributes after we get the device state */
>  	ret =3D device_add_group(&drvdata->hdev->dev, &claw_gamepad_attr_group);
>  	if (ret) {
> @@ -791,7 +1306,25 @@ static void cfg_setup_fn(struct work_struct *work)
>  	}
>  	drvdata->gamepad_registered =3D true;
> =20
> +	/* Add and enable RGB interface once we have the device state */
> +	INIT_DELAYED_WORK(&drvdata->rgb_queue, &claw_rgb_queue_fn);

If INIT_DELAYED_WORK is called asynchronously 500ms after probe, what
happens if the device is unplugged or suspended before this timer expires?

Will the unconditional cancel_delayed_work_sync(&drvdata->rgb_queue) in
claw_remove() or claw_suspend() be called on a zero-initialized work
structure, causing undefined behavior and a kernel crash?

[ ... ]

> @@ -918,10 +1475,15 @@ static void claw_remove(struct hid_device *hdev)
>  		return;
>  	}
> =20
> +	/* Block writes to brightness/multi_intensity during teardown */
> +	drvdata->led_mc.led_cdev.brightness_set =3D NULL;
>  	cancel_delayed_work_sync(&drvdata->cfg_setup);
>  	cancel_delayed_work_sync(&drvdata->cfg_resume);
> +	cancel_delayed_work_sync(&drvdata->rgb_queue);

Can rgb_queue be re-queued after this point, leading to a Use-After-Free?

Since cancel_delayed_work_sync() is called before the custom sysfs
attributes are removed via device_remove_group() and before the devm-managed
LED class device is unregistered, a user could write to an RGB sysfs
attribute (like effect or speed) concurrently with or immediately after the
work is canceled. The sysfs callback executes mod_delayed_work() and
re-queues the delayed work.=20

When claw_remove() finishes, devres frees the drvdata memory. Could the
re-queued work execute later on the freed memory?

> =20
>  	guard(mutex)(&drvdata->cfg_mutex);
> +	if (drvdata->rgb_registered)
> +		device_remove_group(drvdata->led_mc.led_cdev.dev, &claw_rgb_attr_group=
);
>  	if (drvdata->gamepad_registered)
>  		device_remove_group(&hdev->dev, &claw_gamepad_attr_group);

Can holding cfg_mutex across these device_remove_group() calls cause an
ABBA deadlock?

device_remove_group() blocks until all active sysfs operations for the
group finish. However, if a sysfs callback (like mkeys_function_store() for
the gamepad group) is executing concurrently, it will call
claw_hw_output_report() which attempts to acquire cfg_mutex.

If this occurs, the sysfs callback will block waiting for cfg_mutex, and
claw_remove() will block waiting for the sysfs callback to complete,
hanging device teardown.

[ ... ]

> @@ -982,6 +1544,7 @@ static int claw_suspend(struct hid_device *hdev)
> =20
>  	cancel_delayed_work_sync(&drvdata->cfg_setup);
>  	cancel_delayed_work_sync(&drvdata->cfg_resume);
> +	cancel_delayed_work_sync(&drvdata->rgb_queue);

Can the rgb_queue work be incorrectly re-scheduled while the device is
suspended?

Since the LED class device and custom sysfs attributes remain active, if an
active LED trigger or a userspace sysfs write occurs during suspend, could
mod_delayed_work() re-queue the work and cause the driver to attempt USB
communication with a suspended device?

> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517013925.3120=
314-1-derekjohn.clark@gmail.com?part=3D3
