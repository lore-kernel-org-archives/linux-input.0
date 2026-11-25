Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795574983;
	b=LsrKxR/c/Lwqi9fSTvw5LvQAnyFo6DOgEK1zgt1gmvi/b/mvfU33jxoldDzAUqnb0ZY+
	 jTdwV9uV8KKYVTOHw5BKSj523DB39Sa9WAEd88KtsVl20F2OROyxK8aq2/tX1g9AAthUX
	 n8cIA1YfOkqGk26ZeT+Q4J0H7UJtD/Neu/a0yoRMXFGRPhFstbQ6sXOVjxUlWTe4ElVfF
	 dJGHPTGFvQaBQittxum1QMioMdCiU2UZdoio6wzwVhdk6CChRJpgqaHoa4hQVt7BiQ/cx
	 +eJkmZtW5B7VH8QNV9LHyfo2DRiYgmLoRhFMWK9M9CYzsx19XRL8rJLw+CtP75C7/mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795574983;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c9glRbfTcVHBbunDTcByHsHQ4ZaWeP9mFG4ZNiO80p8=;
	b=FYO+kkxj1h2tgtgHSgjP3d1N289YovHPV06sEID50uqlpWcCqFTgJgN+yClcgDXt+lLg
	 x2ptlS/b/0rjYY53C6jpblA/SOOHJ31XLF33OvAvSwg5bHFs6sVr8e5vp2DWKyUPzAGW0
	 IrAqeepGxRL216RSvQt8zFs2gFtobgGSNivtUnZDIgrcKv/Qcps41vDsHDY0vkptTiMNm
	 KDgHTWOOjL+GEE8jPVfzc3B8TjkDsnBwaTB01R91YQ1wHf86PN2jgwcscZeHfBJuoMn9I
	 K4iglT7mA9NUtbGXEMs5HQbtWXea2SPzjX5h4Y5LgMKgmyEh9sg9oT6gXYTRUmy628Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVaJtRIy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C3E606A321;
	Wed, 25 Nov 2026 02:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVaJtRIy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020C31F000C0;
	Wed, 25 Nov 2026 02:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795574982;
	bh=c9glRbfTcVHBbunDTcByHsHQ4ZaWeP9mFG4ZNiO80p8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fVaJtRIy5Jh60gB2f8edRDN8SFcdWN/NrNVNKZ8CBfkA0X0hpEbo1lVRJgo6bJN8h
	 LOnEoOphsIwc5zmZHVDQHd2FxsNTI2kjaKyRgrxXZNDRzXFn5HMya0WllE+wNWYUaM
	 VSY5jPvrl5tnlsN33bPSQO6zZ1BJF7M7y1DgfjEq8WeCQ8BrtgRYPmY9AjaxbGIpmm
	 eek9UtQfjav51Ufff4/upVjAV53DvZ/hEXgzWtcgiegkGa5BzqeF/20lF3tSSxyqzs
	 xrfrS4EDwUsdl4CaBYSJF9vKiFMLiJsGgD3fI9VV5fETITZh30mTJL9G4EgpAeujze
	 ubRrFMCx35h5w==
Message-ID: <sashiko-outbox-232421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] Input: add Jadard JD9365TX in-cell touchscreen
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_05AAFCF8CA47B5D5ED770621DB13E46F1406@qq.com>
References: <20261125024226.1293-1-3066883572@qq.com>
 <tencent_05AAFCF8CA47B5D5ED770621DB13E46F1406@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:49:41 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] Input: jadard_jd9365tx: wrong supply array type in
  jadard_tp_probe()
- [Low] Input: jadard_jd9365tx: u32 overflow in jd_resolve_coord_addr()
  bounds check
--

commit 57a37b18fbb37602183e66793eebea170b919dc2
Author: Hefei <3066883572@qq.com>

Input: add Jadard JD9365TX in-cell touchscreen driver

This commit adds a polling I2C touchscreen driver for the Jadard JD9365TX
in-cell touch controller.

> diff --git a/drivers/input/touchscreen/jadard_jd9365tx.c b/drivers/input/=
touchscreen/jadard_jd9365tx.c
> new file mode 100644
> index 0000000000000..3312119d7b696
> --- /dev/null
> +++ b/drivers/input/touchscreen/jadard_jd9365tx.c
> @@ -0,0 +1,356 @@

[ ... ]

> +struct jadard_tp {
> +	struct i2c_client *client;
> +	struct input_dev *input;
> +	struct touchscreen_properties prop;
> +	struct gpio_desc *reset;
> +	struct regulator *vdd;
> +	struct regulator *iovcc;
> +	u32 coord_addr;
> +	u16 touch_data_size;
> +	u16 max_points;
> +	unsigned int poll_interval_ms;
> +};

[ ... ]

> +static int jd_resolve_coord_addr(struct jadard_tp *ts)
> +{
> +	u32 esram_num_addr =3D JD_ERAM_BASE + 4 + JD_MAX_DSRAM_NUM * 8;
> +	u32 esram_sec_addr =3D esram_num_addr + 4;
> +	u8 buf[JD_ESRAM_SECTION_NUM * 8];
> +	u32 addr, len;
> +	int ret;
> +
> +	ret =3D jd_read_reg(ts->client, esram_sec_addr, buf, sizeof(buf));
> +	if (ret)
> +		return ret;
> +
> +	addr =3D get_unaligned_le32(&buf[JD_ESRAM_COORD_IDX * 8]);
> +	len =3D get_unaligned_le32(&buf[JD_ESRAM_COORD_IDX * 8 + 4]);
> +
> +	if (addr < JD_ERAM_BASE ||
> +	    addr + len > JD_ERAM_BASE + 0x1000 ||
> +	    len < JD_REPORT_MIN_SIZE || len > JD_TOUCH_DATA_SIZE)
> +		return -EINVAL;

[Severity: Low]
Can the 32-bit addition addr + len wrap around here?  If the controller
returns a corrupted section descriptor with addr near U32_MAX and len in
[JD_REPORT_MIN_SIZE, JD_TOUCH_DATA_SIZE], addr + len wraps to a small
value below JD_ERAM_BASE + 0x1000 and jd_resolve_coord_addr() accepts an
invalid coordinate address instead of falling back to
JD_DEFAULT_COORD_ADDR.  Checking len first and testing
addr > JD_ERAM_BASE + 0x1000 - len avoids the overflow.

[ ... ]

> +static int jadard_tp_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct jadard_tp *ts;
> +	struct input_dev *input;
> +	struct regulator_bulk_data supplies[2];
> +	u32 val;
> +	int error;
> +
> +	ts =3D devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
> +	if (!ts)
> +		return -ENOMEM;
> +
> +	ts->client =3D client;
> +	ts->max_points =3D JD_MAX_POINTS;
> +	ts->poll_interval_ms =3D JD_DEFAULT_POLL_MS;
> +	ts->touch_data_size =3D JD_TOUCH_DATA_SIZE;
> +	ts->coord_addr =3D JD_DEFAULT_COORD_ADDR;
> +
> +	supplies[0].supply =3D "vdd";
> +	supplies[1].supply =3D "iovcc";
> +	error =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(supplies),
> +					       supplies);

[Severity: High]
Does passing struct regulator_bulk_data * to
devm_regulator_bulk_get_enable() fail to build with
-Werror=3Dincompatible-pointer-types?  devm_regulator_bulk_get_enable()
takes a const char * const * array of supply names, so if built without
that error it also reads uninitialized stack memory
(supplies[0].consumer) as the second supply name pointer.  Using static
const char * const supplies[] =3D { "vdd", "iovcc" } fixes this, and the
unused vdd and iovcc fields in struct jadard_tp can be dropped as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_7B5CDF8F847=
44FFBBFCFA89FE3651F675608@qq.com?part=3D5
