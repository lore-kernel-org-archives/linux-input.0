Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FED3148D8
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792203797; cv=none; b=YeZIzJjtEMq6uWK+/LyOLNhaoLMeGnY649gC+jza2lEKkv7oZkL4LUnIMymxE2gBUZOxIQK1vqJJIuwg0l5N/5/aTI46HMT12pgAzaDCXy0/oazXySRiJedFaY9DRrKlbwLDULm30jfqcVyLm6m5fClTqaY2NY3kE7sppbVEQcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792203797; c=relaxed/simple;
	bh=Mg+ykhciEw+eBssK/z3A42goDLYcgBsPVFbSXrkYIs4=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Z+pSW7qGcelvRJWOIX56F9uarU2GQE6Y7sZ4yBsXqA5xqnBMTnsjWKVDLOGUoABu0z+xk0Gv1MnvDpK7P0yJwi6TbR2dWHt4EFDA7gkGzE4G1ZZaqY0yZ6q0aITsM/Hj82u+Wcc+fO+gPhboup1iWOHmE1oqv3Vt2ZkIRSTca3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f29znrdq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f29znrdq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78C11F000C4;
	Sat, 17 Oct 2026 02:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792203796;
	bh=6cf1FDQh9j0mV2aNEL9CuvPregLIB1VyP8FjFMcbYFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f29znrdqQPeHpsjSyaTLlRPJPpVywOBxZIC+43RivLwCnW/M2ueHqbmz5ajQwxCFf
	 KUL1Ukcx0XbcldfauXct7LN4IvZuayIKRnLXop4BkINNLsBrqw6SlUBdAvdsNCleGn
	 iV8PBrp+1IXvUZQCFnQRgSjYF3RtTANB5+8sD1MkNO03snFeKvvufqYieBCotRn9yd
	 n95R16O6KFk5npyx7FLpLWIhUv64NPF12PoeHbZu1b5b41qfjquCEDbIQyTSd7mcRa
	 F69m8j5rDLfqwvjWNqHGh56ZgCWJU/buMziaXs8C3PmjV3HTccO1Or8M7mnvUlt81m
	 3LPJwShTkN6tA==
Message-ID: <sashiko-outbox-175204@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/11] HID: hid-lenovo-go-s: Use devm_kzalloc for
 drvdata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261017013956.2440130-11-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
 <20261017013956.2440130-11-derekjohn.clark@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 02:23:15 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] HID: hid-lenovo-go-s: sleeping in atomic context in hid_gos_bright=
ness_set()
- [Medium] HID: hid-lenovo-go-s: missing resume callback leaves gos_cfg_set=
up cancelled
- [Medium] HID: hid-lenovo-go-s: rgb_registered not cleared in hid_gos_cfg_=
remove()
- [Low] HID: hid-lenovo-go-s: clear rgb_registered before unregister in cfg=
_setup()
--

commit dee5a3ea54364a99dd4973105a8bc5e0a649f8ce
Author: Derek J. Clark <derekjohn.clark@gmail.com>

HID: hid-lenovo-go-s: Use devm_kzalloc for drvdata

This commit converts drvdata in hid-lenovo-go-s from a static global
structure to a per-device devm-allocated structure and updates the
setup work function name in barrier comments.

> diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
> index 2e938dd5e77c5..1a2b28e1bed1b 100644
> --- a/drivers/hid/hid-lenovo-go-s.c
> +++ b/drivers/hid/hid-lenovo-go-s.c

[ ... ]

> @@ -1189,13 +1261,14 @@ static ssize_t rgb_profile_range_show(struct devi=
ce *dev,
>  static void hid_gos_brightness_set(struct led_classdev *led_cdev,
>  				   enum led_brightness brightness)
>  {
> -	struct led_classdev_mc *led_mc =3D &drvdata.led_mc;
> +	struct led_classdev_mc *led_mc =3D lcdev_to_mccdev(led_cdev);
> +	struct gos_cfg_drvdata *drvdata =3D container_of(led_mc, struct gos_cfg=
_drvdata, led_mc);
>  	enum rgb_config_index index;
>  	bool rgb_registered;
>  	int ret;
> =20
> -	/* Pairs with smp_store_release from gos_cfg_setup */
> -	rgb_registered =3D smp_load_acquire(&drvdata.rgb_registered);
> +	/* Pairs with smp_store_release from cfg_setup */
> +	rgb_registered =3D smp_load_acquire(&drvdata->rgb_registered);
>  	if (!rgb_registered)
>  		return;
> =20
> @@ -1204,15 +1277,15 @@ static void hid_gos_brightness_set(struct led_cla=
ssdev *led_cdev,
>  		return;
>  	}
> =20
> -	index =3D drvdata.rgb_profile + 2;
> -	u8 rgb_profile[6] =3D { drvdata.rgb_effect,
> +	index =3D drvdata->rgb_profile + 2;
> +	u8 rgb_profile[6] =3D { drvdata->rgb_effect,
>  			      led_mc->subled_info[0].intensity,
>  			      led_mc->subled_info[1].intensity,
>  			      led_mc->subled_info[2].intensity,
>  			      brightness,
> -			      drvdata.rgb_speed };
> +			      drvdata->rgb_speed };
> =20
> -	ret =3D rgb_cfg_call(drvdata.hdev, SET_RGB_CFG, index, rgb_profile, 6);
> +	ret =3D rgb_cfg_call(drvdata->hdev, SET_RGB_CFG, index, rgb_profile, 6);

[Severity: High]
Can hid_gos_brightness_set() sleep in atomic context here?

In hid_gos_cfg_probe(), hid_gos_brightness_set() is wired to
drvdata->led_mc.led_cdev.brightness_set rather than brightness_set_blocking.
In the LED core, setting brightness_set tells led_set_brightness_nopm() that
the callback does not sleep, so __led_set_brightness() invokes it directly =
in
the caller's context without deferring to set_brightness_work.

When software blinking (via led_timer_function() in timer softirq context) =
or
an atomic LED trigger calls led_set_brightness_nosleep(), the call chain is:

  hid_gos_brightness_set()
    rgb_cfg_call()
      mcu_property_out()

Inside mcu_property_out(), the code acquires a sleeping mutex
(drvdata->cfg_mutex), allocates memory with GFP_KERNEL, and blocks on
wait_for_completion_timeout() and wait_for_completion_interruptible_timeout=
().
Should this use brightness_set_blocking instead?

[ ... ]

> @@ -1536,67 +1610,75 @@ static void cfg_setup(struct work_struct *work)
>  		}
>  	}
> =20
> -	if (!drvdata.rgb_registered) {
> -		/* Pairs with smp_load_acquire in attribute show/store functions */
> -		smp_store_release(&drvdata.rgb_registered, true);
> +	if (!drvdata->rgb_registered) {
> +		/* Pairs with smp_load_acquire in attribute show/store */
> +		smp_store_release(&drvdata->rgb_registered, true);
>  		rgb_registered =3D true;
> =20
> -		ret =3D led_classdev_multicolor_register(&drvdata.hdev->dev,
> -						       &drvdata.led_mc);
> +		ret =3D led_classdev_multicolor_register(&drvdata->hdev->dev,
> +						       &drvdata->led_mc);
>  		if (ret) {
> -			dev_err(&drvdata.hdev->dev, "Failed to create RGB device: %i\n",
> +			dev_err(&drvdata->hdev->dev, "Failed to create RGB device: %i\n",
>  				ret);
> =20
> -			/* Pairs with smp_load_acquire in attribute show/store functions */
> -			smp_store_release(&drvdata.rgb_registered, false);
> +			/* Pairs with smp_load_acquire in attribute show/store */
> +			smp_store_release(&drvdata->rgb_registered, false);
>  			rgb_registered =3D false;
>  		} else {
> -			ret =3D devm_device_add_group(drvdata.led_mc.led_cdev.dev,
> +			ret =3D devm_device_add_group(drvdata->led_mc.led_cdev.dev,
>  						    &rgb_attr_group);
>  			if (ret) {
> -				dev_err(&drvdata.hdev->dev,
> +				dev_err(&drvdata->hdev->dev,
>  					"Failed to create RGB configuration attributes: %i\n",
>  					ret);
> =20
> -				led_classdev_multicolor_unregister(&drvdata.led_mc);
> +				led_classdev_multicolor_unregister(&drvdata->led_mc);
> =20
> -				/* Pairs with smp_load_acquire in attribute show/store functions */
> -				smp_store_release(&drvdata.rgb_registered, false);
> +				/* Pairs with smp_load_acquire in attribute show/store */
> +				smp_store_release(&drvdata->rgb_registered, false);
>  				rgb_registered =3D false;
>  			}
>  		}
>  	}

[Severity: Low]
In cfg_setup(), if devm_device_add_group() fails, should
drvdata->rgb_registered be set to false before calling
led_classdev_multicolor_unregister(&drvdata->led_mc)?

Because LED_RETAIN_AT_SHUTDOWN is not set on drvdata->led_mc.led_cdev.flags,
led_classdev_unregister() calls led_set_brightness(led_cdev, LED_OFF), which
synchronously invokes hid_gos_brightness_set(). Since drvdata->rgb_register=
ed
is still true at that point and drvdata->rgb_profile is still 0,
hid_gos_brightness_set() sends an unintended SET_RGB_CFG command with index
LIGHT_PROFILE_SEL (0 + 2) and a 6-byte payload to the MCU during error
rollback.

[ ... ]

> @@ -1607,15 +1691,19 @@ static int hid_gos_cfg_probe(struct hid_device *h=
dev,
> =20
>  static void hid_gos_cfg_remove(struct hid_device *hdev)
>  {
> +	struct gos_cfg_drvdata *drvdata =3D hid_get_drvdata(hdev);
>  	bool rgb_registered;
> =20
> -	disable_delayed_work_sync(&drvdata.gos_cfg_setup);
> +	if (!drvdata)
> +		return;
> +
> +	disable_delayed_work_sync(&drvdata->gos_cfg_setup);
>  	sysfs_remove_groups(&hdev->dev.kobj, top_level_attr_groups);
> =20
> -	/* Pairs with smp_store_release in cfg_setup */
> -	rgb_registered =3D smp_load_acquire(&drvdata.rgb_registered);
> +	/* Pairs with smp_store_release from cfg_setup */
> +	rgb_registered =3D smp_load_acquire(&drvdata->rgb_registered);
>  	if (rgb_registered)
> -		led_classdev_multicolor_unregister(&drvdata.led_mc);
> +		led_classdev_multicolor_unregister(&drvdata->led_mc);
> =20
>  	hid_hw_close(hdev);
>  	hid_hw_stop(hdev);

[Severity: Medium]
Does calling led_classdev_multicolor_unregister(&drvdata->led_mc) in
hid_gos_cfg_remove() without clearing drvdata->rgb_registered first cause a
timeout and error log on every driver unbind or module unload?

When hid_device_remove() runs, it holds hdev->driver_input_lock, causing
__hid_input_report() to drop any incoming HID reports. In
hid_gos_cfg_remove(), led_classdev_multicolor_unregister() is called while
drvdata->rgb_registered is still true and before hid_hw_stop():

  hid_device_remove()
    hid_gos_remove()
      hid_gos_cfg_remove()
        led_classdev_multicolor_unregister()
          led_classdev_unregister()
            led_set_brightness(led_cdev, LED_OFF)
              hid_gos_brightness_set()
                rgb_cfg_call()
                  mcu_property_out()

Because drvdata->rgb_registered is still true and hid_hw_stop() has not been
called yet, mcu_property_out() sends SET_RGB_CFG to the MCU and blocks in
wait_for_completion_interruptible_timeout(). Since driver_input_lock blocks
hid_gos_raw_event(), the wait always times out with -EBUSY and logs
dev_err("Failed to write RGB profile: -16").

> @@ -1624,16 +1712,21 @@ static void hid_gos_cfg_remove(struct hid_device =
*hdev)
> =20
>  static int hid_gos_cfg_reset_resume(struct hid_device *hdev)
>  {
> +	struct gos_cfg_drvdata *drvdata =3D hid_get_drvdata(hdev);
>  	bool gp_registered, rgb_registered;
> -	u8 os_mode =3D drvdata.os_mode;
> +	u8 os_mode;
>  	int ret;
> =20
> -	/* Pairs with smp_store_release from gos_cfg_setup */
> -	gp_registered =3D smp_load_acquire(&drvdata.gp_registered);
> -	/* Pairs with smp_store_release from gos_cfg_setup */
> -	rgb_registered =3D smp_load_acquire(&drvdata.rgb_registered);
> +	if (!drvdata)
> +		return -ENODEV;
> +
> +	os_mode =3D drvdata->os_mode;
> +	/* Pairs with smp_store_release from cfg_setup */
> +	gp_registered =3D smp_load_acquire(&drvdata->gp_registered);
> +	/* Pairs with smp_store_release from cfg_setup */
> +	rgb_registered =3D smp_load_acquire(&drvdata->rgb_registered);
>  	if (!gp_registered || !rgb_registered) {
> -		ret =3D schedule_delayed_work(&drvdata.gos_cfg_setup, msecs_to_jiffies=
(2));
> +		ret =3D schedule_delayed_work(&drvdata->gos_cfg_setup, msecs_to_jiffie=
s(2));
>  		if (!ret) {
>  			dev_err(&hdev->dev, "Failed to schedule startup delayed work\n");
>  			return -ENODEV;

[ ... ]

> @@ -1730,9 +1823,14 @@ static int hid_gos_reset_resume(struct hid_device =
*hdev)
>  	return 0;
>  }
> =20
> -static int hid_gos_cfg_suspend(void)
> +static int hid_gos_cfg_suspend(struct hid_device *hdev)
>  {
> -	cancel_delayed_work_sync(&drvdata.gos_cfg_setup);
> +	struct gos_cfg_drvdata *drvdata =3D hid_get_drvdata(hdev);
> +
> +	if (!drvdata)
> +		return -ENODEV;
> +
> +	cancel_delayed_work_sync(&drvdata->gos_cfg_setup);
> =20
>  	return 0;
>  }
> @@ -1749,7 +1847,7 @@ static int hid_gos_suspend(struct hid_device *hdev,=
 pm_message_t msg)
> =20
>  	ep =3D ret;
>  	if (ep =3D=3D GO_S_CFG_INTF_IN)
> -		return hid_gos_cfg_suspend();
> +		return hid_gos_cfg_suspend(hdev);
> =20
>  	return 0;
>  }

[Severity: Medium]
What happens if the device suspends before drvdata->gos_cfg_setup completes
and then resumes without a USB reset?

In hid_gos_cfg_probe(), drvdata->gos_cfg_setup is scheduled with a 2ms delay
and retries up to 5 times at 50ms intervals in cfg_setup(). On any suspend
(such as s2idle or runtime autosuspend), hid_gos_suspend() calls
hid_gos_cfg_suspend(), which cancels drvdata->gos_cfg_setup via
cancel_delayed_work_sync().

However, struct hid_driver hid_lenovo_go_s only defines .reset_resume and
omits .resume:

  static struct hid_driver hid_lenovo_go_s =3D {
          .name =3D "hid-lenovo-go-s",
          .id_table =3D hid_gos_devices,
          .probe =3D hid_gos_probe,
          .remove =3D hid_gos_remove,
          .raw_event =3D hid_gos_raw_event,
          .reset_resume =3D pm_ptr(hid_gos_reset_resume),
          .suspend =3D pm_ptr(hid_gos_suspend),
  };

When usbhid resumes without a port reset, hid_driver_resume() checks
hdev->driver->resume and does not fall back to .reset_resume. Without a
.resume callback to reschedule drvdata->gos_cfg_setup when !gp_registered ||
!rgb_registered, won't the gamepad sysfs groups and RGB LED device remain
permanently unregistered?

I hope this is helpful.

Lawall-Bot

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017013956.2440=
130-1-derekjohn.clark@gmail.com?part=3D10
