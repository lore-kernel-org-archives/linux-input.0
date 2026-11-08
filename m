Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794123524;
	b=aFFOCV4qvZ/eoBpDlEo41qii0mjx0GEcJfax3EYMEm71ElQU306Asc/VJfFGtSQ4gCTX
	 RznSWBC8pgGsB2d1K7Dn3OH+MkMUzct7cru7DnCuGojB5wRd4Yny1cqM9L2XvwWP9r6UC
	 +ThH5T7f9Q37ESA4gnNW/luPAZDGhNSJwovRqYY/3MCGrdA2fBQD6h1FBFGG/sFTOvu12
	 kOrL0x+XiipshWPXF0xSKp3rSDAs+chK7hnRPov/iciROcQuzwTbvPf+OnGDqxFbRB79+
	 R2LlVwCJ5ywHbqiGvDJnwCTvBEO93tybDU/JQNbE2Vf9byKjTTAMh3vgAdTxTdmQFuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794123524;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+sgABAbDy7akS78j5zySMSWOzUiLhl6H8EU1TaCCbvg=;
	b=U25DK5T3j/X20cyUSqRGi81TZRgtdpKuoaVv3w+73KN2Gy2l5VECCdSOVF3oJARSeGqS
	 ZoMdZ2+ozLzOuN1GDQ2gVkDEeDrGFfI+k0V7svcQv1Vbx0YecwKW5pn/41EWK1Kp4DKFf
	 LBEI/5Khrqa0PDb3rJkrC06PaazPH3F85h0AmB8v7FDOzL9dDIrCQDiMUuUXazPJCcUsL
	 nvEJoW57Ih2CfESKMoPoFHwQWtHL8oitE+GqgVHlBwXqfzn1EviYmx1ZOyFg6K7sLfZ5o
	 id9qGK5GJ3W6PKW9w+iUIqt+8Sa6Vp4jNIzTTm8AjfYR4weFEQrONrtq2xwIDVTye7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1cRqKH5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1887606A31C;
	Sun,  8 Nov 2026 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F1cRqKH5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0AE1F0089F;
	Sun,  8 Nov 2026 07:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794123523;
	bh=+sgABAbDy7akS78j5zySMSWOzUiLhl6H8EU1TaCCbvg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F1cRqKH5L2H3hNtDDe6AiNDxb0NnFxh4RKvDbfsO3SIYfebe83iOEv2vbEY4KBLlP
	 /iVHlq6LR/uqn7lRaqP0juVzmAw95CLYaX/Le96dIOxkQ3rCmIwRrNJeuNaVPyxhbc
	 dpBYuwGV3ZPk5nvZb7wXmYdQpGETEemJaytdYOrfsCgb35gAt3qIu0CLUirvRyxrMJ
	 vswK4gbiaXvtNR29W+alxe7UNodRvaQzMQIpaW0vdM8VRBJgFynnDLjOShJWkXD06G
	 4UohYMBRhNinuF4q1gaG5T6nznJ6rjaozO4YCLr2dhrSTwOvSG5Pq/9iE9uGVK4axs
	 jwI2lmmWJGzKA==
Message-ID: <sashiko-outbox-203630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/8] HID: apple: Add support for DockChannel HID
 keyboards
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Reeves" <michael.reeves077@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261108-b4-apple-mtp-keyboard-v5-5-e2c97b82669a@gmail.com>
References: <20261108-b4-apple-mtp-keyboard-v5-0-e2c97b82669a@gmail.com>
 <20261108-b4-apple-mtp-keyboard-v5-5-e2c97b82669a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 07:38:42 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] HID: apple: redundant apple_match() duplicates
  hid_check_device_match()
--

commit 9add0dddf8a7b243671bc6303c493d3097cdd737
Author: Michael Reeves <michael.reeves077@gmail.com>

HID: apple: Add support for DockChannel HID keyboards

This commit adds HID_GROUP_APPLE_DOCKCHANNEL and matches host-bus Apple
DockChannel keyboards in hid-apple using the modern Magic Keyboard
function-key translation table.

> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> index 5b32fb8c77f3f..d0059a3c0ac7e 100644
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c

[ ... ]

> @@ -1025,6 +1035,18 @@ static void apple_remove(struct hid_device *hdev)
>  	hid_hw_stop(hdev);
>  }
> =20
> +static bool apple_match(struct hid_device *hdev, bool ignore_special_dri=
ver)
> +{
> +	if (ignore_special_driver ||
> +	    (hdev->quirks & HID_QUIRK_IGNORE_SPECIAL_DRIVER))
> +		return false;
> +
> +	if (hdev->group =3D=3D HID_GROUP_APPLE_DOCKCHANNEL)
> +		return apple_is_dockchannel_keyboard(hdev);
> +
> +	return true;
> +}
> +
>  static const struct hid_device_id apple_devices[] =3D {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE),
>  		.driver_data =3D APPLE_MIGHTYMOUSE | APPLE_INVERT_HWHEEL },
> @@ -1250,6 +1272,9 @@ static const struct hid_device_id apple_devices[] =
=3D {
>  		.driver_data =3D APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_TOUCHBAR_BACK=
LIGHT),
>  		.driver_data =3D APPLE_MAGIC_BACKLIGHT },
> +	{ HID_DEVICE(BUS_HOST, HID_GROUP_APPLE_DOCKCHANNEL,
> +		     HID_ANY_ID, HID_ANY_ID),
> +		.driver_data =3D APPLE_HAS_FN | APPLE_ISO_TILDE_QUIRK },
> =20
>  	{ }
>  };
> @@ -1258,6 +1283,7 @@ MODULE_DEVICE_TABLE(hid, apple_devices);
>  static struct hid_driver apple_driver =3D {
>  	.name =3D "apple",
>  	.id_table =3D apple_devices,
> +	.match =3D apple_match,

[Severity: Low]
Is apple_match() needed here?

hid_check_device_match() first matches against apple_devices[], where the
HID_DEVICE(BUS_HOST, HID_GROUP_APPLE_DOCKCHANNEL, ...) entry already
requires hdev->bus =3D=3D BUS_HOST and hdev->group =3D=3D
HID_GROUP_APPLE_DOCKCHANNEL.  When hdrv->match is NULL,
hid_check_device_match() also enforces !hid_ignore_special_drivers and
!(hdev->quirks & HID_QUIRK_IGNORE_SPECIAL_DRIVER) itself:

drivers/hid/hid-core.c:hid_check_device_match() {
	*id =3D hid_match_device(hdev, hdrv);
	if (!*id)
		return false;

	if (hdrv->match)
		return hdrv->match(hdev, hid_ignore_special_drivers);

	/*
	 * hid-generic implements .match(), so we must be dealing with a
	 * different HID driver here, and can simply check if
	 * hid_ignore_special_drivers or HID_QUIRK_IGNORE_SPECIAL_DRIVER
	 * are set or not.
	 */
	return !hid_ignore_special_drivers && !(hdev->quirks & HID_QUIRK_IGNORE_SP=
ECIAL_DRIVER);
}

Setting .match on apple_driver duplicates those checks and causes
__hid_bus_driver_added() to run __hid_bus_reprobe_drivers() across all HID
devices whenever any HID driver is registered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-b4-apple-m=
tp-keyboard-v5-0-e2c97b82669a@gmail.com?part=3D5
