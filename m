Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0700F3CF1E2
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587220; cv=none; b=TkT86bXhbTYL+xFgx9sf/5LWbOxoyXVc5ZGX+D+ZDPmQhKxTU9bTdyjR3R1KSxz4OtwbgQH6oBseUbswNmuOTZ8WJVhfP5VNvie6jL6rLXJuyO84vW9mm4Nc2XKugV/uVnHPiZdafMEyWXraGl+7pH0rNkp+/Bi9N2qVmQgeVnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587220; c=relaxed/simple;
	bh=edGt3edgwexTl37QK/CniGcwii+Pbikw+ic7s1TUl/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EuXtZeoCY/DWlCBJNG2OeVOv5roItcrv5luAPjEYh/CJXwiZGV4nh3J6bJJRYlzyZnaepL5ljhIX6felhIx/3nXDmTE2wh52sWEMDPBjae/eY1hxsGfn1bTbfzOz/TY0uorKbBW36J7c/rwsd2ZhIER5Bz6xaLc/cNH8OV+O9ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSO8I6Rq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSO8I6Rq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DF21F000E9;
	Tue, 16 Jun 2026 05:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781587218;
	bh=1kYvqXUbr1Afa7UDPNJgZif4mYA+CsI1UVEC2k9Opd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bSO8I6RqJAZIAMAzW0jCdwZlD5lJe3qPMUTOXahxOzF3hvySA+r5xc88Z6EyS320d
	 sF7Vd6X53I1+ZggIf3e27f4rT20vJq3dN/onOj9G6NdTObxirMOyFO0vxwccucfL9M
	 xwBwfvh2+TDEDtasLvwZ2WCAMlKuMxVSqYQWShZxafMInVkV6DvJEz5qhWYf9KRwc+
	 HqOiq2F8byRxf27PCOnEJQC5TJvAVw+DRR4BmVmE5xeuhV4KTNakDiJQPcwY1x3cQi
	 Dl1BOCysVv9bHYQsye8LBABbIsibgSenqfJQB6y2DK6gPCnw7+EZM0Am9tRZYvePDR
	 0o4dFRNOPqCnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] Input: mms114 - use appropriate register argument
 types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260616050912.1531241-3-dmitry.torokhov@gmail.com>
References: <20260616050912.1531241-3-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 05:20:18 +0000
Message-Id: <20260616052018.C5DF21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Stack-allocated memory is passed to I2C transfer functions, which =
is unsafe as I2C controllers may use DMA.
- [High] The driver doesn't handle a touch ID of 0 for touchscreen events, =
which causes a slot underflow and corrupts the previously active slot's sta=
te.
- [High] Incorrect initialization of Y-axis resolution register.
--

commit e6fe847438e30cfef36a69ac4ec8110ef02638d0
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Input: mms114 - use appropriate register argument types

This commit updates the register arguments in the mms114 touch controller
driver to use 8-bit unsigned integers, matching the hardware specifications.
It also changes the value buffer pointer to void* to prevent explicit casti=
ng
when reading from the device.

> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscre=
en/mms114.c
> index db23b51f4630d..c2e006ac11960 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -87,12 +87,12 @@ struct mms114_touch {
>  	u8 reserved[2];
>  } __packed;
> =20
> -static int __mms114_read_reg(struct mms114_data *data, unsigned int reg,
> -			     unsigned int len, u8 *val)
> +static int __mms114_read_reg(struct mms114_data *data, u8 reg,
> +			     unsigned int len, void *val)
>  {
>  	struct i2c_client *client =3D data->client;
>  	struct i2c_msg xfer[2];
> -	u8 buf =3D reg & 0xff;
> +	u8 buf =3D reg;

[Severity: High]
This is a pre-existing issue, but I noticed we are using a stack-allocated
variable here.

Could this cause issues with DMA? The buf variable is allocated on the stack
and its address is assigned to xfer[0].buf for the outgoing I2C transfer.
Does this violate the DMA API prohibition on using stack-allocated memory
for I2C controllers that use DMA?

[ ... ]

> -static int mms114_write_reg(struct mms114_data *data, unsigned int reg,
> -			    unsigned int val)
> +static int mms114_write_reg(struct mms114_data *data, u8 reg, u8 val)
>  {
>  	struct i2c_client *client =3D data->client;
>  	u8 buf[2];
>  	int error;
> =20
> -	buf[0] =3D reg & 0xff;
> -	buf[1] =3D val & 0xff;
> +	buf[0] =3D reg;
> +	buf[1] =3D val;
> =20
>  	error =3D i2c_master_send(client, buf, 2);

[Severity: High]
This isn't a bug introduced by this patch, but this function also uses a st=
ack
array.

Is it safe to pass the local stack array buf[2] directly to
i2c_master_send()? Does this risk stack corruption if the I2C controller
uses DMA?

[ ... ]

> @@ -242,9 +241,8 @@ static irqreturn_t mms114_interrupt(int irq, void *de=
v_id)
> =20
>  	touch_size =3D packet_size / event_size;
> =20
> -	error =3D __mms114_read_reg(data, MMS114_INFORMATION, packet_size,
> -			(u8 *)touch);
> -	if (error < 0)
> +	error =3D __mms114_read_reg(data, MMS114_INFORMATION, packet_size, touc=
h);
> +	if (error)
>  		goto out;

[Severity: High]
This isn't a bug introduced by this patch, but the touch array is allocated
on the stack in this interrupt handler.

Since the touch array is passed as the read buffer for incoming I2C
touch events, could this lead to stack corruption if the I2C controller
performs DMA?


While reviewing this file, I also noticed a couple of other pre-existing
issues outside of this diff:

[Severity: High]
This is a pre-existing issue, but I noticed there isn't a check for touch ID
0 in mms114_process_mt():

    id =3D touch->id - 1;
    ...
    input_mt_slot(input_dev, id);

If the hardware sends a touch event with touch->id =3D=3D 0, id would under=
flow
to -1. When passed to input_mt_slot(), would this cause the input core to
ignore the slot update and overwrite the state of the previously active slo=
t?


[Severity: High]
This is a pre-existing issue, but it looks like we might be writing the
X-resolution into the Y-resolution register in mms114_setup_regs():

    val =3D props->max_x & 0xff;
    error =3D mms114_write_reg(data, MMS114_Y_RESOLUTION, val);

Does val here inadvertently use props->max_x instead of props->max_y
when writing to MMS114_Y_RESOLUTION?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616050912.1531=
241-1-dmitry.torokhov@gmail.com?part=3D3
