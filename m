Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796187;
	b=CfGHhYqz9Xl66eIRub30hL2kleuP8DZ/SF2Nhes0s65IpEBORld2WfhEqc7AHxR07iG0
	 LfMKGWjlr6B/xCCvuG1jnoULIMyXaCi5MPX+ge29DnElKNMR7YvlbidK353qWIggf3X3U
	 xyC/Xs0+oX5qCIaU6Eq7tkFA44PpWNfQHHeDcQC5H1Vr4x0T0D1m48l8SARROR8ICJtii
	 JLRok/tfXsddkLJB0DQbeRlffFJK0gDNNqjidvbfj7RlW9EQ3GejVOW6lx0ODTZDuZWDX
	 0tH9926J7mJJn2PzeWt/Fn4FlQQ/y3Urr+OKtt0POO79SJGD+qCMkc5Fv13vOEV2Z2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796187;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AeuiRmVTbewkewJs2xRMNyhsEitP00wnZ7/PLCycRnM=;
	b=fhgtAOviDcJZ0qlYxuHtCCVAyt/prSYhvQvf6dKCcXUbsmxLlFcuKitFpyqDsW2pWi1/
	 Ww4cnbBMz3DF4MHMa9kjK1pKAtdkGSkJtdFwYbEq/h1yEKm4VZxT90th89NyTwCVxfsZa
	 xiY4QPbe+gxFgR+iTy8aHAwzqfdJrfquoFyGNQMi5H8vqDP8oVNPLkNZI27+3yC5QQiBX
	 Q5lNvco3RVZlwZ3RsHC6JwFYjM9c4scam3EsJNmkiYJt6wE8J/NjhOiiEQvS29I0uQ3Fy
	 RYflq69lZYPHyYcYTToOVw6tIJ0Thb/kylA5faVvNK3d0wmm5Wn88OlMOrjb+7JC+eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzwmnJsV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B84F606A326;
	Wed,  4 Nov 2026 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LzwmnJsV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1641F000C1;
	Wed,  4 Nov 2026 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793796187;
	bh=AeuiRmVTbewkewJs2xRMNyhsEitP00wnZ7/PLCycRnM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LzwmnJsV0E/L2zbeZJT483z8oZuOBlyAA8wmFuqC0z8p4eAxwEDoQj5LeID+9Iv6/
	 AUtuQvb4XJCC0qhH30oQfRxjGodq05EPfMeZv6SNS7NN3+THjxWALZIZKD2D+j0fe1
	 8SHzYFKGISjKWSYpaCCd8Hop8j3QKkjm/3X9XIAmjrv+jTwO4V+6wheEJbz24T3ZxG
	 Q9ceAQb5CXLKJZPJYiidNxf8s20u9oNDls8VDBFF/a5QOYfp9OG73ILOm1tf/zG8KQ
	 2Iz9bUqJCEXgWJWd2tMhB4JjUKKVJBzLMoBdoObnDlcr70ofb0Gl1Y6rv5CG2TcCih
	 9g3bMRS4C02+g==
Message-ID: <sashiko-outbox-197285@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, mfd@lists.linux.dev, linux-leds@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261104122606.215629-3-clamor95@gmail.com>
References: <20261104122606.215629-1-clamor95@gmail.com>
 <20261104122606.215629-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 12:43:06 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] mfd: asus-transformer-ec: UAF on dockram_ec_data in devm_asus_dock=
ram_get()
- [Medium] mfd: asus-transformer-ec: ec_buf clobbered in asus_ec_interrupt(=
) on SMI
- [Medium] mfd: asus-transformer-ec: fixed retry count in asus_ec_clear_buf=
fer()
- [Low] mfd: asus-transformer-ec: inverted comment in asus_ec_clear_buffer()
- [Low] mfd: asus-transformer-ec: sibling input state in asusec_core and mf=
d naming
--

commit 127ab1fbe238a806a6be88edfad37b1c227e1824
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

mfd: Add driver for ASUS Transformer embedded controller

This commit adds a core MFD driver for the Nuvoton NPCE795-based embedded
controller found in ASUS Transformer tablets and docks, handling I2C
communication, detection, and sub-device registration.

> diff --git a/drivers/mfd/asus-transformer-ec.c b/drivers/mfd/asus-transfo=
rmer-ec.c
> new file mode 100644
> index 0000000000000..2f575ecb4f58b
> --- /dev/null
> +++ b/drivers/mfd/asus-transformer-ec.c
> @@ -0,0 +1,551 @@
[ ... ]
> +#define ASUSEC_ACCESS_TIMEOUT		300
> +#define ASUSEC_DOCKRAM_OFFSET		2
> +#define ASUSEC_ECREQ_DELAY		50
> +#define ASUSEC_ECREQ_TIMEOUT		200
> +#define ASUSEC_RESET			0
> +#define ASUSEC_RETRY_MAX		3
> +#define ASUSEC_RSP_BUFFER_SIZE		(ASUSEC_ENTRIES / ASUSEC_ENTRY_SIZE)
> +#define ASUSEC_SL101_ENTRY_SIZE		8

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
> +						    ddata->info->read_size, ddata->ec_buf);
> +		if (ret < ddata->info->read_size)
> +			continue;
> +
> +		if (ddata->ec_buf[ASUSEC_IRQ_STATUS] & ASUSEC_OBF_MASK)
> +			continue;
> +
> +		break;
> +	}
> +}

[Severity: Medium]
In asus_ec_clear_buffer(), retry is initialized to ASUSEC_RSP_BUFFER_SIZE,
which divides ASUSEC_ENTRIES (256) by ASUSEC_ENTRY_SIZE (32) for 8
iterations.

However, each iteration reads ddata->info->read_size bytes. On the SL101
dock variant (asus_ec_sl101_dock_data), read_size is ASUSEC_SL101_ENTRY_SIZE
(8), so 8 iterations only drain at most 64 bytes instead of the full 256-by=
te
EC buffer.

Should the retry count be computed from ddata->info->read_size instead of
the fixed ASUSEC_ENTRY_SIZE?

[Severity: Low]
Also in asus_ec_clear_buffer(), the comment states "Read the buffer till we
get valid data by checking ASUSEC_OBF_MASK", whereas the loop actually
continues while ASUSEC_OBF_MASK is set (valid data present) and breaks once
the buffer is empty. Should the comment say it reads until the buffer no
longer has valid data?

[ ... ]

> +static void asus_ec_handle_smi(struct asus_ec_data *ddata, unsigned int =
code)
> +{
> +	switch (code) {
> +	case ASUSEC_SMI_HANDSHAKE:
> +	case ASUSEC_SMI_RESET:
> +		asus_ec_init(ddata);
> +		break;
> +	}
> +}
> +
> +static irqreturn_t asus_ec_interrupt(int irq, void *dev_id)
> +{
> +	struct asus_ec_data *ddata =3D dev_id;
> +	unsigned long notify_action;
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_i2c_block_data(ddata->client, ASUSEC_READ_BUF,
> +					    ddata->info->read_size, ddata->ec_buf);
> +	if (ret < ddata->info->read_size)
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
> +	blocking_notifier_call_chain(&ddata->ec.notify_list, notify_action, dda=
ta->ec_buf);
> +
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
When asus_ec_interrupt() receives an SMI event with ASUSEC_SMI_HANDSHAKE or
ASUSEC_SMI_RESET, it calls:

asus_ec_interrupt()
  -> asus_ec_handle_smi()
       -> asus_ec_init()
            -> asus_ec_clear_buffer()

asus_ec_clear_buffer() reads into the same shared ddata->ec_buf buffer until
ASUSEC_OBF_MASK is clear, overwriting the SMI packet that triggered the
interrupt before blocking_notifier_call_chain() passes ddata->ec_buf to
registered listeners. In addition, asus_ec_handle_smi() ignores the return
value of asus_ec_init(), so notifier callbacks still run even if
reinitialization failed.

Should asus_ec_clear_buffer() use a separate buffer (or should
asus_ec_interrupt() avoid passing a clobbered ddata->ec_buf and check for
asus_ec_init() errors)?

> +static void asus_ec_release_dockram_dev(void *client)
> +{
> +	i2c_unregister_device(client);
> +}
> +
> +static struct i2c_client *devm_asus_dockram_get(struct device *dev)
> +{
> +	struct i2c_client *parent =3D to_i2c_client(dev);
> +	struct i2c_client *dockram;
> +	struct dockram_ec_data *ddata;
> +	int ret;
> +
> +	dockram =3D i2c_new_ancillary_device(parent, "dockram",
> +					   parent->addr + ASUSEC_DOCKRAM_OFFSET);
> +	if (IS_ERR(dockram))
> +		return dockram;
> +
> +	ret =3D devm_add_action_or_reset(dev, asus_ec_release_dockram_dev, dock=
ram);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ddata =3D devm_kzalloc(&dockram->dev, sizeof(*ddata), GFP_KERNEL);
> +	if (!ddata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	i2c_set_clientdata(dockram, ddata);
> +	mutex_init(&ddata->ctl_lock);
> +
> +	return dockram;
> +}

[Severity: High]
As reported by Dmitry Torokhov on v11 [1], devm_asus_dockram_get() allocates
ddata with devm_kzalloc(&dockram->dev, ...) and attaches it via
i2c_set_clientdata(dockram, ddata) on the ancillary dummy I2C device rather
than the parent device dev.

Because dockram is bound to the I2C dummy driver, unbinding dockram from the
dummy driver via sysfs triggers device_unbind_cleanup(&dockram->dev), which
frees &dockram->dev devres allocations and clears its driver_data to NULL
while the parent MFD driver and child sub-devices remain active. Concurrent
calls to asus_dockram_access_ctl() can then suffer a use-after-free on
ddata->ctl_lock and ddata->ctl_buf across sleeping SMBus transfers, and
subsequent calls will fail with -ENODEV.

Could ddata be allocated with devm_kzalloc(dev, ...) on the parent device i=
nstead?

> +static const struct mfd_cell asus_ec_sl101_dock_mfd_devices[] =3D {
> +	MFD_CELL_NAME("asus-transformer-ec-kbc"),
> +};
> +
> +static const struct mfd_cell asus_ec_tf101_dock_mfd_devices[] =3D {
> +	MFD_CELL_NAME("asus-transformer-ec-battery"),
> +	MFD_CELL_NAME("asus-transformer-ec-charger"),
> +	MFD_CELL_NAME("asus-transformer-ec-led"),
> +	MFD_CELL_NAME("asus-transformer-ec-kbc"),
> +	MFD_CELL_NAME("asus-transformer-ec-keys"),
> +};
> +
> +static const struct mfd_cell asus_ec_tf201_pad_mfd_devices[] =3D {
> +	MFD_CELL_NAME("asus-transformer-ec-battery"),
> +	MFD_CELL_NAME("asus-transformer-ec-led"),
> +};
> +
> +static const struct mfd_cell asus_ec_tf600t_pad_mfd_devices[] =3D {
> +	MFD_CELL_NAME("asus-transformer-ec-battery"),
> +	MFD_CELL_NAME("asus-transformer-ec-charger"),
> +	MFD_CELL_NAME("asus-transformer-ec-led"),
> +};
[ ... ]
> diff --git a/include/linux/mfd/asus-transformer-ec.h b/include/linux/mfd/=
asus-transformer-ec.h
> new file mode 100644
> index 0000000000000..fda6fb08cc41a
> --- /dev/null
> +++ b/include/linux/mfd/asus-transformer-ec.h
> @@ -0,0 +1,100 @@
[ ... ]
> +struct asusec_core {
> +	const char *model;
> +	const char *name;
> +	struct i2c_client *dockram;
> +	struct blocking_notifier_head notify_list;
> +	u8 keyboard_mask;
> +	bool ext_keys_enabled;
> +	bool right_alt_pressed;
> +	bool special_combo_triggered;
> +};

[Severity: Low]
This isn't a bug, but in struct asusec_core, the fields ext_keys_enabled,
right_alt_pressed, and special_combo_triggered are unused by the core MFD
driver in drivers/mfd/asus-transformer-ec.c and appear to be private input
state shared between sibling sub-devices. Also, the mfd_cell arrays in
drivers/mfd/asus-transformer-ec.c (such as asus_ec_sl101_dock_mfd_devices)
include "mfd" in their names. Would it be cleaner to avoid exposing
sibling-specific input state in the core MFD structure and drop "mfd" from
the cell array names in accordance with MFD conventions?

[1] https://lore.kernel.org/r/d5f54636c25e0e60731adc200a63ceb5@gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104122606.2156=
29-1-clamor95@gmail.com?part=3D2
