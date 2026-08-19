Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB77445AD5
	for <linux-input@vger.kernel.org>; Wed, 19 Aug 2026 09:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787133024; cv=none; b=Z/tIgenO8W02t1712dWFXmri4fZKhtHlvkE7H+dsLXCfNz+aH4Qjem5kiO9pPWqLSXnDP5ivwmGv52CFKLbiZmToFJV1J1Y9r4VJ0vp3niyxiziNGUrNz5eTfQZPOnlo8aG78yVj7M72VlDpAOZ3G2FbEo5Pv9DnJUYJTEBV48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787133024; c=relaxed/simple;
	bh=Z2ErqCszzgMWD2Dquuqv2p1JQdIkLJYJHl7iVXdj29M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q512skU5WjMuKJTCs8sUXcFQX1XshQUGOxhq1VItD0zTx9wvBj/yDqEy5xMWblyTvuQmutK1Ss9tRdA9ois2kkxKKIU7dy08rGpjpMdCSDFEh11nWkEvPy93Y1NhxTTeaw3/46hUu1JL0hLSXeUam+Y+jtoHATjux3xIMYTxxlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6rPm1mI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6rPm1mI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C7A1F000E9;
	Wed, 19 Aug 2026 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787133023;
	bh=PXgW+m+fc3mi90hp9Vk0f3NOwL9wOXUh2UPyaGhA6Ws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=g6rPm1mIF/EGpOHCRDxxxMuyJW17wm7/E3/dErT+ol5RA7lRu4eLQa1HYBd3srq6p
	 JGU/t/BNXkw82lEEIG4hYG4L+jxJKDSJKjA3W+RKy+WagNJNnnJocYfETUPMZFEK+Y
	 /6RQjaloSQDn90tRxC4bxEtgvlDhumirtZbaotmKUj+6cJgPLWkUFnbQBjQQ5JYp0N
	 Pzm64OlYTz0Ac6qYDM/z9onVa483m7norIWprSZ+pS4/yHbmyoaB7NRPz20J5UNaJ1
	 dKQTEYYtQKYYK5cdE+ND6xQ4IcKXnhdQjJozYIMs7z6nyG5Tq64uyTLfQru8h/AhJU
	 BoZi96rcF9h2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] HID: multitouch: add support for Goodix GXTP7863
 touchpad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruzal Daminov" <daminovruzal7@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260819093938.1387-1-daminovruzal7@gmail.com>
References: <20260814171247.16707-1-daminovruzal7@gmail.com>
 <20260819093938.1387-1-daminovruzal7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:50:22 +0000
Message-Id: <20260819095023.18C7A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using `MT_CLS_DEFAULT` instead of a Win8 PTP class disables critic=
al Windows 8 Precision Touchpad (PTP) quirks, causing severe regressions in=
 touchpad functionality (such as broken clickpad button tracking and stuck =
finger releases).
--

--- Patch [1]: [PATCH v3] HID: multitouch: add support for Goodix GXTP7863 =
touchpad ---
commit 04179c956954e748355b634f8668ad96cef6871c
Author: Ruzal Daminov <daminovruzal7@gmail.com>

HID: multitouch: add support for Goodix GXTP7863 touchpad

This commit adds the Goodix GXTP7863 touchpad controller to the mt_devices[]
table so it is claimed by hid-multitouch instead of hid-generic. It uses
MT_CLS_DEFAULT to prevent the vendor telemetry collection (0xFF01) from
being mapped to an input node.

> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c

[ ... ]

> @@ -2460,6 +2460,11 @@ static const struct hid_device_id mt_devices[] =3D=
 {
>  		MT_BT_DEVICE(USB_VENDOR_ID_FRUCTEL,
>  			USB_DEVICE_ID_GAMETEL_MT_MODE) },
> =20
> +	/* Goodix GXTP7863 Touchpad */
> +	{ .driver_data =3D MT_CLS_DEFAULT,
> +	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,
> +		     I2C_DEVICE_ID_GOODIX_01E0) },
> +

[Severity: High]
Does using MT_CLS_DEFAULT here disable necessary Windows 8 Precision
Touchpad quirks?

While it successfully prevents export_all_inputs from mapping the telemetry
node, MT_CLS_DEFAULT lacks quirks like MT_QUIRK_WIN8_PTP_BUTTONS and
MT_QUIRK_STICKY_FINGERS.

Without MT_QUIRK_WIN8_PTP_BUTTONS, will mt_sync_frame() fail to emit
BTN_LEFT events and break physical left-clicks?

Without MT_QUIRK_STICKY_FINGERS, will mt_touch_report() fail to arm the
release_timer, potentially leaving touches stuck if the firmware drops a
release report?

The file-level documentation in mt_devices mentions that there is no
point in adding a device with MT_CLS_DEFAULT. Is there a better way to
ignore the vendor telemetry collection without losing the PTP quirks?

>  	/* Goodix GT7868Q devices */
>  	{ .driver_data =3D MT_CLS_WIN_8_FORCE_MULTI_INPUT_NSMU,
>  	  HID_DEVICE(BUS_I2C, HID_GROUP_ANY, I2C_VENDOR_ID_GOODIX,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819093938.1387=
-1-daminovruzal7@gmail.com?part=3D1
