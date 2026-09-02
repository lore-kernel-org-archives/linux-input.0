Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E939B4AE
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343450; cv=none; b=bda3GlHmqEOsOhgCpPjgYlY1yRZf13Y3OIwnTUPGaL1F23Yh6cNU2b3t/MhiEW0HnL/CRiXZvVsQDWVTqVaD7yJUq3TTdFO/oUw6yM6q9LQXoFoiy/JmRB72Yg2YhKlIIzP7rYrpW+SjQwuzpVn4JIapw7fHpqaNP4ox8YrqulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343450; c=relaxed/simple;
	bh=B8ca5vFL8+puu1HTSJ6D59ggkm3R4VclSDkILfrGT2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zj2lR/GxQQnGqX58g2wicFdfjOvhVxgLuJoCXrMy/odGIwpfLWfBrskaMoa7C9PQWyUUAOcADYNvclmfSLvS3oQdkeRkAOn4W5GoBGnwDmR/LIX7sLyv/YzTimM6DeuA2g3eRV9Z97MToZ5Iv+KVmTt2OFmDF4utQE6cb7RRIEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCuSBAz6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCuSBAz6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5681F000E9;
	Wed,  2 Sep 2026 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788343448;
	bh=RSZdtWUXnIrmFSs4SXHNVs27m+m+72qs2Xtadl074YU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hCuSBAz6htyE3ZSR/jFmxjWhy2CzXHl1j56Sx9BFsr6ZvDuXqBwOaOrK43XdYlvxN
	 xc4lOy2LehJ8qCzdc05TcnzDQ9HUeFOAW+yBdfGwW6Ipvf6RMNt71tnS0yqI4y47hF
	 I7Vq4mW2FAk20HmweEOjM14F+Qe9TcbuUNDhqyLe8u1qp5Ll0aTlxwysb89LwOC6rl
	 DEWa8CZdBzRBKVTDgQmpY11GQfKYQ1gIzpi2R0W0zhXUQa4XsdKjuholCCAKcDsE0V
	 gdLLfqEjPGzBdInQocnamHVBYBVdXMWF2Yd7qansmJ/INquuwacFrKh6eBVzwloilU
	 jymVl71XmKoqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: roccat: fix locking in roccat_connect() and
 roccat_disconnect()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260902094551.200587-1-dmantipov@yandex.ru>
References: <20260902094551.200587-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 10:04:08 +0000
Message-Id: <20260902100408.9C5681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to `devices` array in `roccat_report_event()` race=
s with `roccat_disconnect()`, leading to a NULL pointer dereference.
- [High] `roccat_report_event()` incorrectly calls sleeping `mutex_lock()` =
functions inside an atomic interrupt context.
- [High] Tear-down ordering violation in hardware-specific sub-drivers free=
s private data before calling `hid_hw_stop()`, leading to a Use-After-Free =
in `raw_event`.
--

commit 703610255dcd5d9ce2d448d2494e1361c5869fcf
Author: Dmitry Antipov <dmantipov@yandex.ru>

HID: roccat: fix locking in roccat_connect() and roccat_disconnect()
   =20
Extend critical section in roccat_connect() to ensure that partially
initialized 'struct roccat_device' is never exposed in 'devices' list,
and do the same in roccat_disconnect() to avoid racy 'devices' access
against roccat_release().

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 4f15eb9510396..5deb6da8d4f74 100644
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
> -	mutex_unlock(&devices_lock);
[Severity: High]
This is a pre-existing issue, but does setting `devices[minor] =3D NULL` he=
re
without stopping the hardware polling first create a race condition?

When a Roccat device is unplugged and has no open references, this sets
`devices[minor] =3D NULL` and frees the device. Because this occurs before
`hid_hw_stop()` is called in the sub-drivers, hardware polling is still act=
ive.

If an interrupt fires during this window, could `roccat_report_event()`
locklessly fetch the device and encounter a NULL pointer dereference?

drivers/hid/hid-roccat.c:roccat_report_event() {
	...
	device =3D devices[minor];
	new_value =3D kmemdup(data, device->report_size, GFP_ATOMIC);
	...
}

[Severity: High]
This is a pre-existing issue, but is it possible for `roccat_report_event()`
to attempt to acquire sleeping locks in an atomic context?

`roccat_report_event()` is called synchronously from HID `raw_event` handle=
rs
which execute in an atomic softirq context. While it correctly uses
`GFP_ATOMIC` for its allocation, it seems to call `mutex_lock()` immediately
after:

drivers/hid/hid-roccat.c:roccat_report_event() {
	...
	mutex_lock(&device->readers_lock);
	mutex_lock(&device->cbuf_lock);
	...
}

Can this lead to a kernel panic or a 'scheduling while atomic' bug?

[Severity: High]
This is a pre-existing issue, but is there a tear-down ordering violation in
hardware-specific sub-drivers like `hid-roccat-kone.c`?

During driver unbind or device unplug, the `remove` function calls
`kone_remove_specials()` which frees the private data before calling
`hid_hw_stop()`:

drivers/hid/hid-roccat-kone.c:kone_remove_specials() {
	...
		kfree(hid_get_drvdata(hdev));
	...
}

drivers/hid/hid-roccat-kone.c:kone_remove() {
	...
	kone_remove_specials(hdev);
	hid_hw_stop(hdev);
	...
}

Because hardware polling isn't stopped before freeing, incoming reports cou=
ld
execute the `raw_event` handler, which fetches the freed pointer:

drivers/hid/hid-roccat-kone.c:kone_raw_event() {
	struct kone_device *kone =3D hid_get_drvdata(hdev);
	...
	if (memcmp(&kone->last_mouse_event.tilt, &event->tilt, 5))
	...
}

Could this result in a Use-After-Free memory corruption if `kone` is
dereferenced for reads or writes here?

> =20
>  	if (device->open) {
>  		hid_hw_close(device->hid);
> @@ -385,6 +381,8 @@ void roccat_disconnect(int minor)
>  	} else {
>  		roccat_free_device(device);
>  	}
> +
> +	mutex_unlock(&devices_lock);
>  }
>  EXPORT_SYMBOL_GPL(roccat_disconnect);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902094551.2005=
87-1-dmantipov@yandex.ru?part=3D1
