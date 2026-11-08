Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794096373;
	b=M425de0MPCMYwC86egc+lnY76pK/KicQUsDs7B3ymOEh7MYIfJL0b3uScwaaMvDK8/bE
	 j0HNkLBr7iqpciRAlqtACKK4YHlqtIRACMR3LsfeUmTMp6T1vyS3YILODLX6k6btLJKOs
	 KmNkAHahB5mrY4zkmuQSVrjiADGm5Sqm2R0KML2VqFr6hWK5M/zk1bv9YeWLT4GkRWZs7
	 Ggzo/+n5Zx7wWhpFbDH94SJOxKHFhAHy6mvm3SVkuvqfeJPEZUic4iLCM7MtxbC4Q+mQR
	 pA1Eq/QiPhDGmesbS4od26KncNqRXjL578fKcNDMYRnvVXNRQfEiNgZiGj5iIeFTQ9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794096373;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wkq+o+mkue1kEdGjgGA6xzvph56O5rXIKMsRzYT7JkA=;
	b=C9b68IP9jMK5eR4gnRzS71fLYBLIjIW/a9Kw63iYXnbvK08iQZ7Dx9dowjUZafUKfgQE
	 R3NPeBwVOauCtkHubln7TyXRgCHIFsX2R+qJJU/7gcHTJTq7f6fhLb/a1NojOMbY2ymcz
	 1Tr6BJYh7U6kldyvgM2jNFU4Qg9ez7wPqFZ0admC8rNe7McLIVi8ONjtfSdMGKtq+s9d2
	 44zgazLmgFRgKiZhlmapp4LahsQPEe2Hj+S9eLXO2nKQW+pUA/e/9/oQZEtroleCdmYZ8
	 gVu9OlxyMT3KnAPQ96wCkr+prRf2FkHDwiF4z0xltq9xjysasoLKr0LmiVGtqaXLTaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7kP+X9E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F1606A326
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7kP+X9E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6338D1F008A1;
	Sun,  8 Nov 2026 00:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794096372;
	bh=wkq+o+mkue1kEdGjgGA6xzvph56O5rXIKMsRzYT7JkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D7kP+X9EzZUNR92lHd+yAUfwvQWKQAqdyRtRIDG7a8VGsDte/8P2s+ZopKg0uvirz
	 Xaagn491K80itEyGHjRyJl/hGWEF3VMiCPKXbo1iahOzzjHRQa6iHF/IGTujg8hsaR
	 PnhS4eXB7J8RtvbrHH2uwEIB+zm8Hn32ooZv77z1Ed5heS+LVeuMeASDHVCLfCKFpg
	 yBpdDZFT3kcXK8fbmm6ltgf1aFNXFGINeZ+Vot+Nw24pNhGma1E9QjNn6OfiMr+87u
	 8VtTpAybqoEUi96CLueouw6CYZvqEGO/9gnajQ0w6a4kxhSYupxthiRmgYQdRxLzd5
	 7m1dCQmss5dOg==
Message-ID: <sashiko-outbox-203404@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: santroller: add driver for Santroller
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sanjay Govind" <sanjay.govind9@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261107234444.960207-2-sanjay.govind9@gmail.com>
References: <20261107234444.960207-2-sanjay.govind9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 00:06:11 +0000
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
- [Medium] HID: santroller: stale brightness read in
  santroller_player_led_set()
- [Low] HID: santroller: USB profile naming compiled out when USB_HID=3Dm
  and HID_SANTROLLER=3Dy
--

commit 28369893e9b4de37e159a34ce2a7a1ca4302cd7d
Author: Sanjay Govind <sanjay.govind9@gmail.com>

HID: santroller: add driver for Santroller controllers

This commit adds a HID driver for Santroller USB and Bluetooth game
controllers and instruments, supporting profile naming, rumble, player
LEDs, RGB indicator LEDs, and turntable euphoria LEDs.

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
Should this also depend on USB_HID || !USB_HID?  When CONFIG_HID_SANTROLLER=
=3Dy
and CONFIG_USB_HID=3Dm, IS_REACHABLE(CONFIG_USB_HID) in
santroller_profile_name() evaluates to false and silently compiles out USB
profile naming even though USB HID support is enabled.

> diff --git a/drivers/hid/hid-santroller.c b/drivers/hid/hid-santroller.c
> new file mode 100644
> index 0000000000000..7dcc5d7eae604
> --- /dev/null
> +++ b/drivers/hid/hid-santroller.c

[ ... ]

> +static void santroller_player_led_set(struct led_classdev *led,
> +				      enum led_brightness value)
> +{
> +	struct hid_device *hdev =3D to_hid_device(led->dev->parent);
> +	struct santroller *sc =3D hid_get_drvdata(hdev);
> +	int i;
> +
> +	guard(spinlock_irqsave)(&sc->lock);
> +
> +	sc->player =3D SANTROLLER_PLAYER_LED_OFF;
> +	for (i =3D 0; i < SANTROLLER_NUM_PLAYER_LEDS; i++) {
> +		if (sc->player_leds[i].brightness) {
> +			sc->player =3D i;
> +			break;
> +		}
> +	}
> +	sc->player_dirty =3D true;
> +	santroller_schedule_output(sc);
> +}

[Severity: Medium]
Can santroller_player_led_set() send a stale player LED state by ignoring
value and reading sc->player_leds[i].brightness?

When software blinking (such as the timer trigger) is stopped while the LED
is in its ON phase, led_set_brightness(led_cdev, LED_OFF) defers the update
to set_brightness_delayed() without clearing led_cdev->brightness:

drivers/leds/led-core.c:set_brightness_delayed() {
    ...
	if (test_and_clear_bit(LED_SET_BRIGHTNESS_OFF, &led_cdev->work_flags)) {
		set_brightness_delayed_set_brightness(led_cdev, LED_OFF);
    ...
}

set_brightness_delayed_set_brightness() calls __led_set_brightness(led_cdev,
LED_OFF) -> santroller_player_led_set(led_cdev, LED_OFF) while
led->brightness is still 1, leaving the hardware player LED lit.  Using
value for the entry matching led (or updating led->brightness =3D value und=
er
sc->lock before the loop) would keep the state in sync.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107234444.9602=
07-2-sanjay.govind9@gmail.com?part=3D1
