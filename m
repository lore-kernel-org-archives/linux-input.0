Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19F51A5B9E
	for <linux-input@vger.kernel.org>; Sat, 18 Jul 2026 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784378160; cv=none; b=RORpWIWeFSwgicCFfbgQ/VtT7NLCZSBQ5zlpu/QiBMydZh20auAMiwKWc1PObIDVM0ryToa7+/Beu+iJPvM1fpsnBPX+mlxANomjpqbSPJYAsVI7AqSONJ7eIk3bjnJW/9NEZuLsV1cY++7GJROCk1i5Pp5M9R62T9NUml8PIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784378160; c=relaxed/simple;
	bh=gdXPdgx9NqiEXZpa9x0rgFnatmlpqbBcIXsGJ5Phy84=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j6QyXjaL9jy16F3EPwBSX20HNECzDgYBMD6QNIqZCOmAlzsMy299f23OmtPbzj0sc6JkHuFt/AdD6zmM2wjPIDN2/choyE/WQhc0euCwHQeaByjcwE85S3KIjw/BtESuQu/S7DLSlJJX6SvH5cir6+bNjJ0zwKBePb7BIvB8BGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8R63fQh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8R63fQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABF41F000E9;
	Sat, 18 Jul 2026 12:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784378158;
	bh=SCeKYbfxSYl5cxnQOZoNxXtaYN9qBSmZ7mFQ/qCKoiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J8R63fQhGZlNOsSrF17vkQEyX39sWPYpaGSxHMk7rKwl8esDorK1acNa+Hu3OllkA
	 B+OZD76s0MLz2M1LWEKK3vFCEp+Np1IX8ywbIuBhUBnBhhV2zgRqPfApWMpkW41nLf
	 Vx1Vh6QUEjd/b4AtdMa2xvy7J3wPvWvjgdA0qBLaO6bDK9msAxTSDhuiSJLnuaOwtm
	 U4zqcfvrzffw4KLSVG5F7/D7b+iVtwLpHVyNkS9bXRRyeGndmHDEim3MjmWW8COhxS
	 YrEKC9r8w5Rc2FNCwG0Gy4eX61NZddon2sz3RmWWWmSHM7m6ospyoQ8YGnKatuyzBn
	 sZxRUlDidWYbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: apple: preserve keyboard backlight across T2
 resume
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andre Eikmeyer" <dev@deq.rocks>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260718121527.15924-1-dev@deq.rocks>
References: <20260718121527.15924-1-dev@deq.rocks>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 12:35:57 +0000
Message-Id: <20260718123558.0ABF41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Removing the `LED_CORE_SUSPENDRESUME` flag reverts a previous powe=
r-management fix, causing the keyboard backlight to remain powered on durin=
g system suspend.
--

--- Patch [1]: [PATCH 1/2] HID: apple: preserve keyboard backlight across T=
2 resume ---
commit 2758811c67b214fbd3316fec3f21127f8166f490
Author: Andre Eikmeyer <dev@deq.rocks>

HID: apple: preserve keyboard backlight across T2 resume

This commit fixes an issue where the T2 virtual USB host controller
re-enumerates the internal keyboard on resume, resulting in the backlight
starting off. It caches the brightness during removal and restores it
during the subsequent probe.

Fixes: 1f95a6cd5ad7 ("HID: apple: ensure the keyboard backlight is off if s=
uspending")
Cc: stable@vger.kernel.org

> diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
> --- a/drivers/hid/hid-apple.c
> +++ b/drivers/hid/hid-apple.c

[ ... ]

> @@ -860,13 +864,20 @@ static int apple_backlight_init(struct hid_device *=
hdev)
>  	asc->backlight->cdev.name =3D "apple::kbd_backlight";
>  	asc->backlight->cdev.max_brightness =3D rep->backlight_on_max;
>  	asc->backlight->cdev.brightness_set_blocking =3D apple_backlight_led_se=
t;
> -	asc->backlight->cdev.flags =3D LED_CORE_SUSPENDRESUME;
> +	/* VHCI re-enumeration restores the cached brightness in the next probe=
. */

[Severity: High]
Does removing the LED_CORE_SUSPENDRESUME flag cause the backlight to remain
on during system suspend?

The T2 butterfly keyboard hardware does not automatically power off its
backlight when suspending. When this flag is removed, the LED subsystem
bypasses led_classdev_suspend(), leaving the hardware illuminated and
draining the battery.

The new caching mechanism in apple_remove() successfully tracks the user
brightness preference, as led_classdev_suspend() only alters the physical
hardware state without modifying the logical led_cdev->brightness.

Could the device initialization issue have been caused by the hardcoded
apple_backlight_set(hdev, 0, 0) during probe, rather than the presence of
this suspend flag?

> =20
> -	ret =3D apple_backlight_set(hdev, 0, 0);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718121527.1592=
4-1-dev@deq.rocks?part=3D1
