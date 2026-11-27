Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795799331;
	b=Drfs/vOFulpthJjeEHAFpAni1ZWeo6QiRA7VYpAailhrOwoXRrd1qP5l/gLcDPPcpLAm
	 hWcDBpCgyeJ3o82lhl1x9j6WUPwG6hE3Rh2evqbzeXdP08hvPL6RnMDfjz+z0NDPie6a4
	 ThHy0HHTnVKSIj7WN7SY+af1I/WOzBkgOCcT2MFLaM6KNOIrijzgAB/vFC247K80e/zHg
	 p+9F1SW4/Qkon5A6RnpBwgGfA0I+mnnKInrQzeq+RxxgbbCzXYhYypmzHdUcH7IHjB0Fw
	 Zox/yoX9gmeh1nRTtDSfsf5IpaxKP4RTSdUKeNrooffa7sL4YKjlX8P4KW+oh7t45Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795799331;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h7Abw7yBWrDnHRc0VUiEOI/VwtJBcFj+u/vumbT+qkA=;
	b=kVqfE3Luz/o/ufFbenAdDXKV8HfdEdZBdxl/uoJSATWdsfpWL6Jg7bk+szLPOmhwCPKn
	 Z2LShWlMnJuT3zJHKRXD54BptQEkVW9Sh1lMnlsPm11jDk7DVvQv3IOOjo+S+8QmQTZp2
	 Andi655qgK8AkCNSTvCtresa8Vo3Xgv7wxTF8+NKNkVReDNAsl4QiwZlDi56nr/MpBEYl
	 /06B/EpVLIFVw8k94fVcLp+2HTcFyJjTyGUYLU+t46NrdptZRM2SW+PiND/Bcsrb+I03v
	 0nLEeI//d16Ak0HDHtvxGPR4EhquzQ9aGDQv/GPS1A8LE9zSwOnBs3T9lbZYakzyT3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAWxZ+6d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0857A606A31F
	for <linux-input@vger.kernel.org>; Fri, 27 Nov 2026 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAWxZ+6d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB601F00899;
	Fri, 27 Nov 2026 17:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795799330;
	bh=h7Abw7yBWrDnHRc0VUiEOI/VwtJBcFj+u/vumbT+qkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UAWxZ+6dj3qrirl8m5El31q76ehVpVDoz35d2pWwvL6x3+0ijpM1+9a+sIKi4C+c3
	 Vjh1yD3U+uFPV10saOMGA6bwQeICb8w8KNU17aCIWjqSYG7GDM09t4W15W6lEICuFc
	 zGAlOx0wGBb9dcwnfwa7qsCWAJv6D39jQ1K3IlzRha0FRH+gjrMsM6YCf/kc8ONO6k
	 7X/T38BT7bUn0t/zJ6ga4blTAhceUulfsCqHnaYPw0WYGakh00JxCyHgbUgRHFn1UJ
	 xnv27vEekVN8801sQvJOD453tSbC5qlsSGKHfQNgN3uHqYNMyTceLbcMlH/7PvCvdD
	 YVk0Kd41a4buw==
Message-ID: <sashiko-outbox-237964@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: asus: add support for the ASUS Zenbook A14
 (UX3407QA) keyboard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marcelo Niendicker Grando" <marcelogrando@icloud.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261127164052.59518-1-marcelogrando@icloud.com>
References: <20261127164052.59518-1-marcelogrando@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 17:08:48 +0000
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
- [Medium] HID: asus: missing I2C_KEYBOARD_QUIRKS for Zenbook A14 I2C
  keyboard
--

commit ddfdb63c8208f8d574ebd38f9f5c9b3f01175e08
Author: Marcelo Niendicker Grando <marcelogrando@icloud.com>

HID: asus: add support for the ASUS Zenbook A14 (UX3407QA) keyboard

This commit binds the ASUS Zenbook A14 UX3407QA internal I2C keyboard
(0B05:0220) to hid-asus so its vendor report 0x5a Fn hotkeys are mapped.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index dcb3d50f9288e..8a8fa9fb588b1 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1907,6 +1907,8 @@ static const struct hid_device_id asus_devices[] =
=3D {
>  	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
>  		USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_KEYBOARD),
>  	  I2C_KEYBOARD_QUIRKS | QUIRK_FILTER_CAMERA_COMPANION },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
> +		USB_DEVICE_ID_ASUSTEK_I2C_ZENBOOK_A14_KEYBOARD) },

[Severity: Medium]
Should this entry set I2C_KEYBOARD_QUIRKS like the other ASUS I2C notebook
keyboards?

In the device's 132-byte report descriptor, Report ID 2 declares Logical
Maximum 0x65 at rdesc[55] alongside Usage Maximum 0xdd, and Report ID 3
declares a Consumer Control array spanning usages 0x0000..0x023c.

Without QUIRK_FIX_NOTEBOOK_REPORT from I2C_KEYBOARD_QUIRKS,
asus_report_fixup() leaves rdesc[55] at 0x65, so hid-core rejects all
Keyboard/Keypad usages above 0x65.  Without QUIRK_NO_CONSUMER_USAGES,
asus_input_mapping() maps dummy Consumer usages from Report ID 3 (including
BTN_MISC, ABS_VOLUME and REL_HWHEEL) onto the merged keyboard input device,
causing userspace to classify the keyboard as a pointer device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127164052.5951=
8-1-marcelogrando@icloud.com?part=3D1
