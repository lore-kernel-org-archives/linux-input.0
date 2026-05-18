Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD833ED134;
	Mon, 18 May 2026 10:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100268; cv=none; b=msKhopYC6Fhu2xvU2TfR3j+RyrjOD3a4El0pM3yf7IBdm2h1ktfZ3UP2St9qsHxGLwKCmWcplrV1glVaFzUfhMLjvYSQz3U2lHSWze79CQpANQUV6CnzE3GnrE300DnITv3uEMrDqU3vtlz8lUjSJ9OoRDrrJV/pRjseHICpfSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100268; c=relaxed/simple;
	bh=FhzxYt//Uphy9XIMcZdhMxK6XHMp+0lzc44JUU+R3NU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nKY7WRRCMx0YKet+57wDxl3ps3y0KBFb9gw0SJ9zr9xLzQbrvXgvgsm60MhKQQdX5GjkBa1PboRNGZ2BwvYDaUf4rnPu/IiejhfUPMPnOO2PszSt3dmev+YzQ82jx+Lxhb7+Z083FlbqgXFk74hngLxVcW63DKlffHUO9fam3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ac3nSHih; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ac3nSHih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DE5C2BCB8;
	Mon, 18 May 2026 10:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779100265;
	bh=FhzxYt//Uphy9XIMcZdhMxK6XHMp+0lzc44JUU+R3NU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ac3nSHihohxac5PHqDzudCDR2GXQIEPgjVw7GnlzLgOvF3pt1fsK5nZy7fv/I0ZOY
	 IEkryONTbOIDkqMcjL3HabW9KbWuXvwzzaEw4n4mzq6aRHfslKC7skhnRV1XiDvTym
	 0+q6txvuo/d+vtN/IgcPFmAOjAIV8AgBDHZO/TIQt41TiXrWcw2qaS7JyMa4yfQzSL
	 KqBkItR4ousgOfrmZg16MA3kgYoWBiekFlCoWv3bSB7qIxu91w2ZeVKwQvJqQNLmBP
	 8Sxd7yJw9pUrfjeOguLBRqUOPEB2WnuI7bWvlhwhmcIrlN3lVdMhdHmk689y0j6EUu
	 xtoW1bjg//meA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, devicetree@vger.kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260518095907.36158-3-clamor95@gmail.com>
References: <20260518095907.36158-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 10:31:04 +0000
Message-Id: <20260518103104.C1DE5C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] Unsynchronized reallocation of `ddata->ec.model` causes Use-After-=
Free during interrupts.
- [High] Stale and uninitialized data is accessed on short I2C reads.
- [Medium] `asus_dockram_access_ctl()` silently ignores I2C write errors.
- [Medium] Memory leak of `ddata->ec.model` upon driver unbind or probe fai=
lure.
- [Medium] The original IRQ event payload is corrupted before being passed =
to child notifiers.
- [Medium] Subsystem Guideline Violation: Mixing `goto` error handling with=
 `__free()` cleanup.
- [Medium] Missing error check for `kstrndup()` allocation failure in `asus=
_ec_log_info()`.
- [Low] Incorrect length check causes string truncation in `asus_ec_log_inf=
o()`.
--

commit d95a94a77b9b37ec021eabccb7ff81e4dd52730e
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

mfd: Add driver for ASUS Transformer embedded controller
   =20
Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201,
TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF101 dock
and TF600T, P1801-T and TF701T pad. This is a glue driver handling
detection and common operations for EC's functions.

> diff --git a/drivers/mfd/asus-transformer-ec.c b/drivers/mfd/asus-transfo=
rmer-ec.c
> new file mode 100644
> index 0000000000000..18bb3e5f384d9
> --- /dev/null
> +++ b/drivers/mfd/asus-transformer-ec.c

[ ... ]

> +	if (mask || xor) {
> +		put_unaligned_le64((val & ~mask) ^ xor, buf + 1);
> +		ret =3D i2c_smbus_write_i2c_block_data(client,
> +						     ASUSEC_DOCKRAM_CONTROL,
> +						     DOCKRAM_ENTRY_SIZE, buf);
> +	}
> +
> +	return 0;
> +}

Does this accidentally hide hardware write failures? Since ret is ignored,
callers might falsely assume the I2C block write succeeded.

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
> +						    sizeof(ddata->ec_buf),
> +						    ddata->ec_buf);
> +		if (ret < 0)
> +			continue;
> +
> +		if (ddata->ec_buf[ASUSEC_IRQ_STATUS] & ASUSEC_OBF_MASK)
> +			continue;

Can a short read leave stale data in ddata->ec_buf? The function
i2c_smbus_read_i2c_block_data() returns the actual number of bytes read. If=
 it
returns a positive value less than ASUSEC_IRQ_STATUS + 1, the buffer will
retain data from previous iterations.

[ ... ]

> +static int asus_ec_log_info(struct asus_ec_data *ddata, unsigned int reg,
> +			    const char *name, char **out)
> +{
> +	struct device *dev =3D &ddata->client->dev;
> +	u8 buf[DOCKRAM_ENTRY_BUFSIZE];
> +	int ret;
> +
> +	memset(buf, 0, DOCKRAM_ENTRY_BUFSIZE);
> +	ret =3D i2c_smbus_read_i2c_block_data(ddata->ec.dockram, reg,
> +					    DOCKRAM_ENTRY_SIZE, buf);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (buf[0] > DOCKRAM_ENTRY_SIZE) {
> +		dev_err(dev, "bad data len; buffer: %*ph; ret: %d\n",
> +			DOCKRAM_ENTRY_BUFSIZE, buf, ret);
> +		return -EPROTO;
> +	}

Is there a risk of an out-of-bounds read here? The I2C read fills up to 32
bytes (DOCKRAM_ENTRY_SIZE), meaning buf[0] to buf[31] are valid. If buf[0]
equals 32, the kstrndup() below will attempt to copy 32 bytes starting from
buf + 1, reading up to buf[32].

> +
> +	if (!ddata->logging_disabled)
> +		dev_info(dev, "%-14s: %.*s\n", name, buf[0], buf + 1);
> +
> +	if (out)
> +		*out =3D kstrndup(buf + 1, buf[0], GFP_KERNEL);
> +
> +	return 0;
> +}

If kstrndup() fails and returns NULL, asus_ec_detect() will unknowingly ass=
ign
NULL to ddata->ec.model. Should this return -ENOMEM on allocation failure?

[ ... ]

> +static int asus_ec_detect(struct asus_ec_data *ddata)
> +{
> +	char *model __free(kfree) =3D NULL;
> +	int ret;
> +
> +	ret =3D asus_ec_reset(ddata);
> +	if (ret)
> +		goto err_exit;

This isn't a bug, but mixing goto error handling with __free() cleanup in t=
he
same function violates the subsystem guidelines. Functions are expected to =
use
either scope-based cleanup or goto-based cleanup exclusively to prevent
confusing ownership semantics.

[ ... ]

> +	/* Check and inform about EC firmware behavior */
> +	ret =3D asus_ec_susb_on_status(ddata);
> +	if (ret)
> +		goto err_exit;
> +
> +	kfree(ddata->ec.model);
> +
> +	ddata->ec.model =3D no_free_ptr(model);

Could this cause a use-after-free or a memory leak?

Since asus_ec_detect() can be called from the threaded interrupt handler at
runtime, ddata->ec.model might be freed and replaced without synchronization
while child drivers or sysfs attributes are concurrently accessing it.

Additionally, ddata->ec.model is never freed on driver unbind or probe
failure, causing a memory leak.

[ ... ]

> +static irqreturn_t asus_ec_interrupt(int irq, void *dev_id)
> +{
> +	struct asus_ec_data *ddata =3D dev_id;
> +	unsigned long notify_action;
> +	int ret;
> +
> +	ret =3D i2c_smbus_read_i2c_block_data(ddata->client, ASUSEC_READ_BUF,
> +					    sizeof(ddata->ec_buf), ddata->ec_buf);
> +	if (ret <=3D 0 || !(ddata->ec_buf[ASUSEC_IRQ_STATUS] & ASUSEC_OBF_MASK))
> +		return IRQ_NONE;

Similar to asus_ec_clear_buffer(), if ret is a positive value smaller than
the required length, this could process stale data from previous interrupt
events.

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

Does asus_ec_handle_smi() corrupt the event payload before it is passed to
child notifiers?

If asus_ec_handle_smi() triggers a reset, it eventually calls
asus_ec_clear_buffer(), which performs new I2C reads directly into
ddata->ec_buf. This overwrites the original event data, meaning
blocking_notifier_call_chain() will pass a clobbered buffer to child
devices.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518095907.3615=
8-1-clamor95@gmail.com?part=3D2
