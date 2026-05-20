Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BDD3DC4A7
	for <linux-input@vger.kernel.org>; Wed, 20 May 2026 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779279872; cv=none; b=CcKnr9Kk9NJ3yPIb3Kb9sDwXpUGYhAVyAl26rKyX382aVmukAFHCiQJEkO6yKNWW9QT1ywq+ZWQiLf9r6I0JG7wkFYRB1M6VQnLctk0rEJe3LRmNdnck2c9eh+WaMmn5T3H6rEbvfyhE9PLerf76pJrb1dU4YhPOoG5s4CFQJho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779279872; c=relaxed/simple;
	bh=IYqaVtZdmlAhfNkXyuD+5GiqugKhQ4NuFuvy6bljtc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=neheM/ZzfgWboZRoa7h01CnxFdRiuO8o1AsK1KvznhfkxR3Nvg7KneuVivXR1X1jwqZjfSoiuyxsEF/98NBZu4yiNorAEZqcu+byHxM4eouhO+EgzJVdEMWQ6TmNJuy1efEK7w/bJiRb1Hvqof/JFYBG0aNuhnSqzM5Iqmtky4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oG4jH9mr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oG4jH9mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E901F000E9;
	Wed, 20 May 2026 12:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779279870;
	bh=+Ef6P9iv2N9MsMnY6tT2osxs+3eSGJA2PqXVcz53OQ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oG4jH9mrRoX0bUH9Jm4yF/X594BvuUO0s+5Yoq/gBjAGjXCXDNBwiZrN5UanI4zp1
	 C5cWPbv99Xq+ob/V1YhCrOohnKO+/h/+W2cyDEkbx1gdBttoJjdA2oVlpc3xhY4Lbv
	 UU4ZWxRJ0X0fwUUt73Rxkjywk+q3UVoFgoswgzJcRN/H6mZxmfYbEm+7mwKD5rAsgd
	 LQKpeHHJdM79ppe0Q/NoVj2JCoTTEKmcgJsQiKeLGV6QRGJtuJSRPHxaffE4kX4jZ1
	 CDESWBVC93wbnO3tHQ4wF68Y9OIX6dxlBtOTeWpzpAYXX0geIWHC86zZfRkUKtSNgY
	 VAcmnU7yF9S4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 7.0-5.10] HID: elan: Add support for ELAN SB974D
 touchpad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260520111944.3424570-28-sashal@kernel.org>
References: <20260520111944.3424570-28-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 20 May 2026 12:24:30 +0000
Message-Id: <20260520122430.B5E901F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver fails to restore the device to multitouch mode after a =
system suspend/resume cycle.
- [High] In USB mode, if more than two fingers are active, the driver assig=
ns identical coordinates to all fingers after the first one.
--

commit d5ae02b47586e24db0bca9c6a7b552b9fc7ef6e4
Author: Damien Dejean <damiendejean@google.com>

HID: elan: Add support for ELAN SB974D touchpad

This commit adds support for the ELAN SB974D touchpad by registering its
device ID in the supported devices list so the driver can parse its
vendor-specific formats.

> diff --git a/drivers/hid/hid-elan.c b/drivers/hid/hid-elan.c
> index 76d93fc48f6a2..0190ad567ce4d 100644
> --- a/drivers/hid/hid-elan.c
> +++ b/drivers/hid/hid-elan.c
> @@ -513,6 +513,7 @@ static const struct hid_device_id elan_devices[] =3D {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_HP_X2_10_COVER),
>  	  .driver_data =3D ELAN_HAS_LED },
>  	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_TOSHIBA_CLICK_L9W) },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, USB_DEVICE_ID_SB974D) },

[Severity: High]
This is a pre-existing issue, but does the driver fail to restore the device
to multitouch mode after a system suspend/resume cycle?

The ELAN touchpads require a vendor-specific initialization command
(elan_start_multitouch) to disable mouse emulation and enable multitouch
mode. This sequence is currently only executed during the initial elan_prob=
e.

The hid_driver struct for elan_driver does not provide resume or reset_resu=
me
callbacks. When the system suspends and the device loses power (both in USB
and I2C modes), it reverts to its default mouse emulation mode.

Upon resume, the core HID drivers call hid_driver_reset_resume(), which acts
as a no-op since the callback is missing and returns success without rebind=
ing.

Does this leave the touchpad permanently in a degraded state after a
suspend/resume cycle?

[Severity: High]
This is a pre-existing issue, but in USB mode, if more than two fingers are
active, does the driver assign identical coordinates to all fingers after t=
he
first one?

Looking at elan_usb_report_input(), when parsing the ELAN_MT_SECOND_FINGER
packet, the driver iterates over ELAN_MAX_FINGERS to dispatch slot updates
based on the active touch bits in prev_report[2].

For the first active bit found, it correctly uses coordinates from
prev_report + 3. For all subsequent active bits, the else branch executes:

    elan_report_mt_slot(drvdata, data + 1, i);

Because data + 1 is passed directly each time without incrementing any offs=
et,
are the exact same coordinates and pressure values assigned to all fingers
after the first?

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, elan_devices);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520111944.3424=
570-28-sashal@kernel.org?part=3D1
