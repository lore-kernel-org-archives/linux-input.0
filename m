Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAFB3AE19B
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 05:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778821273; cv=none; b=WbnZyVsJ9Vjk/QcPAnsX4RSdiyZ7eWurEw/paFHz0ddOTJtmG8gnwuTKAQ2PlSfmpt8poPVQ5IFLcT1vTt964RzmtR7U7HuJSv4SfDcmiNxNngngf+CYtws/+TdNZbxA9NrkEuibb3Znx+YJZ6pslGkTITVOtyJooGjZmgxu9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778821273; c=relaxed/simple;
	bh=6iZJauTgragY3M0DKfgQfjyY3uNFoDP2De+5QMImUo4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R3ZDD31cXYqn0SImkhOfcwmtlwIbkPh6X+LClBI0uQYS2bvPd5Zg5UHLj9jLatbX3IuHNQL2Ya8EFlItHGuJ3cYNLKlgF/V/PiHNANGmXhpVw8GhjTIAHB/6IJLIbPc7EOwnWB2DDrB07Mm67dsJiTtmgOWBvJMUv8UYfGZIAto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlXOOU8T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlXOOU8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 889ADC2BCB0;
	Fri, 15 May 2026 05:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778821272;
	bh=6iZJauTgragY3M0DKfgQfjyY3uNFoDP2De+5QMImUo4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=KlXOOU8TX1s6SUU+XwyyTtbI0jbwaWjoiqz3QSumAmquqvrlCdkwQ2TXY1uDBzQCE
	 SsjJ9JU7jGdDeE8MhHgeTQjnZqCaxaK7AQP5es18JLZGaKImQlX5cfE6u9lGqGi3nn
	 lZgm/d0poriL8Pyxk81V9N/YGcz5I/cskQRoKxpT28nbeROUsJ2UGYjBI+ewHjFi5v
	 vvm5Z8gvYQfTlP7bMV56/lNE/IuZivU+ISgJm2/6Ym1PfeR8Sizrv6NjAebhapiLMy
	 gXMeH/dEP9wrlVPg2yaVUKEPqNAoAvu+EsxH/rP5uRJf79f9+AAZTImXMRqUxGgTWV
	 wX10kjW0jgM8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] HID: hid-msi: Add RGB control interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260515033622.2095277-4-derekjohn.clark@gmail.com>
References: <20260515033622.2095277-4-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 05:01:11 +0000
Message-Id: <20260515050112.889ADC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Out-of-bounds write in `claw_profile_event` due to an off-by-one b=
ounds check on `frame_calc`.
- [High] Sleeping in atomic context due to `mutex` acquisition in the HID `=
raw_event` callback.
- [High] Use-After-Free and data race due to devm LED unregistration happen=
ing after `rgb_queue` is cancelled.
- [High] Teardown order race condition causes leaked sysfs attributes and U=
se-After-Free.
--

commit 56238f43183718f9b78311c16ef55fefd8acc6e2
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-msi: Add RGB control interface

This commit adds an RGB control interface for MSI Claw devices, managing
up to 8 sequential frames of RGB zone data. It mirrors Windows effects
and adds sysfs/LED class interfaces for configuration.

> diff --git a/drivers/hid/hid-msi.c b/drivers/hid/hid-msi.c
> index 6ccb9666daedf..06dc4290d2bb5 100644
> --- a/drivers/hid/hid-msi.c
> +++ b/drivers/hid/hid-msi.c
[ ... ]
> @@ -308,15 +369,46 @@ static int claw_profile_event(struct claw_drvdata *=
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
> +		if (frame_calc > CLAW_RGB_MAX_FRAMES) {

Can this result in an out-of-bounds write?

Since CLAW_RGB_MAX_FRAMES is 8 and the rgb_frames array is sized to 8, a
frame_calc value of 8 would pass this check but write past the end of the
array.

Should this check be >=3D instead?

> +			dev_err(drvdata->led_mc.led_cdev.dev, "Got unsupported frame index: %=
x\n",
> +				frame_calc);
> +			ret =3D -EINVAL;
> +			goto err_pending;
> +		}
> +		f_idx =3D frame_calc;
> +
> +		scoped_guard(mutex, &drvdata->frame_mutex) {

Could this mutex acquisition cause a sleep-in-atomic bug?

This function is called synchronously from claw_raw_event(), which is the
HID raw_event callback and typically runs in atomic context (softirq or
hardirq).

Should this use a spinlock or defer the work to a workqueue instead?

> +			memcpy(&drvdata->rgb_frames[f_idx], &frame->zone_data,
> +			       sizeof(struct rgb_frame));
> +
[ ... ]
> @@ -839,12 +1355,28 @@ static int claw_probe(struct hid_device *hdev, u8 =
ep)
[ ... ]
> +	INIT_DELAYED_WORK(&drvdata->rgb_queue, &claw_rgb_queue_fn);
> +
> +	ret =3D devm_led_classdev_multicolor_register(&hdev->dev, &drvdata->led=
_mc);
> +	if (ret)
> +		return ret;
[ ... ]
> @@ -906,7 +1438,11 @@ static void claw_remove(struct hid_device *hdev)
>  		return;
>  	}
> =20
> +	/* Block writes to brightness/multi_intensity during teardown */
> +	drvdata->led_mc.led_cdev.brightness_set =3D NULL;
> +	device_remove_group(drvdata->led_mc.led_cdev.dev, &claw_rgb_attr_group);
>  	device_remove_group(&hdev->dev, &claw_gamepad_attr_group);
> +	cancel_delayed_work_sync(&drvdata->rgb_queue);
>  	cancel_delayed_work_sync(&drvdata->cfg_setup);

Does the order here create a race condition with the delayed work?

If cfg_setup executes concurrently, it might call device_add_group()
immediately after device_remove_group() finishes. By the time
cancel_delayed_work_sync() runs, the setup might have already re-added
the sysfs attributes.

Would it be safer to cancel the delayed work before removing the sysfs
groups?

Additionally, because the LED class device is registered via devm in the
probe function, it won't be unregistered until after claw_remove() returns.

Since brightness_set is checked by the LED core without locks, could a
concurrent write to the brightness sysfs attribute slip past the NULL
check and rearm rgb_queue after it has been cancelled?

When devres later frees drvdata, could this rearmed delayed work cause
a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515033622.2095=
277-1-derekjohn.clark@gmail.com?part=3D3
