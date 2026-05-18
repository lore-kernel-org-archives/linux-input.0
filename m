Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA212F90C5
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 19:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779132262; cv=none; b=ZPcYSfRP47v4ePuXu1tfObfskGQpTLR+Oe8AoGmm+HGCmuslYX6OwgszOrDT/dxU704ZYbTiQXKDQymYPeZw6XUtFYHo8L0AqOcPt0hdx6jiCWRyFbIb5oDltLWoVq59TJrdxUuic5Gd0jmfgZ4F1JmJZp1bbQiSfJbRNG/qpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779132262; c=relaxed/simple;
	bh=7QpXqPtM383HeEX6NMmi2uMXUm/iQn1FQiQwHQU/FuQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uGjl9Q1CEU+LqfMeXi0tWhq2ySfT1/bnRTId+KRNukWB7PRaVmwbKKpBoKhzQJ3yOI/28cXh6fvUkH762lAG6m0Fnp8xMAqSHvUGtqdSQ5B289Vr16SQRMut0jq6iA89EHcdt/t+MpD+9WMO/dPyfLYYqmKfuzywPJe2NRc1K3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bes.tel; spf=pass smtp.mailfrom=bes.tel; dkim=pass (2048-bit key) header.d=bes.tel header.i=@bes.tel header.b=aTzT+CYG; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=XxbYmmlc; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bes.tel
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bes.tel
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bes.tel header.i=@bes.tel header.b="aTzT+CYG";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="XxbYmmlc"
DKIM-Signature: a=rsa-sha256; b=aTzT+CYGL1kt+DaVMP0OmWKj9M/yb7+RGAf/5ivjsG8vu0b6JXpwEKEsj0ukjHQcDOh9i2zBDRL7800hw4AtnrlgoBbsxq6/fE9cF+aBECRTKtX871oTjRaQTtDIeK7RPc32G5c+Q7ugir6Lrh6G+TRVM2z0LHvV74gKGhpRa9OJO09euSZJbyp7glV6cNTteqCXcIlxEUJ6XGz5AZlhakJeS0IG+XKIxA/fCU/yoGtsC1xY9AGzNj0lR79xoxEMkL1h3VqdnB5GZ1uqxTbLXXPY2bPEaDNUhg9ge7LOPV/fsNiwPeBO7k+vsIeBGw9xoShQLYG9hyOvMd6K3KBXNg==; s=purelymail2; d=bes.tel; v=1; bh=7QpXqPtM383HeEX6NMmi2uMXUm/iQn1FQiQwHQU/FuQ=; h=Received:Received:Subject:From:To:Date;
DKIM-Signature: a=rsa-sha256; b=XxbYmmlcgCwgZI7XkfQ1y+tZppUZ/XY3Ha1nWNB/DEk5btILQhn23z75r8dtnHr9tLyomPEAMJ1HGOMfh1sIf5SFKsDQ1JzKVm8SWSQCSveVQzYeue77FEMCXHye+z+Eu6zxwZk4Bkmlikbo7rzlBQ9wFicxkCrqAaZG2vZsPRT3lbXqfMYdyXc6lzcKUsvCQQO4vFnck45aytKVXlgBgLmrXBEha9pUrlQNR8Q+mN6R0FNaeBV7EM8nrBe8pxgYs1PEROnSs3SrwymJD+okyt5haxRltiZIBSCk2kzbsBMjjGRoiEjyuIAL6jvAnNmkJkJBD3xAKGVuM3HxCZpF/Q==; s=purelymail2; d=purelymail.com; v=1; bh=7QpXqPtM383HeEX6NMmi2uMXUm/iQn1FQiQwHQU/FuQ=; h=Feedback-ID:Received:Received:Subject:From:To:Date;
Feedback-ID: 19882:3702:null:purelymail
X-Pm-Original-To: linux-input@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -700216346;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 18 May 2026 19:24:05 +0000 (UTC)
Received: from [10.2.161.35] (unknown [10.2.161.35])
	by awak.mobi (Postfix) with ESMTPSA id A347D361380;
	Mon, 18 May 2026 21:24:04 +0200 (CEST)
Message-ID: <9865f220ce268ca322ce8d1059399e7e33c47bf7.camel@bes.tel>
Subject: Re: [PATCH] HID: lg-g15: Add support for the Logitech G710/G710+
 gaming keyboards
From: Xavier Bestel <xav@bes.tel>
To: sashiko-reviews@lists.linux.dev, Hans de Goede <hansg@kernel.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Date: Mon, 18 May 2026 21:24:03 +0200
In-Reply-To: <20260518161227.BCAF6C2BCB7@smtp.kernel.org>
References: <20260518153519.605627-1-xav@bes.tel>
	 <20260518161227.BCAF6C2BCB7@smtp.kernel.org>
Autocrypt: addr=xav@bes.tel; prefer-encrypt=mutual;
 keydata=mDMEaBuzUBYJKwYBBAHaRw8BAQdAGHVrbf6OLBOo4PjYPoYLSIOV+u8/rKgFlLM4pk+rj
 eC0G1hhdmllciBCZXN0ZWwgPHhhdkBiZXMudGVsPoiWBBMWCgA+FiEEPYfp8pYhYROehNkEULR9s/
 9K9OgFAmgbs1ACGwMFCQWjmoAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQULR9s/9K9OgeJAD
 /aPp0IPj5ahqo7DGo1Xk8/t7afPAHYMBeV03Fte4f57EBAPKvhRUTyR4+CrPtGERWfoYlxNkp5yKr
 wwkjUbLon1AG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le lundi 18 mai 2026 =C3=A0 16:12 +0000, sashiko-bot@kernel.org a =C3=A9cri=
t=C2=A0:
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
> - [Critical] Missing workqueue cancellation on module unload or device re=
moval causes a Use-After-Free
> - [High] Missing edge detection for Game Mode and brightness buttons lead=
s to USB bus spam and state desynchronization
> - [High] Data race on `g15->transfer_buf` during device probe
> - [Medium] LED brightness callbacks violate the API contract by returning=
 success on failure
> - [Medium] Hardware events arriving before LED registration trigger a ker=
nel WARN_ON
> --
>=20
> commit f98ec9abc4841148689435f75f93ed341ba49d7d
> Author: Xavier Bestel <xav@bes.tel>
>=20
> HID: lg-g15: Add support for the Logitech G710/G710+ gaming keyboards
>=20
> Add support for the Logitech G710 and G710+ gaming keyboards to the
> hid-lg-g15 driver, exposing the G-keys, M-keys, game mode toggle, and
> brightness cycle buttons.
>=20
> > diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
> > --- a/drivers/hid/hid-lg-g15.c
> > +++ b/drivers/hid/hid-lg-g15.c
>=20
> [ ... ]
>=20
> > @@ -597,6 +605,234 @@ static int lg_g510_mkey_led_set(struct led_classd=
ev *led_cdev,
> > =C2=A0	return ret;
> > =C2=A0}
> > =C2=A0
> > +/******** G710 LED functions ********/
>=20
> [ ... ]
>=20
> > +static int lg_g710_mkey_led_set(struct led_classdev *led_cdev,
> > +			=C2=A0 enum led_brightness brightness)
> > +{
>=20
> [ ... ]
>=20
> > +	ret =3D hid_hw_raw_request(g15->hdev, LG_G710_FEATURE_M_KEYS_LEDS,
> > +				 g15->transfer_buf, 2,
> > +				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> > +	if (ret =3D=3D 2) {
> > +		/* Success */
> > +		g15_led->brightness =3D brightness;
> > +		ret =3D 0;
> > +	} else {
> > +		if (ret !=3D -EPIPE)
> > +			hid_err(g15->hdev, "Error setting LED brightness: %d\n", ret);
> > +		/* -EPIPE is transient (USB stall), cache is unchanged, retry next t=
ime */
> > +		ret =3D 0;
> > +	}
> > +
> > +	mutex_unlock(&g15->mutex);
> > +
> > +	return ret;
> > +}
>=20
> Does returning 0 here break the LED class API contract when a hard error
> like -EIO or -ENODEV occurs?
>=20
> If we return success despite hardware failure, won't the internal softwar=
e
> cache update while the physical hardware remains unchanged, leading to a
> permanent desynchronization between sysfs and the device?

Right, will fix.

>=20
> [ ... ]
>=20
> > @@ -890,6 +1136,71 @@ static int lg_g510_leds_event(struct lg_g15_data =
*g15, u8 *data)
> > =C2=A0	return 0;
> > =C2=A0}
> > =C2=A0
> > +static int lg_g710_event(struct lg_g15_data *g15, u8 *data, int size)
> > +{
>=20
> [ ... ]
>=20
> > +	/*
> > +	 * Detect brightness key presses and schedule the work function
> > +	 * to cycle cached brightness and notify userspace.
> > +	 * Bit 10 =3D WASD backlight (maps to LG_G15_LCD_BRIGHTNESS slot).
> > +	 * Bit 11 =3D Kbd backlight (maps to LG_G15_KBD_BRIGHTNESS slot).
> > +	 */
> > +	if (pressed_keys & BIT(10)) {
> > +		set_bit(LG_G15_LCD_BRIGHTNESS, &g15->brightness_changed);
> > +		schedule_work(&g15->work);
> > +	}
> > +	if (pressed_keys & BIT(11)) {
> > +		set_bit(LG_G15_KBD_BRIGHTNESS, &g15->brightness_changed);
> > +		schedule_work(&g15->work);
> > +	}
> > +
> > +	/* Game mode toggle =E2=80=94 bit 12 is a state bit, trigger on any c=
hange */
> > +	if (pressed_keys & BIT(12)) {
> > +		set_bit(LG_G15_GAMEMODE, &g15->brightness_changed);
> > +		schedule_work(&g15->work);
> > +	}
>=20
> Could these bitwise checks cause continuous triggering on every HID repor=
t
> received?
>=20
> Since the game mode toggle check evaluates the absolute state, if game mo=
de
> is enabled (for instance, while holding a macro key), won't this continuo=
usly
> schedule the workqueue, spam the USB bus with synchronous get-report requ=
ests,
> and flood userspace with duplicate notifications?
>=20
> Also, since the condition evaluates to false when game mode is disabled, =
will
> userspace ever be notified of the disabled state?
>=20
> Similarly for the brightness buttons, does checking the absolute state me=
an
> that holding the button down will rapidly decrement the software brightne=
ss
> cache and permanently desynchronize it from the physical hardware?
>=20
> Should the driver track previous states and trigger actions only on edge
> transitions instead?

Right again, will add edge detection.

> [ ... ]
>=20
> > @@ -1212,6 +1562,13 @@ static int lg_g15_probe(struct hid_device *hdev,=
 const struct hid_device_id *id)
> > =C2=A0	case LG_Z10:
> > =C2=A0		connect_mask =3D HID_CONNECT_HIDRAW;
> > =C2=A0		break;
> > +	case LG_G710:
> > +		INIT_WORK(&g15->work, lg_g710_leds_changed_work);
> > +		hdev->quirks |=3D HID_QUIRK_NOGET;
> > +		connect_mask =3D HID_CONNECT_DEFAULT;
> > +		gkeys_settings_feature_report =3D LG_G710_FEATURE_EXTRA_KEYS;
> > +		gkeys =3D 6;
> > +		break;
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	ret =3D hid_hw_start(hdev, connect_mask);
>=20
> This isn't a bug introduced exclusively by this patch, but does the lack =
of a
> remove callback or devres action to cancel the scheduled work risk a
> use-after-free?
>=20
> The driver allocates the context structure using devm_kzalloc and initial=
izes
> the work struct, but nothing calls cancel_work_sync on shutdown. If the w=
ork
> is pending or running on the system workqueue when devm frees the memory,
> won't it dereference freed memory?

Sure, but it probably ought to be changed in a separate patch, if ever.

> [ ... ]
>=20
> > @@ -1234,11 +1591,13 @@ static int lg_g15_probe(struct hid_device *hdev=
, const struct hid_device_id *id)
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	if (gkeys_settings_feature_report) {
> > +		int report_size =3D (g15->model =3D=3D LG_G710) ? gkeys * 2 : gkeys;
> > =C2=A0
> > =C2=A0		g15->transfer_buf[0] =3D gkeys_settings_feature_report;
> > -		memset(g15->transfer_buf + 1, 0, gkeys);
> > +		memset(g15->transfer_buf + 1, 0, report_size);
> > =C2=A0		ret =3D hid_hw_raw_request(g15->hdev,
> > =C2=A0				gkeys_settings_feature_report,
> > -				g15->transfer_buf, gkeys + 1,
> > +				g15->transfer_buf, report_size + 1,
> > =C2=A0				HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> > =C2=A0	}
>=20
> This isn't a new bug, but since this lockless access to the transfer buff=
er
> occurs right after hid_hw_start, could an incoming HID report concurrentl=
y
> schedule the work queue?
>=20
> The asynchronous worker safely locks the mutex before mutating the exact =
same
> transfer buffer. Does this allow the workqueue to overwrite the buffer wh=
ile
> the probe function is actively using it, resulting in malformed requests?

Same. I'll defer to Hans for better judgement.

> [ ... ]
>=20
> > @@ -1327,12 +1686,18 @@ static int lg_g15_probe(struct hid_device *hdev=
, const struct hid_device_id *id)
> > =C2=A0		goto error_hw_stop;
> > =C2=A0
> > =C2=A0	/* Register LED devices */
> > -	for (i =3D 0; i < LG_G15_LED_MAX; i++) {
> > +	for (i =3D 0; i <=3D LG_G15_MACRO_RECORD; i++) {
> > =C2=A0		ret =3D lg_g15_register_led(g15, i, led_names[i]);
> > =C2=A0		if (ret)
> > =C2=A0			goto error_hw_stop;
> > =C2=A0	}
> > =C2=A0
> > +	if (g15->model =3D=3D LG_G710) {
> > +		ret =3D lg_g15_register_led(g15, LG_G15_GAMEMODE, "g15::gamemode");
> > +		if (ret)
> > +			goto error_hw_stop;
> > +	}
>=20
> Because hid_hw_start is called earlier in the probe sequence, is it possi=
ble
> for a hardware event to trigger lg_g710_event before these LEDs are actua=
lly
> registered?
>=20
> If the worker thread runs and invokes the brightness hardware changed
> notification on zero-initialized, unregistered LED devices, won't the
> internal sysfs nodes be NULL, triggering a stack trace warning in the LED
> core?

Same again.

Hans, I'll fix the 2 issues I introduced (brightness/game-mode edge
detection and error filtering). What about the pre-existing errors
reported by sashiko ?
