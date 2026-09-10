Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAA0379ED4;
	Thu, 10 Sep 2026 03:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011812; cv=none; b=dTXh6XsSJzoqpkEj05tesyM2q9p8N2DLP03JL3f90BYDJs34vUNtZZHSN0R8uY0onvSX3QOSDyeRk00tGO4V4wKYCUgrobt6keQ8mOr1c39OxMjdNQqysDL+Eht5Uc1wa/zuY1geZcFs7eqUcz8GmUN5YgRpl6z38lVLtSPBcaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011812; c=relaxed/simple;
	bh=rLXN7cjP6JyvH5QPLcx4TBQ5eGVgmNT2excDoC5P4T8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QJrEa68ttSIO9H/U4kdU/CYg0WijBc1tM8BDaQ/6fLIMO7TjVZIHNv2Bq7a8+ejyDtR3qxu2C5XR7g4d6faFfl9rJv8SUqD5QwWInYL8hpWk5usM9cx2YwYJ3kaIIEsnhgFWRHWZD5/dMKaCdLS5pbasRs4M5/9WDTPX9iYsKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f76/e6wV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f76/e6wV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272C11F000FF;
	Thu, 10 Sep 2026 03:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011811;
	bh=q4UcZt3IDRzMUj/hOVg+N2dRDq1xOK1QL29WlWpl4nw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f76/e6wVD1Bb8VA0F+mJ64aCmDrvzfgKqmBXAlQ2v4VlwCgx0x+FuWGfcClD8TX6O
	 qvmzaSll3w/moqinbrcnk0mbXcx7FgwTI4FGU1CZ5+edA8PGhDxidHUzhmEhd7CFTI
	 mcoIRJvlW+pz5Eypkeg6dCDSS0rJTjBE/OS9lkwSq3nsSuPg/vxi8h6qWn/7puBXLC
	 T3mJmdBOnDGtW+bFPYLaG5y35ZtQDddc8MmX+BVfHyQuYDHxnjFPTGyt3zoCp5zYc6
	 vcVcpL3FBjM6/+Ai0hj5amFqPyNMWwhPIOX5zHvUZdiBgMO65jbkym/+HouTPeAwXK
	 7YCxuvesD69DA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/15] HID: hid-oxp: add Gen3 joystick ring RGB support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Aldea" <andrei1998@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-leds@vger.kernel.org, linux-input@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260910032115.28669-15-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-15-andrei1998@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 03:43:30 +0000
Message-Id: <20260910034331.272C11F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Invalid cast to usb_interface when bound to non-USB parent.
--

commit 6855a3cf4aaf330705ad5f598a86f86db5c13fc3
Author: Andrei Aldea <andrei1998@gmail.com>

    HID: hid-oxp: add Gen3 joystick ring RGB support
   =20
    Select the X2/Gen3 RGB protocol early for the ONEXPLAYER 3 and X2 Mini =
Pro.
    These controllers share the Gen2 HID usage page but require a 59-byte
    color payload and writes to ring zones 1, 2 and 7. Keep the Gen1 55-byte
    and legacy Gen2 57-byte color builders separate and unchanged.

> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 55f8b4773e334..9a46602238aa3 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c

[ ... ]

> @@ -1868,6 +2199,7 @@ static int oxp_cfg_probe(struct hid_device *hdev, u=
16 up,
>  		return -ENOMEM;
> =20
>  	cfg->hdev =3D hdev;
> +	cfg->x2_rgb =3D quirks && quirks->x2_rgb;

[Severity: High]
This is a pre-existing issue, but does oxp_is_cfg_interface() perform an
unsafe cast of the parent device?

During probe, before oxp_cfg_probe() is called, the driver checks:

	if (!oxp_is_cfg_interface(hdev, quirks))
		return 0;

Looking at oxp_is_cfg_interface(), it uses:

	if (hdev->bus !=3D BUS_USB)
		return false;

	intf =3D to_usb_interface(hdev->dev.parent);
	return intf->cur_altsetting->desc.bInterfaceNumber =3D=3D
	       quirks->cfg_interface_num;

Could a userspace program create a UHID device spoofing the BUS_USB bus type
and target device IDs? If so, the hdev->bus !=3D BUS_USB check would pass, =
but
the parent device would be a UHID device rather than a USB interface.=20

Does unconditionally casting a non-USB parent device to struct
usb_interface lead to an out-of-bounds memory read or kernel panic when
accessing intf->cur_altsetting->desc.bInterfaceNumber? Should this code use
hid_is_usb(hdev) to safely guard the cast?

>  	mutex_init(&cfg->cfg_mutex);
>  	mutex_init(&cfg->rgb_mutex);
>  	spin_lock_init(&cfg->rgb_reply_lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910032115.2866=
9-1-andrei1998@gmail.com?part=3D14
