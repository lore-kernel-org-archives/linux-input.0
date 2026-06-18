Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CEB317176
	for <linux-input@vger.kernel.org>; Thu, 18 Jun 2026 03:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781752708; cv=none; b=aGmLpc27kOhF8iMA1EjEzcuusu9dc/cL65pyBkaue4YPmHHuH+cfKHeshXAhZG4HU2WGuf34vzydiSI+r9DqtuRqELnjmybf936/YDQsdRKQqpSvlxHLZql9Hg2upbkIt+r+vSsDU49mREDj7q7EhCaO6iVt3x2P70HPBiE/zw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781752708; c=relaxed/simple;
	bh=6ngIlVHZCPFDRSeZc6sLWLAf710C1eDIO3SlN/4SAoI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iwmQ1t3cQROI94LYzGxue9VZzKcVqhPdpC08ocnYv6u038CVjUawjGuVMu1HvTPQuunf3Zr186h+P2TjrNuP7ooKywTzac/jhIE9JKMQfTLtXdPEwN9etw+zcTYxsvc4Q8oa9oQzUfeOVpB5rVPMLPEL6T3tJu2Li5gEL7t9ick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jwo/3SC3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jwo/3SC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004F51F000E9;
	Thu, 18 Jun 2026 03:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781752706;
	bh=p0qxJ6IduLrfU6IWv9zuihVQdE2/Dr8uJIENUOiFFjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jwo/3SC3NSHrARGCr5CGO2z76Sf6yKA2utUFuzu1uKGaRCSTkuDu1ARvIZkyTuu6B
	 v2BUYCKamhl71GzNgd6dU7RKzVhD6uPqw1vO/7UG/1d9xqIb+/rHdwUw42Uy+klBRX
	 c4AKJLBbSE+xoV8ghHAskRpSlSo/D3ZnkrJQuQD8JtihV92GBQ/usu8NfUEFk73qoL
	 uSWPOImmYtKGGcB1noPG3w7IcQyKTdmHvwG2gArAlFFVZoywXPdxWDWlSQ7Nafb+ls
	 skQp6eQcAH6tJhCg0GvedZ2FIfwFKwN/Up38PaeDMvPI/3B5/sKwV3G2X6g6W9hz76
	 aryBL6AV41cyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] HID: roccat: bound device-supplied profile index
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Bommarito" <michael.bommarito@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260618030036.1880139-2-michael.bommarito@gmail.com>
References: <20260618030036.1880139-1-michael.bommarito@gmail.com>
 <20260618030036.1880139-2-michael.bommarito@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 03:18:25 +0000
Message-Id: <20260618031826.004F51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Closing a stale roccat character device file descriptor after devi=
ce removal causes a memory leak, state corruption and Use-After-Free.
- [High] `kone_get_profile()` uses an embedded, unaligned struct field (`&k=
one->profiles[i]`) as a DMA buffer for inbound USB control messages, leadin=
g to cache-line sharing corruption.
--

commit cda04d8cb7b50c97cbcee76f405a2121b1b4c56d
Author: Michael Bommarito <michael.bommarito@gmail.com>

HID: roccat: bound device-supplied profile index

kone_keep_values_up_to_date() and kone_profile_activated() use an
8-bit, device-supplied profile value as an index into the 5-element
kone->profiles[] array without a range check. A malicious USB device
claiming the Roccat Kone id can send a switch-profile event (or a
startup_profile read at probe) with an out-of-range value and make the
driver read out of bounds; the result is exposed via the actual_dpi
sysfs attribute.

> diff --git a/drivers/hid/hid-roccat-kone.c b/drivers/hid/hid-roccat-kone.c
> index 58654cf78f0df..17495fcc8b7da 100644
> --- a/drivers/hid/hid-roccat-kone.c
> +++ b/drivers/hid/hid-roccat-kone.c

[ ... ]

> @@ -793,8 +795,10 @@ static void kone_keep_values_up_to_date(struct kone_=
device *kone,
>  {
>  	switch (event->event) {
>  	case kone_mouse_event_switch_profile:
> -		kone->actual_dpi =3D kone->profiles[event->value - 1].
> -				startup_dpi;
> +		if (event->value >=3D 1 &&
> +		    event->value <=3D ARRAY_SIZE(kone->profiles))
> +			kone->actual_dpi =3D
> +				kone->profiles[event->value - 1].startup_dpi;
>  		fallthrough;
>  	case kone_mouse_event_osd_profile:
>  		kone->actual_profile =3D event->value;

[Severity: High]
This is a pre-existing issue, but does kone_get_profile() use an embedded,
unaligned array element as a DMA buffer?

In kone_init_kone_device_struct(), we call kone_get_profile() passing a
pointer to the embedded array element:

drivers/hid/hid-roccat-kone.c:kone_init_kone_device_struct() {
    ...
    retval =3D kone_get_profile(usb_dev, &kone->profiles[i], i + 1);
    ...
}

Which then passes the unaligned buffer directly to usb_control_msg() for a
USB_DIR_IN transfer:

drivers/hid/hid-roccat-kone.c:kone_get_profile() {
    ...
    len =3D usb_control_msg(usb_dev, usb_rcvctrlpipe(usb_dev, 0),
            USB_REQ_CLEAR_FEATURE,
            USB_TYPE_CLASS | USB_RECIP_INTERFACE | USB_DIR_IN,
            kone_command_profile, number, buf,
            sizeof(struct kone_profile), USB_CTRL_SET_TIMEOUT);
    ...
}

Since sizeof(struct kone_profile) is 975 bytes, the array elements are not
cache-line aligned and share cache lines with other struct kone_device
members. Because hid_hw_start() is called earlier, the device can generate
interrupts and concurrent writes to these shared fields may occur.

On architectures with non-coherent DMA caches, won't the cache invalidation
required for the inbound USB DMA wipe out these concurrent CPU writes,
leading to state corruption?


[Severity: High]
This is a pre-existing issue, but can roccat_release() cause a memory leak,
list corruption, and Use-After-Free if a stale file descriptor is closed
after device removal?

When closing the file descriptor, roccat_release() retrieves the device from
the global array instead of using the local reader->device:

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

If the original device was disconnected, devices[minor] is cleared, causing
roccat_release() to return -ENODEV and permanently leak the roccat_reader
allocation and the original roccat_device.

If a new device is plugged in before the stale file descriptor is closed,
devices[minor] resolves to the new device. roccat_release() then operates on
the new device, locking its readers_lock while modifying the old device's
list:

drivers/hid/hid-roccat.c:roccat_release() {
    ...
    list_del(&reader->node);
    ...
    if (!--device->open) {
    ...
}

Could this lead to list corruption and incorrectly decrement the new device=
's
open count, causing premature shutdown and a Use-After-Free of the new devi=
ce
when legitimate users close their descriptors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618030036.1880=
139-1-michael.bommarito@gmail.com?part=3D1
