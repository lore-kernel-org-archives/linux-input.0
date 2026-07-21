Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6A3D16EF;
	Tue, 21 Jul 2026 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628108; cv=none; b=LWz+NM0HsUbwgJvcuye/HQnmR6FJjsCkRewFOmsp1oBper/Giqb9e6tJwzAwBYfe3waNj9gWdPiQiSdc748eNoNoqLK6NxMjK1ayQjDQiPc2MPBWdzvUmsmfwTBNUv0kCv8bpmlFart3lNg2LfyISSsIGBa5V/AmAyhFP8BsYGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628108; c=relaxed/simple;
	bh=KAva9eSD6iFwLYPmV7+xkhoqdrfJVYpgkzkgNcdDetg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RKrkLcAD6YJ0p6vZ8ZSgUPs9VE6hZ48lF+WOyYV4MA7FvT1bcGAVfe5WoYDukoDHgnlySuifQIZa0t0Q4TwrytgSEYcY9g0Z9jrJ1UTH7sh1wmUfNOOMSBp5JkzUq7hswrZ/LMQ03F6m9GHbkGWeoxWofWACG7vOkgtiKFXrxto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbEjBD+z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbEjBD+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E2741F000E9;
	Tue, 21 Jul 2026 10:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628107;
	bh=fw3x7eagxMhOaOsJHQtsSwEMQX2OSWLFYZADM37/B9o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mbEjBD+zw7qWLQgU/z5yTtOxkvOHe+Xqq8a8nQv/wDxe5CmuKrqyeACgSFNXUUIl/
	 117O8xzQJAZB8L62dVlbo4HqYGuAHc3/mEG17Es8GZC4SgmM1eVtm7i/AH8n8HuVXu
	 eaOYEfHX0t+LH1iN6TcXsL5nfkRSjNwcA2wSy55zSFHbQblFPARDPXUvGvhPUuB7Bj
	 rMsyu3eIHBLNhPMzxIJQ6cy8GKmzHCmUPfI7Q5LM5o6waP6FK4LoD9503iIqrsc9xl
	 yA1HO9U2b/rg5uewj/edkE1CuhB/3/UDHQQZERHibLVqNv4HEr4TBfL9ef3w3We6cp
	 ycmeQ/u1Zmfwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, robh@kernel.org, lee@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260721095233.420823-3-clamor95@gmail.com>
References: <20260721095233.420823-1-clamor95@gmail.com>
 <20260721095233.420823-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:01:45 +0000
Message-Id: <20260721100145.9E2741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] The shared interrupt buffer `ddata->ec_buf` is overwritten during =
SMI handling, causing event loss and data corruption before broadcast.
- [Medium] The driver exports a bespoke accessor function (`asus_dockram_ac=
cess_ctl`) for child devices, violating MFD architecture guidelines.
- [Medium] The driver hardcodes MFD cell IDs and the base ID instead of usi=
ng automatic cell indexing (`PLATFORM_DEVID_AUTO`).
- [Medium] A complex pointer to a structure is passed as match data via the=
 `.data` field in the device tree match table.
- [Low] The commit message prefix does not follow the mandatory format for =
the MFD subsystem.
- [Low] A driver-specific header file is incorrectly placed in the global M=
FD include directory.
--

--- Patch [2]: [PATCH v10 2/7] mfd: Add driver for ASUS Transformer embedde=
d controller ---
commit a8d39d11a11a5c2d6e44a0723ad1b451adc8effe
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

mfd: Add driver for ASUS Transformer embedded controller
   =20
Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201,
TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF101 dock
and TF600T, P1801-T and TF701T pad. This is a glue driver handling
detection and common operations for EC's functions.

> mfd: Add driver for ASUS Transformer embedded controller

[Severity: Low]
This isn't a bug, but does this commit message prefix follow the standard
MFD subsystem format? I believe it should be formatted as
"mfd: <Driver>: <Capitalized description>", for example:
"mfd: asus-transformer-ec: Add driver...".

[ ... ]

> diff --git a/drivers/mfd/asus-transformer-ec.c b/drivers/mfd/asus-transfo=
rmer-ec.c
> new file mode 100644
> index 0000000000000..739c66fdaf22f
> --- /dev/null
> +++ b/drivers/mfd/asus-transformer-ec.c

[ ... ]

> +int asus_dockram_access_ctl(struct i2c_client *client, u64 *out, u64 mas=
k,
> +			    u64 xor)
> +{
> +	struct dockram_ec_data *ddata =3D i2c_get_clientdata(client);
> +	u8 *buf =3D ddata->ctl_buf;
> +	u64 val;
> +	int ret =3D 0;
> +
> +	guard(mutex)(&ddata->ctl_lock);
> +
> +	memset(buf, 0, ASUSEC_ENTRY_BUFSIZE);
> +	ret =3D i2c_smbus_read_i2c_block_data(client, ASUSEC_DOCKRAM_CONTROL,
> +					    ASUSEC_ENTRY_SIZE, buf);

[ ... ]

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(asus_dockram_access_ctl);

[Severity: Medium]
Does exporting this bespoke accessor for child devices violate the MFD
layering rules? It looks like it creates tight coupling between the parent
and child drivers instead of using standard APIs like regmap or
dev_get_drvdata().

[ ... ]

> +static void asus_ec_clear_buffer(struct asus_ec_data *ddata)
> +{
> +	int ret, retry =3D ASUSEC_RSP_BUFFER_SIZE;
> +
> +	/*
> +	 * Read the buffer till we get valid data by checking ASUSEC_OBF_MASK
> +	 * of the status byte or till we reach end of the 256 byte buffer.
> +	 */
> +	while (retry--) {
> +		ret =3D i2c_smbus_read_i2c_block_data(ddata->client, ASUSEC_READ_BUF,
> +						    ASUSEC_ENTRY_SIZE,
> +						    ddata->ec_buf);
> +		if (ret < ASUSEC_ENTRY_SIZE)
> +			continue;
> +
> +		if (ddata->ec_buf[ASUSEC_IRQ_STATUS] & ASUSEC_OBF_MASK)
> +			continue;
> +
> +		break;
> +	}
> +}

[ ... ]

> +static irqreturn_t asus_ec_interrupt(int irq, void *dev_id)
> +{
> +	struct asus_ec_data *ddata =3D dev_id;
> +	unsigned long notify_action;
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_i2c_block_data(ddata->client, ASUSEC_READ_BUF,
> +					    ASUSEC_ENTRY_SIZE, ddata->ec_buf);
> +	if (ret < ASUSEC_ENTRY_SIZE)
> +		return IRQ_NONE;
> +
> +	/* Check status byte with ASUSEC_OBF_MASK if data is valid */
> +	ret =3D ddata->ec_buf[ASUSEC_IRQ_STATUS] & ASUSEC_OBF_MASK;
> +	if (!ret)
> +		return IRQ_NONE;
> +
> +	notify_action =3D ddata->ec_buf[ASUSEC_IRQ_STATUS];
> +	if (notify_action & ASUSEC_SMI_MASK) {
> +		unsigned int code =3D ddata->ec_buf[ASUSEC_SMI_CODE];
> +
> +		asus_ec_handle_smi(ddata, code);
> +
> +		notify_action |=3D code << 8;
> +	}
> +
> +	blocking_notifier_call_chain(&ddata->ec.notify_list,
> +				     notify_action, ddata->ec_buf);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: High]
Can this sequence corrupt the interrupt event payload?

When asus_ec_handle_smi() receives ASUSEC_SMI_HANDSHAKE or ASUSEC_SMI_RESET,
it calls asus_ec_init() which then calls asus_ec_clear_buffer().

Because asus_ec_clear_buffer() repeatedly reads from the bus into the exact
same shared ddata->ec_buf until the queue is empty, won't it overwrite the
original event payload?

If so, the subsequent call to blocking_notifier_call_chain() will broadcast
a clobbered buffer (containing the final empty read) to the notifiers inste=
ad
of the actual event data.

[ ... ]

> +static const struct mfd_cell asus_ec_tf101_dock_mfd_devices[] =3D {
> +	MFD_CELL_BASIC("asus-transformer-ec-battery", NULL, NULL, 0, 1),
> +	MFD_CELL_BASIC("asus-transformer-ec-charger", NULL, NULL, 0, 1),
> +	MFD_CELL_BASIC("asus-transformer-ec-led", NULL, NULL, 0, 1),
> +	MFD_CELL_NAME("asus-transformer-ec-kbc"),
> +	MFD_CELL_NAME("asus-transformer-ec-keys"),
> +};

[ ... ]

> +static int asus_ec_probe(struct i2c_client *client)
> +{

[ ... ]

> +	return devm_mfd_add_devices(dev, 0, cells, num_cells, NULL, 0, NULL);
> +}

[Severity: Medium]
Does hardcoding the cell IDs and the base ID lead to device naming collisio=
ns?

The MFD subsystem guidelines mandate using PLATFORM_DEVID_AUTO for automatic
cell indexing instead of explicitly passing 0 or statically mapped IDs via =
the
MFD_CELL_BASIC macro.

[ ... ]

> +static const struct of_device_id asus_ec_match[] =3D {
> +	{
> +		.compatible =3D "asus,sl101-ec-dock",
> +		.data =3D &asus_ec_sl101_dock_data
> +	}, {

[Severity: Medium]
Is it safe to pass a complex structure pointer via the match table's .data
field?

Passing complex pointers this way can cause memory safety hazards and
initialization ordering races. Should this store an enum or integer ID
instead, and resolve the struct in the probe function?

[ ... ]

> diff --git a/include/linux/mfd/asus-transformer-ec.h b/include/linux/mfd/=
asus-transformer-ec.h
> new file mode 100644
> index 0000000000000..1c25c3a18355c
> --- /dev/null
> +++ b/include/linux/mfd/asus-transformer-ec.h

[Severity: Low]
This isn't a bug, but should this driver-specific header be placed in the
global include/linux/mfd/ directory? It looks like it is only used by the
parent and its immediate children, which suggests it should be kept local
to drivers/mfd/ to avoid tight coupling.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721095233.4208=
23-1-clamor95@gmail.com?part=3D2
