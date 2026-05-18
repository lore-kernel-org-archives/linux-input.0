Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75169481FD7
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779120748; cv=none; b=C/gAFg04jtjYlP7qBMYAl1vGUtfBO3+3o2532yOh9aAQE6JxXmKdwgjwaWF8VQ3ewUntTDkwz31NF1ZXEDhAzQ80gQmfiqAT6HsMLTaUWBhc/ifj8MI1B41FVK3ftCC4+QM0e0fhm5JzUy2c+TZRLvQKcVeiCzNrrTA7dpGmhPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779120748; c=relaxed/simple;
	bh=9P3IWwsORrpb856FnfQgc+VSfCR7r+bvMpgWShWMDNM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Thg7Zre4UGzxN4XxBG3X+k2mCugxAu3MVL7N7yKGJCjFADLUMahk40LiGsklpi9Tc/cIU5CGMCexeM9012iYcK5oS1ct6bdJ3HjLa6PdO9QIaQap7e/6RX5GEYoQiartVxXM3Sy56AEioy8DjgfJZa0V+Es1LkUC3fHjzuZFu1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNqFq0d3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNqFq0d3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAF6C2BCB7;
	Mon, 18 May 2026 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779120747;
	bh=9P3IWwsORrpb856FnfQgc+VSfCR7r+bvMpgWShWMDNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aNqFq0d3uRNleGTTEtUK1eVpBdg3mZYOui0Kd8A+OoCShKyGR2hyE5oTHPino5Bqd
	 PIoq9OFr7PkmuJVh2yNUfln0hyqhrkXU/Azxyo+PP4yyDn7VhtYLdX1EgXvgAedJA7
	 J/M3vkCFTWsigGT1TSEGJFkAlsdBJYxWNTmDAMVgcl4ODlBS1Wswx0CdHFWqjBzegk
	 gyduDeqsN1MzR9hr/26JPUgsB4biZJoiGDoRZ73LQSyfhFlQlIzG/zrSUHxJaruq4r
	 zMHdKDbJc6KISEfxWw7d8hIs4BM1zMo5LL5QKBpwmZNyKOhUbGtLMUDR0AlXlS35WY
	 ZHd5CKTyDtTfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: lg-g15: Add support for the Logitech G710/G710+
 gaming keyboards
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xavier Bestel" <xav@bes.tel>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260518153519.605627-1-xav@bes.tel>
References: <20260518153519.605627-1-xav@bes.tel>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 16:12:19 +0000
Message-Id: <20260518161227.BCAF6C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Missing workqueue cancellation on module unload or device remo=
val causes a Use-After-Free
- [High] Missing edge detection for Game Mode and brightness buttons leads =
to USB bus spam and state desynchronization
- [High] Data race on `g15->transfer_buf` during device probe
- [Medium] LED brightness callbacks violate the API contract by returning s=
uccess on failure
- [Medium] Hardware events arriving before LED registration trigger a kerne=
l WARN_ON
--

commit f98ec9abc4841148689435f75f93ed341ba49d7d
Author: Xavier Bestel <xav@bes.tel>

HID: lg-g15: Add support for the Logitech G710/G710+ gaming keyboards

Add support for the Logitech G710 and G710+ gaming keyboards to the
hid-lg-g15 driver, exposing the G-keys, M-keys, game mode toggle, and
brightness cycle buttons.

> diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
> --- a/drivers/hid/hid-lg-g15.c
> +++ b/drivers/hid/hid-lg-g15.c

[ ... ]

> @@ -597,6 +605,234 @@ static int lg_g510_mkey_led_set(struct led_classdev=
 *led_cdev,
>  	return ret;
>  }
> =20
> +/******** G710 LED functions ********/

[ ... ]

> +static int lg_g710_mkey_led_set(struct led_classdev *led_cdev,
> +			  enum led_brightness brightness)
> +{

[ ... ]

> +	ret =3D hid_hw_raw_request(g15->hdev, LG_G710_FEATURE_M_KEYS_LEDS,
> +				 g15->transfer_buf, 2,
> +				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> +	if (ret =3D=3D 2) {
> +		/* Success */
> +		g15_led->brightness =3D brightness;
> +		ret =3D 0;
> +	} else {
> +		if (ret !=3D -EPIPE)
> +			hid_err(g15->hdev, "Error setting LED brightness: %d\n", ret);
> +		/* -EPIPE is transient (USB stall), cache is unchanged, retry next tim=
e */
> +		ret =3D 0;
> +	}
> +
> +	mutex_unlock(&g15->mutex);
> +
> +	return ret;
> +}

Does returning 0 here break the LED class API contract when a hard error
like -EIO or -ENODEV occurs?

If we return success despite hardware failure, won't the internal software
cache update while the physical hardware remains unchanged, leading to a
permanent desynchronization between sysfs and the device?

[ ... ]

> @@ -890,6 +1136,71 @@ static int lg_g510_leds_event(struct lg_g15_data *g=
15, u8 *data)
>  	return 0;
>  }
> =20
> +static int lg_g710_event(struct lg_g15_data *g15, u8 *data, int size)
> +{

[ ... ]

> +	/*
> +	 * Detect brightness key presses and schedule the work function
> +	 * to cycle cached brightness and notify userspace.
> +	 * Bit 10 =3D WASD backlight (maps to LG_G15_LCD_BRIGHTNESS slot).
> +	 * Bit 11 =3D Kbd backlight (maps to LG_G15_KBD_BRIGHTNESS slot).
> +	 */
> +	if (pressed_keys & BIT(10)) {
> +		set_bit(LG_G15_LCD_BRIGHTNESS, &g15->brightness_changed);
> +		schedule_work(&g15->work);
> +	}
> +	if (pressed_keys & BIT(11)) {
> +		set_bit(LG_G15_KBD_BRIGHTNESS, &g15->brightness_changed);
> +		schedule_work(&g15->work);
> +	}
> +
> +	/* Game mode toggle =E2=80=94 bit 12 is a state bit, trigger on any cha=
nge */
> +	if (pressed_keys & BIT(12)) {
> +		set_bit(LG_G15_GAMEMODE, &g15->brightness_changed);
> +		schedule_work(&g15->work);
> +	}

Could these bitwise checks cause continuous triggering on every HID report
received?

Since the game mode toggle check evaluates the absolute state, if game mode
is enabled (for instance, while holding a macro key), won't this continuous=
ly
schedule the workqueue, spam the USB bus with synchronous get-report reques=
ts,
and flood userspace with duplicate notifications?

Also, since the condition evaluates to false when game mode is disabled, wi=
ll
userspace ever be notified of the disabled state?

Similarly for the brightness buttons, does checking the absolute state mean
that holding the button down will rapidly decrement the software brightness
cache and permanently desynchronize it from the physical hardware?

Should the driver track previous states and trigger actions only on edge
transitions instead?

[ ... ]

> @@ -1212,6 +1562,13 @@ static int lg_g15_probe(struct hid_device *hdev, c=
onst struct hid_device_id *id)
>  	case LG_Z10:
>  		connect_mask =3D HID_CONNECT_HIDRAW;
>  		break;
> +	case LG_G710:
> +		INIT_WORK(&g15->work, lg_g710_leds_changed_work);
> +		hdev->quirks |=3D HID_QUIRK_NOGET;
> +		connect_mask =3D HID_CONNECT_DEFAULT;
> +		gkeys_settings_feature_report =3D LG_G710_FEATURE_EXTRA_KEYS;
> +		gkeys =3D 6;
> +		break;
>  	}
> =20
>  	ret =3D hid_hw_start(hdev, connect_mask);

This isn't a bug introduced exclusively by this patch, but does the lack of=
 a
remove callback or devres action to cancel the scheduled work risk a
use-after-free?

The driver allocates the context structure using devm_kzalloc and initializ=
es
the work struct, but nothing calls cancel_work_sync on shutdown. If the work
is pending or running on the system workqueue when devm frees the memory,
won't it dereference freed memory?

[ ... ]

> @@ -1234,11 +1591,13 @@ static int lg_g15_probe(struct hid_device *hdev, =
const struct hid_device_id *id)
>  	}
> =20
>  	if (gkeys_settings_feature_report) {
> +		int report_size =3D (g15->model =3D=3D LG_G710) ? gkeys * 2 : gkeys;
> =20
>  		g15->transfer_buf[0] =3D gkeys_settings_feature_report;
> -		memset(g15->transfer_buf + 1, 0, gkeys);
> +		memset(g15->transfer_buf + 1, 0, report_size);
>  		ret =3D hid_hw_raw_request(g15->hdev,
>  				gkeys_settings_feature_report,
> -				g15->transfer_buf, gkeys + 1,
> +				g15->transfer_buf, report_size + 1,
>  				HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
>  	}

This isn't a new bug, but since this lockless access to the transfer buffer
occurs right after hid_hw_start, could an incoming HID report concurrently
schedule the work queue?

The asynchronous worker safely locks the mutex before mutating the exact sa=
me
transfer buffer. Does this allow the workqueue to overwrite the buffer while
the probe function is actively using it, resulting in malformed requests?

[ ... ]

> @@ -1327,12 +1686,18 @@ static int lg_g15_probe(struct hid_device *hdev, =
const struct hid_device_id *id)
>  		goto error_hw_stop;
> =20
>  	/* Register LED devices */
> -	for (i =3D 0; i < LG_G15_LED_MAX; i++) {
> +	for (i =3D 0; i <=3D LG_G15_MACRO_RECORD; i++) {
>  		ret =3D lg_g15_register_led(g15, i, led_names[i]);
>  		if (ret)
>  			goto error_hw_stop;
>  	}
> =20
> +	if (g15->model =3D=3D LG_G710) {
> +		ret =3D lg_g15_register_led(g15, LG_G15_GAMEMODE, "g15::gamemode");
> +		if (ret)
> +			goto error_hw_stop;
> +	}

Because hid_hw_start is called earlier in the probe sequence, is it possible
for a hardware event to trigger lg_g710_event before these LEDs are actually
registered?

If the worker thread runs and invokes the brightness hardware changed
notification on zero-initialized, unregistered LED devices, won't the
internal sysfs nodes be NULL, triggering a stack trace warning in the LED
core?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518153519.6056=
27-1-xav@bes.tel?part=3D1
