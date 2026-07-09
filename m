Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C029393DC8
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 03:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783568273; cv=none; b=NY2BX2Ueb2xHtGlB1sZgFPgTD+jCVvqjr6r6UgZVASmbw8+2XaO4xsWS9fFVEt0V7l7iLlN3sYCGGRBme1vvb/O24lyI133f2N/8Dn0IaXJ1fAQGulCJJA2mmShtuAc79mRaga8z1XFhSWHnH44ckm77V0yBSmxu9pLR4f/otJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783568273; c=relaxed/simple;
	bh=TOmqMrdiBH0oiu8hU6m5AO4yGORTsEOCzs39cInO0RY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IfMknOw4/4j3QsKSigi2bkK4mpne4EkM974dWIQkSe7ThR0fpaAcoHoh5SD1/uEeTiCkU5gQ4JNuS5pG/iwUtznC1p3WjfJvjP5nwn65DJAwdx2cDf27n02muWPkzCzPuZS2YfHU6+FJMg5F/lFzVJM+zFmKfUv5bpKg080BMXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7vorhBv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7vorhBv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907051F000E9;
	Thu,  9 Jul 2026 03:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783568271;
	bh=uceH6OYvyQR1G3HK+e9icjEU2qbrL58TgTwTAWq3JzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j7vorhBvGQT8Y3k1/gEacGFf3lD7ymHH9Bwf6twimGmFB6t8kRACJEgTD0ViO6X7r
	 q7qigqelT1gZKkL7JsWKh7bk3QBxYidJMuWDsnyrrcVdCBdw+cfz6n70z1ZAWUL+9i
	 sBy53rgq+pd3pTKZgItXJpKPxDRpx3AglOuV3vai/QeQu+f05M6EgYzDuNr+Nr+cBP
	 IZXGxCszoncywMct0zkhSkM4tKDzYTbKNO/wJGwJ7OTJEKu+mvGzhaDUfUkj4G37HD
	 o7tyeZujoz2WF+Xvj3oF0IASJxFZ22PEpuDnAwfzN60fWn6Hx41b+NGBcE3HHvwdEN
	 isnjs8DNyR+4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/9] HID: steelseries: Add async status interface
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sriman Achanta" <srimanachanta@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260709032316.1908460-9-68172138+srimanachanta@users.noreply.github.com>
References: <20260709032316.1908460-1-68172138+srimanachanta@users.noreply.github.com>
 <20260709032316.1908460-9-68172138+srimanachanta@users.noreply.github.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 03:37:51 +0000
Message-Id: <20260709033751.907051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] A concurrent unbinding of the sync interface's HID driver via sysf=
s can result in a Use-After-Free of the `steelseries_device` object during =
the async interface's probe.
- [High] Blindly casting `usb_get_intfdata()` to `struct hid_device *` caus=
es a Type Confusion and Out-Of-Bounds Read if another driver is bound to th=
e sibling interface.
- [Medium] The `async_interface` field treats `0` as a sentinel value for '=
not present', which will break for devices where the async interface is act=
ually at index 0.
--

--- Patch [8]: [PATCH v6 8/9] HID: steelseries: Add async status interface =
support ---
commit b3e51c178159f4ed7f8fb3b18ebfac675c1ff9b7
Author: Sriman Achanta <srimanachanta@gmail.com>

HID: steelseries: Add async status interface support

This patch adds support for a second HID interface that asynchronously sends
battery and connection updates. It binds both sync and async interfaces,
deferring the async one until the sync interface is ready.

> diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steel=
series-arctis.c
> index e534aa44e70a0..9960c0ec512bf 100644
> --- a/drivers/hid/hid-steelseries-arctis.c
> +++ b/drivers/hid/hid-steelseries-arctis.c
[ ... ]
> @@ -318,6 +320,53 @@ static int steelseries_battery_register(struct steel=
series_device *sd)
>  	return 0;
>  }
> =20
> +static struct hid_driver steelseries_arctis_driver;
> +
> +static struct steelseries_device *
> +steelseries_get_sibling_sd(struct hid_device *hdev, int interface_num)
> +{
[ ... ]
> +	if (!device_trylock(&sibling_intf->dev))
> +		return NULL;
> +	if (sibling_intf->dev.driver) {
> +		sibling_hdev =3D usb_get_intfdata(sibling_intf);
> +		if (sibling_hdev &&
> +		    sibling_hdev->driver =3D=3D &steelseries_arctis_driver) {

[Severity: High]
Does casting usb_get_intfdata() directly to a hid_device risk a type
confusion and out-of-bounds read?

If another driver (like usbfs via userspace claiming the interface) is
bound to the sync USB interface, usb_get_intfdata() would return that
driver's data (e.g., a much smaller struct usb_dev_state).

Reading sibling_hdev->driver would then read far past the bounds of that
smaller struct.

> +			sd =3D hid_get_drvdata(sibling_hdev);
> +			if (sd)
> +				kref_get(&sd->refcnt);

[Severity: High]
Is there a race condition here that could lead to a use-after-free of
the steelseries_device object?

The code acquires the parent USB interface lock
(device_trylock(&sibling_intf->dev)), but not the child hid_device lock.

If the HID driver of the sync interface is unbound via sysfs while the
async interface is actively probing, steelseries_arctis_remove() could be
executed, freeing 'sd'.

Is there a window before the driver core clears sibling_hdev->driver and
drvdata where this probing thread could call kref_get() on the freed 'sd'?

> +		}
> +	}
> +	device_unlock(&sibling_intf->dev);
> +
> +	return sd;
> +}
[ ... ]
> @@ -339,43 +388,81 @@ static int steelseries_arctis_probe(struct hid_devi=
ce *hdev,
>  	if (ret)
>  		return ret;
> =20
> -	/* Let hid-generic handle non-sync interfaces */
> -	if (interface_num !=3D info->sync_interface)
> +	/* Let hid-generic handle non-vendor or unknown interfaces */
> +	if (interface_num !=3D info->sync_interface &&
> +	    (!info->async_interface || interface_num !=3D info->async_interface=
))

[Severity: Medium]
Will this logic prevent devices from using interface 0 as the async
interface?

USB interfaces are zero-indexed, making 0 a valid interface number, but
evaluating !info->async_interface treats 0 as a sentinel "not present"
value.

>  		return hid_hw_start(hdev, HID_CONNECT_DEFAULT);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709032316.1908=
460-1-68172138+srimanachanta@users.noreply.github.com?part=3D8
