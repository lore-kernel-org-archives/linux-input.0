Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E044A3D52
	for <linux-input@vger.kernel.org>; Thu,  3 Sep 2026 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438437; cv=none; b=pAozF62UzQ89jpMrQ2DA8+XD/x0Q6O+iyd02kl7deeyayCC67cm1YqWvJEEjosfoG7dONmiAekUeDddObxGkez/HEWzQWzdi8PCR/2yGVEPgiq9sWcEOhzeXun+KC0XOfQaBUCHvYQTYHxyCa3TLXlaskikenzTMtxpVFO5hxEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438437; c=relaxed/simple;
	bh=aOft3Jsclo0KWuwJmwEXl+hNGpdc2hoJypHdEtGP4lk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t6DbXkg+YDRmwz4Zh4VqgB/yfduw3EETuyPTgmaSikU/5CmmaenxzC87eAIogA/+q3GjyEjbr3DEG8LYMbf/KoVLa2rag9+B5ixJ4ul9Nu0WqzSUfxFW+CyEfxvm6ye96+RvnEjeyBGvcGG9j4/CtZ0I8WkP1paicHjuLtDrO/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozqXxqCe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozqXxqCe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45E3F1F00A3A;
	Thu,  3 Sep 2026 12:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788438435;
	bh=8G95IK19uxuwBw2qyBSnLdk/fIhRqjjT/DufmJhm2D0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ozqXxqCewzZjsiImeNgchhCQqd0r0YbA4FGDTI//T8a7XgdXBwK1d43wZufs7g5yj
	 /5nOtepLlRgaeXi3vr/MyjamXOA0NTJDT2CEo1B594y+g6JhZhEXI4pVho5NjI2c+N
	 VzEj3Q85m7ATADsSRk8UNXHdgAvjWMcEGfLvTIVES/+pskrLaFeynUElABGN60Jf3C
	 EUqp+IkBLUeCaWNgBu9d1zZ69wqu6MowCiIlWcJ7aeDlX2/UZ/BCTnSg78YzmsMWvi
	 PamvMPXKTojA8uQU1mMNiBXpgUW2qkHrRebqg+YF5xqILUc7dgpbzfQ2UzqaqkpOJm
	 1iAlppu+bvR3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: roccat: fix use-after-free and uninitialized-mutex
 races
Reply-To: sashiko-reviews@lists.linux.dev
To: "Deepanshu Kartikey" <kartikey406@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260903121206.6893-1-kartikey406@gmail.com>
References: <20260903121206.6893-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 12:27:14 +0000
Message-Id: <20260903122715.45E3F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] roccat_release looks up the device by minor from the global ar=
ray instead of using reader->device, causing memory leaks and cross-device =
UAF/list corruption after a disconnect.
- [Critical] Multiple roccat sub-drivers free their private data before cal=
ling hid_hw_stop(), creating a Use-After-Free window in raw_event handlers.
- [High] roccat_report_event() accesses devices[minor] locklessly and witho=
ut NULL checks, leading to a NULL pointer dereference.
- [High] roccat_report_event() calls mutex_lock() while executing in an ato=
mic context.
--

commit f1bc16383a0353c41082cf198a1495d5e17e528e
Author: Deepanshu Kartikey <kartikey406@gmail.com>

    HID: roccat: fix use-after-free and uninitialized-mutex races

This commit fixes a use-after-free in roccat_disconnect() by keeping the
whole lookup, state update, and free decision inside a single devices_lock
critical section. It also fixes an uninitialized-mutex race in
roccat_connect().

Closes: https://syzkaller.appspot.com/bug?extid=3Dc492a9e154f81127551f

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 4f15eb9510396..1d57f8a44a3dc 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
[ ... ]
> @@ -369,15 +368,12 @@ void roccat_disconnect(int minor)
> =20
>  	mutex_lock(&devices_lock);
>  	device =3D devices[minor];
> -	mutex_unlock(&devices_lock);
> =20
>  	device->exist =3D 0; /* TODO exist maybe not needed */
> =20
>  	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
> =20
> -	mutex_lock(&devices_lock);
>  	devices[minor] =3D NULL;

[Severity: Critical]
This is a pre-existing issue, but does roccat_release() mishandle the device
lookup after this disconnect clears devices[minor]?

drivers/hid/hid-roccat.c:roccat_release() {
	...
	device =3D devices[minor];
	if (!device) {
		mutex_unlock(&devices_lock);
		pr_emerg("roccat device with minor %d doesn't exist\n", minor);
		return -ENODEV;
	}
	...
}

If a user holds an open file descriptor while the USB device is disconnecte=
d,
roccat_disconnect() clears devices[minor] to NULL here. When the user later
closes the file descriptor, roccat_release() returns early because
devices[minor] is NULL, which seems to leak both roccat_reader and
roccat_device.

Also, if a new device is plugged in before the old file descriptor is close=
d,
reusing the minor number, won't roccat_release() fetch the new device and
incorrectly delete the old reader from the new device's list, corrupting the
list and the open count?

[Severity: High]
This isn't a bug introduced by this patch, but does roccat_report_event() l=
ack
NULL checks and synchronization when accessing the global array?

drivers/hid/hid-roccat.c:roccat_report_event() {
	...
	device =3D devices[minor];

	new_value =3D kmemdup(data, device->report_size, GFP_ATOMIC);
	...
}

If an incoming hardware interrupt invokes this function concurrently with a
physical disconnection, could roccat_disconnect() clearing devices[minor] h=
ere
cause roccat_report_event() to dereference a NULL pointer for
device->report_size?

[Severity: High]
This is a pre-existing issue, but is it safe to use mutex_lock() inside
roccat_report_event()?

drivers/hid/hid-roccat.c:roccat_report_event() {
	...
	mutex_lock(&device->readers_lock);
	mutex_lock(&device->cbuf_lock);
	...
}

Since roccat_report_event() is called from the driver's .raw_event handlers
(like kone_raw_event), which execute in an atomic context (such as URB
completion softirq or hardirq), won't these mutexes sleep and lead to a
scheduling while atomic panic?

> -	mutex_unlock(&devices_lock);
> =20
>  	if (device->open) {
>  		hid_hw_close(device->hid);
[ ... ]

[Severity: Critical]
This isn't a bug introduced by this patch, but does kone_remove() free
resources before stopping the hardware?

drivers/hid/hid-roccat-kone.c:kone_remove_specials() {
	...
	kfree(hid_get_drvdata(hdev));
	...
}

drivers/hid/hid-roccat-kone.c:kone_remove() {
	...
	kone_remove_specials(hdev);
	hid_hw_stop(hdev);
}

If a hardware interrupt arrives between the kfree() in kone_remove_specials=
()
and hid_hw_stop(), couldn't the HID core route it to the kone_raw_event()
handler? That handler would then dereference the dangling private data poin=
ter,
causing a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903121206.6893=
-1-kartikey406@gmail.com?part=3D1
