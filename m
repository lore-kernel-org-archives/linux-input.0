Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967F32AADC
	for <linux-input@vger.kernel.org>; Mon, 11 May 2026 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778534550; cv=none; b=kX+Qm9bPfnZzt3G6eorgjNZ5f/qTDmOYafVKFYeWicAtNS0hWl8FUv/KXvywkdg4ynK0sKmB3bi3hEgn7CvJyt+/t+GUhmoA8Ya+PwG7WMDqIS61J9y9B9YI41uelQWO/BghpQOjImQ1BlIRal0hu2rwNEAO8/TYkTRVxXHeE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778534550; c=relaxed/simple;
	bh=c2T4+7se8GQ0dOHl4xZ6SQxG/SRZon5xN4pyA3kVHWU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NoznQTJW4tHDp8e4j/pNJbVyoICA+86GnuJoh1jADkcKcN0mfVoqab5sdL9ETsG23qXdLeP3FlRGXZBewu80qHCv1uZ3KnWrQUM7z1/j5Bxt1g65ZyXy0LbzjmnurCZTSV5yvPxeEEL7gwW+owXbX3XIPYAwFB2IDH7F78H2Cuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cUmcMdII; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUmcMdII"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21800C2BCB0;
	Mon, 11 May 2026 21:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778534550;
	bh=c2T4+7se8GQ0dOHl4xZ6SQxG/SRZon5xN4pyA3kVHWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cUmcMdII+JEJVg9HZdpEWn/uyjxlCw8yg2dOVBoggZK1TYv/PV1EjgLCpU2J5xEXG
	 PPD1reNh/SSw9n7vG7ZKoCo5HndJNTqT2/3oM+j8D+tIOYoSUIPU7G5ZUQ6vS3jKAD
	 6vSFkhIPNtDIHzkZzj2+0DXMgm+KsYJUGSoIy+inW2xazZLx9rUcZdvptvMYVyaOzL
	 CjMoyt6gDEYG8W8gtnFu9YbzLszD/87q8rdmzMJgZoHlM7/RkxO93IdDzfmLQQKTK/
	 FnXyWaM73hkJ+WKbVfEfVvs2s0nGmlwdUmSlzhLjbH79cwnMXe4PA8YmsoD19JK1Xu
	 Q4Qra1tP5YEmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] HID: hid-msi-claw: Add RGB control interface
Reply-To: sashiko@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260510043510.442807-4-derekjohn.clark@gmail.com>
References: <20260510043510.442807-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 May 2026 21:22:29 +0000
Message-Id: <20260511212230.21800C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] `speed_show()` incorrectly casts the LED class device pointer to a=
 `hid_device`, leading to an out-of-bounds memory read and kernel crash.
- [High] Deadlock and missing return in `cfg_setup_fn` when handling initia=
lization errors.
- [High] Sysfs attributes re-arm the cancelled delayed work after device te=
ardown, leading to a Use-After-Free.
- [High] Racy nullification of `brightness_set` causes a TOCTOU NULL pointe=
r dereference.
- [Medium] Communication failure in `claw_read_rgb_config` leaves the profi=
le parser in a corrupted state.
--

commit 9663adbabcba6be0b443e7073133d650a790c871
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi-claw: Add RGB control interface
   =20
Adds RGB control interface for MSI Claw devices with 9 total zones and
supports up to 8 sequential frames of RGB zone data.

> diff --git a/drivers/hid/hid-msi-claw.c b/drivers/hid/hid-msi-claw.c
> index 60694d075d56f..f4fe74a784c29 100644
> --- a/drivers/hid/hid-msi-claw.c
> +++ b/drivers/hid/hid-msi-claw.c

[ ... ]

> @@ -743,6 +836,389 @@ static const struct attribute_group claw_gamepad_at=
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
> +	for (i =3D 0; i < 8; i++) {
> +		drvdata->profile_pending =3D CLAW_RGB_PENDING;
> +		data[1] =3D (read_addr >> 8) & 0xff;
> +		data[2] =3D read_addr & 0x00ff;
> +		ret =3D mcu_property_out(hdev, CLAW_COMMAND_TYPE_READ_PROFILE, data, l=
en, 8);
> +		if (ret)
> +			return ret;

If mcu_property_out() fails here, does drvdata->profile_pending remain set
to CLAW_RGB_PENDING? If a subsequent unrelated profile event or stray ACK
arrives, could claw_profile_event() incorrectly parse its payload as an RGB
frame?

[ ... ]

> +static ssize_t speed_show(struct device *dev, struct device_attribute *a=
ttr,
> +			  char *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);

Since the rgb_attr_group attributes are attached to the LED class device
rather than the HID device, does to_hid_device(dev) result in an invalid
pointer dereference here? Other sysfs functions in this patch seem to
correctly use dev_get_drvdata(dev) to retrieve the led_classdev.

[ ... ]

> @@ -758,6 +1234,13 @@ static void cfg_setup_fn(struct work_struct *work)
>  		claw_remove(drvdata->hdev);
>  	}
> =20
> +	ret =3D claw_read_rgb_config(drvdata->hdev);
> +	if (ret) {
> +		dev_err(drvdata->led_mc.led_cdev.dev,
> +			"Failed to setup device, can't read RGB config: %d\n", ret);
> +		claw_remove(drvdata->hdev);
> +	}

If claw_remove() is called from within the cfg_setup worker thread, and
claw_remove() calls cancel_delayed_work_sync(&drvdata->cfg_setup), won't
this deadlock waiting for itself to complete?

Also, since there is no return statement after claw_remove() is called in
these error blocks, will this proceed to execute the rest of the function on
a stopped device?

[ ... ]

> @@ -881,6 +1405,9 @@ static void claw_remove(struct hid_device *hdev)
> =20
>  	if (drvdata->endpoint =3D=3D CLAW_XINPUT_CFG_INTF_IN ||
>  	    drvdata->endpoint =3D=3D CLAW_DINPUT_CFG_INTF_IN) {
> +		/* Block writes to brightness/multi_intensity during teardown */
> +		drvdata->led_mc.led_cdev.brightness_set =3D NULL;

Is it safe to dynamically nullify the brightness_set callback here? If a
concurrent brightness update in the LED core checks the pointer, sees it as
valid, and then this nullification happens before the actual function call,
could it result in a NULL pointer dereference?

> +		cancel_delayed_work_sync(&drvdata->rgb_queue);

Since the LED class device is registered with devres
(devm_led_classdev_multicolor_register), the sysfs attributes like effect,
speed, and enabled remain accessible until after claw_remove() completes.

If userspace writes to any of those attributes in this window, could
mod_delayed_work() re-arm rgb_queue, leading to a use-after-free when
drvdata is subsequently freed?

>  		sysfs_remove_group(&hdev->dev.kobj, &claw_gamepad_attr_group);
>  		cancel_delayed_work_sync(&drvdata->cfg_setup);
>  		cancel_delayed_work_sync(&drvdata->cfg_resume);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260510043510.4428=
07-1-derekjohn.clark@gmail.com?part=3D3
