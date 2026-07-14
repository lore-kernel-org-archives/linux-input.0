Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8A817A300
	for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025741; cv=none; b=H33PyDia2wJuIKrHUQ9t7igvMzgiAJqRqUfMoPlYvkiURl8m+uswUIFCZDWNW0MDPcEzbm5ToSL0/Lh9+fyy2YFkxECqCOTTdHA/5mpXrpyiixbIJUfXmKx8QkTeIYcljGaw+tDlooT34OR4LEB8IX7msBjIbhDumyPUU3fFGPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025741; c=relaxed/simple;
	bh=lYiM5K/Wvfjo06AAOEnxA5S5Un7zjsnILSrMMOP0DIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BPpo8LgDxPCyciZx8Awy5xKCoMBRNXvNQYRydMtRtZ1Tn22lAT26mJqMLx8oeNMOUhNSYDM3+I9kOIY51Lk0UDCdEa4+mHdKOkT2NYhzDwgvQ9z9k7gKer5XuS1Pg3zIdWCNoGTPW25q/S3M9qPNdR1oqBl3pHSqf05Z5EsJhQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rmh1ZB+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rmh1ZB+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAE31F000E9;
	Tue, 14 Jul 2026 10:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784025739;
	bh=UsHMVKs2Qcw1gEF/uOu0OYyyJ+1jGgj+XXfUaMidb2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rmh1ZB+GWJlYZjR9Dre2c/WqFrwGHwXQesinnbNVKn5MsaK2MvOoosSPkabrHqBZK
	 CIzebluEthQcYqfn8Q6bvNsd1GV+8A70QASKW2EqCM05EgDYlHgrvaYeQFkARRJDfO
	 Yj6QT6kNdWh/I4qhrPydeS8Cjs9Cw2tfQ12QZBFZH+x7WTwhymzEHbBf4tY0CzYeAV
	 0ECYG646ZZtJ1fHFrCnyKTUCEVCmfGehDMXExjE6ZlMVVVge+CxSZyEkg2MPOU7MQq
	 CcUtVGejpyHM4goE32lq777kGyOGXV9Ej3Cvw17MV9cOTElpB5hKJsUZpJL0SI6GLR
	 bqBZdA0bKDlrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 3/4] HID: hid-msi: Add RGB control interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260714102640.18075-4-derekjohn.clark@gmail.com>
References: <20260714102640.18075-1-derekjohn.clark@gmail.com>
 <20260714102640.18075-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:42:19 +0000
Message-Id: <20260714104219.AEAE31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The `rgb_queue` delayed work accesses a freed device pointer `led_=
cdev.dev` on its error path due to incorrect teardown order in `claw_remove=
`.
- [High] Missing cancellation of `cfg_setup` and `cfg_resume` delayed works=
 in `claw_remove()`.
- [Medium] RGB configuration states and LED class properties are modified a=
nd read concurrently without proper synchronization.
--

--- Patch [3]: [PATCH v12 3/4] HID: hid-msi: Add RGB control interface ---
commit 2d837d4907cf2b48e7866a46da8d35b754a9f9a6
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add RGB control interface

Adds RGB control interface for MSI Claw devices. The MSI Claw uses a
fairly unique RGB interface. It has 9 total zones (4 per joystick ring
and 1 for the ABXY buttons), and supports up to 8 sequential frames of
RGB zone data.

Link: https://patch.msgid.link/20260529072111.7565-4-derekjohn.clark@gmail.=
com

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 9d3249fa50291..ddb64adb08b9c 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c
> @@ -406,6 +406,38 @@ static int claw_profile_event(struct claw_drvdata *d=
rvdata, struct claw_command_
>  		for (i =3D 0; i < CLAW_KEYS_MAX; i++)
>  			codes[i] =3D (mkeys->codes[i]);
>  		break;
> +	case CLAW_RGB_PENDING:
> +		frame =3D (struct claw_rgb_report *)cmd_rep->data;
> +		rgb_addr =3D drvdata->rgb_addr;
> +		read_addr =3D be16_to_cpu(frame->read_addr);
> +
> +		if (read_addr < drvdata->rgb_addr)
> +			return -EAGAIN;
> +
> +		frame_calc =3D (read_addr - rgb_addr) / CLAW_RGB_FRAME_OFFSET;
> +		if (frame_calc >=3D CLAW_RGB_MAX_FRAMES) {
> +			dev_err(&drvdata->hdev->dev, "Got unsupported frame index: %x\n",
> +				frame_calc);
> +			return -EAGAIN;
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
> +
> +			drvdata->rgb_speed =3D frame->speed;
> +			drvdata->led_mc.led_cdev.brightness =3D frame->brightness;

[Severity: Medium]
Are there missing locks around rgb_speed and led_cdev.brightness?

Here in claw_profile_event(), drvdata->rgb_speed and
drvdata->led_mc.led_cdev.brightness are written to under the frame_lock.
However, they appear to be read locklessly in claw_write_rgb_state() outside
of frame_lock. Similarly, speed_store() modifies drvdata->rgb_speed lockles=
sly
from userspace.

Could this inconsistent locking lead to torn reads or data races between
sysfs operations, hardware events, and the workqueue?

[ ... ]

> +static void claw_rgb_queue_fn(struct work_struct *work)
> +{
> +	struct delayed_work *dwork =3D container_of(work, struct delayed_work, =
work);
> +	struct claw_drvdata *drvdata =3D container_of(dwork, struct claw_drvdat=
a, rgb_queue);
> +	int ret;
> +
> +	if (!drvdata)
> +		return;
> +
> +	scoped_guard(spinlock_irqsave, &drvdata->registration_lock) {
> +		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context=
 */
> +		if (!smp_load_acquire(&drvdata->rgb_registered))
> +			return;
> +	}
> +
> +	ret =3D claw_apply_rgb_state(drvdata);
> +	if (ret)
> +		dev_err(drvdata->led_mc.led_cdev.dev,
> +			"Failed to apply RGB state: %d\n", ret);

[Severity: High]
Could this dev_err() access a freed device pointer?

If claw_rgb_queue_fn() starts executing and passes the rgb_registered check,
but the device is concurrently removed, claw_remove() will set rgb_register=
ed
to false and call led_classdev_multicolor_unregister(). This drops the final
reference and frees led_cdev.dev.

If claw_apply_rgb_state() subsequently fails, this error path will log using
drvdata->led_mc.led_cdev.dev, which might trigger a use-after-free since the
work was not canceled prior to unregistration.

[ ... ]

> @@ -1084,6 +1721,7 @@ static void claw_remove(struct hid_device *hdev)
>  {
>  	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
>  	bool gp_registered;
> +	bool rgb_registered;
> =20
>  	if (!drvdata)
>  		return;
> @@ -1096,11 +1734,21 @@ static void claw_remove(struct hid_device *hdev)
>  		gp_registered =3D smp_load_acquire(&drvdata->gp_registered);
>  		/* Pairs with smp_load_acquire in attribute show/store functions */
>  		smp_store_release(&drvdata->gp_registered, false);
> +		/* Pairs with smp_store_release from cfg_setup_fn in system_wq context=
 */
> +		rgb_registered =3D smp_load_acquire(&drvdata->rgb_registered);
> +		/* Pairs with smp_load_acquire in attribute show/store functions */
> +		smp_store_release(&drvdata->rgb_registered, false);
>  	}
> =20
>  	if (gp_registered)
>  		device_remove_group(&hdev->dev, &claw_gamepad_attr_group);
> =20
> +	if (rgb_registered) {
> +		device_remove_group(drvdata->led_mc.led_cdev.dev, &claw_rgb_attr_group=
);
> +		led_classdev_multicolor_unregister(&drvdata->led_mc);
> +	}
> +	cancel_delayed_work_sync(&drvdata->rgb_queue);

[Severity: High]
Should cancel_delayed_work_sync() for rgb_queue happen before
led_classdev_multicolor_unregister()?

Canceling the work after unregistering the LED device creates a window
where the executing work can access freed led_cdev.dev memory (as noted
in claw_rgb_queue_fn).

>  	hid_hw_close(hdev);
>  }

[Severity: High]
Are we missing the cancellation of the cfg_setup and cfg_resume delayed wor=
ks?

The driver schedules cfg_setup and cfg_resume, but does not seem to explici=
tly
cancel them here in claw_remove(). If the device is disconnected while eith=
er
work is pending, could they execute after drvdata has been freed by devres,
resulting in a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714102640.1807=
5-1-derekjohn.clark@gmail.com?part=3D3
