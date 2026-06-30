Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890E1A9B58
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 17:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782841155; cv=none; b=tNPIozJpqfpskuZWH9q8XWTwPBn0AZfmZ3nOEkkMmiusF8LGLpXzhwTuowA1i5FBn5HNRwhIQqQ3gKVCmeOjgtuxFNlvjoWSYqSDoPn8gh9wtU/922hoGqSwfSE0zABPDn0IrRw/JmuZXsAwCti/+VD07EHi03ZIAkMM2l+VDEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782841155; c=relaxed/simple;
	bh=5Uny3ir2A9ciqgowrsQpSxBvB24UNwykyV9kdyR7lz8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FCn3hZfSgRUl5cCngv9BMJJF9x9YachPMSe9AgSmfB+TX29zXzCvOfJRExCECLtDSyfQPtAPF70lZtbJ5eKwAuXoqG95FD9plXVV9kb+Dm8LxZE76VAuuUodv7Jkw1DU/iVF5skhRPSu7hG0Yr7iJBO8PlCC26QkZc0DJrHOu2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bw/ZTol+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw/ZTol+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EEC1F000E9;
	Tue, 30 Jun 2026 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782841154;
	bh=qi6r0u4lAvokOTqz0mb95QZjpzlMamT9JyPz/7Aa2OA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bw/ZTol+r+QAvgoepdDY0kv9wOrCifDy1xAY3KFwXZyHSzBOIkzCd//sjxOlU08qL
	 NfVHl+Bczu5Kywy1oqcEHOGbYB6J/V3+Y898vkwKITsIFV3ESvZf+KUFzatvoTdKKB
	 KQKW+YUEbc8aOGyQmu8A7+uODATqjf6aZmCa+P7UeIPp/yKNmbJAZuk5g7cZO+tYm9
	 pYcZzbyUGP27MDmTBisguvYpIbhA4KI4I65p+q6Q5yTqwxCqv0120PSzolNvPXdpsb
	 5qSAAmtYspJixBIdXYR1ztD6/JiOhUdVadcQgOMQsSjunczpvyIRKtfr5KrC7IDbeq
	 mKHKMkc/qTSkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/9] HID: steelseries: Add async status interface
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sriman Achanta" <srimanachanta@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <c993054229da167e96332fc142d372091e8c7406.1782840133.git.srimanachanta@gmail.com>
References: <cover.1782840133.git.srimanachanta@gmail.com>
 <c993054229da167e96332fc142d372091e8c7406.1782840133.git.srimanachanta@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:39:13 +0000
Message-Id: <20260630173913.E6EEC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unsynchronized access to the sibling interface's HID device and dr=
iver data in `steelseries_get_sibling_sd()` leads to Use-After-Free vulnera=
bilities during concurrent unbinding.
- [High] Unsafe retrieval of `intfdata` from a sibling USB interface withou=
t verifying the bound USB driver leads to type confusion.
--

commit 184e416637c40dbd71e035542907c5105f99d55d
Author: Sriman Achanta <srimanachanta@gmail.com>

HID: steelseries: Add async status interface support

This patch adds support for an async status interface on some Steelseries
headsets. The driver binds both sync and async interfaces, using the async
interface to push status events and delay its probe until the sync interface
is fully initialized.

> diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steel=
series-arctis.c
> --- a/drivers/hid/hid-steelseries-arctis.c
> +++ b/drivers/hid/hid-steelseries-arctis.c

[ ... ]

> +static struct steelseries_device *
> +steelseries_get_sibling_sd(struct hid_device *hdev, int interface_num)
> +{
> +	struct usb_interface *intf =3D to_usb_interface(hdev->dev.parent);
> +	struct usb_device *usb_dev =3D interface_to_usbdev(intf);
> +	struct usb_interface *sibling_intf;
> +	struct hid_device *sibling_hdev;
> +	struct steelseries_device *sd;
> +
> +	sibling_intf =3D usb_ifnum_to_if(usb_dev, interface_num);
> +	if (!sibling_intf)
> +		return NULL;
> +
> +	sibling_hdev =3D usb_get_intfdata(sibling_intf);
> +	if (!sibling_hdev || sibling_hdev->driver !=3D &steelseries_arctis_driv=
er)

[Severity: High]
Can a malicious USB device trigger an out-of-bounds read here?

If the device advertises the sync interface as a non-HID class (like Mass
Storage) but the async interface as HID, the USB core might bind a different
driver to the sync interface. In that case, usb_get_intfdata() would return
a driver-specific structure (like struct us_data) rather than a
struct hid_device.

Would it be safer to verify the bound USB driver on the sibling interface
before casting the intfdata and dereferencing sibling_hdev->driver?

> +		return NULL;
> +
> +	sd =3D hid_get_drvdata(sibling_hdev);
> +	if (sd)
> +		kref_get(&sd->refcnt);

[Severity: High]
Is there a race condition with concurrent unbinding here?

If the sync interface is concurrently unbound (e.g., via sysfs or physical
disconnection) while the async interface is probing, usb_get_intfdata()
and hid_get_drvdata() are called without holding device_lock() for the
sibling interface's device.

Could this allow the hid_device to be freed before checking
sibling_hdev->driver, or allow the steelseries_device (sd) to be freed
before kref_get() is called?

> +
> +	return sd;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1782840133.gi=
t.srimanachanta@gmail.com?part=3D8
