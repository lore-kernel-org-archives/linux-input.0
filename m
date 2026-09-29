Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2562639E178
	for <linux-input@vger.kernel.org>; Tue, 29 Sep 2026 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666093; cv=none; b=QUgrt/7Llo0I9BqPJVUCLGHElE7fj4EK5WJl1Ps6Yd8Anroi1dWaeyyor6P8KMVmb3kMlvA5IVD8jOexcRHJAb+zEGOd1dhOuimgAPongJGrXdpG4DmF3H+nP3wfrOPNJ41F6GSjpfByMSyNOkIGW0OxieiB3LmjaYIZWWg56ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666093; c=relaxed/simple;
	bh=+3VDPjF9InWdBEUagYo8hjEZ7Fzj9+nGVcbz2o0Q71o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dPUbQpkc37AbVROpgTFOG/XtyfigEs6DRhxqT15BoNPj6ofZ2qh4Q2i7s29945urRfQpwFeeXz5RbIfwCgDu7t9x9yEOW/AD3guWwJWt1kdq1iBFxp7pma6O1+bVXek5dfjUTrV16aBbBqfB+KF5yxQWTkI+CoRD7ybOBKvTD0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ub4n12/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ub4n12/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28441F000FF;
	Tue, 29 Sep 2026 07:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790666091;
	bh=Ms5z6AzKwtDDTI0sPhGlm8+AkyxIf3BsSX3UMNrxskc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ub4n12/tBjy3td6IDA8so6n8/kzVd4XAqNBpsDFKuXsa++F4LJjIYRzypbCOEPEO9
	 6M6AjQFMYjxk1jGUY2ZLKDbA3VOnfhwljOYh6QX0rqRZOFi9PlS82nXzu2pQdA/2CW
	 fuxr0tCb1gX1kgHzpSofqdlOSssAFybWMG+xsKlgYN70CbikR0keCpQZoLM5VvTBnA
	 mZklVCrM+7g91i3/2c8XCe/MMus8jBFULeyn7nGJk3bc0jD+wgsFWU+mg3Fe4LXLlH
	 ZgoyTjXV9TY10oxu0v8QRzIYnMZAAAxD4PaQ/ZwR3uzbAzTr23TmL8sHT9dSfw1dIs
	 3iVp/Z2qxfuog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] HID: roccat: use device_is_registered() to check
 whether device is available
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Antipov" <dmantipov@yandex.ru>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260929065743.134635-2-dmantipov@yandex.ru>
References: <20260929065743.134635-1-dmantipov@yandex.ru>
 <20260929065743.134635-2-dmantipov@yandex.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 07:14:51 +0000
Message-Id: <20260929071451.B28441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] HID: roccat: Use-After-Free in roccat_device_available() via devic=
e_is_registered()
--

commit 79c5b3b7724b3fbf847bc777badc500fdf61abef
Author: Dmitry Antipov <dmantipov@yandex.ru>

    HID: roccat: use device_is_registered() to check whether device is avai=
lable

This patch introduces roccat_device_available() to check if a device is
available (using device_is_registered()), removing the explicit 'exist'
flag from struct roccat_device.

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 5deb6da8d4f74..96aa508111a1b 100644
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
> +	struct device *dev =3D READ_ONCE(device->dev);
> +
> +	return dev ? device_is_registered(dev) : false;

[Severity: High]
Are we dereferencing the cached dev pointer here without holding a reference
count?

If a thread reads the dev pointer here, gets preempted while device_destroy=
()
frees it, and then evaluates device_is_registered(dev), could this lead to a
Use-After-Free?

This is not fixed by subsequent patches in the series (e.g., commit
"HID: roccat: use kref to manage device instances"), which only refcount
the struct roccat_device, not the struct device.

> +}
> +
>  static void roccat_free_device(struct roccat_device *device)
>  {
>  	int i;
[ ... ]
> @@ -149,7 +155,7 @@ static __poll_t roccat_poll(struct file *file, poll_t=
able *wait)
>  	poll_wait(file, &reader->device->wait, wait);
>  	if (reader->cbuf_start !=3D reader->device->cbuf_end)
>  		return EPOLLIN | EPOLLRDNORM;
> -	if (!reader->device->exist)
> +	if (!roccat_device_available(reader->device))

[Severity: High]
Is it possible for a lockless caller like roccat_poll() to trigger the
Use-After-Free vulnerability mentioned above by reading dev concurrently?

>  		return EPOLLERR | EPOLLHUP;
>  	return 0;
>  }
[ ... ]
> @@ -369,10 +374,8 @@ void roccat_disconnect(int minor)
>  	mutex_lock(&devices_lock);
>  	device =3D devices[minor];
> =20
> -	device->exist =3D 0; /* TODO exist maybe not needed */
> -
>  	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
> -
> +	WRITE_ONCE(device->dev, NULL);

[Severity: High]
Can this sequence unregister and free the struct device memory concurrently
before the pointer is cleared, causing the Use-After-Free?

Could device_destroy() drop the final reference and free the struct device
memory immediately before WRITE_ONCE() clears the pointer?

>  	devices[minor] =3D NULL;
> =20
>  	if (device->open) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929065743.1346=
35-1-dmantipov@yandex.ru?part=3D1
