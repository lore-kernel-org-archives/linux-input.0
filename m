Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9B826D4CA
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 12:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763218; cv=none; b=Qm2o8yp5vS/9rq78roblKY6ByAlislw35MFnUEPVvSWwsW81+dywa2SWp3M5PN6G9RFW8RusxP7nfB+WxrK8EQ67Mg3qoXaJp03b6JxUk7knbf4tg/PAkdvp4uPMT06mUB5C8p58F1VU2maPjwNsXKNajoUrysFxRgvMnta5Ko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763218; c=relaxed/simple;
	bh=9LKu0jLHhv0h0ed7bmOmCeIYGtOuw/sIKpI9/9SNswU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CBQm6GXIHO2clPYN4i1ww68G2c38FOFzzDgbS1vT4AKFBItiyojvNEjCtlVxrbKaR/z7aUdJMEAYlDUYQKc/oWGlmei9RL3SOP4afxJb2LOJloXfp8ukRDUQ/HpZBKTWSVaeyxPkcsqb3BSKrp9P+6QCGBAfUzIfb7LdJt4/BmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAY/L+gK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAY/L+gK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950E8C2BCB3;
	Thu, 14 May 2026 12:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778763217;
	bh=9LKu0jLHhv0h0ed7bmOmCeIYGtOuw/sIKpI9/9SNswU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=nAY/L+gKJNvGGUJjSJQb7YMJA42ZsLLp5ab6v1b+gNlVQovaFGWYdaZXhd8EvPfsO
	 WRCmDq2iXOphaujtnkn3zMwxBurzn38pHuSvJQiZ+9KeYgxD3g9aIHiDiF0aqGDor1
	 DDepKFTEzpEjx/CIb3MtpjdFX2T1aYuCWdn1IbqbcX2S6e7gkZ8E5mLcurLKBv4BLM
	 KuylYFQeHehQnUARgubzIYjXJyyrnbEqUSpBYLTOcYu0WzwURafCyNyz9cjrGN+6jc
	 Q/BMLk14J/f1/dhtlOEUBD+RfXOwmNVsTz9h5rN7PwebPYWy16B5e2gC14E4OUJPWh
	 SSdLg5v2bR68g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] HID: hid-msi: Add RGB control interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260513231445.3213501-4-derekjohn.clark@gmail.com>
References: <20260513231445.3213501-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 12:53:37 +0000
Message-Id: <20260514125337.950E8C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] The `speed_show` function incorrectly casts the LED class devi=
ce to a HID device, resulting in an invalid pointer dereference and a guara=
nteed kernel panic.
- [Critical] Missing bounds check on `frame->frame_count` from the USB devi=
ce leads to an out-of-bounds read of kernel memory.
- [High] Re-arming `rgb_queue` from sysfs attributes after it has been expl=
icitly cancelled in `claw_remove` leads to a Use-After-Free.
- [High] The `guard(mutex)` macro in `claw_hw_output_report()` is incorrect=
ly used inside a block scope, providing absolutely no synchronization.
- [High] Concurrent modification of shared RGB state without lock protectio=
n causes data races and memory corruption.
- [High] Every RGB state change triggers a `SYNC_TO_ROM` command, causing s=
evere flash memory degradation.
- [Medium] An early return in `cfg_setup_fn` silently drops core gamepad sy=
sfs attributes if RGB initialization fails.
--

commit a90ff4a0f03b6df7827bfbcd222f977138b9d280
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add RGB control interface

Adds RGB control interface for MSI Claw devices. The MSI Claw uses a
fairly unique RGB interface. It has 9 total zones (4 per joystick ring
and 1 for the ABXY buttons), and supports up to 8 sequential frames of
RGB zone data.

> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -308,15 +368,52 @@ static int claw_profile_event(struct claw_drvdata *=
drvdata, struct claw_command_
>  		for (i =3D 0; i < CLAW_KEYS_MAX; i++)
>  			codes[i] =3D (cmd_rep->data[6 + i] !=3D 0xff) ? cmd_rep->data[6 + i] =
: 0x00;
>  		break;
> +	case CLAW_RGB_PENDING:
> +		frame =3D (struct rgb_report *)cmd_rep->data;
> +		rgb_addr =3D drvdata->rgb_addr;
> +		read_addr =3D be16_to_cpu(frame->read_addr);
> +		frame_calc =3D (read_addr - rgb_addr) / CLAW_RGB_FRAME_OFFSET;
> +		if (frame_calc > U8_MAX) {
> +			dev_err(drvdata->led_mc.led_cdev.dev, "Got unsupported frame index: %=
x\n",
> +				frame_calc);
> +			ret =3D -EINVAL;
> +			goto err_pending;
> +		}
> +		f_idx =3D frame_calc;
> +
> +		if (f_idx >=3D CLAW_RGB_MAX_FRAMES) {
> +			dev_err(drvdata->led_mc.led_cdev.dev, "Got illegal frame index: %x\n",
> +				f_idx);
> +			ret =3D -EINVAL;
> +			goto err_pending;
> +		}
> +
> +		/* Always treat the first frame as the truth for these constants */
> +		if (f_idx =3D=3D 0) {
> +			drvdata->rgb_frame_count =3D frame->frame_count;

drvdata->rgb_frame_count is assigned directly from the hardware packet.
Should there be a bounds check here to ensure it is less than or equal to
CLAW_RGB_MAX_FRAMES?

Later, claw_write_rgb_state() uses drvdata->rgb_frame_count as the upper
bound for a loop reading from drvdata->rgb_frames. If a device sends a
frame count greater than 8, could this read out-of-bounds kernel memory
and send it back to the USB device?

> +			/* Invert device speed (20-0) to sysfs speed (0-20) */
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
> +		memcpy(&drvdata->rgb_frames[f_idx], &frame->zone_data,
> +		       sizeof(struct rgb_frame));

claw_profile_event() modifies drvdata->rgb_frames and
drvdata->rgb_frame_count from the HID raw event handler context.
Simultaneously, claw_rgb_queue_fn() runs in a workqueue and calls
functions that overwrite these exact same fields.

Since there are no locks protecting these updates, could a background
worker read torn state or corrupt the frame arrays while they are being
actively updated by the asynchronous device response?

[ ... ]

> @@ -759,6 +856,397 @@ static const struct attribute_group claw_gamepad_at=
tr_group =3D {
>  	.is_visible =3D claw_gamepad_attr_is_visible,
>  };
> =20
> +/* Read RGB config from device */
> +static int claw_read_rgb_config(struct hid_device *hdev)
> +{

[ ... ]

> +/* Send RGB configuration to device */
> +static int claw_write_rgb_state(struct claw_drvdata *drvdata)
> +{
> +	struct rgb_report report =3D { 0x01, 0x0000, CLAW_RGB_FRAME_OFFSET, 0x0=
0,
> +			drvdata->rgb_frame_count, 0x09, drvdata->rgb_speed,
> +			drvdata->led_mc.led_cdev.brightness };
> +	u16 write_addr =3D drvdata->rgb_addr;
> +	size_t len =3D sizeof(report);
> +	int f, ret;
> +
> +	if (!drvdata->rgb_addr)
> +		return -ENODEV;
> +
> +	if (!drvdata->rgb_frame_count)
> +		return -EINVAL;
> +
> +	guard(mutex)(&drvdata->rom_mutex);
> +	/* Loop through (up to) 8 pages of RGB data */
> +	for (f =3D 0; f < drvdata->rgb_frame_count; f++) {
> +		report.zone_data =3D drvdata->rgb_frames[f];
> +
> +		/* Set the MCU address to write the frame data to */
> +		report.read_addr =3D cpu_to_be16(write_addr);
> +
> +		/* Serialize the rgb_report and write it to MCU */
> +		ret =3D claw_hw_output_report(drvdata->hdev, CLAW_COMMAND_TYPE_WRITE_P=
ROFILE_DATA,
> +					    (u8 *)&report, len, 8);
> +		if (ret)
> +			return ret;
> +
> +		/* Increment the write addr by the offset for the next frame */
> +		write_addr +=3D CLAW_RGB_FRAME_OFFSET;
> +	}
> +
> +	ret =3D claw_hw_output_report(drvdata->hdev, CLAW_COMMAND_TYPE_SYNC_TO_=
ROM, NULL, 0, 8);

Does sending CLAW_COMMAND_TYPE_SYNC_TO_ROM on every RGB state change
cause excessive flash memory degradation?

Because claw_apply_rgb_state() is triggered by unthrottled sysfs writes
(such as rapidly changing a brightness slider), this might cause hundreds
of NVRAM writes per second and potentially degrade the MCU's flash
endurance.

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
> +	ret =3D sysfs_match_string(claw_rgb_effect_text, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	drvdata->rgb_effect =3D ret;
> +	mod_delayed_work(system_wq, &drvdata->rgb_queue, msecs_to_jiffies(50));
> +
> +	return count;
> +}

Is there a potential use-after-free here if sysfs attributes are written
after the device is removed?

In claw_remove(), the driver attempts to tear down the worker using
cancel_delayed_work_sync(&drvdata->rgb_queue). However, the sysfs files
and LED endpoints remain active because devm cleanup executes after
claw_remove() completes.

A concurrent write to a sysfs attribute like effect_store could call
mod_delayed_work() and re-arm the work item, causing it to execute after
drvdata has been freed.

[ ... ]

> +static ssize_t speed_show(struct device *dev, struct device_attribute *a=
ttr,
> +			  char *buf)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);

Is the dev parameter passed to speed_show actually a hid_device?

The rgb_attr_group sysfs group is attached to the LED class device
(led_cdev.dev), not the parent HID device. The macro to_hid_device(dev)
blindly performs a container_of cast, which will yield an invalid pointer
for hdev.

Dereferencing it with hid_get_drvdata(hdev) will likely cause a kernel
panic when this world-readable attribute is accessed.

[ ... ]

> @@ -772,6 +1260,13 @@ static void cfg_setup_fn(struct work_struct *work)
>  		return;
>  	}
> =20
> +	ret =3D claw_read_rgb_config(drvdata->hdev);
> +	if (ret) {
> +		dev_err(drvdata->led_mc.led_cdev.dev,
> +			"Failed to setup device, can't read RGB config: %d\n", ret);
> +		return;
> +	}
> +
>  	/* Add sysfs attributes after we get the device state */
>  	ret =3D devm_device_add_group(&drvdata->hdev->dev, &claw_gamepad_attr_g=
roup);

If claw_read_rgb_config() fails due to a temporary USB error or
unsupported firmware, this early return skips the subsequent
devm_device_add_group call.

Does this unintentionally break the device's core gamepad configuration
interface simply because the RGB initialization failed?

This isn't a new bug introduced by this patch, but does the guard() in
claw_hw_output_report() provide any synchronization?

claw_hw_output_report() {
    if (timeout) {
        guard(mutex)(&drvdata->cfg_mutex);
        reinit_completion(&drvdata->send_cmd_complete);
    }
    ...
}

Because the guard is declared inside the block, the mutex is immediately
released at the closing brace before hid_hw_output_report() and
wait_for_completion_interruptible_timeout() are ever called. This seems
to leave the I/O operations unprotected against concurrent threads, which
this patch introduces via the new RGB workers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513231445.3213=
501-1-derekjohn.clark@gmail.com?part=3D3
