Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65C42DBF75
	for <linux-input@vger.kernel.org>; Sun, 23 Aug 2026 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787512525; cv=none; b=nXrOCVCm9SftXrC84fA0kjeRkt0BU61zoDQ21QAWNtUh782cV0uf9OnUNgQtgnfGqK1+VTqQMb1WsYyuGWKWYtWIH3x3hhLvMKFWnnXJ+9918BmRSkbATMmmSt0Cu0DE/kRrK/Xtej7uEfgx90tS1Pp86heZnhyeITqD81G4uTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787512525; c=relaxed/simple;
	bh=5s033rDzlCvgF2g2/3AdPpl34z1z801fGXUbPURfnTo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q47m7oOuserVb6WNZ8+1fMYXfdMX1QFjO1L9+9Z8aMfcqXwYCdWEmCCwv6pcKtU3gQG4qiFhL5Xygx2X6u8EMz5au/dDhZq0/LZ4bI8pLInYa8AcIZspumNzXDvsp9cRoHY/oLZQa9pw6IbcBo2vtYwViR5xDBfinqD0I0+93Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7XKWk48; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7XKWk48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415921F000E9;
	Sun, 23 Aug 2026 19:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787512523;
	bh=JJtTv66f5T/NA+8srhW93Y8/AqJmBJ7HMiLUta561kE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D7XKWk48aUfokS4zUKVPNN1bmgDJ/hENLg1fW+oQE5RfVfoHNmB//81Jx15KVypqH
	 0/dnn6RnP7uC+mtBTn9s6ribg66Yodc5G6aN3ryVQc27Mdrnq1PxclwuGiih/2c8LO
	 a/7jnXoZNP9rVcLgi9S0YdhKmxS37gHMPSuq6498oU4z7I/QN8Ulv7WjytMQ2v2gDx
	 mWnvn7iRb82XSG0bcFA7tFQZT49mBsHrmbHiOw9fgADKC7oMn5gnYex4Qa5/WVZc4+
	 JHBO12gI7NQffitX4pyVwu6HyQj9LWS6TQ7DLECpq6dU8sEFpvTIdcTfJzotQljFMW
	 mJSTVXku6Jkcg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/12] HID: asus: add gamepad configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Denis Benato" <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260823185849.2478673-4-denis.benato@linux.dev>
References: <20260823185849.2478673-1-denis.benato@linux.dev>
 <20260823185849.2478673-4-denis.benato@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 19:15:22 +0000
Message-Id: <20260823191523.415921F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Invalid cast of parent device to usb_interface or usb_device witho=
ut checking hid_is_usb().
--

--- Patch [3]: [PATCH v3 03/12] HID: asus: add gamepad configuration ---
commit f281ed94708b0871557c0870cec3173a2e3fa823
Author: Denis Benato <denis.benato@linux.dev>

HID: asus: add gamepad configuration

Add the base configuration structures for the gamepad configuration,
detect capabilities and initialize the device in a known state.

> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 048bc902323ab..04f41294edf67 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

[ ... ]

> @@ -964,6 +1254,7 @@ static struct ally_handheld *hid_asus_ally_probe(str=
uct hid_device *hdev)
>  	unsigned long flags;
>  	int ret, ep =3D ally_get_endpoint_address(hdev);
>  	struct usb_device *udev;
> +	struct ally_config *ally_cfg;
>  	struct hid_input *hidinput;
> =20
>  	if (ep < 0)

[Severity: High]
This is a pre-existing issue, but in hid_asus_ally_probe() in
drivers/hid/hid-asus.c, there is an unsafe cast of the parent device to a
usb_interface and usb_device without first verifying the transport.

If a userspace process creates a virtual device via /dev/uhid with the Asus
ROG Ally vendor and product IDs, the HID core binds this driver, assigns the
QUIRK_ROG_ALLY_XPAD quirk, and calls hid_asus_ally_probe() in asus_probe():

    if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
        ally =3D hid_asus_ally_probe(hdev);

Since the transport is not verified with hid_is_usb(hdev), the driver
blindly casts the uhid parent device to struct usb_interface:

    udev =3D interface_to_usbdev(to_usb_interface(hdev->dev.parent));

This results in garbage pointers being passed to usb_get_dev(udev), which
can immediately panic the kernel or lead to a use-after-free or out-of-boun=
ds
access. This is reachable by any unprivileged userspace process that has
access to /dev/uhid, allowing for a local denial of service.

Should this code check hid_is_usb(hdev) before making USB-specific casts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823185849.2478=
673-1-denis.benato@linux.dev?part=3D3
