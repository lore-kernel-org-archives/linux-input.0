Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C741DDF0
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151118; cv=none; b=Icn3vEPGHuK6g+1eNYQMr5HsuWaFa+AvcfgLzTY8T+BPErf9+AjUsQAY8cQ2av3O0ACi5Fz3R57veGnEoh3uRNA2eLUhElAVCarHTvYG64OvxAY02kfGJmS3lfccOBarq8jmXY6zpA6OsiBYg5L3HpPjHGFh+C585OfLvZvq+OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151118; c=relaxed/simple;
	bh=BD7Zw52oOFJ/XJuHFiD1bIEJW/2+p6ADsTi3Y+WTXAo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OkDgxvYkesBSkS/FgXnMWRemTvBfAYJyL4Ie2dqj8iL++QGO2uU72j454DsTtEX8cfK7x1twIh1BsDz6ccn71Zm0BhnlzYjd/beg2OT267dXZQlFQKaD9frFUWTw+FgkVeRqbh3ZIiYwhUA+moLUJzTIxIDEOrrRGqvUXmvHqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXBLGUEZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXBLGUEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878CB1F000C4;
	Fri, 16 Oct 2026 11:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792151116;
	bh=DbVQBCgSFBlhlgbX91IdjibF9rWkEX0OT4QP73XBgqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QXBLGUEZ6bU+87YpURGSQT3jnw4AXZsgXVUYxbtS9A0nt60HAo/lBlEOlYksbIz9e
	 4lpZOPHTdiIGqSrx7fC3Msdg/Yx8qR35n0Q3cbN1VFGJkEcu+Z4/Nzki0uj2FcBuAO
	 6+jeDsAZHLa8/Kfo0hg9g+cSrePylhhtS92CqQ6/r4VOGGNBIPOaABgLCqm6OyqMXo
	 Naxag4cTPjf29jxtAuXYHQO1Pigto15ybtMM25BOXFLfh86TNeZxTaC6i2LdvmnDiz
	 Q29CH/4AXgmSylDed5p1ihohZjV5ZmPFgRpGdem3k68AQafqoS/I7okGyauuZgrEb/
	 ccuR6gEaWok+Q==
Message-ID: <sashiko-outbox-174248@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] HID: roccat: use device_is_registered() to check
 whether device is available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261016113321.892452-2-dmantipov@yandex.ru>
References: <atECwbWrAQFpbELS@beelink>
 <20261016113321.892452-1-dmantipov@yandex.ru>
 <20261016113321.892452-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 11:45:16 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] hid: Use-After-Free of struct device in roccat_device_available()
- [High] hid: roccat: UAF in roccat_device_available() during device removal
--

commit 55c9b90288fdb8c7ef6b2e3456eeca1cc08711d4
Author: Dmitry Antipov <dmantipov@yandex.ru>

HID: roccat: use device_is_registered() to check whether device is available

This commit introduces roccat_device_available() to check if a device is
registered. It removes the explicit 'exist' flag from struct roccat_device.

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 5deb6da8d4f74..92a9b9f14f591 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c

[ ... ]

> @@ -70,6 +69,13 @@ static struct roccat_device *devices[ROCCAT_MAX_DEVICE=
S];
>  /* protects modifications of devices array */
>  static DEFINE_MUTEX(devices_lock);
> =20
> +static bool roccat_device_available(struct roccat_device *device)
> +{
> +	struct device *dev =3D smp_load_acquire(&device->dev);
> +
> +	return dev ? device_is_registered(dev) : false;

[Severity: High]
Does this create a Use-After-Free risk when evaluated concurrently with dev=
ice
removal?

If roccat_read() or roccat_poll() fetches the 'dev' pointer via
smp_load_acquire() but is then preempted before calling
device_is_registered():

Thread 1 (roccat_read/roccat_poll)
roccat_device_available()
    struct device *dev =3D smp_load_acquire(&device->dev);
    <preempted>

Thread 2 (roccat_disconnect)
    dev =3D xchg(&device->dev, NULL);
    device_destroy(dev->class, MKDEV(roccat_major, minor));

Since device_destroy() synchronously drops the reference and can free the
underlying struct device memory, could Thread 1 then resume and pass the fr=
eed
'dev' pointer to device_is_registered(), dereferencing freed memory?

[ ... ]

> @@ -365,13 +370,13 @@ EXPORT_SYMBOL_GPL(roccat_connect);
>  void roccat_disconnect(int minor)
>  {
>  	struct roccat_device *device;
> +	struct device *dev;
> =20
>  	mutex_lock(&devices_lock);
>  	device =3D devices[minor];
> =20
> -	device->exist =3D 0; /* TODO exist maybe not needed */
> -
> -	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
> +	dev =3D xchg(&device->dev, NULL);
> +	device_destroy(dev->class, MKDEV(roccat_major, minor));

[Severity: High]
Since roccat_device_available() can be called from read and poll handlers
without holding devices_lock, does swapping the pointer and immediately
destroying the device leave concurrent readers unprotected?

> =20
>  	devices[minor] =3D NULL;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016113321.8924=
52-1-dmantipov@yandex.ru?part=3D1
