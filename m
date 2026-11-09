Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218446;
	b=gP9u287eNGGlJFXgbZks193fTALaZ0XC9YXFfTJSLPPPc2JEuxNwWEfkq2nKm/s+n1kq
	 xF9/dPKGsTMtzoZxHDjaUW59X/GA/l+moHhNo6JafAZvQ8fh7oshWv59LP8lIXcJRnVVq
	 BBB6B6bgLduU0b0iHUYYeO05XQiOn8klTwypGdbKLGKvPn4Dx13lxcvqKDyCQwkxvm5ZE
	 vTa/yl4W7tDBDecCKaBmlWpg+goLMCo+OPPE1hlz1XZaADf1isjYh7Dg82KmjB+qiaO7w
	 +iOm6nYtM/RGPqurl/KShxrUJFkrVyMuZFvCEHnMUivEqEXRVlf1zBA0/vm3bLYCe0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218446;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BjnvFkZVTH7Crj3D12oBCZDLjA5oYujllBgl7pOTuIk=;
	b=Qzpa5mlcOC0TnQbAdALNeIplS7LAPH1q3dGHAayWqZcUbw6+CNcLZMo8Es4iR2zEt0aA
	 JbDd+Rc0RDrv21cH1Qgn0VI4ee5If4lEgHgiP7NlS9AqqKkAAqrU5x4wy/V5zvDBSksPW
	 MHaQBQGY6EwlSYEWnLp8JfkMw2tVy39QxhhOjpQfDqOzoZHJIbRfxDdrDjy4/gZkloUSg
	 i/KUaeJxNGN+FLIUMPsuN88mNap01e2AGmPCtlyMKi/t3dxem2cCm9s1Qau301uNkJ+5/
	 7M11DJBE3XYCUTsv2XG+XgKEaXtaKMGXnAShx8IQX9FbN66M++RJPSS4fmS+q6TdR2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=caPNEnjt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794EF606A321
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 10:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=caPNEnjt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8161F0089F;
	Mon,  9 Nov 2026 10:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794218446;
	bh=BjnvFkZVTH7Crj3D12oBCZDLjA5oYujllBgl7pOTuIk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=caPNEnjtIujRFyOYhXVJWRLHEuZP1w+whOx0mrRuxtUi/WvYUsHVaaLtHKOPW/6Lj
	 gzqhicYQotoB/aWtNXnLZEcy/lIpVFgd27s5Swk3oIzWUFDWgcaTZtKvsXbtfPFTSS
	 bFDDrddNtzdADuCaOnsTBQyeg+atl1vM7rB0JiAgJ6Pfi3AjAgV+roiInybUIuWgEX
	 XOZdF+nUcfIN1CMJMT0sbGRxEzME+SJ+IUYiNHyZopOQeYGP+yMkV3x0+b3zT9AHRA
	 ReCWHAC5E3j1+tDJS9m9uc8de2ZQlF4Qev9XliwCQecJcK8Pf4Ql3a3Cqob1G+dyZN
	 Qs4D41sykKUIw==
Message-ID: <sashiko-outbox-204775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] HID: lg-g15: add LCD contrast LED
Reply-To: sashiko-reviews@lists.linux.dev
To: "Torstein Eide" <torsteine+linux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261109094426.1432465-2-torsteine+linux@gmail.com>
References: <20261109094426.1432465-1-torsteine+linux@gmail.com>
 <20261109094426.1432465-2-torsteine+linux@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 10:00:45 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] HID: lg-g15: out-of-bounds read in lg_g15_contrast_set() on
  unclamped brightness
- [Low] HID: lg-g15: unlocked read of contrast brightness in
  lg_g15_resume()
--

commit 8cb726418b3437c4e73ef257cf7f4986794e4a67
Author: Torstein Eide <torsteine+linux@gmail.com>

HID: lg-g15: add LCD contrast LED

This commit adds an LED class device to control the LCD contrast on
Logitech G15 and G15 v2 keyboards and restores the configured contrast on
resume.

> diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
> index 02ef3e2094b4c..50abe6c58b10b 100644
> --- a/drivers/hid/hid-lg-g15.c
> +++ b/drivers/hid/hid-lg-g15.c

[ ... ]

> @@ -365,6 +375,57 @@ static int lg_g15_led_set(struct led_classdev *led_c=
dev,
>  	return ret;
>  }
> =20
> +/*
> + * LCD contrast, report 2 field 32: {2, 32, 129, value}, value in
> + * {18, 22, 26} for low/medium/high. Distinct sub-format from the
> + * brightness/macro fields (value sits in byte 3, not byte 2, and byte 2=
 is
> + * a fixed marker rather than the field selector) and has no GET_REPORT
> + * readback, so brightness_get just returns the last value we set.
> + */
> +static int lg_g15_contrast_set(struct led_classdev *led_cdev,
> +			       enum led_brightness brightness)
> +{
> +	struct lg_g15_led *g15_led =3D
> +		container_of(led_cdev, struct lg_g15_led, cdev);
> +	struct lg_g15_data *g15 =3D dev_get_drvdata(led_cdev->dev->parent);
> +	static const u8 contrast_values[] =3D { 18, 22, 26 };
> +	int ret;
> +
> +	if (led_cdev->flags & LED_UNREGISTERING)
> +		return 0;
> +
> +	mutex_lock(&g15->mutex);
> +
> +	g15->transfer_buf[0] =3D LG_G15_FEATURE_REPORT;
> +	g15->transfer_buf[1] =3D 32;
> +	g15->transfer_buf[2] =3D 129;
> +	g15->transfer_buf[3] =3D contrast_values[brightness];

[Severity: Medium]
Can this read past the end of contrast_values[] when brightness > 2?

When LED_SET_BRIGHTNESS or LED_BLINK_DISABLE is already set in
led_cdev->work_flags (for example, during back-to-back sysfs writes to
brightness), led_set_brightness() stores the unclamped brightness value in
led_cdev->delayed_set_value before led_set_brightness_nosleep() clamps it
to max_brightness:

drivers/leds/led-core.c:led_set_brightness() {
    ...
		if (test_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags) ||
		    test_bit(LED_BLINK_DISABLE, &led_cdev->work_flags)) {
			led_cdev->delayed_set_value =3D brightness;
			set_bit(LED_SET_BRIGHTNESS, &led_cdev->work_flags);
			queue_work(led_cdev->wq, &led_cdev->set_brightness_work);
			return;
		}
    ...
}

set_brightness_delayed() then passes delayed_set_value directly to
brightness_set_blocking() without clamping, so a value >=3D 3 indexes out of
bounds in contrast_values[], sends that byte in the feature report, and
caches the out-of-bounds index in g15_led->brightness.

[ ... ]

> @@ -1389,12 +1465,33 @@ static void lg_g15_remove(struct hid_device *hdev)
>  	hid_hw_stop(hdev);
>  }
> =20
> +/*
> + * The LCD does not retain its contrast across a USB reset or power loss;
> + * re-apply the last value userspace set, if any.
> + */
> +static int lg_g15_resume(struct hid_device *hdev)
> +{
> +	struct lg_g15_data *g15 =3D hid_get_drvdata(hdev);
> +	struct lg_g15_led *contrast;
> +
> +	if (!g15)
> +		return 0;
> +
> +	contrast =3D &g15->leds[LG_G15_LCD_CONTRAST];
> +	if (contrast->cdev.dev && g15->lcd_contrast_set)
> +		lg_g15_contrast_set(&contrast->cdev, contrast->brightness);

[Severity: Low]
Can reading contrast->brightness without g15->mutex overwrite a concurrent
contrast update?

CPU0                              CPU1 (kworker)
lg_g15_resume()
  val =3D contrast->brightness
                                  lg_g15_contrast_set(..., new_val)
                                    mutex_lock(&g15->mutex)
                                    hid_hw_raw_request(...)
                                    contrast->brightness =3D new_val
                                    mutex_unlock(&g15->mutex)
  lg_g15_contrast_set(..., val)
    mutex_lock(&g15->mutex)
    hid_hw_raw_request(...)
    contrast->brightness =3D val    <-- overwrites new_val
    mutex_unlock(&g15->mutex)

Because lg_g15_resume() reads contrast->brightness and
g15->lcd_contrast_set before lg_g15_contrast_set() acquires g15->mutex, a
concurrent update on leds_wq can complete in between and then be clobbered
by the stale value on both the hardware and contrast->brightness.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109094426.1432=
465-1-torsteine+linux@gmail.com?part=3D1
