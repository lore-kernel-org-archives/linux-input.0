Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C442D521238
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 09:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859543; cv=none; b=qr8j32KeZ9f4g8Laa1StDDJJUKiliwe5W9JqoqOIQvgYmkAXPBTIom0kcuHdUnRAGBbx/ZO2hVtE7M/uYhMbQCf0aeqpI8T/vuVrpIavjTL2OaSVUGrMHmPXgoOKfvFDNX6xzCA/XA/ppNMKYZ72hKMp6DS7SerXuT8Ve/f3Iwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859543; c=relaxed/simple;
	bh=nabQilCUC+uDCHiJVW6AMT/IWN6Rig03MKCUkayYPXY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u34cxBphr7SGpPhXodaXCqOlDUbKCsLK80m4nkMvviV1zyjAxCt7oFeYT2UMlCQRcLpdclYpQA9+EMkYDe9IgcdlcOAnPIdihMNsYQErto0vWnxYfjW5Krmj8ZY6bqReKMozVOqKjZbyGh7MPse0FY+k5uNPEszMzbIL45bwmEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+V4mRRD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+V4mRRD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A361F00A3D;
	Tue,  8 Sep 2026 09:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788859541;
	bh=eNP4kvg3CTleU67YsIW2ZbqLHXlkfM5SZuZnZJLTOe0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f+V4mRRD3uGIRQUhv4EaQsNM6s5h7Zpt1KVww5KvaETO8AbznFXnfSHRtjcnMA3fS
	 cB/ADtJXvVtCzaHbnVs9oJrpCX1pxKvJBimwI93mnYEcwOEd9EoCyRmQ28YuqAFF13
	 A86H+SYhZHpzVLX9nt/NIJe/62fbOGJJsS/Z1gxvaETAJsMbPAZUIwY75loer9fQxj
	 nI4zrr9Fg1icZVbYMkzMUFqy7xh3huPmOKfvN5bw6FCY7R6OF7t8hS2hfVg+eGiy2L
	 U65VVvRQyTb1FJ5N7EJi2yG4KDsrc6C9MonU84PEokXs/kDVgWozuHPiPxmgZtbIyC
	 EXFwtcs9UBKug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: lenovo: suppress phantom radio control input on
 Yoga Slim 7x Gen 11
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oleg Keri" <okerixx@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260908091907.5653-1-okerixx@gmail.com>
References: <20260908091907.5653-1-okerixx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 09:25:37 +0000
Message-Id: <20260908092541.75A361F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The macro `I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD` is u=
sed but never defined, resulting in a compilation error.
--

commit 4ee02285ee5c593b77b5e50d44817b425e9ba25b
Author: Oleg Keri <okerixx@gmail.com>

HID: lenovo: suppress phantom radio control input on Yoga Slim 7x Gen 11

The ITE keyboard controller (048d:83db) declares a Wireless Radio Controls
application collection, which hid-input registers as a second input device
advertising KEY_RFKILL. That collection never reports anything: the
airplane mode key is wired to the embedded controller and reaches the host
as EC event 0x19, where the platform driver emits the key.

> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index 3976d7b53b14b..617bba6626592 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
[ ... ]
> @@ -510,6 +520,8 @@ static int lenovo_input_mapping(struct hid_device *hd=
ev,
>  	case USB_DEVICE_ID_LENOVO_X1_TAB2:
>  	case USB_DEVICE_ID_LENOVO_X1_TAB3:
>  		return lenovo_input_mapping_x1_tab_kbd(hdev, hi, field, usage, bit, ma=
x);
> +	case I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD:

[Severity: Low]
Where is I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD defined?

It appears this macro is undeclared, which will cause a build failure when
compiling drivers/hid/hid-lenovo.c in lenovo_input_mapping().

> +		return lenovo_input_mapping_yoga7x_g11_kbd(hdev, hi, field, usage, bit=
, max);
>  	default:
>  		return 0;
>  	}
> @@ -1568,6 +1580,8 @@ static const struct hid_device_id lenovo_devices[] =
=3D {
>  		     USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X13_TAB) },
>  	{ HID_DEVICE(BUS_I2C, HID_GROUP_GENERIC,
>  		     USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_KEYBOARD=
) },
> +	{ HID_DEVICE(BUS_I2C, HID_GROUP_GENERIC,
> +		     USB_VENDOR_ID_ITE, I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYB=
OARD) },

[Severity: Low]
Will this also fail to compile in lenovo_devices because
I2C_DEVICE_ID_ITE_LENOVO_YOGA_SLIM_7X_G11_KEYBOARD is missing its definitio=
n?

>  	{ }
>  };
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908091907.5653=
-1-okerixx@gmail.com?part=3D1
