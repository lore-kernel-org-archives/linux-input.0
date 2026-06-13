Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0054328B61
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781365552; cv=none; b=YJ1LVrGC9y539JHoA8NB0DGdqZJjue/08dWHtuIwztp7dTNpb2lfU+N0aQqYy9f9ZYMu2uLxs02NOTJz0wJSKYl4Bx2hz3dt+I4axzXq1OyV2GIEul3N/X9usxZRI22rG+a0k/N2zvHN4/w/wU6M0wBHNAA4WNRntVDWEDw7lM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781365552; c=relaxed/simple;
	bh=ph8N/QWNhyYPJfkBWINHglSgZBBAunmknV3y4Kx3GrI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RtUJTUeIVPdGxJsCCZ8tc3y9SaXJqQm16PC4gzIJW+StFSeS5Apbjbwa591Fuk2uxlWtVNb8A0QAx+rVl1gZrvnz9P1MCgg3zqx+iSpeCMMX0hjZnnBuxWxhshbeNILjJQAGCZGyVTvTb7RbnXeSAylby4E5qlXC5n37/tYw52Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jd2M1Dd1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jd2M1Dd1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C3D1F000E9;
	Sat, 13 Jun 2026 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781365551;
	bh=M72FQvby9ibKoiKTE1K1lLRTkwcqYH8oZTc8KvW3360=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jd2M1Dd1nL9/ZmOPo3m1kzSTbCXlV3lOr6GuWMbj4NtTGMhlbBxlg9XWoOW0im9/J
	 zmRJ0k6MRMMzt5+SEXq7Xq+jL/slOGOT6T1mXndMMSg8OkDzhJDXHY8mbisIZYtMM0
	 HSX9sEuT+JxfpoWmmhZspyXbuuMoKLcsOSIzkMEgnDlRq9CK+anFPSRbW+WwX0cOfK
	 M+rBRczdvCHgnX1q4gdVadBASGY2/R2u4vBrHtQtKrH9SnNFpDmYqff+4mzZfO6xby
	 U8it89hdce9TEqh0/+aDmiAQJIkJZTVyi2eZUH/7qcUgfaKCCTPNPfmgCSUVN4Gdg9
	 rNP1gLKxc+Pbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/8] HID: asus: add i2c entry for FA808UM and other
 TUFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260613153029.2559774-8-denis.benato@linux.dev>
References: <20260613153029.2559774-8-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jun 2026 15:45:50 +0000
Message-Id: <20260613154551.13C3D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] NULL pointer dereference or UAF in asus_e1239t_event when handling=
 a Medion E1239T device with no input usages
--

commit f6d872852d0965599a5f0e0ef39dc3d4ec54c196
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add i2c entry for FA808UM and other TUFs

On newer TUF laptops the keyboard HID device uses the same PID/VID of a USB
device that was found in ROG laptops. This patch adds the device to hid-asus
as an I2C device to enable support.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index c1a247348c3d9..639d42708b5fc 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1640,6 +1640,9 @@ static const struct hid_device_id asus_devices[] =
=3D {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
>  	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK=
 },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
> +	    USB_DEVICE_ID_ASUSTEK_ROG_NKEY_KEYBOARD2),
> +	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD | QUIRK_HID_FN_LOCK=
 },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  	    USB_DEVICE_ID_ASUSTEK_ROG_Z13_LIGHTBAR),
>  	  QUIRK_USE_KBD_BACKLIGHT | QUIRK_ROG_NKEY_KEYBOARD },

[ ... ]

[Severity: High]
This is a pre-existing issue, but could asus_e1239t_event() trigger a NULL
pointer dereference or use-after-free when handling a Medion E1239T device
with no input usages?

If a malicious Medion E1239T device provides a HID descriptor with no
recognized input usages, asus_input_configured() is not called, or the input
is freed by the core. This leaves drvdata->input NULL or dangling.

However, hid_hw_start() will still succeed by claiming the device as a hidr=
aw
device. When a raw event (such as a mute key press) is received,
asus_raw_event() routes it to asus_e1239t_event().

This function unconditionally dereferences the input pointer:

drivers/hid/hid-asus.c:asus_e1239t_event() {
    ...
    input_report_key(drvdat->input, KEY_MUTE, 1);
    ...
}

Is it possible for this raw event routing to dereference drvdata->input
without validating if it is non-NULL or if the input was properly claimed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613153029.2559=
774-1-denis.benato@linux.dev?part=3D7
