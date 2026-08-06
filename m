Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3E16FC5
	for <linux-input@vger.kernel.org>; Thu,  6 Aug 2026 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997249; cv=none; b=Er7yLaDHvcXw/uG2gW4wjrr/y3S6fqSl9kQHdtcuPIl7b/mxfxjmhA/kIXrcDnx8iFqqPGTy4GM2eRPjuY5ZwZTdly5InUtRMVYVK21h5wMOc2hf2QykKJYMvAABB6BmK8EmPQw4bPean0Wdaf6ifmcO0rKnvqk3dFz/6QbPX84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997249; c=relaxed/simple;
	bh=Jq+A+0NUQMLL66kXdF6NKSA1hK3k15GLcN8fbkJzgu8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QGXlml0cRtMPfShG0J76mN3/ZWFMIOYClLhriIrw0iz1e3JneOQl/+owe/uz1cNIPOhQzTXZFJJW1slS0J9mx6LYr5kQG87KYQHH7hB9/IrAqXKR9M3p3iXyhx5CXY07ILU47F8CN9rkAw9nDqtVQIrdw+BUI1LQLnJXphwocuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKUaw70o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKUaw70o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4867E1F000E9;
	Thu,  6 Aug 2026 06:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785997247;
	bh=CmQ4uz1PR/s85C0riRKXKFsweRBDGhtLE2gP23k1GKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bKUaw70owT6cB+VzXrS3o3tJ1wLOrSjB/cAF7nYkwNRFJer7NCLkM7/FIVwStzhC5
	 KmGlfyUCcw5IpjhSE+kvm0KGu/uMLNSV3L3DxTkcqGEuCYRwzy4P84ATLVs/+qze/S
	 aiUzFHcXvzUgwY9Ujhz9/rczTvGJHSDq9puZtxTWMMedGUZ4asRibT2riB4hoT+eNZ
	 wn4sfnp0SGQkAnE9ms/hQ+CP5yjYFyY+gHdb1CRefXyZ1ZjJEU3qHX7Uk3WlVtfhzi
	 /C7B/yb4qBBARl6mc5wday7b7m7Y/yaZJ1AX+IATs3Bfs11E6iR9vfdxW2gXHuk/9C
	 2Evfi3Mtduv5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: roccat: fix device lifetime during disconnect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hongyan Xu" <getshell@seu.edu.cn>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260806060512.1664-1-getshell@seu.edu.cn>
References: <20260806060512.1664-1-getshell@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 06:20:46 +0000
Message-Id: <20260806062047.4867E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] roccat_report_event() acquires mutexes while running in atomic con=
text
- [High] roccat_report_event() dereferences NULL pointer and accesses freed=
 memory due to concurrent disconnect
- [High] Roccat sub-drivers trigger Use-After-Free by freeing driver data b=
efore stopping HID hardware
- [High] roccat_connect() exposes uninitialized device to userspace
--

--- Patch [1]: [PATCH] HID: roccat: fix device lifetime during disconnect -=
--
commit 5e229d8ced35e1abadf95620f08339c5580af3c2
Author: Hongyan Xu <getshell@seu.edu.cn>

    HID: roccat: fix device lifetime during disconnect
   =20
    roccat_disconnect() drops devices_lock after loading the device pointer=
. A
    concurrent release of the last reader can then free the device before
    disconnect continues to access it. Release also looks the device up by
    minor, so closing a file after disconnect either leaks its reader when =
the
    slot is NULL or operates on a replacement device if the minor was reuse=
d.
   =20
    Keep devices_lock held while disconnect marks and removes the device, a=
nd
    have release use the device retained by its reader. The open count then
    keeps a disconnected device alive until the final file is released.

> diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
> index d6fff53d4ee7a..4f504e7575e8c 100644
> --- a/drivers/hid/hid-roccat.c
> +++ b/drivers/hid/hid-roccat.c
[ ... ]
> @@ -360,15 +352,12 @@ void roccat_disconnect(int minor)
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

[Severity: High]
This isn't a bug introduced by this patch, but does clearing devices[minor]
here race with concurrent event reporting?

Roccat sub-drivers (like kone) call roccat_disconnect() before they stop the
hardware with hid_hw_stop(). Since events can still arrive, could
roccat_report_event() dereference a null pointer?

drivers/hid/hid-roccat.c:roccat_report_event() {
    ...
    device =3D devices[minor];

    new_value =3D kmemdup(data, device->report_size, GFP_ATOMIC);
    ...
}

If it fetches devices[minor] after it is cleared here, it will crash on
device->report_size. Alternatively, could this cause a use-after-free if it
fetches the pointer just before it is cleared but accesses it after it is
freed?

> -	mutex_unlock(&devices_lock);
> =20
>  	if (device->open) {
>  		hid_hw_close(device->hid);
[ ... ]

While looking at roccat_report_event(), I noticed another pre-existing issu=
e.

[Severity: High]
This isn't a bug introduced by this patch, but does roccat_report_event()
illegally acquire sleeping locks in atomic context?

When a roccat device receives an event from the hardware, the usb completion
handler runs in softirq (atomic) context. This calls the hid driver's
raw_event callback, which calls roccat_report_event().

drivers/hid/hid-roccat.c:roccat_report_event() {
    ...
    new_value =3D kmemdup(data, device->report_size, GFP_ATOMIC);
    if (!new_value)
        return -ENOMEM;

    mutex_lock(&device->readers_lock);
    mutex_lock(&device->cbuf_lock);
    ...
}

While the function correctly uses GFP_ATOMIC for allocations, it then
immediately calls mutex_lock(). Since mutexes can sleep, won't locking them
in an interrupt/atomic context cause a scheduling while atomic panic?

Looking at the device initialization in roccat_connect():

[Severity: High]
This is a pre-existing issue, but does roccat_connect() expose an
uninitialized device to userspace?

drivers/hid/hid-roccat.c:roccat_connect() {
    ...
    device->dev =3D device_create(klass, &hid->dev,
            MKDEV(roccat_major, minor), NULL,
            "%s%s%d", "roccat", hid->driver->name, minor);
    ...
    mutex_unlock(&devices_lock);

    init_waitqueue_head(&device->wait);
    INIT_LIST_HEAD(&device->readers);
    mutex_init(&device->readers_lock);
    mutex_init(&device->cbuf_lock);
    ...
}

The device node is published to userspace via device_create() and then the
global devices_lock is dropped. This allows userspace to open the device
node before critical state like readers_lock and cbuf_lock are initialized.

Could a concurrent roccat_open() access these uninitialized fields and cause
a crash?

Finally, regarding the sub-driver cleanup sequence:

[Severity: High]
This isn't a bug introduced by this patch, but do the roccat sub-drivers
trigger a use-after-free during removal?

In kone_remove(), the driver data is freed via kone_remove_specials() before
the hardware is stopped:

drivers/hid/hid-roccat-kone.c:kone_remove() {
    kone_remove_specials(hdev);
    hid_hw_stop(hdev);
}

drivers/hid/hid-roccat-kone.c:kone_remove_specials() {
    ...
        kfree(hid_get_drvdata(hdev));
    ...
}

Since hid_hw_stop() is called after the memory is freed, events can still
arrive. The interrupt handler then accesses the freed struct kone_device:

drivers/hid/hid-roccat-kone.c:kone_raw_event() {
    struct kone_device *kone =3D hid_get_drvdata(hdev);
    ...
    if (memcmp(&kone->last_mouse_event.tilt, &event->tilt, 5))
    ...
}

Will this cause memory corruption or a crash when the device is disconnecte=
d?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806060512.1664=
-1-getshell@seu.edu.cn?part=3D1
