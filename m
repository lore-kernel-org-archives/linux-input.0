Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1173A411F9F;
	Mon, 10 Aug 2026 15:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376651; cv=none; b=tDh0978598cXRcu5WeP1rUKHWaeye4NtvjzeRj6KaQAbQL1wRPuIV/InwaoF7s71WTE8h4xuAMdnyMBvR4Ye5DG5BCuQPF4GEbMxnqaFoXuMa4CIB4y5ZVsjFsjrk7QF9QTlMm0+xFOVfkkmLROgmo+X46UhOlqzRWulb5zY9Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376651; c=relaxed/simple;
	bh=C6cxHOsZACAKeN94E994O/jwwjeiJzpYCkhLkorsEoI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VLYyqmkkw1Yc/dkSjsje3H0JevRgmcZBlnzq4WMuNTmM4ryFKuYMzHTWF4nWEgT8Kq0eKM2XCyhiFaNXH0vgkdJSFeXTII5eTa62XT4amoad6MUa6+ry/tYnCacGy5E5TGxzWETnVkiHc8/YDrxQyEE2SeU3HfTv9YgpixiOVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/UHmIp9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/UHmIp9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C7C1F000E9;
	Mon, 10 Aug 2026 15:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786376649;
	bh=fqBoJFSQE2agf1BaBtWZMKpmosXJ/LW6AkjryVxXCPU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k/UHmIp9cmpecAWB/f1sU6bWAsIyBmQxfZUtoU017Sa3pgVYF5X3j/+yWy46wgn3S
	 GuJQaxKo26ud7oL27FU3nR4tmzGbPTGarBUwT5kRQkGVTbw+CPM4Voe5ahScSbvVoS
	 9O3RhLywLk9avlNNdvYHgGZA6YxGnqCbw3/+Kz7mNUnXOnavXBsDvJWjdbMQhIEDd+
	 cQa78aInEZ98qO1wnVtNuITE6DKs/zpwWTdDXEcVysqn0tpmz6Zbpzum08dEZ8lTW5
	 wzol27uEb+mbp6Bt1pL7HaRWlPRP5YkXuyEkgqsacgcKL3+5lgOqL/SlaNQwhzg8TZ
	 aMkK2yXwsVqHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] Input: stmfts - support FTS5
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg" <david@ixit.cz>
Cc: dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260810-stmfts5-v5-2-0c737d929976@ixit.cz>
References: <20260810-stmfts5-v5-0-0c737d929976@ixit.cz>
 <20260810-stmfts5-v5-2-0c737d929976@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 15:44:08 +0000
Message-Id: <20260810154409.40C7C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Unconditional dereference of `sdata->ops` leads to NULL pointer de=
reference if probed via I2C board info.
- [High] The FTS5 Y-coordinate is entirely corrupted due to erroneous MSB a=
nd LSB bit shifts.
- [Medium] The power-off sequence attempts an I2C write after the chip has =
already been placed into hardware reset.
- [Medium] Touch Major and Minor axes are corrupted due to logic errors com=
bining bits with the constant Event ID.

Pre-existing issues:
- [High] The touchscreen is left in a sleep state after system resume if it=
 was active prior to suspend.
--

--- Patch [2]: [PATCH v5 2/3] Input: stmfts - support FTS5 ---
commit 8851d4460d3a4355e8954e1dd8b5a724d25fb3be
Author: David Heidelberg <david@ixit.cz>
Subject: Input: stmfts - support FTS5

This commit adds support for FTS5 touchscreens to the stmfts driver. It
introduces a mode-switch GPIO for SLPI and AP modes, currently only handling
full power AP mode.

> diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscre=
en/stmfts.c
> index 972687797f826..1da113d7197e6 100644
> --- a/drivers/input/touchscreen/stmfts.c
> +++ b/drivers/input/touchscreen/stmfts.c

[ ... ]

> @@ -205,6 +246,104 @@ static void stmfts_report_contact_release(struct st=
mfts_data *sdata,
>  	input_sync(sdata->input);
>  }
> =20
> +/* FTS5 event handling functions */
> +static void stmfts5_report_contact_event(struct stmfts_data *sdata,
> +					 const u8 event[])
> +{
[ ... ]
> +	/* Parse coordinates with better precision */
> +	x =3D (((int)event[3] & STMFTS_MASK_X_MSB) << 8) | event[2];
> +	y =3D ((int)event[4] << 4) | ((event[3] & STMFTS_MASK_Y_LSB) >> 4);

[Severity: High]
Does this bitwise logic for the Y coordinate scramble the value?

According to the comment above this code, event[4] is the 8-bit Y LSB, and
event[3] contains the 4-bit Y MSB. By shifting event[4] up by 4 and event[3]
down by 4, this appears to treat the 8-bit LSB as the most significant bits
and the 4-bit MSB as the least significant bits.

Should this be (((int)event[3] & STMFTS_MASK_Y_LSB) << 4) | event[4] instea=
d?

> +
> +	/* Parse pressure - ensure non-zero for active touch */
> +	area =3D event[5];
[ ... ]
> +
> +	/* Parse touch area with improved bit extraction */
> +	maj =3D (((event[0] & 0x0C) << 2) | ((event[6] & 0xF0) >> 4));
> +	min =3D (((event[7] & 0xC0) >> 2) | (event[6] & 0x0F));

[Severity: Medium]
Is it intentional to use event[0] to calculate maj?

event[0] holds the event ID (like STMFTS5_EV_MULTI_TOUCH_ENTER which is
0x13). For valid contact events, event[0] & 0x0C will always be zero,
meaning maj only captures the upper 4 bits of event[6].

Does this result in malformed touch area statistics being reported?

[ ... ]

> @@ -601,15 +835,11 @@ static int stmfts_power_on(struct stmfts_data *sdat=
a)
>  	if (sdata->reset_gpio)
>  		stmfts_reset(sdata);
> =20
> -	err =3D stmfts_read_system_info(sdata);
> -	if (err)
> -		goto err_disable_regulators;
> -
>  	enable_irq(sdata->client->irq);
> =20
>  	msleep(50);
> =20
> -	err =3D stmfts_configure(sdata);
> +	err =3D sdata->ops->configure(sdata);
>  	if (err)
>  		goto err_disable_irq;

[Severity: High]
This is a pre-existing issue, but does stmfts_power_on() unintentionally
leave the touchscreen dead after a system resume if it was active before
suspend?

When resuming, the device is powered on and unconditionally put to sleep
with STMFTS_SLEEP_IN at the end of stmfts_power_on():

        /*
         * At this point no one is using the touchscreen
         * and I don't really care about the return value
         */
        (void)i2c_smbus_write_byte(sdata->client, STMFTS_SLEEP_IN);

Because the PM core still considers the device RPM_ACTIVE from before the
suspend, it will not automatically invoke stmfts_runtime_resume(). Thus,
STMFTS_SLEEP_OUT is never sent and the hardware remains unresponsive until
userspace closes and reopens the device.

[ ... ]

> @@ -637,9 +887,61 @@ static void stmfts_power_off(void *data)
>  	if (sdata->reset_gpio)
>  		gpiod_set_value_cansleep(sdata->reset_gpio, 1);
> =20
> +	if (sdata->ops->power_off)
> +		sdata->ops->power_off(sdata);

[Severity: Medium]
Will this cause an I2C transaction timeout?

By asserting the reset GPIO to 1 just before calling
sdata->ops->power_off(), the chip is placed into hardware reset.

When stmfts5_chip_power_off() immediately tries to send the
STMFTS_SLEEP_IN I2C command:

static void stmfts5_chip_power_off(struct stmfts_data *sdata)
{
        i2c_smbus_write_byte(sdata->client, STMFTS_SLEEP_IN);
        msleep(20);
}

The unresponsive chip would likely NACK the transfer or cause a bus
timeout since it is held in reset.

[ ... ]

> @@ -685,6 +987,8 @@ static int stmfts_probe(struct i2c_client *client)
>  	mutex_init(&sdata->mutex);
>  	init_completion(&sdata->cmd_done);
> =20
> +	sdata->ops =3D of_device_get_match_data(dev);
> +
[ ... ]
> @@ -703,8 +1007,8 @@ static int stmfts_probe(struct i2c_client *client)
> =20
>  	sdata->input->name =3D STMFTS_DEV_NAME;
>  	sdata->input->id.bustype =3D BUS_I2C;
> -	sdata->input->open =3D stmfts_input_open;
> -	sdata->input->close =3D stmfts_input_close;
> +	sdata->input->open =3D sdata->ops->input_open;
> +	sdata->input->close =3D sdata->ops->input_close;

[Severity: High]
What happens if this driver is instantiated via I2C sysfs board info?

Since dev->of_node would be NULL, of_device_get_match_data() would
return NULL. Would this cause a NULL pointer dereference when
accessing sdata->ops->input_open shortly after?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-stmfts5-v5=
-0-0c737d929976@ixit.cz?part=3D2
