Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A817A2E8
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421721; cv=none; b=cLvrtvPb6LgkNqUaaJyYx/uJIKh5RUeGhwsA+ZfUn0iC0hG3B8iQcuNVvwD1Wi/aDnRUpLg+5l8u6H0AbysSM+2bqgVL/qedZ0b2kIdPE7PRLPfkFVBeEPbxDOGJ35TNBGbsAn1D8aTg7eWa6aZDLYt6UIFY9aIL/4/UC2uswZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421721; c=relaxed/simple;
	bh=c0VhtHPxmPwdQiaRnHym6kN0JTTbGKkzQJP2ADd5pak=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I8v1RHB+3GovuetTD99B+zxJF8ryD6OTh6DcnLmBK4HWJ4ld/CdOjOwEImP3wOWPVDu2kJa1TDTDJSamclI0KRNVNxTJ2oYsVmSrzBPNXS/tLi7vp0e0kU5dGZkGam24aVFGThRpspkwICB3IugkgREPpc3qfm0RCs/xaJp30Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpZw/+P5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpZw/+P5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4279D1F000E9;
	Thu,  3 Sep 2026 07:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788421719;
	bh=ilwHtbrMLcjFIiLPUn0eCSdLaaY982x9ywNzthYD/3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fpZw/+P5rMy8/oGt8o1PuT0un2DjjHKvp2FOzFNzVyiWz3WYHE8GJcyKM/mkcqFII
	 XH4Fhd191WbVrnZZ3AMDR3KgGyQq3z7aLcFrwVLqGtap3bkpjeQpLknXYkp/7c/mLo
	 2CQ3g8wiHprCtwI0T5DctLnY0Ayrhbv4TCCvoqmDwLgq1A3FbQx9gsNmdeHlPWQrkc
	 wKLiCy+e7pM5vCmV95FABQ1yT9sbCYX/i8ivbK1BXfSqIUZZ9/pJCej1iR5RSxEk+K
	 37HkQhOt43Oqw7UA5RT7dlkHSiASPghrf21nvKZ0TY1KQJp3punT+r+iOR172AjEbQ
	 IB+f2L/LRPszA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] HID: lamparray: add new LampArray helper module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Erhardt" <aer@tuxedocomputers.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260903073602.3815258-2-aer@tuxedocomputers.com>
References: <20260903073602.3815258-1-aer@tuxedocomputers.com>
 <20260903073602.3815258-2-aer@tuxedocomputers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:48:38 +0000
Message-Id: <20260903074839.4279D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] Division by zero during LampArray LED registration if the device r=
eports zero intensity levels.
- [High] `lamparray_register` forcibly releases the HID core's `driver_inpu=
t_lock` during driver probe.
- [Medium] Concurrent sysfs writes can cause the internal state flag (`use_=
leds_uapi`) to completely desynchronize from the actual LED registration st=
ate due to prematurely dropping `dev_lock`.
- [Medium] The hardcoded LED name violates the LED subsystem naming convent=
ions and will cause a sysfs `-EEXIST` error when multiple identical devices=
 are connected.
- [Medium] The driver assumes all color and range fields reside within the =
same HID report, leading to incomplete state updates if they are split.
- [Medium] Hardware is left in a non-autonomous state on the `lamparray_reg=
ister` error path if `lamparray_restore_state` fails.
- [Medium] Lamp Range Update reports are defined as Output reports in the H=
ID specification, but the driver only searches Feature reports.
- [Medium] Incorrect teardown ordering in `lamparray_unregister` allows con=
current hardware writes in autonomous mode.
- [Low] The driver prints a success log message during initialization, whic=
h explicitly violates the subsystem's logging rules.
--

commit f90eeb3c7fb481eba03a666b2a5bcb8dd92f3e9c
Author: Aaron Erhardt <aer@tuxedocomputers.com>
Subject: HID: lamparray: add new LampArray helper module

This commit adds a new hid-lamparray helper module for devices exposing a
Lighting/LampArray application collection (usage page 0x59). It registers a
single-zone RGB LED representation via the LED subsystem.

> diff --git a/drivers/hid/hid-lamparray.c b/drivers/hid/hid-lamparray.c
> new file mode 100644
> index 0000000000000..9a438aa2d305e
> --- /dev/null
> +++ b/drivers/hid/hid-lamparray.c

[ ... ]

> @@ -176,14 +176,12 @@ static int lamparray_parse_update_report(struct lam=
parray_device *ldev)
>  	int i, j;
>  	int ret =3D 0;
> =20
>  	mutex_lock(&ldev->dev_lock);
> =20
>  	re =3D &hdev->report_enum[HID_FEATURE_REPORT];
> =20
>  	list_for_each_entry(report, &re->report_list, list) {
>  		for (i =3D 0; i < report->maxfield; i++) {

[Severity: Medium]
This restricts the search strictly to feature reports.

Since the HID specification defines Lamp Range Update reports as output
reports, does this mean the driver will fail to probe compliant devices
because it cannot find their output reports?

[ ... ]

> @@ -340,11 +340,9 @@ static int lamparray_hw_set_state(struct lamparray_d=
evice *ldev, u8 r, u8 g,
>  	set_field_value(&ldev->color_update.red, r);
>  	set_field_value(&ldev->color_update.green, g);
>  	set_field_value(&ldev->color_update.blue, b);
>  	set_field_value(&ldev->color_update.intensity, intensity);
> =20
>  	report =3D ldev->color_update.red.field->report;
>  	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
>  	hid_hw_wait(hdev);

[Severity: Medium]
This hardware request is dispatched exclusively for the report containing
the 'red' field.

If a device descriptor splits the color channels across multiple report IDs,
wouldn't this leave the other colors unsent and result in incomplete state
updates?

[ ... ]

> @@ -386,10 +386,9 @@ static int lamparray_get_lamp_attributes(struct lamp=
array_device *ldev)
>  	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
>  	hid_hw_wait(hdev);
> =20
>  	ldev->max_r =3D get_field_value_as_u8(&ldev->color_levels.red);
>  	ldev->max_g =3D get_field_value_as_u8(&ldev->color_levels.green);
>  	ldev->max_b =3D get_field_value_as_u8(&ldev->color_levels.blue);
>  	ldev->max_brightness =3D get_field_value_as_u8(&ldev->color_levels.inte=
nsity);

[Severity: High]
This reads the maximum brightness directly from the device's GET_REPORT
response without validating it against zero.

Later, when led_mc_calc_color_components() is called to apply the brightnes=
s,
this max_brightness value acts as a divisor. If a device reports zero
intensity levels, does this trigger a kernel panic due to division by zero?

[ ... ]

> @@ -497,10 +497,8 @@ static int lamparray_register_led(struct lamparray_d=
evice *ldev)
>  		if (ldev->lamparray_kind_value =3D=3D HID_LAMPARRAY_KIND_KEYBOARD)
>  			function =3D LED_FUNCTION_KBD_BACKLIGHT;
> =20
>  		cdev->name =3D kasprintf(GFP_KERNEL, "rgb:%s", function);
>  		if (!cdev->name) {
>  			mutex_unlock(&ldev->sysfs_lock);
>  			return -ENOMEM;
>  		}

[Severity: Medium]
This hardcodes the LED name based solely on the function.

If multiple identical LampArray devices are connected, won't this cause a
deterministic sysfs naming collision (-EEXIST) that prevents the second
device's LED interface from registering?

[ ... ]

> @@ -608,13 +608,10 @@ static ssize_t use_leds_uapi_store(struct device *d=
ev,
> =20
>  	if (val =3D=3D old_val) {
>  		mutex_unlock(&ldev->dev_lock);
>  		return count;
>  	}
> =20
>  	ldev->use_leds_uapi =3D val;
>  	mutex_unlock(&ldev->dev_lock);
> =20
>  	if (val =3D=3D 1) {
>  		ret =3D lamparray_register_led(ldev);

[Severity: Medium]
The protective dev_lock is dropped here before executing the actual
registration side effects.

Does this leave a race window where concurrent sysfs writes could cause the
internal use_leds_uapi state to completely desynchronize from the actual LED
registration state?

[ ... ]

> @@ -706,10 +706,8 @@ struct lamparray *
>  	ldev->use_leds_uapi =3D true;
>  	ldev->led_registered =3D false;
> =20
>  	/* Make sure the driver lock gets released for probing. */
>  	hid_device_io_start(hdev);

[Severity: High]
Calling hid_device_io_start() here forcibly releases the HID core's
driver_input_lock during the probe sequence.

Could this allow incoming hardware interrupt events to race with the
unfinished probe() initialization of the parent driver, potentially leading
to uninitialized memory accesses or a use-after-free?

[ ... ]

> @@ -772,16 +772,13 @@ struct lamparray *
>  	ret =3D lamparray_hw_set_autonomous(ldev, false);
>  	if (ret) {
>  		hid_err(hdev, "Could not disable autonomous mode: %d", ret);
>  		goto err_remove_sysfs;
>  	}
> =20
>  	hid_info(hdev, "LampArray device registered\n");

[Severity: Low]
This prints a success log message during normal device initialization.
Should this be removed to comply with the subsystem's logging rules against
printing success messages?

> =20
>  	ret =3D lamparray_restore_state(ldev);
>  	if (ret) {
>  		hid_err(hdev, "Failed to set default state: %d", ret);
>  		goto err_remove_sysfs;
>  	}

[Severity: Medium]
If lamparray_restore_state() fails, this error path routes to
err_remove_sysfs. However, this bypasses restoring the hardware back to
autonomous mode via lamparray_hw_set_autonomous().

Does this leave the hardware in a frozen, non-autonomous state if the
initial state restoration times out or fails?

[ ... ]

> @@ -794,11 +794,9 @@ void lamparray_unregister(struct lamparray *la)
>  	if (!la)
>  		return;
> =20
>  	ldev =3D &la->ldev;
> =20
>  	lamparray_hw_set_autonomous(ldev, true);
> =20
>  	lamparray_remove_sysfs(ldev);
>  	xa_erase(&lamparray_by_hdev, (unsigned long)ldev->hdev);
>  	lamparray_unregister_led(ldev);

[Severity: Medium]
This sets the hardware to autonomous mode before unregistering the userspace
interfaces (the LED class device and sysfs attributes).

Could userspace write to the sysfs brightness attribute simultaneously while
the driver is being unbound, sending manual LED commands while the hardware
is configured to operate autonomously?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903073602.3815=
258-1-aer@tuxedocomputers.com?part=3D1
