Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FD743F081
	for <linux-input@vger.kernel.org>; Wed, 16 Sep 2026 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546148; cv=none; b=jc5GQgfSblMvuC4o1Yw5oE+JC5lwJBLzTOb2ZVwQZTOpMdSoiAYwa2fSyl/papx6te5XtuSJcKYtWGVW5X3H6d+Fs86TtKvVrl+XExw7NvtB+FwJG4aH/j3fnmFyJpT2T0Q3XZGUP6JoFBxdzpxGBwabu1pGxi9rKoh1akwF73k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546148; c=relaxed/simple;
	bh=Vfv6cz9kP+slp3fCixEo1vxfdZoxZKPDD7iWcm4TQLE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yr5zrLO+UuYoGuMLxHQbtuVVwCIg+ySuv60IyE8ABdy4sgyoMFYjpy8NDvpQO4uakgT2zCogP6kFZjJRncn/qnrcHn1hXkftRczC3LZZK0ztwfgdZwP0gOt/bVDFDpi6E+Le5Llvmbg8RQU/aw5t353Sl7xbBqjOTXy+hPUFmt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKmwiqaC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKmwiqaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D6F1F00899;
	Wed, 16 Sep 2026 08:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789546141;
	bh=aVK4GJTOBEdcZisvjKiYjWACGDLVjzJ6MpcQv+7Wa0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XKmwiqaC2Nb+ZQoX5oq523vfUUXlAODv3uiPsJ2KXk3Ulpiq8NNnl10XkvLEeResx
	 iOUEhkT6UtW2jta0N53DlkveJ7iLsIPPKLumDFCBIZs5ZlQgRS66JjpfJa9FRsavyY
	 NWibb9X9g9Rh4IWSFLh5zWG2HjK2jRnKvtq/V2wM+VwApp+OeQjB4F2thURo737WKZ
	 ZdGrx/oS9YcpG46oNT/G9ePBc5DyPYMS4lZ2W9qINrxkxm4fhqww9ZOClTpAmfmBJE
	 Y74r1F4msVDpwz6Y72mPh82AW5nuccw4qqdiMxRxIt7gnyykI5+taR8gtWqpMC7yKi
	 6YeaRK+yXfohA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] HID: roccat: use device_is_registered() to check
 whether device is available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260916080013.56388-2-dmantipov@yandex.ru>
References: <20260916080013.56388-1-dmantipov@yandex.ru>
 <20260916080013.56388-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 08:09:00 +0000
Message-Id: <20260916080901.47D6F1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hid: roccat: UAF/NULL deref in roccat_device_available() during di=
sconnect
--

commit cd1f0994ff4ff722b51fd011ca302365c749f4ad
Author: Dmitry Antipov <dmantipov@yandex.ru>

HID: roccat: use device_is_registered() to check whether device is available

This commit introduces roccat_device_available() to check whether a device
is actually available by calling device_is_registered(device->dev), replaci=
ng
the explicit 'exist' flag from 'struct roccat_device'.

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 5deb6da8d4f74..454b201c0524b 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
[ ... ]
> @@ -70,6 +69,11 @@ static struct roccat_device *devices[ROCCAT_MAX_DEVICE=
S];
>  /* protects modifications of devices array */
>  static DEFINE_MUTEX(devices_lock);
> =20
> +static bool roccat_device_available(struct roccat_device *device)
> +{
> +	return device->dev ? device_is_registered(device->dev) : false;
> +}
> +

[Severity: High]
Does this introduce a Use-After-Free or NULL pointer dereference race?

When roccat_device_available() is called, device->dev is evaluated. If a
concurrent thread calls roccat_disconnect() and frees the device structure =
via
device_destroy(), device_is_registered(device->dev) may access freed memory.
Also, a compiler double-fetch could result in a direct NULL pointer derefer=
ence.

[ ... ]
> @@ -105,7 +109,7 @@ static ssize_t roccat_read(struct file *file, char __=
user *buffer,
>  				retval =3D -ERESTARTSYS;
>  				break;
>  			}
> -			if (!device->exist) {
> +			if (!roccat_device_available(device)) {
>  				retval =3D -EIO;
>  				break;
>  			}

[Severity: High]
Can this race occur here?

roccat_read() calls roccat_device_available() without holding devices_lock.
This means the device's availability is evaluated locklessly while
roccat_disconnect() might be tearing down the device.

[ ... ]
> @@ -149,7 +153,7 @@ static __poll_t roccat_poll(struct file *file, poll_t=
able *wait)
>  	poll_wait(file, &reader->device->wait, wait);
>  	if (reader->cbuf_start !=3D reader->device->cbuf_end)
>  		return EPOLLIN | EPOLLRDNORM;
> -	if (!reader->device->exist)
> +	if (!roccat_device_available(reader->device))
>  		return EPOLLERR | EPOLLHUP;
>  	return 0;
>  }

[Severity: High]
Similarly, roccat_poll() calls roccat_device_available() without holding
devices_lock, exposing it to the same race condition as roccat_read().

[ ... ]
> @@ -369,10 +372,8 @@ void roccat_disconnect(int minor)
>  	mutex_lock(&devices_lock);
>  	device =3D devices[minor];
> =20
> -	device->exist =3D 0; /* TODO exist maybe not needed */
> -
>  	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
> -
> +	device->dev =3D NULL;
>  	devices[minor] =3D NULL;
> =20
>  	if (device->open) {

[Severity: High]
Could this teardown path trigger the race?

roccat_disconnect() holds devices_lock, destroys and drops the reference to
the device with device_destroy(), and then nullifies device->dev.
Since roccat_read() and roccat_poll() don't hold devices_lock, they can
dereference device->dev concurrently just before or as it is being freed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916080013.5638=
8-1-dmantipov@yandex.ru?part=3D2
