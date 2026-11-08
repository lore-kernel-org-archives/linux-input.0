Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794137043;
	b=ZxN2JQ718VRPevf8CjNYspZVUbuJh9cTl6EUBHVhiJhZJhY2XvqovrcotgqLa+xqWM33
	 2KI/gfPzz2mf3VhS9YuhNCjwDXxsHun74kGzVh4618FcfWdHZ3XOXnOzttnuKNshuewJW
	 YB3yJ2meK+TKhfMVU4La4uL7tZaPIcFp9p+1izAxsgA8nSOOTh5CBumHc589Oe+L1MaIq
	 TznWzrWvqbDyXsYQDbxcUufoBq+PPLC/siSuhpQfkrjxaZMLT7ierd2UZEOvae5ZnWgc+
	 l+4d1tisKx1gy5ixlq+ML3QNnFZvjV2u+CQghIa4FApInXw5o4LOzq5djx6mLZaInmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794137043;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qnB57uX7smHWhcExk/rez1Kc/uiMOIn8ZV8FWDOsUCE=;
	b=fGZm9Bv8fd7zBF3dG2NOgGglqMApm/p5N1N+/wAHfCeIUom/poOCMuTDmNrWNclPtv7s
	 vLqsstbkzMFNoPYC0g6xqAoZOOqvxT7fX2O0KTUZRoIvZ/S2VA/zu325qSZWNoM+9TLm8
	 wRVtk9wbBTQzrASej9CBygRbF63zotiU+XbMghY8/nLyTUtqotjW/enB8NnUZMhp3UpSD
	 oVR4hBXUhSHgA025FV//J6d8HR8TRPleKqj3WIgqGCFZGhOA2bIsBVunZcAl34V+OA+/U
	 9QVTHrdGHI941XMIQCsHRnK0UwquT0Nj72oUEoGrjsuG2Qe/JXZmDu+GpS2t46rpfsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GUGRAVkT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B1B606A31C
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 11:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GUGRAVkT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F661F0089F;
	Sun,  8 Nov 2026 11:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794137042;
	bh=qnB57uX7smHWhcExk/rez1Kc/uiMOIn8ZV8FWDOsUCE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GUGRAVkTVRytP7K6evQKz73rYT/D5sHR2GxjYZWnAQ/LLWxpBu1L99aTuK1L/wv4m
	 +/Q9Tf5HLRzjWMxVsbBShpNZen6ZHXUDdIhJyiFBezhsyYJGBtY4BXGMDQtsATzuYQ
	 MFML2VQ0mKIa4bOMzaQ2o/SLXNgzgVIWgtA1vs2a2B0D334wD8BeULA3gedcKZS9u/
	 evjCiAkizMm/nrDhKFNlPRifu4x857juam7fAx1WSGJ0hiu7wtMxHRduhEjPB+zhTY
	 7EJNLkBR8CyfYC9Y6UK2oNlATeWbkukuHToev1wdy+UVlem2DeuH9IGjZxtBp5BIcP
	 jgOJZLIWpjpxg==
Message-ID: <sashiko-outbox-203693@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: ayaneo-flip-kb: Add driver for keyboard backlight
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hijae Song" <hijae99@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261108110757.41368-1-hijae99@gmail.com>
References: <20261108110757.41368-1-hijae99@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 11:24:01 +0000
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
- [Low] HID: ayaneo-flip-kb: spurious error log in flip_kb_probe()
- [Low] HID: ayaneo-flip-kb: missing HID_CONNECT_DRIVER in
  flip_kb_probe()
--

commit 9c851b9f20ca56279eed558bac4b9d796257c299
Author: Hijae Song <hijae99@gmail.com>

HID: ayaneo-flip-kb: Add driver for keyboard backlight

This commit adds a HID driver exposing the RGB keyboard backlight of the
AYANEO Flip KB as a multicolor LED class device.

> diff --git a/drivers/hid/hid-ayaneo-flip-kb.c b/drivers/hid/hid-ayaneo-fl=
ip-kb.c
> new file mode 100644
> index 0000000000000..8068b7d44eae2
> --- /dev/null
> +++ b/drivers/hid/hid-ayaneo-flip-kb.c

[ ... ]

> +static int flip_kb_probe(struct hid_device *hdev, const struct hid_devic=
e_id *id)
> +{
> +	struct flip_kb *kb;
> +	int ret, i;
> +
> +	ret =3D hid_parse(hdev);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Both interfaces match this driver, which keeps hid-generic from
> +	 * binding to them, so the boot keyboard interface must be started
> +	 * normally and left alone.
> +	 */
> +	if (!hid_validate_values(hdev, HID_FEATURE_REPORT, FLIP_KB_REPORT_ID,
> +				 0, 1))
> +		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);

[Severity: Low]
Does calling hid_validate_values() here log a spurious error every time the
boot keyboard interface is probed?

hid_validate_values() logs hid_err(hid, "missing %s %u\n", ...) whenever the
requested report ID is absent, so probing the boot keyboard interface always
emits a false error message.  Also, if the vendor interface has a malformed
report 0x41 descriptor, hid_validate_values() returns NULL and causes
flip_kb_probe() to treat it as the boot keyboard interface instead of
failing probe.

> +
> +	kb =3D devm_kzalloc(&hdev->dev, sizeof(*kb), GFP_KERNEL);
> +	if (!kb)
> +		return -ENOMEM;
> +
> +	kb->hdev =3D hdev;
> +	hid_set_drvdata(hdev, kb);
> +
> +	kb->subled[0].color_index =3D LED_COLOR_ID_RED;
> +	kb->subled[1].color_index =3D LED_COLOR_ID_GREEN;
> +	kb->subled[2].color_index =3D LED_COLOR_ID_BLUE;
> +	for (i =3D 0; i < 3; i++)
> +		kb->subled[i].intensity =3D 255;
> +
> +	kb->mc_led.subled_info =3D kb->subled;
> +	kb->mc_led.num_colors =3D 3;
> +	kb->mc_led.led_cdev.name =3D "ayaneo:rgb:" LED_FUNCTION_KBD_BACKLIGHT;
> +	kb->mc_led.led_cdev.max_brightness =3D 255;
> +	/* Keep the backlight lit across driver unbind instead of blanking it. =
*/
> +	kb->mc_led.led_cdev.flags =3D LED_RETAIN_AT_SHUTDOWN;
> +	kb->mc_led.led_cdev.brightness_set_blocking =3D flip_kb_brightness_set;
> +
> +	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret)
> +		return ret;

[Severity: Low]
Will hid_hw_start() fail with -ENODEV on the backlight interface when both
CONFIG_HIDRAW and CONFIG_USB_HIDDEV are disabled?

Because the vendor-defined interface has no input application usages and
flip_kb_driver has no .raw_event callback, hid_connect() finds hdev->claimed
=3D=3D 0 when hidraw and hiddev are disabled and returns -ENODEV ("device h=
as no
listeners, quitting"), preventing the LED device from registering.  Passing
HID_CONNECT_DEFAULT | HID_CONNECT_DRIVER (or HID_CONNECT_DRIVER) marks the
interface claimed by the driver.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108110757.4136=
8-1-hijae99@gmail.com?part=3D1
