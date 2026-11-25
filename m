Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573327;
	b=k9rgMYHfs41yOoJ1g4aXxomqNgOWFxilpXa2VLUrKaruCpEscJad8B7iW5KNmLczdlXq
	 Cn9ULurSpAu7hFkxh2oNtIvglEvP5KHxixM7vlRKApMO24n9tLEVrKBVvKGj6u4NZh6BU
	 9F1TlLXtKD7NyLO7cELkxH+qN3ZPnZoxueJxe66nUyf5BJ2ZVw/cQD7LKVzFPoTanyz0s
	 MVAoBZNAkXAfHJSMvl69odbwk6xH7HDrcC5ybwRhYciX9C9s3Du6/ErDfDl439xBWqhUw
	 razLrpS0nX3yOCMyRdc3OTprH5gaURvvyY7i2RaWPz4XXsvMUTP2XtyZR8grLfJyRsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573327;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/XSmqqxUGa1wWcATLZ461v+9fzmTTq0bue0NNZazp7c=;
	b=R/3XGdrxkhyjP4hi2iBml21NkVjp7nrLg35LR8UnKk3iGuaQ07O3r6Wrym65/yJuk8nJ
	 9oRgexhxazlp+SUQsTCt26Ik63ZjNvUBK6X0t69dSbofQJikg1VQCY0H9VijrTHkBSfQB
	 urZcpf0StMnLvqC1TybJMX2sJti/BJUdJEJ6KTJKMvl3tiQtCPwUTrXfhjZ1a8+AoNgwx
	 6H8c6wLzBkqqFl8v/ALR6j2aPl12Q92dFVKdqIUd55r442sRjF/AM8cH54wPLnFJcDLk7
	 QtpDHxEFDI1jTYQydD0A/E4o4v2TqeILZt+OXnbd9QXKlgcKQZOo7F2Hg8cIr+SAYQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OiPYahr8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA281606A31E;
	Wed, 25 Nov 2026 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OiPYahr8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8E61F000D2;
	Wed, 25 Nov 2026 02:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795573326;
	bh=/XSmqqxUGa1wWcATLZ461v+9fzmTTq0bue0NNZazp7c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OiPYahr8PyjBdWvoBs6dW5ePPeSKtAOSx3NtYnUnqagMRff6YFfTD21wV+znJ1Pvi
	 QX+1QO5vBvussr9gHCJDETvHJplt98jNh9E5iuiGRDKLNWNc0rC1lT0Hcj5sk2F4Cd
	 V5ntSCI/Pq46zDD4IdsMP1Q8LwvYFn3o/Gs6P00osEk8FGn/ZHmtZreYtKzMWJtI66
	 eN9lYLuFGL7ZzIK+FuZ5hsppoVtIGkNyeN+Hv26HomeRRhjebCWbmtsOOjBGJuRqU5
	 pd3HGUcWtkUIYGqDqxtJ2HEl8N0mK9JLeLM7/9CVyj1z6fFzOwXP23lRdfKxvfbt+g
	 ksbhsQS9K+qsw==
Message-ID: <sashiko-outbox-232405@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] backlight: add VIEWE I2C backlight driver
Reply-To: sashiko-reviews@lists.linux.dev
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_5185BF35A815E3151FD856BCDF3E84F14F08@qq.com>
References: <20261125021127.1430-1-3066883572@qq.com>
 <tencent_5185BF35A815E3151FD856BCDF3E84F14F08@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:22:05 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] backlight: viewe_bl_i2c: missing DT property parsing and
  initial HW sync in viewe_bl_probe()
- [Low] backlight: viewe_bl_i2c: positional initializer and mismatched
  ID in viewe_bl_id
- [Low] backlight: viewe_bl_i2c: open-coded byte write in
  viewe_bl_update_status()
- [Low] backlight: viewe_bl_i2c: hardcoded device name in
  viewe_bl_probe() breaks multi-instance probe
- [Low] backlight: viewe_bl_i2c: empty commit message body lacking
  hardware and driver description
--

commit 4e7ef9a994e068f00aa52e87d93462c70437631d
Author: Hefei <3066883572@qq.com>

> backlight: add VIEWE I2C backlight driver
>=20
> Signed-off-by: Hefei <3066883572@qq.com>

[Severity: Low]
The commit message has an empty body.  Could you add a description of the
VIEWE 7KF82 I2C backlight MCU hardware and explain why a dedicated driver
is needed?

> diff --git a/drivers/video/backlight/viewe_bl_i2c.c b/drivers/video/backl=
ight/viewe_bl_i2c.c
> new file mode 100644
> index 0000000000000..53dcf0834dcb2
> --- /dev/null
> +++ b/drivers/video/backlight/viewe_bl_i2c.c
> @@ -0,0 +1,79 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 VIEWE
> + *
> + * I2C backlight for VIEWE 7KF82 DSI modules (MCU @0x45, register 0x86, =
0..255).
> + */
> +
> +#include <linux/backlight.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +
> +#define VIEWE_BL_REG		0x86
> +#define VIEWE_BL_MAX		255
> +#define VIEWE_BL_DEFAULT	200
> +
> +static int viewe_bl_update_status(struct backlight_device *bd)
> +{
> +	struct i2c_client *client =3D bl_get_data(bd);
> +	u8 buf[2] =3D { VIEWE_BL_REG, (u8)backlight_get_brightness(bd) };
> +	struct i2c_msg msg =3D {
> +		.addr =3D client->addr,
> +		.flags =3D 0,
> +		.len =3D sizeof(buf),
> +		.buf =3D buf,
> +	};
> +	int ret;
> +
> +	ret =3D i2c_transfer(client->adapter, &msg, 1);
> +	return ret =3D=3D 1 ? 0 : (ret < 0 ? ret : -EIO);
> +}

[Severity: Low]
Could viewe_bl_update_status() use i2c_smbus_write_byte_data(client,
VIEWE_BL_REG, backlight_get_brightness(bd)) instead of open-coding a raw
i2c_transfer()?  Using the SMBus helper preserves client->flags and works
on SMBus-only adapters that do not implement raw I2C master_xfer.

> +
> +static const struct backlight_ops viewe_bl_ops =3D {
> +	.update_status =3D viewe_bl_update_status,
> +};
> +
> +static int viewe_bl_probe(struct i2c_client *client)
> +{
> +	struct backlight_properties props =3D {
> +		.type =3D BACKLIGHT_RAW,
> +		.brightness =3D VIEWE_BL_DEFAULT,
> +		.max_brightness =3D VIEWE_BL_MAX,
> +	};
> +	struct backlight_device *bd;
> +
> +	bd =3D devm_backlight_device_register(&client->dev, "viewe_bl",
> +					   &client->dev, client, &viewe_bl_ops,
> +					   &props);
> +	if (IS_ERR(bd))
> +		return PTR_ERR(bd);
> +
> +	i2c_set_clientdata(client, bd);

[Severity: Low]
Does passing the constant string "viewe_bl" to
devm_backlight_device_register() cause probing a second panel instance to
fail with -EEXIST when creating /sys/class/backlight/viewe_bl?  Passing
dev_name(&client->dev) avoids the name collision, and the
i2c_set_clientdata() call can be dropped since client data is never read.

> +	return 0;
> +}

[Severity: Medium]
Does viewe_bl_probe() ignore the default-brightness property from Device
Tree and leave the hardware brightness uninitialized at probe?

devm_backlight_device_register() neither parses default-brightness (or
max-brightness) from device properties nor calls backlight_update_status().
Any default-brightness configured per the viewe,7kf82-backlight binding is
silently ignored in favor of VIEWE_BL_DEFAULT, sysfs brightness is out of
sync with register 0x86 until userspace writes to it, and probe succeeds
even if the MCU at 0x45 does not respond.  In addition, viewe_bl_ops omits
.options =3D BL_CORE_SUSPENDRESUME, so the backlight is not blanked and
restored across system suspend and resume.

> +
> +static const struct of_device_id viewe_bl_of_match[] =3D {
> +	{ .compatible =3D "viewe,7kf82-backlight" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, viewe_bl_of_match);
> +
> +static const struct i2c_device_id viewe_bl_id[] =3D {
> +	{ "viewe_bl", 0 },
> +	{ }
> +};

[Severity: Low]
New struct i2c_device_id entries should use named initializers (such as
{ .name =3D "7kf82-backlight" }), and the ID string should match the
vendor-stripped compatible name ("7kf82-backlight" rather than "viewe_bl")
so fallback I2C ID matching works with the OF compatible string.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_A3BF23A8B6E=
3691F0D567ADF8B84194F4408@qq.com?part=3D6
