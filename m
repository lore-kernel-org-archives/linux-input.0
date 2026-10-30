Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793401197;
	b=cSj9DH80ahuvNaJhp/JB9dbleogZXL2l512tHDj+Mi825rZWZ9A9BRe+4O9upHoZxpRr
	 mfwMHTncRAQC6JPn9LqD1yd2j+LdxDZI36IEXCRTuewKRLnlk9PrU6J+bWDsNW4TPnfog
	 t1zHeUeMTSQKIs66tbnmTJH22iolHmK3M8RQvSDl18KNTvnijIQ5q1vrLnB3auVVBUd4A
	 k0f2umRzcFSxgg3ReVSWekIpoJL2+/qlhf8twprmr0b5XPiaaQocjnXxEO4FVA2ZG3VB6
	 qn6BXQMKyPPgzSCpdxj8n3Q+aBEbPz/ExVPXiLNC2xnH851z8iWLxB3Ap+lSN1aYFUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793401197;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PgZ+9Qt2QbNTt/+Nqt/K0H9j0xEk5jXp4WJtgKzNahM=;
	b=aRNVat9Lh/Q4igQcXzibzPlgK8KntEmbBZ81DWvdKD1OkbUzjjSzAvyDV8Bpawe1PQKS
	 8trOs3Iy/rAHSKmPXFoW5nxiy2GHV20WqF04TcNbX0Pi00RewpuRBPpy9Px9aV1AK4gBK
	 Fsg+gp6HKutC0K7WBKf/f4eGr8S49yu+N1FUub233i5Pp8AvvF98RXTUMEzVwOli0MO2D
	 30YC+EMQc2z6r27nXYCTUqRzCBuC5bgAsc2F/ep2YJbzTdNIy+v0wiqKlnvcTJXwSxg8l
	 mmzt87ntrfTj3GWphKjT0fipblHCAxzwxUm18srCnurO7e35ar+WM4J7JSF4WjY+wDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MbBzwA8k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED86606A31A;
	Fri, 30 Oct 2026 22:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MbBzwA8k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A366B1F000C1;
	Fri, 30 Oct 2026 22:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793401196;
	bh=PgZ+9Qt2QbNTt/+Nqt/K0H9j0xEk5jXp4WJtgKzNahM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MbBzwA8k461orMv1EOA/67IIO9UNBR2z70aKQLDo6rLlEmtRajkKzqiJWg+nXXqpp
	 i2cAPkLDRhHz8XX7mvwBCYNgJfGlPwogBJSzstIyU87Y9uTtOzqY0HzNDPuRn/L9CY
	 p5ofOzoWoxGlMg1DkD50fGFSl5VTa0FlMV63TIVGCQ4xltLZf3hHfOkLhjsYmOyXhx
	 9th3R0bJ7MQs/NYiclpZNgMe4KU5PWAk6mMjHQy3FTXPouF5huhuJPMbLhTO71b3MB
	 nH/274k1/UwGdXtztnhxI+CFV5OtrTldaP7USDuLtK3AlOg6eM8n86mx578wrFUdcn
	 2Rj6F/EtQ+RTA==
Message-ID: <sashiko-outbox-191610@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/15] HID: ft260: workaround for TN_189 errata
 endpoint STALL after enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261030223637.86907-12-michael.zaidman@gmail.com>
References: <20261030223637.86907-1-michael.zaidman@gmail.com>
 <20261030223637.86907-12-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 22:59:56 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] HID: ft260: duplicate per-interface resets in ft260_schedule_reset=
()
- [Medium] HID: ft260: race between ft260_reset_and_rebind() and sibling ft=
260_probe()
- [Low] HID: ft260: ft260_check_dev_responsive() masks -ENOMEM as -ENODEV
--

commit d1a110e7b9317417bd055dbbded2a9eda4b1e754
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: workaround for TN_189 errata endpoint STALL after enumeration

This patch adds an in-driver workaround for FTDI errata TN_189 where the
FT260's USB interrupt endpoints are occasionally halted after enumeration.
During probe, the driver checks interrupt endpoint health and device
responsiveness, and on failure schedules deferred work on an ordered
workqueue to reset the USB device and rebind all of its interfaces.

Link: https://ftdichip.com/wp-content/uploads/2026/05/TN_189-FT260-Errata-T=
echnical-Note.pdf

> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 65835e13fa2ad..923ce6ee9dcfd 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c

[ ... ]

> @@ -2396,15 +2397,229 @@ static int ft260_uart_probe(struct ft260_device =
*dev,
>  	return ret;
>  }
> =20
> +/*
> + * FT260 errata TN_189 Section 2.1: the USB interrupt endpoints are
> + * occasionally halted right after enumeration. When this happens:
> + *  - Standard Clear-Feature ENDPOINT_HALT does not recover the endpoint
> + *  - Subsequent communication with the device is dead
> + *  - The only known recovery is a USB device reset
> + *
> + * A separate finding from FTDI engineering (confirmed by USB analyzer
> + * trace while testing this workaround) is that the FT260 does NOT
> + * honestly report the halt state via USB_REQ_GET_STATUS: it returns 0
> + * even when the endpoint is STALLed. Detection must therefore observe
> + * the STALL handshake at the host controller level rather than ask
> + * the device.
> + *
> + * Recovery is performed by a deferred work item that resets the USB
> + * device and unbinds/rebinds all interfaces to force usbhid to
> + * destroy stale HID devices and create fresh ones, which triggers a
> + * new ft260_probe() that succeeds.
> + *
> + * https://ftdichip.com/wp-content/uploads/2026/05/TN_189-FT260-Errata-T=
echnical-Note.pdf
> + */
> +struct ft260_reset_work {
> +	struct work_struct work;
> +	struct usb_interface *usbif;
> +};
> +
> +static struct workqueue_struct *ft260_reset_wq;
> +
> +static void ft260_reset_and_rebind(struct work_struct *ws)
> +{
> +	struct ft260_reset_work *rw =3D
> +		container_of(ws, struct ft260_reset_work, work);
> +	struct usb_interface *usbif =3D rw->usbif;
> +	struct usb_device *usbdev =3D interface_to_usbdev(usbif);
> +	struct usb_host_config *actconfig;
> +	int ret, i, attempt;
> +
> +	/*
> +	 * Retry the device lock for up to ~10 seconds. The lock is held
> +	 * by hub_event for the duration of device enumeration; with the
> +	 * fast-fail responsiveness check in probe, both interfaces should
> +	 * abort within ~1-2 seconds, after which the lock becomes free.
> +	 * Each usb_lock_device_for_reset() attempt already polls for up to
> +	 * one second internally.
> +	 */
> +	for (attempt =3D 0; attempt < 10; attempt++) {
> +		ret =3D usb_lock_device_for_reset(usbdev, NULL);
> +		if (ret >=3D 0)
> +			break;

[Severity: Medium]
Can ft260_reset_and_rebind() race with a concurrent ft260_probe() on the
sibling HID interface when the driver is loaded after USB enumeration has
already finished?

When an FT260 device in the TN_189 errata state is enumerated before
hid-ft260 is loaded, usbhid_probe() registers both hid_device instances and
hub_event releases usb_lock_device(usbdev). When udev later loads hid-ft260
(or the driver is bound via sysfs), __hid_register_driver() probes the HID
devices sequentially on hid_bus_type without holding usb_lock_device(usbdev=
).

When interface 0 fails ft260_check_intr_ep_health() or
ft260_check_dev_responsive() in ft260_probe(), it queues
ft260_reset_and_rebind() on ft260_reset_wq and returns -ENODEV. While the
module init thread moves on to probe interface 1, the worker thread on
another CPU can immediately acquire usb_lock_device_for_reset(usbdev, NULL)
and run usb_reset_device(usbdev) and device_release_driver(&intf->dev)
concurrently with interface 1 running usbhid_start(), USB transfers, and
usbhid_stop() in ft260_probe().

In particular, usb_reset_device() invokes hid_pre_reset() -> hid_cease_io()
-> usb_kill_urb() without holding usbhid->mutex while interface 1's error
path in ft260_probe() -> hid_hw_stop() -> usbhid_stop() calls usb_free_urb(=
),
and interface 1's failing probe will also queue a redundant reset work item.

> +		if (ret =3D=3D -ENODEV || ret =3D=3D -EHOSTUNREACH) {
> +			dev_dbg(&usbif->dev,
> +				"device gone before reset (%d), abort\n", ret);
> +			goto out;
> +		}
> +		/* -EBUSY: someone else holds the lock; retry. */
> +	}
> +	if (ret < 0) {
> +		dev_err(&usbif->dev,
> +			"failed to acquire USB device lock for reset after %d attempts: %d\n",
> +			attempt, ret);
> +		goto out;
> +	}
> +
> +	ret =3D usb_reset_device(usbdev);
> +	if (ret < 0) {
> +		dev_err(&usbif->dev, "USB reset failed: %d\n", ret);
> +		usb_unlock_device(usbdev);
> +		goto out;
> +	}
> +
> +	/*
> +	 * usb_reset_device() keeps usbhid bound (its pre_reset/post_reset
> +	 * both return 0) and does not re-trigger HID-level driver probing.
> +	 * Unbind and rebind all USB interfaces to force usbhid to destroy
> +	 * stale HID devices and create new ones, which triggers fresh
> +	 * ft260_probe() calls.
> +	 */
> +	actconfig =3D usbdev->actconfig;
> +	for (i =3D 0; actconfig && i < actconfig->desc.bNumInterfaces; i++) {
> +		struct usb_interface *intf =3D actconfig->interface[i];
> +
> +		if (intf && intf->dev.driver)
> +			device_release_driver(&intf->dev);
> +	}
> +	for (i =3D 0; actconfig && i < actconfig->desc.bNumInterfaces; i++) {
> +		struct usb_interface *intf =3D actconfig->interface[i];
> +
> +		if (!intf)
> +			continue;
> +		ret =3D device_attach(&intf->dev);
> +		if (ret < 0)
> +			dev_err(&intf->dev,
> +				"failed to rebind USB interface: %d\n", ret);
> +	}
> +
> +	usb_unlock_device(usbdev);
> +out:
> +	usb_put_intf(usbif);
> +	kfree(rw);
> +}
> +
> +static int ft260_schedule_reset(struct usb_interface *usbif)
> +{
> +	struct ft260_reset_work *rw;
> +
> +	rw =3D kmalloc_obj(*rw, GFP_KERNEL);
> +	if (!rw)
> +		return -ENOMEM;
> +
> +	usb_get_intf(usbif);
> +	rw->usbif =3D usbif;
> +	INIT_WORK(&rw->work, ft260_reset_and_rebind);
> +	queue_work(ft260_reset_wq, &rw->work);
> +
> +	return 0;
> +}

[Severity: High]
As reported by Sashiko on v1 [1], since the FT260 in composite modes
(FT260_MODE_ALL and FT260_MODE_BOTH) exposes two USB HID interfaces on the
same struct usb_device, won't scheduling an independent ft260_reset_work
item per failing interface cause a redundant reset that tears down the
already-recovered device and multiply pending work items on repeated
failures?

During enumeration under hub_event, usb_set_configuration() probes both
interface 0 and interface 1 while holding the USB device lock. When the
chip hits the TN_189 state, ft260_probe() fails on both interfaces and calls
ft260_schedule_reset(usbif) twice, queueing two ft260_reset_work items on
ft260_reset_wq for the same usb_device.

Once hub_event releases the USB device lock:

1. The first work item runs ft260_reset_and_rebind(), calls
   usb_reset_device(usbdev), and loops over all interfaces in
   actconfig->desc.bNumInterfaces calling device_release_driver(&intf->dev)
   and device_attach(&intf->dev). When the first reset recovers the chip,
   device_attach() synchronously runs usbhid_probe() and ft260_probe() on
   both interfaces, registering the live I2C adapter, GPIO chip, and
   /dev/ttyFT* port.

2. Immediately after the first work item unlocks usbdev, the second work
   item queued during initial enumeration runs ft260_reset_and_rebind().
   Because ft260_schedule_reset() does not deduplicate per usb_device and
   ft260_reset_and_rebind() does not check whether the interfaces are
   already bound and healthy, it unconditionally resets the healthy USB
   device a second time and calls device_release_driver(&intf->dev) on all
   interfaces, invoking ft260_remove() to tear down the active I2C adapter,
   GPIO chip, and TTY device that were just registered.

3. If a reset does not recover the device on the first attempt (or the
   device is persistently unresponsive), each execution of
   ft260_reset_and_rebind() consumes one work item from ft260_reset_wq
   while its device_attach() loop synchronously triggers failing
   ft260_probe() calls on both interfaces that queue two new
   ft260_reset_work items, causing the workqueue backlog to grow on every
   reset cycle.

[ ... ]

> +static int ft260_check_dev_responsive(struct hid_device *hdev)
> +{
> +	struct usb_interface *usbif =3D to_usb_interface(hdev->dev.parent);
> +	struct usb_device *usbdev =3D interface_to_usbdev(usbif);
> +	__le16 *status;
> +	int ret;
> +
> +	status =3D kmalloc_obj(*status, GFP_KERNEL);
> +	if (!status)
> +		return -ENOMEM;
> +
> +	ret =3D usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0),
> +			      USB_REQ_GET_STATUS,
> +			      USB_DIR_IN | USB_RECIP_DEVICE,
> +			      0, 0, status, sizeof(*status), 500);
> +	kfree(status);
> +
> +	if (ret < 0) {
> +		hid_warn(hdev,
> +			 "device unresponsive to GET_STATUS (%d), suspected TN_189 errata, sc=
heduling USB reset and rebind\n",
> +			 ret);
> +		return -ENODEV;
> +	}

[Severity: Low]
In ft260_check_dev_responsive(), usb_control_msg() allocates a struct
usb_ctrlrequest and a struct urb (via usb_internal_control_msg() ->
usb_alloc_urb()) with GFP_NOIO and returns -ENOMEM if either allocation
fails.

Because the check afterward converts any negative return value (ret < 0) to
-ENODEV, an -ENOMEM failure inside usb_control_msg() will log the TN_189
warning and return -ENODEV to ft260_probe(), which then calls
ft260_schedule_reset(usbif). Should ft260_check_dev_responsive() propagate
ret directly when ret =3D=3D -ENOMEM before converting other negative error=
s to
-ENODEV?

[1] https://lore.kernel.org/r/20260822213941.98882-13-michael.zaidman@gmail=
.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030223637.8690=
7-1-michael.zaidman@gmail.com?part=3D11
