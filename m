Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2317F398902;
	Thu, 28 May 2026 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779958886; cv=none; b=Q8m04OLA4Yr4FKQGB+87Rhfmk82saiTKaoqi0Ywqw5ikwF/dyrAl4tDQwleZEJrOmFClCd9NtNrP02aEKgZIhBSJkO9E+9sLIJsqQaLvcLDih3tKpe72l3M1e0iiUuCYr+dAhugAe2HEglMYaE+57vxFgzTjRr8X81oZd47jCvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779958886; c=relaxed/simple;
	bh=a41kIVkQiyoVJiL/0QyvmVF9uxiC/A56cbxTjNbxQkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V2HxzQSq1XDxBzr5KB9hpX8nFFwVIEuIdWQu3z1OQFkFGOPrmVYxeKOLSooG+eLhAFGZxP9OlQJ535a61+dzuuc3TTI5oFIgq9SErL2j1VyQQUCF/9x2Tk8+bI+YjjeALY4z4j74ZnwPO7N46NKkuADhbPv9xWu7uy2KQkKp4x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddKeH5Fr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddKeH5Fr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554521F00A3A;
	Thu, 28 May 2026 09:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779958883;
	bh=0lp7x0W2YMorFxhhDUmrZPqE55AzTCsOiUmXZfwT2Ok=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ddKeH5FrTvO6Nu6t+JA56D/nZ1RVGCuHpv4ShN/4oYJnaE+OTfETokaTxN9RzIkQn
	 mM8t4m0yLkXuW7EvtwqVEodJk6X759ehbGQZX1H3VaSs8CmNFnFJPvhtjm0ZnQHMj4
	 oO5SNifDlsKPM7Qu9FgJZJ9Mq8HxPCo6/0G18VX+s9OstXOgJa0LrL3S6GfaN3iDwC
	 z8lEwU5sWPZAOubfor/OiqHROM6Q9TKUW21bYD+Z95zn9F24VKSOUsJA89FpEDvodI
	 z/J3zAfJoyDg5J5Iz1b37J2zEjBjvc9/URX85+QWRW4Dxz4dsIvNIvJK1Ge1BaOYdH
	 lzt31JxARSgAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] Input: Add support for Wacom W9000-series
 penabled touchscreens
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hendrik Noack" <hendrik-noack@gmx.de>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260528074818.12151-3-hendrik-noack@gmx.de>
References: <20260528074818.12151-3-hendrik-noack@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 09:01:22 +0000
Message-Id: <20260528090123.554521F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The driver uses stack-allocated buffers for I2C transfers, which v=
iolates the DMA API and can cause panics or memory corruption.
--

commit 5c60cba7d031762dd1ed0e3769ce031bf93c9b48
Author: Hendrik Noack <hendrik-noack@gmx.de>

Input: Add support for Wacom W9000-series penabled touchscreens

This commit adds a new input driver for the Wacom W9000-series penabled
touchscreens, supporting passive Wacom pens over an I2C interface.

> diff --git a/drivers/input/touchscreen/wacom_w9000.c b/drivers/input/touc=
hscreen/wacom_w9000.c
> new file mode 100644
> index 0000000000000..7795508f93b29
> --- /dev/null
> +++ b/drivers/input/touchscreen/wacom_w9000.c

[ ... ]

> +static int wacom_w9000_read(struct i2c_client *client, u8 command, u8 le=
n, u8 *data)
> +{
> +	int error, res;
> +	struct i2c_msg msg[] =3D {
> +		{
> +			.addr =3D client->addr,
> +			.flags =3D 0,
> +			.buf =3D &command,
> +			.len =3D sizeof(command),

[Severity: High]
Is it safe to pass a stack-allocated variable (&command) as an I2C transfer
buffer?=20

If the underlying I2C adapter uses DMA, transferring from a stack address
can lead to kernel panics or silent memory corruption. This happens because
stack memory is often virtually mapped (when CONFIG_VMAP_STACK is enabled)
and is not guaranteed to be safely cacheline aligned.

Would it be better to allocate these buffers dynamically or embed a=20
DMA-safe buffer inside the wacom_w9000_data structure?

> +		}, {
> +			.addr =3D client->addr,
> +			.flags =3D I2C_M_RD,
> +			.buf =3D data,
> +			.len =3D len,
> +		}
> +	};
> +
> +	res =3D i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
> +	if (res !=3D ARRAY_SIZE(msg)) {
> +		error =3D res < 0 ? res : -EIO;
> +		dev_err(&client->dev, "%s: i2c transfer failed: %d (%d)\n", __func__, =
error, res);
> +		return error;
> +	}
> +
> +	return 0;
> +}
> +
> +static int wacom_w9000_query(struct wacom_w9000_data *wacom_data)
> +{
> +	struct i2c_client *client =3D wacom_data->client;
> +	struct device *dev =3D &wacom_data->client->dev;
> +	int error;
> +	int retry =3D 0;
> +	u8 data[CMD_QUERY_NUM_MAX];

[Severity: High]
Similarly, does passing this stack-allocated array down to wacom_w9000_read=
()
violate the DMA API requirements for the same reasons?

> +
> +	for (; retry < CMD_QUERY_RETRIES; retry++) {
> +		error =3D wacom_w9000_read(client, CMD_QUERY, wacom_data->variant->cmd=
_query_num,
> +					 data);

[ ... ]

> +static void wacom_w9000_coord(struct wacom_w9000_data *wacom_data)
> +{
> +	struct i2c_client *client =3D wacom_data->client;
> +	struct device *dev =3D &wacom_data->client->dev;
> +	int error;
> +	u8 data[MSG_COORD_NUM_MAX];
> +	bool touch, rubber, side_button;
> +	u16 x, y, pressure;
> +	u8 distance =3D 0;
> +
> +	error =3D i2c_master_recv(client, data, wacom_data->variant->msg_coord_=
num);

[Severity: High]
Can this call to i2c_master_recv() corrupt memory by DMAing into the
stack-allocated data array? Using a dedicated buffer allocated with kzalloc
or similar might prevent this issue on the coordinate data path.

> +	if (error !=3D wacom_data->variant->msg_coord_num) {
> +		if (error >=3D 0)
> +			error =3D -EIO;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528074818.1215=
1-1-hendrik-noack@gmx.de?part=3D2
