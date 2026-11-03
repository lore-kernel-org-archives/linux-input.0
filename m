Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712152;
	b=hXmoqLZKn+0JOaJoUqivyMVted01X5kFtpT32M133Ovb6KIqJjoI7Mou3hQdYO9CrBtw
	 rbkS+e1K3fg1LWhXPyw4ir0N/2ycCSokX2HuEf3wbm/ul22GRMroPsYc/m1CW62uOf6fM
	 xZodwOEat+2Tf+3d2pgNzJVuY77j3JZ34JZFV0nPORhpooiRuPKDTVmQ3Sph1+K/ZVFLm
	 hz9jJYSVAWTURFY6clida/Xxm+7BSzRYTaW1/b4GUdUw4fK5XZiMoN2wI4MnahS4K+MWo
	 q+KhvkZbbapFfL0ILG3P4U5mrBu4zMG0GDvx1liWRvuxx5jY9rh4MtjFQPBbAx/ZcIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712152;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gMf+AtUldoyW3tHPRM7JpABigXmTMzzHnH1X/Q4LW78=;
	b=WsG8nDsEkv2PJbT7OuoyxlXR/Pe/Ep78ZdM7D6Hx0oclhGLrTeWbQfllBn/d3wND5AKv
	 Sb5COLdBEhJEMDYBHo/4ZyEiQrU2KMkOYH0E0kJfBsrRp2FimXNtV83yzMnXyptJ30rpv
	 FdnGvflKn41cMvcj49tox8iR6AD2KOrUHfkKMQUyhau7ZcGzgQvvMBvSpK+NE8quOU4rO
	 ASyLGLoU/N6do+cHYe2Fujj4p470wtRLce/ApAmNNq2U7LBjPMFYSIC+qzqEGgt6zs8Vu
	 eOEGccMz82qwBli7TBAB2STJSLjBb6XBepdg9IGBKUpGQ+xMTD9wez4rTLxD0MCFPpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESlgbpws;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75ECD606A328
	for <linux-input@vger.kernel.org>; Tue,  3 Nov 2026 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESlgbpws
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2869D1F000C1;
	Tue,  3 Nov 2026 13:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712152;
	bh=gMf+AtUldoyW3tHPRM7JpABigXmTMzzHnH1X/Q4LW78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ESlgbpws7tdarv5n+JremzAGqW+1b0qeEndD/ffd8fh6wk6UudOb2E3NIleMkHoHj
	 4mAbvTOjiBrssUgeO2DTFurwNlvX6P73dJul607MUNFypmTNRyitSUf/iVz1kzWO/S
	 d0JDEiWGRCsfKaeB/p4hh7Pr2GBEk5St07ucMFMiqmGbtbkiFdEe2SqyEe18UMlsBw
	 tq+4DJrapt1vlo4jLQoqVb0wLyW0grDrM1WEaOHwtCiN0s+OZy4VJ0rB24QMLqyLFk
	 WOzs+AgJDNXxKI03AlncizQr7Oy9Wxc1+znyzVQD0tv36+Xx/typhNucb/AcCpKEME
	 JFYFIXh7DiIpQ==
Message-ID: <sashiko-outbox-195329@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Input: cyapa - clamp SMBus block reads to the
 caller's buffer
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengyu Liu" <lui2012qwq@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261103131127.1585884-3-lui2012qwq@gmail.com>
References: <20261103131127.1585884-1-lui2012qwq@gmail.com>
 <20261103131127.1585884-3-lui2012qwq@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 13:22:31 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Input: cyapa - cyapa_smbus_read_block() returns full len on short =
block reads
--

commit 17f2cef41b86752525f835330272cc728242a63c
Author: Chengyu Liu <lui2012qwq@gmail.com>

Input: cyapa - clamp SMBus block reads to the caller's buffer

This commit bounces SMBus block reads in cyapa_smbus_read_block() through
a temporary I2C_SMBUS_BLOCK_MAX buffer and clamps the copy size to the
caller's requested length to prevent buffer overruns.

> diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa=
_gen3.c
> index fc3fb954523b7..cd80ae51f4e52 100644
> --- a/drivers/input/mouse/cyapa_gen3.c
> +++ b/drivers/input/mouse/cyapa_gen3.c
> @@ -254,20 +254,30 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyapa,=
 u8 cmd, size_t len,
>  		return -EINVAL;
> =20
>  	if (SMBUS_GROUP_BLOCK_CMD_MASK & cmd) {
> +		u8 tmp[I2C_SMBUS_BLOCK_MAX];
> +
>  		/* read specific block registers command. */
>  		smbus_cmd =3D SMBUS_ENCODE_RW(cmd, SMBUS_READ);
> -		ret =3D i2c_smbus_read_block_data(client, smbus_cmd, values);
> +		ret =3D i2c_smbus_read_block_data(client, smbus_cmd, tmp);
> +		if (ret > 0)
> +			/* never trust the device-provided count */
> +			memcpy(values, tmp, min_t(size_t, ret, len));
>  		goto out;
>  	}
> =20
>  	ret =3D 0;
>  	for (index =3D 0; index * I2C_SMBUS_BLOCK_MAX < len; index++) {
> +		u8 tmp[I2C_SMBUS_BLOCK_MAX];
> +		size_t chunk =3D min_t(size_t, len - index * I2C_SMBUS_BLOCK_MAX,
> +				     I2C_SMBUS_BLOCK_MAX);
> +
>  		smbus_cmd =3D SMBUS_ENCODE_IDX(cmd, index);
>  		smbus_cmd =3D SMBUS_ENCODE_RW(smbus_cmd, SMBUS_READ);
>  		buf =3D values + I2C_SMBUS_BLOCK_MAX * index;
> -		ret =3D i2c_smbus_read_block_data(client, smbus_cmd, buf);
> +		ret =3D i2c_smbus_read_block_data(client, smbus_cmd, tmp);
>  		if (ret < 0)
>  			goto out;
> +		memcpy(buf, tmp, min_t(size_t, ret, chunk));
>  	}

[Severity: High]
What happens in cyapa_smbus_read_block() if the device returns a short block
count where 0 < ret < len (or 0 <=3D ret < chunk in the indexed loop)?

Both branches copy only ret bytes into values or buf, leaving the remainder
of the caller's buffer untouched, and then jump to out:

drivers/input/mouse/cyapa_gen3.c:cyapa_smbus_read_block() {
	...
out:
	return ret > 0 ? len : ret;
}

Because cyapa_smbus_read_block() still returns the full requested len whene=
ver
the last i2c_smbus_read_block_data() call returned a positive count, callers
that pass uninitialized stack buffers and check for a full read cannot dete=
ct
the short read:

drivers/input/mouse/cyapa_gen3.c:cyapa_gen3_get_query_data() {
	u8 query_data[QUERY_DATA_SIZE];
	int ret;

	/* query dataabda has 27 bytes */
	ret =3D cyapa_read_block(cyapa, CYAPA_CMD_GROUP_QUERY, query_data);
	if (ret !=3D QUERY_DATA_SIZE)
		return (ret < 0) ? ret : -EIO;
	...
}

drivers/input/mouse/cyapa_gen3.c:cyapa_gen3_irq_handler() {
	struct cyapa_reg_data data;
	int ret;

	ret =3D cyapa_read_block(cyapa, CYAPA_CMD_GROUP_DATA, (u8 *)&data);
	if (ret !=3D sizeof(data)) {
		dev_err(dev, "failed to read report data, (%d)\n", ret);
		return -EINVAL;
	}
	...
}

Wouldn't a device returning fewer bytes than requested cause
cyapa_gen3_get_query_data(), cyapa_gen3_irq_handler(),
cyapa_gen3_try_poll_handler(), and cyapa_get_state() to consume uninitializ=
ed
stack memory in query_data, data, and status (and expose uninitialized bytes
from query_data via the product_id and firmware_version sysfs attributes)?
Should cyapa_smbus_read_block() return an error such as -EIO when ret < len
in the group-read branch or ret < chunk in the indexed loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103131127.1585=
884-1-lui2012qwq@gmail.com?part=3D2
