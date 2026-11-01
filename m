Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793547192;
	b=RJ6u4hyo45OvKxC4jSiLseiRS3AQBTXdWgpIWyCLXJnTJ0kGR/pfdXCi6FUzVUY1NX4o
	 5aLO07V0FmbC2nu+FI5Jbiga1fhoocUo2HSUUg5sKq6QfAPyS5w5zyib6I3+su/iQgEWZ
	 9oAKcwHPvEBqBi/kM6o1NCUv9d1d27UkBmTh2wyK9e6Nh3IBJGtNy1onn2tHv/slgCqo8
	 scqwVFzdUrP5AwgaXOeoldBA6fhPNCrOJReFxGQ0f2aHrT07C6oaluxwQLB9JM0sO0NGx
	 oEz+2jFO7QdnoXxAzzjxco0/ero8btOWv7IzVm26SfUk6rzfz64wBUiRYOPKBjUH3Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793547192;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nEbOIW/0lOxbAmvmszloccuofgFzKuZhz0Y2HCI+D0c=;
	b=pOhhwIYt3+1+jB4R/4ck7+vEJo+YKZ9HQZfN5O9wQfNhqxwSMjteRuARTc1NI21YJ4eF
	 Fp8oXsC3tTLRX2jtfnnyK6N/M62uS5RnEDFzo445EaqhanwNxd7Tf7fsh2a2KXICJp7Q5
	 HrUU3NEKd3l8h3Ji2aKsGeBrBMzj42Z6wu2mPOMGOS38of2moH2St/jnSGdXFJTw5BxJD
	 A+L9PieGuvzGC3CjExJe7f7+sEyRr1BycQ47LTnmFTQJLBYiuU3r9a3z25ZDTlj0nvesm
	 g1b93pu6d6GPDbeBcFgMN3R1RiMX4zf1cMNvtrI1VkjdQADBcvpIXQ36/tHfObihEHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjL98akj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01455606A324
	for <linux-input@vger.kernel.org>; Sun,  1 Nov 2026 15:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjL98akj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD0F1F000C1;
	Sun,  1 Nov 2026 15:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793547191;
	bh=nEbOIW/0lOxbAmvmszloccuofgFzKuZhz0Y2HCI+D0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mjL98akjxEMkEKKMYvX5mU456QUHvNQsnTVqrhrUUPx5MOhok8+lu8DmSp+9mE4Qt
	 aXt8lhFYA2pXlKF11bZ3fBjUrGIvdgJuqqNyIoOIijPDQXj4/oeayeiAgmLdA2cIs+
	 oxeKPJMsxKjosKFikfjFW0+3jeCyK9wCPewfjywB5XzidJjzHhxDAJBQz+ylvVpe33
	 C1pPhZ5o5Yk6lf0olY5vb9ZtzRP1DMBeUrJfLsJ/0Kl4LQV/gr09atqfCyUKjV97Vd
	 wWeqTBpr5h7PPheQI6yVIW6+tzenyACW/TFlFQTALUK2czMBwqIXPdAescKad03cAR
	 oVbHKfDwpcdRQ==
Message-ID: <sashiko-outbox-192470@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] HID: add driver for EWEADN G5 mice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Liang Haowen" <nbg2974@gmail.com>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <6ae759e9.4b0417f2.1062f7.b196@mx.google.com>
References: <6ae759e9.4b0417f2.1062f7.b196@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 15:33:10 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] HID: hid-eweadn: missing hid-ids.h include breaks build
- [Low] HID: hid-eweadn: redundant eweadn_probe() duplicates default probe
--

commit 4edaba02eb50bfbcf89b68ad006b2e16efd6acc9
Author: Liang Haowen <nbg2974@gmail.com>

HID: add driver for EWEADN G5 mice

This commit adds a HID driver for EWEADN G5 wireless and wired mice that
replaces the broken firmware report descriptor on USB interface 0 with a
standard mouse report descriptor.

> diff --git a/drivers/hid/hid-eweadn.c b/drivers/hid/hid-eweadn.c
> new file mode 100644
> index 0000000000000..79a9a1545b395
> --- /dev/null
> +++ b/drivers/hid/hid-eweadn.c
> @@ -0,0 +1,129 @@

[ ... ]

> +#include <linux/hid.h>
> +#include <linux/module.h>
> +#include <linux/usb.h>
> +
> +static __u8 eweadn_rdesc[] =3D {

[ ... ]

> +static int eweadn_probe(struct hid_device *hdev,
> +			const struct hid_device_id *id)
> +{
> +	int ret;
> +
> +	ret =3D hid_parse(hdev);
> +	if (ret) {
> +		hid_err(hdev, "parse failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +	if (ret) {
> +		hid_err(hdev, "hw start failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

[Severity: Low]
This isn't a bug, but is eweadn_probe() needed here?

In drivers/hid/hid-core.c, __hid_device_probe() already runs the default
probe sequence when hdrv->probe is not set:

drivers/hid/hid-core.c:__hid_device_probe() {
	if (hdrv->probe) {
		ret =3D hdrv->probe(hdev, id);
	} else { /* default probe */
		ret =3D hid_open_report(hdev);
		if (!ret)
			ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
	}
}

Since hid_parse() is just a wrapper around hid_open_report(), could
eweadn_probe() and the .probe assignment in eweadn_driver be dropped to
rely on the default HID core probe like other report-fixup-only drivers?

> +
> +static const struct hid_device_id eweadn_devices[] =3D {
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_YJXCHIP, USB_DEVICE_ID_YJXCHIP_MOUSE) },
> +	{ HID_USB_DEVICE(0xa8a4, 0x2255) },	/* replacement unit, wired mouse */
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(hid, eweadn_devices);
> +
> +static struct hid_driver eweadn_driver =3D {
> +	.name =3D "eweadn",
> +	.id_table =3D eweadn_devices,
> +	.report_fixup =3D eweadn_report_fixup,
> +	.probe =3D eweadn_probe,
> +};

[Severity: Low]
As reported by Sashiko on v1 [1], does this fail to build when
CONFIG_HID_EWEADN is enabled because drivers/hid/hid-eweadn.c uses
USB_VENDOR_ID_YJXCHIP and USB_DEVICE_ID_YJXCHIP_MOUSE in eweadn_devices[]
without including "hid-ids.h"?

Those macros are defined in drivers/hid/hid-ids.h:

#define USB_VENDOR_ID_YJXCHIP		0xa8a5
#define USB_DEVICE_ID_YJXCHIP_MOUSE	0x2255

Should drivers/hid/hid-eweadn.c include "hid-ids.h", define symbolic
constants in drivers/hid/hid-ids.h for the 0xa8a4:0x2255 device ID entry in
eweadn_devices[] as well, and mark eweadn_rdesc[] as const?

[1] https://lore.kernel.org/r/6ae7529d.10abdf86.7545b.3e9a@mx.google.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6ae759e9.4b0417f2.1=
062f7.b196@mx.google.com?part=3D1
