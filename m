Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37421B67E
	for <linux-input@vger.kernel.org>; Mon,  7 Sep 2026 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821918; cv=none; b=QXDz6XMeXQwZcO7q1JLcGW6d4dMD6n3tGPPtWiemiJhSna5nLh9OXjrd/SgBInoXA3282mshpfUx2Q24VUchroC7giSdjXxxqHTBE1T6uwKAHwI7SNuTRq847isFr5GOc3YGJcHEOR40U0ud7nAdg54QyGayovQSicVI10WJdKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821918; c=relaxed/simple;
	bh=48Nlo8+lw00kL+NJlxp0GwmNHHSY9NI2A0S0Pq2LrnU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RKn8bTLwZTkblUplnIH8VTpRnWLnG2AFsgowfl81vuPHQYIm9kpfzqoGaUliq8+YZop5lKc6EDWIhALIRWP+MYt5RPgiQqwY70eJibpFwM8/e0WxRAVs02pSCnwP0HjUEwZiim58KxysiVncsqafDZ5CbMxrJ300uDdy2uRqWfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOw+euDR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOw+euDR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB8D1F00A3A;
	Mon,  7 Sep 2026 22:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788821916;
	bh=ZWEDUOyT5DkjoUnh1c2w0hjGax4APVdiMykQbvNSCBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nOw+euDRcqEaFPhIpIofKhHV1E0dci0V02oWxTa/ZPfAhxH2U6oIkiFBGv21QliRE
	 hRuuP9HNYFEkoGmr7+7WUAZsPbMn6XC8bw0+bKM2ueUJnG82RClYJkfU0rdB8xap4u
	 iCl6BkT9aoEq/fG8vqZrDjDybjctiioGZMMf8H25eP5gFb2AEcTBpYovO+wEq2ALUr
	 sZTZhFaNj0jv3xT21a6B3+OZUNpcwDZ5d5RZVChAN6b2P84REOo27GRpVVwsVJA6W+
	 fWCkTIw4K1Ucri/3fVdfFj/b/CwApP+mBU9uW4jxTKIzsjpi7jK7+aetu3rWQ6VwX9
	 /+3LuVt9NfN7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: roccat: fully initialize device before publishing
 to devices[]
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ivy Lopez" <skunkolee@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260907224426.159104-1-skunkolee@gmail.com>
References: <6a9ccae4.37659fcc.e790.0006.GAE@google.com>
 <20260907224426.159104-1-skunkolee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 22:58:36 +0000
Message-Id: <20260907225836.8EB8D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `roccat_release()` leaks memory and corrupts state by looking =
up the device from the global array instead of the reader struct when handl=
ing hot-unplug.
- [High] `roccat_report_event()` calls sleepable `mutex_lock()` from within=
 a hardirq/atomic context.
- [High] A race between `roccat_disconnect()` and `roccat_release()` causes=
 a Use-After-Free of the `roccat_device` structure.
--

commit 46468883b2be9805a5a149d03c123b3d8fe1868c
Author: Ivy Lopez <skunkolee@gmail.com>

    HID: roccat: fully initialize device before publishing to devices[]
   =20
    The patch moves the initialization of a roccat device's private state a=
head
    of the point where it is inserted into the global devices array. This e=
nsures
    the object is fully constructed before it becomes visible to concurrent
    readers.
   =20
    Reported-by: syzbot+9f7405999979761b6cfc@syzkaller.appspotmail.com
    Signed-off-by: Ivy Lopez <skunkolee@gmail.com>

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index 4f15eb9510396..2d8b0da6fbb21 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
> @@ -316,26 +316,32 @@ int roccat_connect(const struct class *klass, struc=
t hid_device *hid, int report
>  	if (!device)
>  		return -ENOMEM;
> =20
> -	mutex_lock(&devices_lock);
> +	init_waitqueue_head(&device->wait);
> +	INIT_LIST_HEAD(&device->readers);
> +	mutex_init(&device->readers_lock);
> +	mutex_init(&device->cbuf_lock);
> +	device->hid =3D hid;
> +	device->exist =3D 1;
> +	device->cbuf_end =3D 0;
> +	device->report_size =3D report_size;
> =20
> +	mutex_lock(&devices_lock);
>  	for (minor =3D 0; minor < ROCCAT_MAX_DEVICES; ++minor) {
>  		if (devices[minor])
>  			continue;
>  		break;
>  	}
> -
> -	if (minor < ROCCAT_MAX_DEVICES) {
> -		devices[minor] =3D device;
> -	} else {
> +	if (minor >=3D ROCCAT_MAX_DEVICES) {
>  		mutex_unlock(&devices_lock);
>  		kfree(device);
>  		return -EINVAL;
>  	}
> +	device->minor =3D minor;
> +	devices[minor] =3D device;
> =20
>  	device->dev =3D device_create(klass, &hid->dev,
>  			MKDEV(roccat_major, minor), NULL,
>  			"%s%s%d", "roccat", hid->driver->name, minor);
> -
>  	if (IS_ERR(device->dev)) {
>  		devices[minor] =3D NULL;
>  		mutex_unlock(&devices_lock);
> @@ -343,19 +349,8 @@ int roccat_connect(const struct class *klass, struct=
 hid_device *hid, int report
>  		kfree(device);
>  		return temp;
>  	}
> -
>  	mutex_unlock(&devices_lock);
> =20
> -	init_waitqueue_head(&device->wait);
> -	INIT_LIST_HEAD(&device->readers);
> -	mutex_init(&device->readers_lock);
> -	mutex_init(&device->cbuf_lock);
> -	device->minor =3D minor;
> -	device->hid =3D hid;
> -	device->exist =3D 1;
> -	device->cbuf_end =3D 0;
> -	device->report_size =3D report_size;
> -
>  	return minor;
>  }
>  EXPORT_SYMBOL_GPL(roccat_connect);

[Severity: Critical]
This is a pre-existing issue, but does roccat_release() leak memory and
corrupt state by looking up the device from the global array instead of the
reader struct when handling hot-unplug?

If the device is unplugged, roccat_disconnect() clears the global minor
pointer:

drivers/hid/hid-roccat.c:roccat_disconnect() {
    ...
	mutex_lock(&devices_lock);
	devices[minor] =3D NULL;
	mutex_unlock(&devices_lock);
    ...
}

If userspace later closes the file descriptor, roccat_release() retrieves t=
he
device from the global array rather than using the safe reader->device poin=
ter:

drivers/hid/hid-roccat.c:roccat_release() {
    ...
	mutex_lock(&devices_lock);

	device =3D devices[minor];
	if (!device) {
		mutex_unlock(&devices_lock);
		pr_emerg("roccat device with minor %d doesn't exist\n", minor);
		return -ENODEV;
	}
    ...
}

Does this cause an early return that permanently leaks the device and reader
structs?

If a new Roccat device is plugged in before the file descriptor is closed,
could it assume the old minor slot, causing roccat_release() to operate on =
the
new device, prematurely decrementing its open count and potentially powerin=
g it
down while the old device leaks?

[Severity: High]
This isn't a bug introduced by this patch, but does roccat_report_event() c=
all
sleepable mutex_lock() from within a hardirq/atomic context?

The HID core triggers the raw_event callback (e.g., kone_raw_event) from an
atomic context when the low-level transport driver completes an URB. This
callback invokes roccat_report_event(), which acquires sleepable mutexes:

drivers/hid/hid-roccat.c:roccat_report_event() {
    ...
	new_value =3D kmemdup(data, device->report_size, GFP_ATOMIC);
	if (!new_value)
		return -ENOMEM;

	mutex_lock(&device->readers_lock);
	mutex_lock(&device->cbuf_lock);
    ...
}

Can this lead to a scheduling while atomic panic or system deadlock upon
receiving device events?

[Severity: High]
This is a pre-existing issue, but does a race between roccat_disconnect() a=
nd
roccat_release() cause a Use-After-Free of the roccat_device structure?

When roccat_disconnect() runs, it releases devices_lock before calling
device_destroy():

drivers/hid/hid-roccat.c:roccat_disconnect() {
    ...
	mutex_lock(&devices_lock);
	device =3D devices[minor];
	mutex_unlock(&devices_lock);

	device->exist =3D 0;

	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
    ...
}

If this is preempted after setting device->exist =3D 0, a concurrent
roccat_release() can lock devices_lock, find devices[minor] is still non-NU=
LL,
decrement device->open to 0, and free the device because exist is 0:

drivers/hid/hid-roccat.c:roccat_release() {
    ...
	if (!--device->open) {
		/* removing last reader */
		if (device->exist) {
            ...
		} else {
			roccat_free_device(device);
		}
	}
    ...
}

When roccat_disconnect() resumes, is it possible that it calls device_destr=
oy()
using the freed device->dev pointer, causing a Use-After-Free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907224426.1591=
04-1-skunkolee@gmail.com?part=3D1
