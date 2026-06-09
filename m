Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A272231832;
	Tue,  9 Jun 2026 04:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780980966; cv=none; b=gtubiHyKDIEDRYgnhMDx7oZCfWfkpzA6YaDAtk/g6sx+HLvSxkxbH8PHNcK8OlGlEGeLRoGRtUHi5P9NgWsaOr/B2SRBK8Gj6AVaB+P+ygkFugl8/Q71W4FZfFU7wETq2APKlJmvJcOTvfhiGc0s2jEjqt8xmk8inhz7vLaFxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780980966; c=relaxed/simple;
	bh=IC07BV97/pWTzMhgZv9xj6wge0AWj5XMyd9IVOiqKSw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bZgW/EP63HghpslA66hOtAU91/x6lBRb666Mf83p7F7A2MLgMCZTatiBSkm+A+lsg7mhDxjI1r4bcZ/CDBxr0MkDuvnIWkhJhDha8IWwg7UvLogQw4QZ86HWCZdMeYH1DVVRQygnLuw77W+ErHuvKOALwYBLYdHqdUSj7Gcu0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WaairRZt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaairRZt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FE71F00893;
	Tue,  9 Jun 2026 04:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780980964;
	bh=LT7Wg1/XhplBkOl9vbYXYnbKdLFzAaFLgxre6//x3DI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WaairRZtamMahMIgxE4C4KB5bz5Zu/MU2M6GtE2aK05Tjj+tbAwD8ESqWkK6lx0mL
	 uixrR+JfSEzvhRv8r7t5hDcoPgOvNJViUPNtrUE53TDIvFZ8bTiJ8TOipXQXdKQoAu
	 kzI+zaCwB1IyXRlP6GOz5yiINHp0nhDGAEtorggXBqdBEuQqClh1WJL+VisDl5mfSc
	 Flf3Er2TabNPXZcBXChRsWAvDAava+eYYNejHuhpsNUdcBvkI6z7ObddKWgkn89wAR
	 djtX6lXN8sUS63bhyxXrc5xASA3RYKkksmXlfRZGih/43CytvhJkgfsrQBTkfKUqGs
	 8P7KZdy116gTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/11] HID: spi-hid: add transport driver skeleton
 for HID over SPI bus
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingyuan Liang" <jingyliang@chromium.org>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260609-send-upstream-v4-3-b843d5e6ced3@chromium.org>
References: <20260609-send-upstream-v4-3-b843d5e6ced3@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 04:56:03 +0000
Message-Id: <20260609045604.44FE71F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Embedded arrays `read_approval_header` and `read_approval_body` ar=
e used for SPI DMA transfers without cacheline alignment, risking memory co=
rruption.
- [Medium] Unchecked return values of reset operations in `spi_hid_dev_init=
` and `spi_hid_resume`
--

commit ea35a3a23739acaca367a8d250ef25c96d22df36
Author: Angela Czubak <acz@semihalf.com>

HID: spi-hid: add transport driver skeleton for HID over SPI bus

Create spi-hid folder and add Kconfig and Makefile for spi-hid driver.
Add basic device structure, definitions, and probe/remove functions.

> diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/spi=
-hid-core.c
> new file mode 100644
> index 0000000000000..02a7608c4b882
> --- /dev/null
> +++ b/drivers/hid/spi-hid/spi-hid-core.c
> @@ -0,0 +1,213 @@

[ ... ]

> +/* Driver context */
> +struct spi_hid {
> +	struct spi_device	*spi;	/* spi device. */
> +	struct hid_device	*hid;	/* pointer to corresponding HID dev. */
> +
> +	struct spihid_ops	*ops;
> +	struct spi_hid_conf	*conf;
> +
> +	enum hidspi_power_state power_state;
> +
> +	u32 regulator_error_count;
> +	int regulator_last_error;
> +	u32 bus_error_count;
> +	int bus_last_error;
> +	u32 dir_count;	/* device initiated reset count. */
> +};

[Severity: High]
Does embedding the read_approval_header and read_approval_body arrays direc=
tly
in this struct for SPI DMA transfers risk memory corruption?

When these buffers are passed as tx_buf to spi_sync() (e.g. in
spi_hid_input_sync()), they lack the ____cacheline_aligned directive. On
architectures with non-coherent DMA, cache maintenance operations could
encompass adjacent struct members.

Concurrent CPU writes to those adjacent members during the DMA mapping wind=
ow
will be destroyed, leading to memory corruption.

Should these buffers be cacheline aligned, or dynamically allocated?

[ ... ]

> +int spi_hid_core_probe(struct spi_device *spi, struct spihid_ops *ops,
> +		       struct spi_hid_conf *conf)
> +{

[ ... ]

> +	/*
> +	 * At the end of probe we initialize the device:
> +	 *   0) assert reset, bias the interrupt line
> +	 *   1) sleep minimal reset delay
> +	 *   2) request IRQ
> +	 *   3) power up the device
> +	 *   4) deassert reset (high)
> +	 * After this we expect an IRQ with a reset response.
> +	 */
> +
> +	shid->ops->assert_reset(shid->ops);
> +
> +	shid->ops->sleep_minimal_reset_delay(shid->ops);

[ ... ]

> +	error =3D shid->ops->power_up(shid->ops);
> +	if (error) {
> +		dev_err(dev, "%s: could not power up\n", __func__);
> +		return error;
> +	}
> +
> +	shid->ops->deassert_reset(shid->ops);

[Severity: Medium]
Can hardware reset failures be masked here?

The assert_reset and deassert_reset callbacks return integer error codes.
However, their return values are ignored in spi_hid_core_probe() (as well as
resume paths).

If deassert_reset() fails, the device may remain in reset, causing the driv=
er
to hang waiting for a reset response IRQ that will never arrive.

Should these return values be checked and handled?

> +
> +	dev_dbg(dev, "%s: d3 -> %s\n", __func__,
> +		spi_hid_power_mode_string(shid->power_state));
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-send-upstr=
eam-v4-0-b843d5e6ced3@chromium.org?part=3D3
