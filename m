Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500DA43F0B5
	for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784378203; cv=none; b=V6t0x72/zMvHegDzLWwt+TB4oKByNVA5DLYHoIKRbvKu+aVev8hHZKgP2wU4k/o17WrbXiLcj8LSfpPQzj02lZzEhtqZWT13F1PzFR1Wk78oIcxOnJ6Lv+AJK1FYhRixYoqqWs4g2K36yaUmDoPj2kaMaGZrxLcYoF3CAzVEuHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784378203; c=relaxed/simple;
	bh=uQrUkcbPBDyAfw307ZX3Rdd5PkgtVZKmSBZKW175ENM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i2N0b808uVdkEJJ5/6eUWij03iVf0NTfULTOzUHKH9Dd7SXMCi/x1r51P4n38xsaHx0TxsJSHGnOLsfSjISRBO85OOLbvmgAMmsRWCMvlyryTbZ7GuKdCbWfIqcdRCUo19nQYYzrszJvTU84MXIAkca4urUl2vf32QnrgLlP3SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJJXzOYv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJJXzOYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2FF1F000E9;
	Sat, 18 Jul 2026 12:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784378202;
	bh=jTIwi1osc5LW+fdtYKRakK4+ZRSBFgIXpk4WLOOsx5Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fJJXzOYvZkj3tOp/nSxjkiuRmRd0dnxajTFIGK+Q6Dw3596+1oE60KiJC5PEQkx5s
	 nZCfcrpSpmNRFz/W/8w95ctXJhsc45nJ0J0AfUtVCVulZusFkt8XjO77JyTQhHxC+y
	 F+T2wVL/uTlm0rnQDjzr7AvIiq83YlskTh0WOHQ/P3pXco7LW/Pn08TrfJMnLdfQ71
	 LlEecxrGf1DM+Om2w/HttkcxIa1bJyJa1wMFKX6XaU2Sp/KS8wj9uBLr1pBXtsD4IS
	 gVI6x7OhhKfM96dlMGHzrFkdkEXSRRGongxoHr6JvzvjrmsUeENQ4rPrIh7pQQTrUL
	 k838VsC0D/TgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] HID: apple: use the standard keyboard backlight LED
 name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andre Eikmeyer" <dev@deq.rocks>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260718121527.15924-2-dev@deq.rocks>
References: <20260718121527.15924-1-dev@deq.rocks>
 <20260718121527.15924-2-dev@deq.rocks>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 12:36:41 +0000
Message-Id: <20260718123641.DA2FF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing endianness conversion for USB HID report u16 fields.
--

--- Patch [2]: [PATCH 2/2] HID: apple: use the standard keyboard backlight =
LED name ---
commit fe5b7459cd5f35bce672b51255250e2d12f88cf4
Author: Andre Eikmeyer <dev@deq.rocks>

HID: apple: use the standard keyboard backlight LED name

This commit changes the exposed LED name for the T2-attached butterfly
keyboard backlight from apple::kbd_backlight to the standard
:white:kbd_backlight naming convention. This allows userspace to discover
and handle both the butterfly models and the Magic Keyboards using the same
name without special casing.

> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c
> @@ -860,8 +860,8 @@ static int apple_backlight_init(struct hid_device *hd=
ev)
>  	}
> =20
>  	asc->backlight->hdev =3D hdev;
> -	asc->backlight->cdev.name =3D "apple::kbd_backlight";
> +	asc->backlight->cdev.name =3D ":white:" LED_FUNCTION_KBD_BACKLIGHT;
>  	asc->backlight->cdev.max_brightness =3D rep->backlight_on_max;

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but does
this code lack endianness conversion for the USB HID report fields?

According to the USB HID standard, multi-byte fields are little-endian.
Since rep->backlight_on_max is a u16 read directly from the raw device
report in apple_backlight_init(), could this result in byte-swapped values
on big-endian architectures and cause an out-of-bounds max_brightness?

A similar issue seems to be present in apple_backlight_set() where native
u16 values for rep->backlight and rep->rate are written into the report
struct without CPU to little-endian conversion before transmission.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718121527.1592=
4-1-dev@deq.rocks?part=3D2
