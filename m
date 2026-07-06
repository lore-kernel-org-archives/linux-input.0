Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B773C1F45
	for <linux-input@vger.kernel.org>; Mon,  6 Jul 2026 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361794; cv=none; b=DqOTmjcqwNMo+xcwVaPh67sVLv0az+mr7npqnSBrUxmeMtpNsC+zFE9Mk4toqXzYNa8ituWAlD/5bCwSULXt6sPSsKKgzmRbfiCmHruPUV9Cqf/LaMQT1HfvbZXbUi7Tduf8DlFfa1U0yGK1FlnVz+N0zG9s3SeJ2IktSKY2pNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361794; c=relaxed/simple;
	bh=jLSSb6tr6GFG3EHkMf94nVDc8V+DTdOiL+Tcudb4VLc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I6DTFPgeb808EbhIpACGj6a8Sb1rWkOMbSjcsMbRueR6OUbH08CFrXg/h3Xa+6Gy9D57R8pjmpIjV1kXqFrLRWuRbdJH4NfwiN0fV9n8pJ/0RNYUv4MrWHr6e0Nh6GGfsc5GIZpXYFVWHR0Y9+LtaGhTlKvU3qNPudGlqTc8QcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fj8rZ9z1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fj8rZ9z1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967471F000E9;
	Mon,  6 Jul 2026 18:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783361792;
	bh=q2a3JVUCgqraa9m7GeHS9LpdqF6QP/C1epch/zy7alk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fj8rZ9z1dV/yesQCTjAVhiVTFAHPkmw+BhSXBxdlfyrh3sD+mzRuZT1vNYreN3x2L
	 M6RV8F+oy6Ssjach0VsTOuurkuj20MUSHtfAD9YSLrp8k8RhDjE6BFvQO3AeD17XXK
	 IglM9sLgXnzqVzGWacFc+RRnCrogDtQtzX8n31ikF9uFWodDAtWx53ynV4iQcfMeVC
	 /pnH75zw+cUlE6huRsjb0mJy64pjh2YkmAbr436gGnvtqOtbjelOXRK2wbcrPJA0PW
	 W9mUmKV3nIf1diXnO5+tAXPDr5xBUQICBkmdl3vBKoGYIaBqoNx19m05Z3TF3q92K3
	 leTGPo5blF0+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: zinitix - support the 6-byte/count touch report
 used by bt532
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kavan Smith" <kavansmith82@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260706180826.408989-1-kavansmith82@gmail.com>
References: <20260706180826.408989-1-kavansmith82@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 18:16:32 +0000
Message-Id: <20260706181632.967471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `zinitix,mode` property is read and validated after `input_reg=
ister_device()` is called. This creates a race condition where userspace ca=
n open and use the input device before its private state is fully configure=
d, violating input subsystem initialization rules.
- [High] I2C transactions use stack-allocated buffers, which are unsafe for=
 DMA.
--

commit 25626131785e9a530425fa65d2a03db62641f88e
Author: Kavan Smith <kavansmith82@gmail.com>

Input: zinitix - support the 6-byte/count touch report used by bt532

This commit adds a per-compatible struct zinitix_chip_data to select
the report stride and how byte[2] is interpreted. It provides support
for firmware packing contacts at a 6-byte stride and reporting a finger
count, fixing multitouch behavior on devices like the Samsung Galaxy Tab
A 8.0.

> diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscr=
een/zinitix.c
> index 0c36765bd79f8..04ee4d804b511 100644
> --- a/drivers/input/touchscreen/zinitix.c
> +++ b/drivers/input/touchscreen/zinitix.c

[ ... ]

> @@ -452,8 +475,11 @@ static irqreturn_t zinitix_ts_irq_handler(int irq, v=
oid *bt541_handler)
> =20
>  	memset(&touch_event, 0, sizeof(struct touch_event));
> =20
> +	/* header (status, finger_mask, time_stamp) + one stride per contact */
>  	error =3D zinitix_read_data(bt541->client, ZINITIX_POINT_STATUS_REG,
> -				  &touch_event, sizeof(struct touch_event));
> +				  &touch_event,
> +				  offsetof(struct touch_event, coords) +
> +					  MAX_SUPPORTED_FINGER_NUM * stride);

[Severity: High]
This is a pre-existing issue, but does zinitix_read_data() perform safe I2C
transactions here?

The &touch_event pointer points to stack memory and is passed to
i2c_master_recv() inside zinitix_read_data(). Passing stack-allocated buffe=
rs
to I2C transfer functions can violate DMA safety rules. If the I2C host
controller driver maps these buffers for DMA, it can corrupt adjacent stack
variables on non-cache-coherent architectures.

This same issue seems to exist with &reg_le in zinitix_read_data() and the
packet array in zinitix_write_u16(). Would it be possible to allocate these
buffers dynamically to avoid potential DMA stack corruption?

[ ... ]

> @@ -627,6 +671,7 @@ static int zinitix_ts_probe(struct i2c_client *client)
>  		return -ENOMEM;
> =20
>  	bt541->client =3D client;
> +	bt541->chip =3D device_get_match_data(&client->dev);
>  	i2c_set_clientdata(client, bt541);
> =20
>  	error =3D zinitix_init_regulators(bt541);

[Severity: High]
This isn't a bug introduced by this patch, but looking further down in
zinitix_ts_probe(), zinitix_init_input_dev() is called to register the input
device before reading the zinitix,mode property:

	error =3D zinitix_init_input_dev(bt541);
	if (error) {
		dev_err(&client->dev,
			"Failed to initialize input device: %d\n", error);
		return error;
	}

	error =3D device_property_read_u32(&client->dev, "zinitix,mode",
					 &bt541->zinitix_mode);

Does this create a race condition where userspace could open and use the
input device before its private state is fully configured?

If userspace opens the device in this window, zinitix_input_open() might use
bt541->zinitix_mode while it is still 0 (from kzalloc). This could configure
the hardware in an invalid state instead of the device-tree specified mode.
Should the property be read and validated before calling
input_register_device()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706180826.4089=
89-1-kavansmith82@gmail.com?part=3D1
