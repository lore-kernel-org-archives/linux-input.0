Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4771365A02
	for <linux-input@vger.kernel.org>; Fri,  9 Oct 2026 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560741; cv=none; b=IaxEqoiA8bj5RmUS9Na0EpvYRW+AkeOwaoUGV04jaNRAvwkXc5PRbZWMztgzIDgrc0gbP56VbBfrPB6U6Nyz7mfEj6fbPbS/xV6F8maxWti9D8pCbaUFfAJlZHwf7gDlGv4P/De9sNkx3R5V8j/27vJPm3DQoOBnR8PNXO2EFig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560741; c=relaxed/simple;
	bh=5op7WHvgHlI+cQ/ZFLMqkTjZRTc/RjApO5XMZ6CY3Lo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=m1HtFnmCUB5wFWRJKJiZexa2ZJtGsjAB2dJy6ZftuMUuhYLV2PjH4osHspg8z84jUT2X323z8IUYsXHoTJnUK1nbUwpNiL/f8HLyToqzBAgtY/CwcDfKclo+cAtOjSyquZJklRe9/RhG8OjA46ZvRAMNO3lT2oKRr3p/McvD+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOpkKcFV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOpkKcFV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7C11F000FF;
	Fri,  9 Oct 2026 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560740;
	bh=ybFkAmmKkhWS5ZbMoxKz9A7e5xuFCSlRYLHeRtNYwyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TOpkKcFV/qWNFVIu3vJTdqUn9SuNkvE/o6bxob2Vpqrn3XZ9fRVjR7FvFXvjhPRAT
	 277mOWCWLm5+1R1rcrB17/IiOwgn54uf6e/FuIJedqHsqq2hvYic5r7q5ZOIgKi4kg
	 rFhjg1U+KDo7DATp6nbEQIPN3TOT98bDPUqibdkAGnR5ahi7HmFzBsZTcbgiJFxGAu
	 KKlLSD3JiWmEeODU4imopHHlm1wqhGt30x6kt1HO0r68jsKHeDprqViDBCQ5XFLLDx
	 GxVmJbV107oOOlrUoUVbja7MTFcEuzFTePMKD1Pxdp07anK6fJuMcYjjESs4tymcRw
	 NSW0hVvYZW2Mg==
Message-ID: <sashiko-outbox-165793@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] HID: asus: add prod-id, quirk for Zenbook Duo
 keyboard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Pisati" <p.pisati@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261009153459.124752-7-p.pisati@gmail.com>
References: <20261009153459.124752-1-p.pisati@gmail.com>
 <20261009153459.124752-7-p.pisati@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 15:45:39 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: hid-asus hijacks Zenbook Duo touchpad over Bluetooth
--

commit 5e5f2becf13b4e6d6ecb2a2d14e80b4b0f934932
Author: Luke Jones <luke@ljones.dev>

HID: asus: add prod-id, quirk for Zenbook Duo keyboard

This commit adds USB and Bluetooth device IDs for the 2024/2025/2026 ASUS
Zenbook Duo detachable keyboards. It sets up initialization quirks and binds
the USB IDs strictly to HID_GROUP_GENERIC so the touchpad interface can be
handled by hid-multitouch.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -1834,6 +1834,29 @@ static const struct hid_device_id asus_devices[] =
=3D {
>  	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },
>  	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
>  		USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T101HA_KEYBOARD) },
> +	/*
> +	 * Zenbook Duo detachable keyboards. Bind the USB IDs to the
> +	 * HID_GROUP_GENERIC group only, like the ROG Z13 Folio, so that
> +	 * hid-multitouch keeps handling the touchpad interfaces.
> +	 */
> +	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
> +	    USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406MA_KEYBOARD),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK,
> +	    BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406MA_KEYBOARD),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },

[Severity: High]
The commit message notes the intent to restrict USB IDs to HID_GROUP_GENERI=
C,
so that hid-multitouch keeps handling the touchpad. Will using
HID_BLUETOOTH_DEVICE for the Bluetooth IDs cause hid-asus to unintentionally
hijack the touchpad over Bluetooth?

HID_BLUETOOTH_DEVICE sets .group to HID_GROUP_ANY (0). Because
hid_match_one_id() treats HID_GROUP_ANY as a wildcard, hid-asus will match
and bind to all HID device nodes that share this Vendor and Product ID,
including the HID_GROUP_MULTITOUCH_WIN_8 node.

Should these Bluetooth IDs (for UX8406MA, UX8406CA, and UX8407AA) explicitly
use HID_DEVICE with HID_GROUP_GENERIC to match the USB ID behavior and
prevent the multitouch driver from losing PTP capabilities?

> +	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
> +	    USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406CA_KEYBOARD),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK,
> +	    BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8406CA_KEYBOARD),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
> +	{ HID_DEVICE(BUS_USB, HID_GROUP_GENERIC, USB_VENDOR_ID_ASUSTEK,
> +	    USB_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8407AA_KEYBOARD),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK,
> +	    BT_DEVICE_ID_ASUSTEK_ZENBOOK_DUO_UX8407AA_KEYBOARD),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ZENBOOK_DUO_KEYBOARD },
>  	{ }
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009153459.1247=
52-1-p.pisati@gmail.com?part=3D6
