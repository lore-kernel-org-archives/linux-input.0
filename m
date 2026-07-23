Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458F831326A
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847289; cv=none; b=FlnlUqbo0G52Vt/YE5j0bvKg/kymDAq/48Z2xFuBUz+J4Tvu83ARHNc9ieHx5j7Xko0hUuU9ipIWjKtRQnpOaHo223CRIowOaucpPuXZB0GUgitm+xhi70z9m3CJZoEjXoodpV7YoXAkG1O63E93dEZaVDxhbxFZv6SYWtMPI+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847289; c=relaxed/simple;
	bh=KsOguETlMO/TP2noycq6in31KIYQ78C2p7eUvxE/Vgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fx4nIXMEdyacYU2E3I+9LTjJDgdJzTeBOmP4IzLdMPKqhxHq42az/oiZYlOy6xa2WdK+zPMKJ2apoC4w62n0DL5yObfg6VUs/NtpWWgY+e5q1nposi65UB3fF0qMx5cIavxO3AynG5EP+XRBkQBQlveA0iU27Iz0wg7E+536NpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcU67gMQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcU67gMQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE6151F000E9;
	Thu, 23 Jul 2026 22:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784847287;
	bh=4I6U2IY2AmCK2boc42LlQqTu+6LFgMWpnM1bKMFgtH4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lcU67gMQCcCEDf8e/pcdA5jZLRKo+ymmWPmILjBSuex3oO5cESUs8hEoQr3sTb9sx
	 KtBXDBPvWLH+jJow5HY1q9sKb1k+hDWz2ftcmz2HCucmzIwiyi+UnzlXmE+mhH+Pz3
	 kAyzkJfYFOJPtTo+YOkIFGu/7AVA7wK2vwJ18NZrIkADdlTbRka+gvi9K65bY6YTQj
	 iW3TpDwJEk0qbWCiyGQ66Bu+ccDTthkBoIwrMdSOzLKGyEAiCG/CE9WvPD8WT3eh7e
	 svYLTbK2Dc7RqBTCS/VPxEbeG85MHaNgRF34rfDEl2tImGMj240oim6h0N2nbTnmhp
	 ppwzvUVm9UdzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: multitouch: bound the slot index before touching
 mt_io_flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Your Name" <qwe.aldo@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260723224211.613112-1-you@example.com>
References: <20260723224211.613112-1-you@example.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:54:47 +0000
Message-Id: <20260723225447.AE6151F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Out-of-bounds memory access / State corruption on 32-bit platforms=
 due to `MT_IO_FLAGS_RUNNING` being 32.
- [High] Use-After-Free (UAF) race condition in `mt_remove` due to incorrec=
t timer teardown ordering.
--

--- Patch [1]: [PATCH] HID: multitouch: bound the slot index before touchin=
g mt_io_flags ---
commit 876ccafb8bbdeb9e57250cb530c345252c4de7d6
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

HID: multitouch: bound the slot index before touching mt_io_flags

This commit prevents out-of-bounds writes to mt_io_flags by checking that
the slot index is within the reserved bit range. It introduces mt_io_slot_s=
et()
and mt_io_slot_clear() to enforce this bound before calling set_bit() or
clear_bit().

Cc: stable@vger.kernel.org

> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> index 0495152091e3b..463eab9f73cdb 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -98,6 +98,7 @@ enum report_mode {
>  };
> =20
>  #define MT_IO_SLOTS_MASK		GENMASK(7, 0) /* reserve first 8 bits for slot=
 tracking */
> +#define MT_IO_SLOTS_BITS		8 /* bits covered by MT_IO_SLOTS_MASK */
>  #define MT_IO_FLAGS_RUNNING		32

[Severity: High]
This is a pre-existing issue, but does using bit index 32 cause out-of-boun=
ds
memory access on 32-bit platforms?

Because mt_io_flags is a single unsigned long, valid bit indices are 0-31
on 32-bit architectures.

Calling test_and_set_bit_lock() with bit 32 will read and write to the memo=
ry
immediately following mt_io_flags.

Could this silently corrupt adjacent device state fields like inputmode_val=
ue
and maxcontacts in struct mt_device?

>  static const bool mtrue =3D true;		/* default for true */
> @@ -175,9 +176,10 @@ struct mt_device {
>  	struct hid_haptic_device *haptic;	/* haptic related configuration */
>  	struct hid_device *hdev;	/* hid_device we're attached to */
>  	unsigned long mt_io_flags;	/* mt flags (MT_IO_FLAGS_RUNNING)
> -					 * first 8 bits are reserved for keeping the slot
> -					 * states, this is fine because we only support up
> -					 * to 250 slots (MT_MAX_MAXCONTACT)
> +					 * the first MT_IO_SLOTS_BITS bits are reserved
> +					 * for keeping the slot states; higher slot
> +					 * numbers are not tracked here, see
> +					 * mt_io_slot_set()
>  					 */
>  	__u8 inputmode_value;	/* InputMode HID feature value */
>  	__u8 maxcontacts;

[ ... ]

[Severity: High]
This is another pre-existing issue not introduced by this patch, but is the=
re
a use-after-free race condition during device removal?

In mt_remove(), timer_delete_sync() is called before the hardware is stoppe=
d:

drivers/hid/hid-multitouch.c:mt_remove() {
    ...
	timer_delete_sync(&td->release_timer);

	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
	hid_hw_stop(hdev);
    ...
}

Since the hardware transport is still active, could an incoming HID report
trigger mt_touch_report() and re-arm the timer?

drivers/hid/hid-multitouch.c:mt_touch_report() {
    ...
			mod_timer(&td->release_timer,
				  jiffies + msecs_to_jiffies(100));
    ...
}

If the timer is re-armed after timer_delete_sync(), mt_remove() will comple=
te
and free the devm-managed td structure.

When the timer later fires, won't mt_expired_timeout() access the freed mem=
ory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723224211.6131=
12-1-you@example.com?part=3D1
