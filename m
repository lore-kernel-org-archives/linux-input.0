Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F209389455
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784518234; cv=none; b=FYaNevgkPXhBQO1G01xMuyvRFKeOH1d5bUtie8ti5pkYlUb7ug0w/ySm3t+hFPFsgQc1qjbfixlaSUQ3Fn3BTO2yD7+Haazwpk1SKbknyCUqCtvV7UAuf6QnQJI812L31xNYN5OtDBWMczgsyCQqMWS2PTYXOA27zFz1Ne97ZtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784518234; c=relaxed/simple;
	bh=F0Zq1IFMOAzem8lG+zszMt/ey+RaseXQGO5Yj3En4h8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PW8i4Kpgfg6jdErrDGw5gHflpJ+qos2U1riOjQ/RoszepgcAtEKSNRWNelZNyiFOaeRgJyvbPulmJbhDj3OyXNOrp5gaFQ5xk5OX3e13mgGr8VK6vEJIC9oSN2q0L2wG8OXiStqkbZv6PNjbqzq4UKE45YXZ5iGUlZO/XfvL3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvQhB5Eu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvQhB5Eu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0771F000E9;
	Mon, 20 Jul 2026 03:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784518232;
	bh=KGq5JGVYOm/UTb5S4Vrf3K0j9TJIdhDtjHC5EAt7zYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NvQhB5Eus5Z7upZ4OUhYR9VCGPaVB0uDMaPdPWOlfiZGoKctHA0xuYkym5e6wqdXz
	 S1d8TJh7G+JNhs3vG7aPHOPA+07ouHqVkf5uf9FruOknw+EgHI7T/ezajcXM8P8D2A
	 Xl/Vsk0ACP6GDiNzzNDs/xb7jZwPb3UIJp2vZ9rKvpNpY4gstJhZ0iim4fo3V5w1BQ
	 Ax3FTzPYkcPARGrgbVFSrnbaIQ1iF0Vi0yQ4JaV0sh+w6B1MzKjJtGRrBHZuHGzIi3
	 v6iP5mbVSYh6EBti5/6PTrpbRSR61kdEq6vMboXgJXBdsFbbMrajlzrjQ41uheRaF0
	 ysIwvY4CLOgRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 3/4] HID: hid-msi: Add RGB control interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260720031549.2272658-4-derekjohn.clark@gmail.com>
References: <20260720031549.2272658-1-derekjohn.clark@gmail.com>
 <20260720031549.2272658-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 03:30:32 +0000
Message-Id: <20260720033032.BB0771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Data races and locking mismatches when accessing RGB configurati=
on variables and LED core state.

Pre-existing issues:
- [High] Use-after-free on device teardown due to missing cancellation of d=
elayed works.
--

--- Patch [3]: [PATCH v13 3/4] HID: hid-msi: Add RGB control interface ---
commit d67de53a026c42fe9260a66fca23392240a52c26
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add RGB control interface

This commit adds an RGB control interface for MSI Claw devices. It provides
support for configuring up to 9 LED zones via an MCU memory interface and
sets up the corresponding sysfs attributes and LED class device.

Link: https://patch.msgid.link/20260529072111.7565-4-derekjohn.clark@gmail.=
com

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 023d63cee6b06..5cb85fc2f0534 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c

[ ... ]

> @@ -349,6 +410,38 @@ static int claw_profile_event(struct claw_drvdata *d=
rvdata, struct claw_command_
>  		for (i =3D 0; i < CLAW_KEYS_MAX; i++)
>  			codes[i] =3D (mkeys->codes[i]);
>  		break;
> +	case CLAW_RGB_PENDING:
> +		frame =3D (struct claw_rgb_report *)cmd_rep->data;

[ ... ]

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
> +			drvdata->led_mc.subled_info[0].intensity =3D frame->zone_data.zone[0]=
.red;
> +			drvdata->led_mc.subled_info[1].intensity =3D frame->zone_data.zone[0]=
.green;
> +			drvdata->led_mc.subled_info[2].intensity =3D frame->zone_data.zone[0]=
.blue;
> +		}
> +
> +		break;

[Severity: Medium]
Is there a locking mismatch for rgb_speed? Here in claw_profile_event(),
rgb_speed is updated while holding frame_lock. However, in speed_store(),
it is updated while holding profile_lock.

Also, does this direct modification of the LED class device internal state
need synchronization? Updating brightness and subled_info[x].intensity here
is done without holding the standard led_access lock used by the LED core,
which could cause data races with concurrent sysfs accesses.

[ ... ]

> +/* Send RGB configuration to device */
> +static int claw_write_rgb_state(struct claw_drvdata *drvdata)
> +{
> +	struct claw_rgb_report report =3D { {0x01, 0}, CLAW_RGB_FRAME_OFFSET, 0=
x00,
> +			drvdata->rgb_frame_count, 0x09, drvdata->rgb_speed,
> +			drvdata->led_mc.led_cdev.brightness };

[Severity: Medium]
Does claw_write_rgb_state() need to hold a lock when reading rgb_speed?
It appears to be read locklessly here, but is updated with a lock elsewhere.
This also applies to other variables like rgb_effect and rgb_enabled read
locklessly in claw_apply_rgb_state() and sysfs show functions.

[ ... ]

> +static ssize_t speed_store(struct device *dev, struct device_attribute *=
attr,
> +			   const char *buf, size_t count)
> +{

[ ... ]

> +	/* 0 is fastest, invert value for intuitive userspace speed */
> +	speed =3D 20 - val;
> +
> +	scoped_guard(spinlock_irqsave, &drvdata->profile_lock)
> +		drvdata->rgb_speed =3D speed;
> +
> +	mod_delayed_work(system_wq, &drvdata->rgb_queue, msecs_to_jiffies(50));
> +
> +	return count;
> +}

[Severity: Medium]
This is where rgb_speed is written using profile_lock instead of the
frame_lock used in claw_profile_event().

[ ... ]

> @@ -1088,6 +1727,7 @@ static void claw_remove(struct hid_device *hdev)
>  {
>  	struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
>  	bool gp_registered;
> +	bool rgb_registered;
> =20
>  	if (!drvdata)
>  		return;

[ ... ]

>  	if (gp_registered)
>  		device_remove_group(&hdev->dev, &claw_gamepad_attr_group);
> =20
> +	if (rgb_registered) {
> +		device_remove_group(drvdata->led_mc.led_cdev.dev, &claw_rgb_attr_group=
);
> +		led_classdev_multicolor_unregister(&drvdata->led_mc);
> +	}
> +	cancel_delayed_work_sync(&drvdata->rgb_queue);
> +
>  	hid_hw_close(hdev);
>  }

[Severity: High]
This is a pre-existing issue, but does this teardown path leak delayed work=
s?
The driver initializes the cfg_setup and cfg_resume delayed works during
probe, but they don't appear to be cancelled here in claw_remove().

If the device is removed while either of those works is pending, could they
execute after the devres-allocated drvdata is freed, causing a
use-after-free crash?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720031549.2272=
658-1-derekjohn.clark@gmail.com?part=3D3
