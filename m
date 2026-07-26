Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122B366057
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 08:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785054587; cv=none; b=jbGyKF6vffekBTb9HF403nHF0c6ZLlCVLT8gGOW0dOp/AQnUkgw+qItBMvnLJNdFWrfvpqLVfznT8TW0cDvIOMvs8uJNBakfqqGg6gyrwQDbgcXDERnfqp2mrJtREG8C6sRIM6eIK2k+YqX+z1tSFBO+m5CbR10Yba12AnHvgzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785054587; c=relaxed/simple;
	bh=/QXx9ui5z58WwQtThLU73xg3qwXRroeB7mC0WJj4rDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bvJS8H0ShvWqYo/UMnBZZcR2wD6wl4L7GzVpptJHag4X0Q/TFTH0YdupQ2MjnSgskozuQghj2/dBL8pprH13vpxRylvzz/dTIF7AGgKt3th2b4U3zLR1b457BkTsrTzQS4nUCOFH7QAr6epUpzYlck43gUru4/y8ZjGuK0AHD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdkNq06L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdkNq06L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E251E1F000E9;
	Sun, 26 Jul 2026 08:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785054586;
	bh=gXL38Vvc/WvGbGJuZQQLqM5AZZ1adHUYnDtWWNCMRwk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cdkNq06LzAWyn7XCkx/vtoyxlBl4OEr5DOaK3xlGP+Y+CCLYBUhHxMyZzMEovK6/K
	 StPlFtELomkWv2/T2XNJxz/g3wPAo9V1c60EV4nPI9nlorsL4mtSwgorkS2x6b1iVV
	 P3jprH1ckbEb1TRoTfNBSKWTiyF1lctozVfmhmspTLZhKI8ZhguTamkOhqswpi7syr
	 GkUycr1G9x/eMzuwhbLtfktno6W5hdBYcdExVdsqCGFfLgqPydTa/sIGz0HfoiDS6E
	 aNFbqZa65c7sJ90q6aiZNVoMuDhVRmCANpKp6lu8W6shmMWEzWjTVqmyUzvkwKn5GG
	 USc1KHNG/PQ+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: xpad - add support for Beitong KP series
 controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: VegetablCat <vegetablecat@foxmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_CD9DBF098D1B3BB565A1DD5761C1D34F4805@qq.com>
References: <tencent_CD9DBF098D1B3BB565A1DD5761C1D34F4805@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 08:29:45 +0000
Message-Id: <20260726082945.E251E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Using `IS_ENABLED(CONFIG_HID)` causes undefined reference linker er=
rors when `CONFIG_JOYSTICK_XPAD=3Dy` and `CONFIG_HID=3Dm`.
--

--- Patch [1]: [PATCH v2] Input: xpad - add support for Beitong KP series c=
ontrollers ---
commit aae02dfc97d563806266aab4cd52d4aaca3c3e89
Author: vegetablecat <vegetablecat@foxmail.com>
Subject: Input: xpad - add support for Beitong KP series controllers

This commit adds support for Beitong KP series controllers to the xpad driv=
er,
triggering an XUSB10 descriptor read during probe to keep the devices in XI=
nput
mode. It also introduces an optional HID receiver driver for the KP40D rece=
iver
dongle to prevent interference from hid-generic.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..13b61681d6ec9 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c

[ ... ]

> @@ -2312,7 +2357,79 @@ static struct usb_driver xpad_driver =3D {
>  	.id_table	=3D xpad_table,
>  };
> =20
> -module_usb_driver(xpad_driver);
> +#if IS_ENABLED(CONFIG_HID)

[Severity: Low]
If the kernel is built with CONFIG_JOYSTICK_XPAD=3Dy and CONFIG_HID=3Dm,
IS_ENABLED(CONFIG_HID) evaluates to true.

Will this cause undefined reference linker errors in xpad_receiver_probe()
and xpad_init() since vmlinux cannot link against exported HID symbols like
hid_parse and hid_register_driver which would be built into a loadable modu=
le?

Would it be better to use IS_REACHABLE(CONFIG_HID) here, or enforce this via
a Kconfig dependency like "depends on HID || HID=3Dn" instead?

> +static int xpad_receiver_probe(struct hid_device *hdev, const struct hid=
_device_id *id)
> +{
> +	int error;
> +
> +	error =3D hid_parse(hdev);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_CD9DBF098D1=
B3BB565A1DD5761C1D34F4805@qq.com?part=3D1
