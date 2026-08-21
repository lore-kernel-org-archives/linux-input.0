Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8651386567;
	Fri, 21 Aug 2026 21:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348560; cv=none; b=gNLl1BZYw+R34eYB0WTr2AOHhpWQFxqdiYnd2AyKjA9WgSzYUaegU4kpqnTB472u4XPuvWabTFSaVsGaX1cGfIvi9PkuWaMD4lV2fsnVVg4Pn0adqm2ied4Ulhnzst0enfCh6EEC7gWe4ok/UWGVv2UoH2NSipIx3fb+c2ts/10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348560; c=relaxed/simple;
	bh=A26n5UoMq4MUvyH3KqvcUod9h5ChdTr8XUpSdWmgUgk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e8IDLLu+DvdVHurLX/hWECFVvVpTiQRgV/g6XjoDraNq18cJ4zqJY4qDYZPWsvHcxTutYWsPqB0W4hrLh3WZxYB2rDvU/s4g1TTc1wiQlgH/721BswemwgkZ3lI3UwxKIeH12923cjZEM3pvswEx+F4uqNXsfKvsu2ePWODRS7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8kUjQU+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8kUjQU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560E51F000E9;
	Fri, 21 Aug 2026 21:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787348558;
	bh=wWuLj7QmR5L71z742TeA0srWsjZenXlGDLXll47bjaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a8kUjQU+PFXIkCaoYXWrPGroGZOVV1KtH4qPBhFoONJo9zprNP4cgbmiKQKd/qvUf
	 O8FQrJifSBV2xwK2ezGqv3r3rxQEHxe+SkrbeZvYIYbkWtAOyrcqDRqDvpxrPQXVYk
	 K+YR8OuJiZ/OwoTX18nZSXDbLR3DSmPTfcoyXazmhIaDdy/+Rwl3XZ6hbS8T3qp6ei
	 10FmkhZm+C/19/R6vFMAyoOdYBb+JNFGVL+G/TXeo2g3kSwE7SkpQIrs9OSCTaXrE6
	 x6dbhbuKjyBcom+nJ9xX2J2J3J24jFBGgBYLK593+Ip9gRQnUbdxPCamF1X1J6ZIHy
	 pHjpR9KebKV3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] Input: imagis - add support for IST4050
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markuss Broks" <markuss.broks@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260822-imagis-40xx-v1-5-73e6d6cdf110@gmail.com>
References: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
 <20260822-imagis-40xx-v1-5-73e6d6cdf110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:42:37 +0000
Message-Id: <20260821214238.560E51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The IMAGIS_PROTOCOL_TOUCH_EVENTS protocol handling drops active co=
ntacts due to incompatibility with INPUT_MT_DROP_UNUSED.

Pre-existing issues:
- [High] Missing i2c_set_clientdata() in probe causes guaranteed NULL point=
er dereference during system suspend/resume.
- [High] Stack-allocated buffers are passed to I2C transfers, violating DMA=
 constraints and potentially failing device probe.
--

--- Patch [5]: [PATCH 5/5] Input: imagis - add support for IST4050 ---
commit cea4b151bd39f3f451e6ebe48a6b0a29508b291a
Author: Markuss Broks <markuss.broks@gmail.com>

Input: imagis - add support for IST4050

The Imagis IST4050 shares the register interface and the power-up
sequence with IST3038C, and reports touches using the IST40xx touch
reporting format. Its chip ID register reads back 0x4050.

Also mention the IST40xx family in the Kconfig help text, and refer to
the older chips as IST30xx, since the driver supports more than the C
variants.

> diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscre=
en/imagis.c
> index 5254cccdd653e..9bf5afd438488 100644
> --- a/drivers/input/touchscreen/imagis.c
> +++ b/drivers/input/touchscreen/imagis.c
[ ... ]
> @@ -491,12 +492,21 @@ static const struct imagis_properties imagis_3038h_=
data =3D {
>  	.protocol =3D IMAGIS_PROTOCOL_SHARED_REGISTER,
>  };
> =20
> +static const struct imagis_properties imagis_4050_data =3D {
> +	.interrupt_msg_cmd =3D IST3038C_REG_INTR_MESSAGE,
> +	.touch_coord_cmd =3D IST3038C_REG_TOUCH_COORD,
> +	.whoami_cmd =3D IST3038C_REG_CHIPID,
> +	.whoami_val =3D IST4050_WHOAMI,
> +	.protocol =3D IMAGIS_PROTOCOL_TOUCH_EVENTS,

[Severity: High]
Does the IMAGIS_PROTOCOL_TOUCH_EVENTS protocol drop active contacts?

In imagis_interrupt(), when processing the IST4050 event stream, the driver
extracts an event type. If the hardware sends an event type other than
PRESS or RELEASE (such as a MOVE event), the switch statement hits the
default case:

drivers/input/touchscreen/imagis.c:imagis_interrupt() {
    ...
			switch (FIELD_GET(IST40XX_TOUCH_EVENT_MASK,
					  finger_status)) {
			case IST40XX_TOUCH_EVENT_PRESS:
				pressed =3D true;
				break;
			case IST40XX_TOUCH_EVENT_RELEASE:
				pressed =3D false;
				break;
			default:
				continue;
			}
    ...
}

This silently skips the input_mt_slot() update. Also, if the hardware
only reports contacts with changes, unchanged stationary contacts will
not appear in the loop.

Because input_mt_init_slots() is configured with INPUT_MT_DROP_UNUSED:

drivers/input/touchscreen/imagis.c:imagis_init_input_dev() {
    ...
	error =3D input_mt_init_slots(input_dev,
				    IST3038C_MAX_FINGER_NUM,
				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
    ...
}

input_mt_sync_frame() will unconditionally drop any previously active
contact that is not explicitly updated in the current frame, which would
break touch tracking for moving or stationary contacts.

[Severity: High]
This is a pre-existing issue, but I noticed imagis_probe() allocates the
context but never assigns it to the device client data:

drivers/input/touchscreen/imagis.c:imagis_probe() {
    ...
	ts =3D devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
	if (!ts)
		return -ENOMEM;

	ts->client =3D i2c;
    ...
}

When the system suspends, imagis_suspend() retrieves an uninitialized
NULL pointer and dereferences it:

drivers/input/touchscreen/imagis.c:imagis_suspend() {
    ...
	struct i2c_client *client =3D to_i2c_client(dev);
	struct imagis_ts *ts =3D i2c_get_clientdata(client);
	int error;

	guard(mutex)(&ts->input_dev->mutex);
    ...
}

Can this lead to a guaranteed kernel panic during system suspend and
resume cycles?

[Severity: High]
This is a pre-existing issue, but I noticed stack-allocated buffers are
passed to I2C transfers in imagis_i2c_read_reg():

drivers/input/touchscreen/imagis.c:imagis_i2c_read_reg() {
    ...
	__be32 ret_be;
	__be32 reg_be =3D cpu_to_be32(reg);
	struct i2c_msg msg[] =3D {
		{
			.addr =3D ts->client->addr,
			.flags =3D 0,
			.buf =3D (unsigned char *)&reg_be,
			.len =3D sizeof(reg_be),
		},
    ...
}

If the system's I2C host controller relies on DMA and CONFIG_VMAP_STACK
is enabled, the kernel stack is not physically contiguous. Could this
cause the DMA mapping to fail and the device probe to abort?

> +};
> +
>  static const struct of_device_id imagis_of_match[] =3D {
>  	{ .compatible =3D "imagis,ist3032c", .data =3D &imagis_3032c_data },
>  	{ .compatible =3D "imagis,ist3038", .data =3D &imagis_3038_data },

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-imagis-40x=
x-v1-0-73e6d6cdf110@gmail.com?part=3D5
