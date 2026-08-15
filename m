Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73338388E68
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837670; cv=none; b=UiDkg9jp/wzqsy3WA0y2cXdoJOtvTn1Pt2/dAly7oSkY46k4EMmI7OvePASWGmT1Tx7bbu6SLCj0HfaoiKP+R8x5r/TZGhkYEybqDgGSzdG+wq8OPX4lXONk66lHvZ0HOb2OLueVP5S1EeQYidQMdoZZsbwZpVh6Z4chj/HnsGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837670; c=relaxed/simple;
	bh=MI8xYUSH+4TS/Ex2x1SBiLWLNGt7RnD/gcGbvBj2Uao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MoL9089Ww7lhaLRiJkbukIoXI/OCbNUCAmIQH8omvHC1Ddbe06mpYTS+RDBd9+HPeh/ANfn/ULfz1sJDPoqtsL/nkDMdfsoIpKVPtH9VYtLppvn1Lyamm8/uhZWBGP5eH3OzQfT4z9rHZh4xmAI6cxsOshozn9Wq5l2cThZYm1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1YF/Cmu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1YF/Cmu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7AE1F000E9;
	Sat, 15 Aug 2026 23:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786837669;
	bh=PjJI4KUNqzd64s+FIEYpqpUPvIGiBBhY3KMhzOEYS60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V1YF/CmuIlBerpt8+sg25/vITzJYb2K3QWMoCzJYrPuby0hmfrEfS56gA7P+fcXCA
	 So6SA3gen04ToaJycD3yxbUMtsMSPDMFRO/6MyVNi9Q63Kl/ErKjuRzB/PO9U5YKxN
	 upTmYPytJe2PPdu6A0GRsh3t+OLxDRIsKuErcLkYetg0trvZ7kj76FzS9s/Xn6Sgkt
	 D4NX2J5MJZcAxrluyqDos0gqQj7xeQw/wWKgfBRBAP7yIY78fEU6+Um0dkbUSovEuD
	 WsWofBOXifmJGwMjIROYYE3bSqGo3kPZAHc0dZEHrqvFlRfJQGXdFYZMRZ9lf1TG5U
	 0CVTxiK1A+o2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] HID: pulsar: add driver for Pulsar gaming mice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolas Koesling" <nikolas@koesling.info>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260815233240.95981-1-nikolas@koesling.info>
References: <20260815233240.95981-1-nikolas@koesling.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 23:47:48 +0000
Message-Id: <20260815234748.DA7AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Mismatch between vendor and device IDs in `pulsar_table` prevent=
ing binding for ATK VXE R1 SE+.
--

--- Patch [1]: [PATCH v5] HID: pulsar: add driver for Pulsar gaming mice ---
commit 77c96d32e01f202616edca1e5d0c2f9591dce152
Author: Nikolas Koesling <nikolas@koesling.info>
Date:   Sat Aug 15 23:32:40 2026 +0000

    HID: pulsar: add driver for Pulsar gaming mice
   =20
Add a HID driver for Pulsar wireless gaming mice and related devices.
The driver provides battery level, voltage, and charging status via the
power supply framework.

> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 1059922baaacd..7a73fda02a0f2 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -251,6 +251,12 @@
>  #define USB_VENDOR_ID_ATMEL_V_USB	0x16c0
>  #define USB_DEVICE_ID_ATMEL_V_USB	0x05df
> =20
> +#define USB_VENDOR_ID_ATK	0x373B
> +#define USB_DEVICE_ID_ATK_VXE_R1_SE_WIRED	0xF58F
> +
> +#define USB_VENDOR_ID_ATK_ALT		0x3554
> +#define USB_DEVICE_ID_ATK_VXE_R1_SE_DONGLE	0x1085

[ ... ]

> diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
> new file mode 100644
> index 0000000000000..b90284a00776a
> --- /dev/null
> +++ b/drivers/hid/hid-pulsar.c

[ ... ]

> +static const struct hid_device_id pulsar_table[] =3D {

[ ... ]

> +	{ HID_USB_DEVICE(USB_VENDOR_ID_KYSONA, USB_DEVICE_ID_KYSONA_M600_WIRED),
> +	  .driver_data =3D TYPE_KYSONA },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ATK, USB_DEVICE_ID_ATK_VXE_R1_SE_DONGLE),
> +	  .driver_data =3D TYPE_ATK },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ATK_ALT, USB_DEVICE_ID_ATK_VXE_R1_SE_WIR=
ED),
> +	  .driver_data =3D TYPE_ATK },

[Severity: Medium]
Are the vendor and device IDs for the ATK VXE R1 SE+ swapped here compared
to their definitions?

In hid-ids.h, USB_VENDOR_ID_ATK is grouped with the WIRED device ID, and
USB_VENDOR_ID_ATK_ALT is grouped with the DONGLE device ID. However,
pulsar_table assigns the DONGLE ID to the regular vendor ID and the
WIRED ID to the ALT vendor ID.

Could this prevent the driver from properly binding to the ATK VXE R1 SE+
hardware?

> +	{ HID_USB_DEVICE(USB_VENDOR_ID_VXE, USB_DEVICE_ID_VXE_DRAGONFLY_R1_PRO_=
DONGLE),
> +	  .driver_data =3D TYPE_VXE },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815233240.9598=
1-1-nikolas@koesling.info?part=3D1
