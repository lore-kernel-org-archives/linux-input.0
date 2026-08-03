Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48784334A4
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785785402; cv=none; b=DuT6oFh3D5Gn1vx1LuUnun6C4rMSwq+j/nUx+Ni7P6M2ZpKoRZNIgMuN+2G76w4Zmhx+Vvb42GKJOmnWCFNhgbHLeLQbRtA8qtjmKOM3h4nCKp1KQlDbJNPCiKF7sYV2UcEyDllwpWEHoNQ6wd1OZ9Lo/zp8IlIBS72SHFVkcIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785785402; c=relaxed/simple;
	bh=cbegjGoMKPVYysQ2P1y/4lV/k90XvTW92OBxMOJMxoM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DPQ6Dyf3yMXdyz/LRWVVx66hDuNv6qpZiAMZNO8XnD92tjJmWwwViti8D0K92YRaMincNVb1+QhS833ITyfXoqaNZX875ErpsQJYUwsZe020vxpYN0kPlXh7+NaSA6gLH7LYdBrAL3ho4QD193y0sZGG/40kqMzl7zGn9QAvBGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovfuN0ub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovfuN0ub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0C11F000E9;
	Mon,  3 Aug 2026 19:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785785400;
	bh=IvSPd9X1I92jGOJv/HWZhc3WPpjD4CORqLERvp+hZCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ovfuN0ubJwPOiHq0Jj0PKkwiNzpMqtmVh7xyZFO8AAtaLoRiist7ohOshMAnkCJ/Y
	 u7WtNlWTziVkSsmzthebesGBqjwHDZ0B74o87+49sCfJuRvCR+hzTRXhPaUsUkFLyC
	 UqafvJWZaBHVD5JlLiHLWVliXUmaKbkf5n/RLx0UJUYwnviat0mPUGQqlMbFkYg6hk
	 ApaF6jyI9/kySUQnjnlipZRsIUp9YXT544AdfxMh9pup/j746xATM/x1tcZBzTeztU
	 B9CgzR2YohRjh64D4VvSP5bt+PW3BU0Apw+sw5X7MPiYcS8fJ8hUPfbg9vVb1GEwZl
	 z5OeEt5/mI/EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/8] HID: steelseries: Add async status interface
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sriman Achanta" <srimanachanta@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260803191553.66368-8-srimanachanta@gmail.com>
References: <20260803191553.66368-1-srimanachanta@gmail.com>
 <20260803191553.66368-8-srimanachanta@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 19:29:59 +0000
Message-Id: <20260803192959.EC0C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `steelseries_get_sibling_sd` function uses `usb_get_intfdata` =
on a sibling USB interface and unconditionally casts the result to `struct =
hid_device *`, which leads to type confusion if a different driver binds to=
 it.
- [High] A concurrent sysfs unbind of the HID driver from the sync interfac=
e can cause `steelseries_get_sibling_sd` to return a freed `steelseries_dev=
ice` (sd) and call `kref_get` on it, leading to a Use-After-Free.
--

--- Patch [7]: [PATCH v7 7/8] HID: steelseries: Add async status interface =
support ---
commit 816a244e480f8271ebf1dbc58fbdbe5e0bdbafab
Author: Sriman Achanta <srimanachanta@gmail.com>

HID: steelseries: Add async status interface support

Some headsets expose a second HID interface that sends battery and
connection updates on its own. Watching that interface lets the driver
stop polling the sync interface.

> diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steel=
series-arctis.c
> --- a/drivers/hid/hid-steelseries-arctis.c
> +++ b/drivers/hid/hid-steelseries-arctis.c
[ ... ]
> @@ -318,6 +320,53 @@ static int steelseries_battery_register(struct steel=
series_device *sd)
> +static struct steelseries_device *
> +steelseries_get_sibling_sd(struct hid_device *hdev, int interface_num)
> +{
> +	struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent);
> +	struct usb_device *usb_dev =3D interface_to_usbdev(intf);
> +	struct usb_interface *sibling_intf;
> +	struct hid_device *sibling_hdev;
> +	struct steelseries_device *sd =3D NULL;
> +
> +	sibling_intf =3D usb_ifnum_to_if(usb_dev, interface_num);
> +	if (!sibling_intf)
> +		return NULL;
[ ... ]
> +	if (!device_trylock(&sibling_intf->dev))
> +		return NULL;
> +	if (sibling_intf->dev.driver) {
> +		sibling_hdev =3D usb_get_intfdata(sibling_intf);
> +		if (sibling_hdev &&
> +		    sibling_hdev->driver =3D=3D &steelseries_arctis_driver) {

[Severity: High]
Is it safe to assume sibling_intf is bound to usbhid here?

If an attacker plugs in a crafted USB device, the async interface could be
bound to a different driver (like usbfs or usbmouse). Since
usb_get_intfdata() is unconditionally treated as a struct hid_device
pointer, checking sibling_hdev->driver could result in an out-of-bounds
read if the bound driver's data structure is smaller.

> +			sd =3D hid_get_drvdata(sibling_hdev);
> +			if (sd)
> +				kref_get(&sd->refcnt);

[Severity: High]
Could a concurrent unbind of the HID driver cause a use-after-free on sd?

While the USB interface lock (&sibling_intf->dev) is held here, this
doesn't serialize against a sysfs unbind of the HID driver. If a user
unbinds the HID driver from the sibling interface via sysfs, the HID core's
hid_device_remove() calls the driver's remove callback (which drops the
refcount and frees sd), and only clears hdev->driver afterwards.

This could allow hid_get_drvdata() to return a pointer to a freed
steelseries_device, leading to a kref_get() on freed memory.

> +		}
> +	}
> +	device_unlock(&sibling_intf->dev);
> +
> +	return sd;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803191553.6636=
8-1-srimanachanta@gmail.com?part=3D7
