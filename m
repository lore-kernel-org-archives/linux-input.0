Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19C33A9610;
	Sun, 11 Oct 2026 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791723753; cv=none; b=R6eG1ZKrjij5m3L+L4Dc/uIcE4ZfRFTyTmyLmjieqMN686r8n+mNWwh6ZNud81nhIqte07zS4KTqNhJa8stCbugR7ltgv4wZeiWm/wlFwek2YjchUuEgHIMumU3y4cF++e5gfNrMLDJWTiSjkNUwBSHz1AQmTa2Po299+iN8LQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791723753; c=relaxed/simple;
	bh=2cfKRB66rCmy50MfzlYJ08pR5joT9DEb8F3OnflX+b0=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ac2Cx+vvDXfAA/dP3OS9DLelnlGAH/+SY02FL9zARKNaAQdPNI4sc3Gm+Y4F+6JAwR1kjQpaeluxzV6uJKy+9Z+yz38VXtMNrnhn+TlD2J1A2B/4mFgjdCBes0Khzz6Fk2oqVNLzYXniNY0tj2Xe7tOBHJpUJcMtkS5pHsNlVfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7awnH6/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7awnH6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BA31F0089C;
	Sun, 11 Oct 2026 13:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791723751;
	bh=6dTdksdLt8JD8fVLGoXwnCZZirEASfN6bEExMp73F8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f7awnH6/qAbRZMVcn7vWKE4sw4Nv7NZxXWrASk0iM8aYVT15fDUxZ5bstiMdmjE55
	 RHBITWmM3PG3qa+VX2oTRpv6gDFTR3HvrXNxxE8a2MA8ekoXkrsIigPjQNfMKP9eGw
	 Vx2f/HopCSUz04KeMBZ5qG6e+Uhd/oaONLI79TX/Ji8+fyKsvZXIvQ/jPJr2xVzbLy
	 sD64G3VGnEK/Pe+BlvVAt1eyCBkqb+IY2GGtb8Pe9qYPykKPLuOzw1LqksIw1eG6Fl
	 +Z/1FBmMMavH/Vz7ivVZdOzK6Xp7WkxTKqbyjL9usPzG5sKtFHa1DRyWHj314r2exw
	 y8Y3uDlGgw3JQ==
Message-ID: <sashiko-outbox-167242@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] Input: s6sy761 - add SPI support for S6SY791
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukas Timmermann" <foss@timmermann.space>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20261011-lat3st-google-raven-touch-upstream-v1-4-2a9f55159b9e@timmermann.space>
References: <20261011-lat3st-google-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space>
 <20261011-lat3st-google-raven-touch-upstream-v1-4-2a9f55159b9e@timmermann.space>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 13:02:30 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] input: s6sy761: DMA API violation in i2c_transfer with stack buffe=
rs
--

commit 4918bc0af27755ebb84f3e96213a8de871d7f898
Author: Lukas Timmermann <foss@timmermann.space>

Input: s6sy761 - add SPI support for S6SY791

This commit adds SPI support for the S6SY791 touchscreen controller.
It implements the SPI framing and read delays based on the downstream drive=
r.
The new functionality operates over full-duplex SPI with padded transfers.

> diff --git a/drivers/input/touchscreen/s6sy761_spi.c b/drivers/input/touc=
hscreen/s6sy761_spi.c
> new file mode 100644
> index 0000000000000..c6627e61c2856
> --- /dev/null
> +++ b/drivers/input/touchscreen/s6sy761_spi.c

[ ... ]

> +static int s6sy761_spi_read(struct device *dev, u8 *xfer_buf,
> +			    u8 cmd, size_t length, void *values)
> +{
> +	struct spi_device *spi =3D to_spi_device(dev);
> +	struct spi_transfer reply =3D { };

[ ... ]

> +	ret =3D spi_sync_transfer(spi, &reply, 1);
> +	if (ret)
> +		return ret;
> +
> +	if (xfer_buf[0] !=3D S6SY761_SPI_SYNC_CODE ||
> +	    xfer_buf[5] !=3D cmd ||
> +	    xfer_buf[resp_len - 1] !=3D
> +			s6sy761_spi_checksum(xfer_buf, resp_len - 1))
> +		return -EIO;
> +
> +	memcpy(values, xfer_buf + S6SY761_SPI_READ_HEADER_SIZE, length);
> +
> +	return 0;
> +}

[Severity: High]
While the SPI implementation safely copies the response into the values buf=
fer
using memcpy, does the I2C implementation violate DMA safety requirements
by passing this buffer directly into i2c_transfer?

Looking at drivers/input/touchscreen/s6sy761_core.c:s6sy761_power_on(),
it allocates a small buffer on the stack and passes it down to the bus read
routine:

    u8 buffer[S6SY761_EVENT_SIZE];
    ...
    ret =3D s6sy761_read(sdata, S6SY761_READ_ONE_EVENT, S6SY761_EVENT_SIZE,=
 buffer);

This calls s6sy761_i2c_read() in drivers/input/touchscreen/s6sy761_i2c.c,
which assigns both the caller's stack pointer (values) and its own local
stack variable (&cmd) directly to struct i2c_msg buffers:

	struct i2c_msg msgs[2] =3D {
		{
			.addr	=3D client->addr,
			.len	=3D 1,
			.buf	=3D &cmd,
		},
		{
			.addr	=3D client->addr,
			.flags	=3D I2C_M_RD,
			.len	=3D length,
			.buf	=3D values,
		},
	};
	int ret;

	ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));

It then calls i2c_transfer() which may use DMA. Stack memory is not DMA-safe
(especially with CONFIG_VMAP_STACK), leading to potential memory corruption=
 or
kernel panics when DMA operates on stack addresses. Is it possible to use t=
he
dynamically allocated xfer_buf for I2C transfers instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-lat3st-goo=
gle-raven-touch-upstream-v1-0-2a9f55159b9e@timmermann.space?part=3D4
