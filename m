Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75B72C0296
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 22:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787436220; cv=none; b=QuxoXkyTGPbDRtrD8p7ZjWpHkkVb57NfldgV6Dsdu3lg5ZuBIkVY0r8W7gtPknNFylukr1XrpJD53Ud1El1PIzVKGdrKWXo3XROpU+jDirVSAryrUteT9gnO/Tz/ZH9MvelUVCimCYJgmHJ4hLEVqJ4r4NIa8Ko/VV0jsDwR6mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787436220; c=relaxed/simple;
	bh=kVh4CdAi3vvUIf+p0SeXvmSoUly//kaUMNBfkgAlmcs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b/w8HCWckR5YNlDl1NLyvNVwhz3ynf4em0HK/vAb6M/wZ8itkiGgqCCKISq5ukOE8j0yidjziJqWFJZMkh5AvYttjGSGIIm8pC3b1Pzu9ReBwvq5ZX2+U8OEiKxVE5ooa79JdQE30QooWSSNQcM8hDzfxpbst/IMYuG09ej5YIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5a39DuH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5a39DuH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A885A1F000E9;
	Sat, 22 Aug 2026 22:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787436218;
	bh=Y7lpweB1Wklqf0qMtlGQHhfr8p9L+HzbUQy5elcd2dM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k5a39DuHHCq2gih4X/Swf0QMt7zB9+JwUsEZqcdxgJwr4ZMM+x1zfRDxHwXp0+gvb
	 T9jw9YehPiqgaf7nTP781htxs+mVSclf5u8OP6bUZrx6fkmnJxox1usrUPQDlzI0V/
	 mtASAcPz9XfPJyqTT2EUNxdX+SnYnpx7KT63TTYwPoazCG+n1LCFEXa4zHevqBO9BD
	 ddV0ael3knlf497zI4uLbtfQmDXhuRr7dEn6pKjPRwlGWrKfcoJucR99x5EZRTLMdq
	 KlYYbT9AXc2PBE116OU9lBolOmuZ029i6zw8f42wg0lyi6E7INR42E2atIN/Ex1WHl
	 Gc25NVZ0FmQUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/13] HID: ft260: workaround for TN_189 errata endpoint
 STALL after enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Zaidman" <michael.zaidman@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260822213941.98882-13-michael.zaidman@gmail.com>
References: <20260822213941.98882-1-michael.zaidman@gmail.com>
 <20260822213941.98882-13-michael.zaidman@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 22:03:38 +0000
Message-Id: <20260822220338.A885A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Detached reset work item causes a kernel Oops (Use-After-Free) if =
the driver module is unloaded before the work executes.
- [High] A persistently broken FT260 device will trigger an exponential for=
k bomb of reset work items, causing unbounded workqueue growth.
- [Medium] Memory allocation failures unintentionally trigger a full USB de=
vice reset.
- [Low] Passing endpoint address (with direction bit) to `usb_rcvintpipe` i=
nstead of the endpoint number.

Pre-existing issues:
- [High] `hid_hw_open()` is called before driver spinlocks are initialized,=
 allowing incoming HID reports to access uninitialized locks.
--

--- Patch [12]: [PATCH 12/13] HID: ft260: workaround for TN_189 errata endp=
oint STALL after enumeration ---
commit 8891d1670b0f7ce6179bd30f8809f4b07e8b46dc
Author: Michael Zaidman <michael.zaidman@gmail.com>

HID: ft260: workaround for TN_189 errata endpoint STALL after enumeration

This commit introduces a workaround for the FT260 TN_189 errata where USB
interrupt endpoints stall after enumeration. It schedules a delayed work it=
em
to reset the USB device and rebind interfaces if a STALL or unresponsiveness
is detected during probe.

Closes: https://github.com/MichaelZaidman/hid-ft260/issues/40
Link: https://ftdichip.com/wp-content/uploads/2026/05/TN_189-FT260-Errata-T=
echnical-Note.pdf

> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -2359,15 +2359,227 @@ static int ft260_uart_probe(struct ft260_device =
*dev,

[ ... ]

> +static void ft260_reset_and_rebind(struct work_struct *ws)
> +{

[ ... ]

> +	for (i =3D 0; actconfig && i < actconfig->desc.bNumInterfaces; i++) {
> +		struct usb_interface *intf =3D actconfig->interface[i];
> +
> +		if (!intf)
> +			continue;
> +		ret =3D device_attach(&intf->dev);

[Severity: High]
If the device is persistently wedged and continues to fail probe, will this
device_attach() synchronously trigger fresh ft260_probe() calls that fail
and schedule even more work items?=20

For a 2-interface device, failing probe on both interfaces could initially
schedule two reset work items. If each work item unbinds and rebinds all
interfaces, does this risk creating an unbounded exponential loop (a fork
bomb) of work items being queued?

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
> +	schedule_work(&rw->work);

[Severity: High]
When returning -ENODEV from ft260_probe() on error, the driver binding
aborts and the module reference count stays at 0.=20

If an administrator unloads the hid-ft260 module while this scheduled work
item is pending or executing its 10-second retry loop, could the workqueue
execute unmapped memory and trigger a use-after-free panic?

Would it be safer to pin the module with try_module_get()/module_put() or
ensure the work is correctly cancelled on failure?

> +
> +	return 0;
> +}
> +

[ ... ]

> +static int ft260_check_intr_ep_health(struct hid_device *hdev)
> +{

[ ... ]

> +	buf =3D kmalloc(FT260_REPORT_MAX_LEN, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	pipe =3D usb_rcvintpipe(usbdev, ep->bEndpointAddress);

[Severity: Low]
Does usb_rcvintpipe() expect just the endpoint number instead of the raw
endpoint address?

Passing ep->bEndpointAddress includes the direction bit, which gets shifted
incorrectly by the pipe creation macro. Could we use
usb_endpoint_num(&ep->desc) here to ensure only the endpoint number is
passed?

> +	ret =3D usb_interrupt_msg(usbdev, pipe, buf, FT260_REPORT_MAX_LEN,
> +				&actual_length, 100);
> +	kfree(buf);

[ ... ]

> @@ -2392,6 +2604,23 @@ static int ft260_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
>  		goto hid_fail;
>  	}
> =20
> +	/*
> +	 * TN_189 errata workaround: bail out fast on a broken device so
> +	 * that hub_event releases the device lock quickly, allowing the
> +	 * scheduled reset work to acquire it and recover the device.
> +	 */
> +	ret =3D ft260_check_intr_ep_health(hdev);
> +	if (ret) {
> +		ft260_schedule_reset(usbif);

[Severity: Medium]
If ft260_check_intr_ep_health() fails due to a memory allocation error
(-ENOMEM), this broad check will catch it. Could this erroneously schedule
a full USB device reset during system memory pressure rather than just
propagating the -ENOMEM failure?

> +		goto err_hid_stop;
> +	}
> +
> +	ret =3D ft260_check_dev_responsive(hdev);
> +	if (ret) {
> +		ft260_schedule_reset(usbif);
> +		goto err_hid_stop;
> +	}
> +
>  	ret =3D hid_hw_open(hdev);

[Severity: High]
This is a pre-existing issue, but calling hid_hw_open() here starts the
hardware and allows incoming USB events to trigger the driver's report
callbacks immediately.

If an incoming report causes ft260_raw_event() to attempt to acquire
dev->read_lock before it is initialized further down in ft260_probe()
via spin_lock_init(), could this lead to an uninitialized spinlock splat
or kernel crash?

>  	if (ret) {
>  		hid_err(hdev, "failed to open HID HW\n");
>  		goto err_hid_stop;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822213941.9888=
2-1-michael.zaidman@gmail.com?part=3D12
