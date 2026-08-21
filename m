Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7A6493646;
	Fri, 21 Aug 2026 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348378; cv=none; b=lrkiD2+HffQPT1t4BR39OHmDYEwqxXnNKBIHh0qVh8Uzw3tPLbaJDv2UhS5c5BKDr7AhCdB96gl8owpISfTIobtLQny6P//rozqzkmE90XRvVacSNld959p8cLAGtsB8MQMDPizbBidOYdkI+x6EVjgBpRWSKaHgUW6Gj5512pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348378; c=relaxed/simple;
	bh=TyNTNd+9Et7EgrhVERq245tW5ePzY3BxJWU5qxxWxvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oZnfMsSBXssxAShjJnMHtekjqSzUitS/7QT2hOf2wq8kF/yRes9Amprez6C6/u2lXXTjVP1U/HEccioqagAhCOnKGQJdJQ59izeRhjcuP/aBPaJQAiT2MnR5z57STnub2EDDdsLhMRTB7aOfxiwuvFIm/T8gBerloIx1s3ihxNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO4Ww3P4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO4Ww3P4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E12AF1F000E9;
	Fri, 21 Aug 2026 21:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787348377;
	bh=VFWr5wQzaiYXpVVvf5nPZVkjpnwkIqHYrytILhwGbZw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YO4Ww3P44j0Sl1EqGTmhEgyOZaBjQqZ5xU0sy/ooFhcD5wiIFm8kgehuGqMI+hMxr
	 mxqbOiOx0bwr5fd+n8ySY0upUxKTZaP51lmjqrZtBllYZ7o3vNDkcVb9SAlMim6gvr
	 i7rpHhd5HxSncn413IWSjeZRWzlT1fkCn7BIVdcfjF8Fdn7s/InUV4HbZ9KcMXAy8k
	 OvQsih2r3sufEUhkV8e+tt/gPIrgq6mByW2i5ADaHita8ZYTpWZC3pfdwHsKRAZ0e4
	 JINO27hfiGlpMGXTsfZCylA5lf+NYiy0s7rJmV7ltbT9vrxeGuJwRBFCLa9m0dny66
	 UgxYmE8LBdTPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] Input: imagis - do not report coordinates of
 released contacts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markuss Broks" <markuss.broks@gmail.com>
Cc: conor+dt@kernel.org, robh@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260822-imagis-40xx-v1-2-73e6d6cdf110@gmail.com>
References: <20260822-imagis-40xx-v1-0-73e6d6cdf110@gmail.com>
 <20260822-imagis-40xx-v1-2-73e6d6cdf110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 21:39:36 +0000
Message-Id: <20260821213936.E12AF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] DMA mapping of stack variables in I2C transfer.
- [High] Missing I2C client data initialization leads to a guaranteed NULL =
pointer dereference during system suspend.
- [High] Unconditionally returning IRQ_HANDLED on I2C failure can cause an =
interrupt storm.
--

--- Patch [2]: [PATCH 2/5] Input: imagis - do not report coordinates of rel=
eased contacts ---
commit e577f0168e2b3c0834df658e8cd2f5b4436f2fcb
Author: Markuss Broks <markuss.broks@gmail.com>
Subject: Input: imagis - do not report coordinates of released contacts

This commit modifies the imagis driver to only report the position and
contact area for active contacts. It also prepares the driver for the
IST40xx family, which carries an event type in the contact area bits for
release records.

> diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscre=
en/imagis.c
> index 7bbb00beec3be..7cc91f97c06e0 100644
> --- a/drivers/input/touchscreen/imagis.c
> +++ b/drivers/input/touchscreen/imagis.c

[ ... ]

> @@ -127,6 +127,8 @@ static irqreturn_t imagis_interrupt(int irq, void *de=
v_id)
>  	finger_pressed =3D FIELD_GET(IST3038C_FINGER_STATUS_MASK, intr_message);
> =20
>  	for (i =3D 0; i < finger_count; i++) {
> +		bool pressed;
> +
>  		if (ts->tdata->protocol_b)
>  			error =3D imagis_i2c_read_reg(ts,

[Severity: High]
This isn't a bug introduced by this patch, but could this I2C read cause DMA
mapping issues?

In imagis_i2c_read_reg(), the variables reg_be and ret_be are allocated
on the stack:

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

Their addresses are passed directly to i2c_transfer(). If the underlying I2C
adapter relies on DMA and CONFIG_VMAP_STACK is enabled, these stack
addresses reside in vmalloc space and are not DMA-mappable, which can lead
to dma_map_single() failures or memory corruption.

>  						    ts->tdata->touch_coord_cmd + (i * 4),
> @@ -141,9 +143,13 @@ static irqreturn_t imagis_interrupt(int irq, void *d=
ev_id)
>  			goto out;
>  		}

[Severity: High]
This is a pre-existing issue, but does this error path bypass the kernel's
spurious interrupt detector?

If imagis_i2c_read_reg() fails, the code jumps to the out label which
unconditionally returns IRQ_HANDLED.

If the controller fails to respond, the physical IRQ line might remain
asserted because the device status registers aren't cleared. By returning
IRQ_HANDLED instead of IRQ_NONE, the IRQ core will unmask the line and it
will immediately fire again, potentially creating an interrupt storm that
locks up the CPU core.

> =20
> +		pressed =3D finger_pressed & BIT(i);
> +
>  		input_mt_slot(ts->input_dev, i);
> -		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER,
> -					   finger_pressed & BIT(i));
> +		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, pressed);
> +		if (!pressed)
> +			continue;
> +
>  		touchscreen_report_pos(ts->input_dev, &ts->prop,
>  				       FIELD_GET(IST3038C_X_MASK, finger_status),
>  				       FIELD_GET(IST3038C_Y_MASK, finger_status),

[Severity: High]
This is a pre-existing issue, but could system suspend trigger a NULL point=
er
dereference?

Looking at imagis_suspend(), it calls i2c_get_clientdata(client) to get the
driver data, but imagis_probe() never sets it via i2c_set_clientdata() or
dev_set_drvdata().

This means i2c_get_clientdata() will return NULL, and the very next line
will dereference it:

    struct imagis_ts *ts =3D i2c_get_clientdata(client);
    int error;

    guard(mutex)(&ts->input_dev->mutex);

Would it be possible to initialize the client data in imagis_probe() to
prevent this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-imagis-40x=
x-v1-0-73e6d6cdf110@gmail.com?part=3D2
