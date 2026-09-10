Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B291A6828
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 03:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011635; cv=none; b=i/YVarLA5RAb+9oDwL8NnR2knWQ0TB5WEKXuUdWmAc3R7Fr1/EZRV/iI8RixDxYHt5IrsdrsAGybf03rYAbLVedSCR6DwmdlMkf+YPCxDzdfPzJ/2B80BI83lo26ZNLcrwlqlu6goYswigI6a1+en7iOiGkQN2WAEHD1QGfHoLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011635; c=relaxed/simple;
	bh=H/oWd7UQco7fxv9J9d+XTXR2r2DGKQNy/TO+z1DOBPI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tAhN54TJjhC12cCLaV/cD09O+ka0Sk8oAwrAoYTxbwwhCoJXB9M5juLAqhTZGa7s3rm6Ss2YnLyeRzTIeAH+V9rGhvV9NfEd8RN86DSOmxG0qsYAhbPBarVSc4NXqnxATo2unmYaNT8MIZoYrlXsDr7l+EPiQflz4smKiEtriuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AAQiJJJ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AAQiJJJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2BD81F000FF;
	Thu, 10 Sep 2026 03:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789011633;
	bh=XZEvGHhUqoX/esJ79pVnN3+LInWm2p/up/IaT4gvnDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AAQiJJJ3l2nbqIrIcwaFZaaQ8fE0zqzGe2XviABVChlGe1DQaxGv6LKV5+Sr4qsJ6
	 G1eBX1WoXY1qo0fh6ba6N4eE9ArXZQWYk5i2tDlByTVw/5fhTOaVpu5JMiTVcxiTiL
	 XMQC5xEiluMM4mFFIZygc2/fT14YurotsL6ce/R3H0w9pNAGMcO/TkS4QHEEVoHWyx
	 5+EcNXUvfBevSEfuCvOvpGES/usuMX/SlvZUDYeqmrvFV7TNcWDuxCUxPeROXpodyM
	 SnnhmYm6gC0dXI7XrhomUh27PIVGKEZvUQPnDI8ZHzaTeS5kjreZ7iPFNnpazNLyLD
	 LVmw586j7+VoQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/15] HID: hid-oxp: support three-page button maps on
 X2 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrei Aldea" <andrei1998@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260910032115.28669-13-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
 <20260910032115.28669-13-andrei1998@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 03:40:33 +0000
Message-Id: <20260910034033.A2BD81F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Invalid cast of HID parent device to `usb_interface` without verif=
ying the transport layer.
--

commit 435c693ab184a92fb526c35572b01cbea8f10f4a
Author: Andrei Aldea <andrei1998@gmail.com>

HID: hid-oxp: support three-page button maps on X2 controllers

This commit adds support for a three-page button map format on the ONEXPLAY=
ER
3 and X2 Mini Pro using exact DMI matches. It initializes the pages and lim=
its
duplicate LED registration by restricting initialization to configuration
interface 2.

> diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
> index 8c44f576f3956..48fa9169b84c7 100644
> --- a/drivers/hid/hid-oxp.c
> +++ b/drivers/hid/hid-oxp.c

[ ... ]

> @@ -1613,6 +1653,21 @@ static void oxp_quiesce_work(struct oxp_hid_cfg *c=
fg)
>  	oxp_drain_output(cfg);
>  }
> =20
> +static bool oxp_is_cfg_interface(struct hid_device *hdev,
> +				 const struct quirk_entry *quirks)
> +{
> +	struct usb_interface *intf;
> +
> +	if (!quirks || !quirks->cfg_interface_num)
> +		return true;
> +	if (hdev->bus !=3D BUS_USB)
> +		return false;
> +
> +	intf =3D to_usb_interface(hdev->dev.parent);

[Severity: High]
Can this cast to a usb_interface lead to an out-of-bounds read or kernel
crash?

Checking that hdev->bus equals BUS_USB is not sufficient to guarantee that
the parent device is actually a USB interface. A user with access to
/dev/uhid can inject a virtual HID device with the bus field spoofed to
BUS_USB.

If that happens, the parent device will be a UHID character device, not a
USB interface. Dereferencing intf->cur_altsetting will then access invalid
memory.

Should this code use the hid_is_usb(hdev) helper to safely validate the USB
transport layer before casting the parent device?

> +	return intf->cur_altsetting->desc.bInterfaceNumber =3D=3D
> +	       quirks->cfg_interface_num;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910032115.2866=
9-1-andrei1998@gmail.com?part=3D12
