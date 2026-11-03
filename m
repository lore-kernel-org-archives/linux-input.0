Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671722;
	b=l0tArcRk/GGdPYv1Fgffut2fdxcDQk8Ewn1MhMBlP16/Q91giDv0+nwRq5WEzPFUIIB1
	 UnrMs1wtjvYctWutnYkpoFpERv86QIJNiVM0rJd4TXgTeV1TmWnvKd9WN9JW5gS5iBxwo
	 n/Rzj/AENAky1G4uVmojE2JxF+6KEtzMa8Soi9TZ4PKHp8dyQcGDRKHNZpR71Wi4wYc6L
	 uaFbUrznoJCFXc4OctpY96DrAaTg3uTGfMixNVdEi1VXyxAXEHKPfZi9ybB6NlkSbY2SL
	 m3C6j5UYREpH1GOuuhZF+G3KHZ+gvfB+fC0ApwUErFsvW4WBnBJcWevulsxrstq0a6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671722;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zc24KuX54+W7/fshC7VZW5Q/KJpUsPe4AilpD9lmfUQ=;
	b=DOZx4lGA2EyXd5J+oh+b2cM5RgPr3WrFZYbF6kZLynE3e5wfP8lQFLGtprJBOUiR8ClZ
	 lDLB/MAqUoz7/OZFaCalaQbVPmyEut/UAUwYrO6kcWlWoRnERRRoha+NZ+p/YXnn1Vojj
	 BcnlOm8GeYZR9mSBFVoAM1dbfJcvDPh/6jhzyHWr/E901l7QWm8FRTK3+0+F3KJbKmMkF
	 qEDYK01JQ+39n9VeXtHnini7AUP9/fjMN2VKJfYO/XmUCwKVvDnZal+9h3gS/s4XwhH7o
	 54PgptwfIZADmhaAKZMU4i5Ina+qOEoMgIWbSQY4SpSkaIGXYARHS/UuSoBhoWDGMQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3QpdKQ0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9D4606A324
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C3QpdKQ0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61DE1F000C1;
	Tue,  3 Nov 2026 02:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793671722;
	bh=zc24KuX54+W7/fshC7VZW5Q/KJpUsPe4AilpD9lmfUQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C3QpdKQ0h8NE/7QD1v4IET6vp6DW1sdMVNOOC6rh67VTRHkHuDd0wMTXUiRRdrHCD
	 DSv01RQA1J2OElzL5CAyuUMsfTRFr/8ZD8hwu/uJFdnfwf212SSt6oOo5xFdVHvqKc
	 H4I4OjQBFBUyc4vFBbQ3DKNREy8Ra0ybDVXj6ax+2HdJ1rzhU32excAMZ9LQM4oiJb
	 6MKOWN6KQMI5ebKkltAfmZysdzad4IdG1GgFxGR+5GM5DSxSC+7r60XKGiaCTAOMVT
	 +pKZWY/YMDwNgO+Kd9kQjAl2w7+iV9cj1O/c3KWDTIcOoKBQAhruZ1rVBeek+rJ8Kj
	 dB1zN3DGZT5KA==
Message-ID: <sashiko-outbox-194446@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: santroller: add driver for Santroller
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Govind" <sanjay.govind9@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261103015335.974344-1-sanjay.govind9@gmail.com>
References: <20261016025403.779635-1-sanjay.govind9@gmail.com>
 <20261103015335.974344-1-sanjay.govind9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 02:08:41 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] HID: santroller: completion token consumed in santroller_get_fea=
tures()
- [Medium] HID: santroller: santroller_resume() clobbers dirty flag and ski=
ps input check
- [Medium] HID: santroller: unlocked color calculation in santroller_rgb_le=
d_set()
- [Low] HID: santroller: missing USB_HID dependency for hid_is_usb()
--

commit 5d9a23d03a81b34363d47e701c2dd2ced730bac9
Author: Sanjay Govind <sanjay.govind9@gmail.com>

HID: santroller: add driver for Santroller controllers

This commit adds a HID driver for game controllers and instruments running
the open source Santroller firmware. It queries a vendor features report to
configure force-feedback rumble, player LEDs, a multicolor RGB indicator LE=
D,
and the DJ Hero turntable euphoria LED.

> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 2481bc01c435b..2fab7003ce18f 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -1138,6 +1138,18 @@ config HID_SAMSUNG
>  	help
>  	Support for Samsung InfraRed remote control or keyboards.
> =20
> +config HID_SANTROLLER
> +	tristate "Santroller game controller support"
> +	depends on LEDS_CLASS_MULTICOLOR
> +	select INPUT_FF_MEMLESS

[Severity: Low]
In drivers/hid/hid-santroller.c, santroller_profile_name() unconditionally
calls hid_is_usb(hdev):

	if (!hid_is_usb(hdev))
		return NULL;

However, include/linux/hid.h declares hid_is_usb() as an extern symbol with
no inline fallback when CONFIG_USB_HID is disabled, and its definition in
drivers/hid/usbhid/hid-core.c is only built when CONFIG_USB_HID is enabled.

Can building with CONFIG_USB_HID=3Dn (or CONFIG_USB_HID=3Dm and
CONFIG_HID_SANTROLLER=3Dy) fail at link time with an undefined reference to
hid_is_usb()? Should HID_SANTROLLER depend on USB_HID (or guard the USB
helper with IS_ENABLED(CONFIG_USB_HID))?

> diff --git a/drivers/hid/hid-santroller.c b/drivers/hid/hid-santroller.c
> new file mode 100644
> index 0000000000000..a2048e4ea3215
> --- /dev/null
> +++ b/drivers/hid/hid-santroller.c
[ ... ]
> +static void santroller_rgb_led_set(struct led_classdev *led,
> +				   enum led_brightness brightness)
> +{
> +	struct led_classdev_mc *mc =3D lcdev_to_mccdev(led);
> +	struct santroller *sc =3D container_of(mc, struct santroller, rgb_led);
> +	int i;
> +
> +	led_mc_calc_color_components(mc, brightness);
> +
> +	guard(spinlock_irqsave)(&sc->lock);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(sc->rgb); i++)
> +		sc->rgb[i] =3D mc->subled_info[i].brightness;
> +	sc->rgb_dirty =3D true;
> +	santroller_schedule_output(sc);
> +}

[Severity: Medium]
Since santroller_rgb_led_set() is registered as the non-blocking
led->brightness_set callback, it can be invoked concurrently from software
blink timers, triggers, or sysfs writes without led_access held.

Because led_mc_calc_color_components(mc, brightness) updates
mc->subled_info[i].brightness in place before sc->lock is acquired, can two
concurrent calls to santroller_rgb_led_set() race on
mc->subled_info[i].brightness and copy stale or mixed RGB values into
sc->rgb[]? Should led_mc_calc_color_components() be called inside the
sc->lock critical section?

[ ... ]
> +static int santroller_raw_event(struct hid_device *hdev,
> +				struct hid_report *report, u8 *data, int size)
> +{
> +	struct santroller *sc =3D hid_get_drvdata(hdev);
> +
> +	if (sc && data[0] =3D=3D SANTROLLER_REPORT_ID_FEATURES &&
> +	    size >=3D SANTROLLER_FEATURES_REPORT_SIZE &&
> +	    !completion_done(&sc->features_done)) {
> +		sc->caps =3D data[2];
> +		complete(&sc->features_done);
> +	}
> +
> +	return 0;
> +}
> +
> +/* The device answers the features command with an input report */
> +static int santroller_get_features(struct santroller *sc)
> +{
> +	u8 *buf __free(kfree) =3D kzalloc(2, GFP_KERNEL);
> +	unsigned long timeout =3D SANTROLLER_FEATURES_TIMEOUT;
> +	int i, ret =3D -ETIMEDOUT;
> +
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	if (sc->hdev->bus =3D=3D BUS_BLUETOOTH)
> +		timeout =3D SANTROLLER_FEATURES_TIMEOUT_BT;
> +
> +	for (i =3D 0; i < SANTROLLER_FEATURES_RETRIES; i++) {
> +		reinit_completion(&sc->features_done);
> +
> +		buf[0] =3D SANTROLLER_REPORT_ID_FEATURES;
> +		buf[1] =3D 0;
> +		ret =3D santroller_send_report(sc->hdev, buf, 2);
> +		if (ret < 0)
> +			continue;
> +
> +		if (wait_for_completion_timeout(&sc->features_done, timeout))
> +			return 0;
> +
> +		ret =3D -ETIMEDOUT;
> +	}
> +
> +	return ret;
> +}

[Severity: Medium]
When santroller_raw_event() receives SANTROLLER_REPORT_ID_FEATURES, it calls
complete(&sc->features_done), which increments sc->features_done.done from 0
to 1. When wait_for_completion_timeout(&sc->features_done, timeout) wakes up
in santroller_get_features(), do_wait_for_common() consumes that token and
decrements sc->features_done.done back to 0.

In santroller_probe(), complete(&sc->features_done) is only called when
santroller_get_features() fails:

	ret =3D santroller_get_features(sc);
	if (ret =3D=3D -ENOMEM)
		goto err_close;
	if (ret) {
		hid_warn(hdev, "failed to get device features: %d\n", ret);
		/* Ignore a late reply, the caps are settled from here on */
		complete(&sc->features_done);
	}

When santroller_get_features() succeeds, sc->features_done.done remains 0,
so completion_done(&sc->features_done) in santroller_raw_event() continues =
to
return false for the lifetime of the device. In addition, reinit_completion=
()
in the retry loop can run concurrently with santroller_raw_event() if a rep=
ly
to an earlier attempt arrives just as a timeout expires.

Can a delayed retry response or a later SANTROLLER_REPORT_ID_FEATURES report
overwrite sc->caps in santroller_raw_event() without synchronization while
santroller_probe() or santroller_resume() is reading sc->caps? Would
complete_all() (or guarding sc->caps with a flag under sc->lock) avoid this?

[ ... ]
> +static int santroller_resume(struct hid_device *hdev)
> +{
> +	struct santroller *sc =3D hid_get_drvdata(hdev);
> +
> +	if (!sc)
> +		return 0;
> +
> +	/* The device may have lost its LED state, so send it again */
> +	guard(spinlock_irqsave)(&sc->lock);
> +
> +	sc->player_dirty =3D sc->caps & SANTROLLER_CAP_PLAYER_LEDS;
> +	sc->rgb_dirty =3D sc->caps & SANTROLLER_CAP_RGB_LED;
> +	sc->rumble_dirty =3D sc->caps & SANTROLLER_CAP_EUPHORIA_LED;
> +	santroller_schedule_output(sc);
> +
> +	return 0;
> +}

[Severity: Medium]
There appear to be two issues in santroller_resume():

First, sc->rumble_dirty is shared between FF_RUMBLE in
santroller_play_effect() and the euphoria LED in
santroller_euphoria_led_set(). Assigning sc->rumble_dirty with '=3D' instea=
d of
'|=3D' clears sc->rumble_dirty to false on controllers that support
SANTROLLER_CAP_RUMBLE but not SANTROLLER_CAP_EUPHORIA_LED. If a rumble upda=
te
was queued before santroller_output_work() ran, will santroller_resume() dr=
op
that pending rumble command?

Second, in santroller_probe(), if sc->input is NULL, the driver jumps to out
without registering any LEDs or initializing sc->player (leaving sc->player
at 0 rather than SANTROLLER_PLAYER_LED_OFF):

	/* The LEDs are named after the gamepad input device */
	if (!sc->input)
		goto out;

Because santroller_resume() does not check sc->input before marking the LEDs
dirty, can resuming a device where sc->input is NULL send uninitialized LED
state to the controller?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103015335.9743=
44-1-sanjay.govind9@gmail.com?part=3D1
