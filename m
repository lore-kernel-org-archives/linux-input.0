Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1787538CFFE;
	Thu, 23 Jul 2026 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806800; cv=none; b=VCiFTiqGq2tZ+gfcoSkwpxeQRu1nU5+zNuG/Vz+EHDKr6eZ78uPtUyOuHVHr1qysncARxmAl2kHdiZ5N2b6oRL+RAIbVKkPkBTTxNyfFWcWUafvS6MxeofWUz8qyZnPWz9zlmjtJoSurZFHTWjLmop0NZZQk0x1R2IyrnEkxQhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806800; c=relaxed/simple;
	bh=q//bIT5O9qcvUURgAoGkVE3duq9NSMusftTU+47dJ88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lUucmu70EnGIgibiUclQ5IRcEE8JQ7blCbAo9nkCK9b1j5fBOiYPLfCOy9HQepkZw0AOtikF1YbIq6EQkrGNhiFiTw+hSiNUmspMVq/ZxqWqlqSGrO/fbytGo8GsdY3PiHMvMiev/yoJd9lErnpKWfdPwdhj8xjlpKgoDLNoQfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbM1blvx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbM1blvx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533CA1F000E9;
	Thu, 23 Jul 2026 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784806798;
	bh=rCf3R3LqnCT1FOrfSllRqtm9M0TSug40KSgD1aFXp+A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YbM1blvxauMrNO47A0tIkwzUdZmL/Ooq+1sVEmkaigim0mdc0imcz+Kr80D7bipMY
	 eo9zfiZUTo20VA7Moi7y/0y7/J5j5G4v5PVohQHErCTnKd42ksuFUY1ah9McDyIoNz
	 9Tu1erBWbbolaes2tWleYlhu7BZ12Pxxu6xuW5lq41PHdj7WueRngcLEn7iUQwQ7LO
	 G4hWwmVkQJMk9yENVHVBPz8BQ33bgoGk90LXYg4BNA8C0QEK8jzm+GMt9PzClHEGZ5
	 S3qWb15zj5BC5uCxRYvEH4FtmBWEEUGZF8thpJVzDWhpYH1VhRCUvPdf8sJzuSskGh
	 WzuNI8dk5uP1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] Input: edt-ft5x06 - allow reading the touch frame
 one register at a time
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexandre Hamamdjian" <azkali.limited@gmail.com>
Cc: conor+dt@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260723-b4-ft5426-v1-3-d4b4e32be042@gmail.com>
References: <20260723-b4-ft5426-v1-0-d4b4e32be042@gmail.com>
 <20260723-b4-ft5426-v1-3-d4b4e32be042@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 11:39:57 +0000
Message-Id: <20260723113958.533CA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] The no-regmap-bulk-read fallback causes an out-of-bounds memory re=
ad and functional breakage on EDT_M06 devices.
- [Medium] Immediate redundant retries on permanent bus errors in edt_ft5x0=
6_bulk_read.
- [Medium] Incomplete implementation of no-regmap-bulk-read leaves other bu=
lk reads unpatched.
- [Low] Subsystem guide violation: variable `ret` used for error codes inst=
ead of `error` or `err`.
--

--- Patch [3]: [PATCH 3/4] Input: edt-ft5x06 - allow reading the touch fram=
e one register at a time ---
commit 5f06c007cc93b45a3ff2f9ecba4f1f085c956d6f
Author: Teguh Sobirin <teguh@sobir.in>

Input: edt-ft5x06 - allow reading the touch frame one register at a time

This commit introduces a "no-regmap-bulk-read" property to handle I2C
controllers that cannot sustain multi-byte transfers. It implements a fallb=
ack
that reads the touch frame one register at a time.

> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touch=
screen/edt-ft5x06.c
> index d6c3d033b83df..ac61ac44fd649 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
[ ... ]
> @@ -295,6 +296,31 @@ static const struct regmap_config edt_M06_i2c_regmap=
_config =3D {
>  	.write =3D edt_M06_i2c_write,
>  };
> =20
> +static int edt_ft5x06_bulk_read(struct regmap *map, unsigned int start,
> +				void *val, size_t len)
> +{
> +	u8 *dst =3D val;
> +	size_t off;
> +
> +	for (off =3D 0; off < len; off++) {
> +		unsigned int v;
> +		int ret, tries;

[Severity: Low]
This isn't a bug, but does using 'ret' here violate the input subsystem
guidelines?=20

The maintainer prefers using 'error' or 'err' for variables that only hold
negative error codes or 0 for success.

> +
> +		for (tries =3D 0; tries < 3; tries++) {
> +			ret =3D regmap_read(map, start + off, &v);

[Severity: High]
Does this 1-byte read cause an out-of-bounds access and functional breakage
on EDT_M06 devices?

If the board uses an M06 device with the no-regmap-bulk-read property, this
call will split the frame read into 1-byte chunks. However, the custom
edt_M06_i2c_read() function expects a larger buffer to validate the header:

    u8 *buf =3D (u8 *)val_buf;
    if (buf[0] !=3D 0xaa || buf[1] !=3D 0xaa ||
        buf[2] !=3D val_size) {

Since regmap only provides a 1-byte buffer for a 1-byte read, this will read
out of bounds and deterministically fail the header validation.=20

Additionally, subsequent bytes will hit the default case, sending invalid
factory commands instead of reading touch data.

> +			if (!ret)
> +				break;
> +			if (ret =3D=3D -ETIMEDOUT || ret =3D=3D -EAGAIN)
> +				usleep_range(2000, 4000);

[Severity: Medium]
Will this loop immediately issue redundant retries if the error is permanen=
t?

If regmap_read() returns a permanent error like -EIO (e.g., due to a NACK),=
 it
correctly skips the usleep_range() here. However, since there is no 'else b=
reak'
for unhandled errors, it will immediately loop and issue the failed transac=
tion
again up to 3 times back-to-back.

> +		}
> +		if (ret)
> +			return ret;
> +		dst[off] =3D v;
> +	}
> +
> +	return 0;
> +}
[ ... ]
> @@ -1212,6 +1242,9 @@ static int edt_ft5x06_ts_probe(struct i2c_client *c=
lient)
>  		return error;
>  	}
> =20
> +	tsdata->no_regmap_bulk_read =3D
> +		device_property_read_bool(&client->dev, "no-regmap-bulk-read");
> +

[Severity: Medium]
Is the no-regmap-bulk-read workaround incomplete?

While the ISR now uses the fallback, other parts of the driver still use
unconditional bulk reads. For example, in edt_ft5x06_ts_identify() called
during probe:

    error =3D regmap_bulk_read(tsdata->regmap, 0xBB, rdbuf, EDT_NAME_LEN - =
1);

If the bus truly cannot sustain multi-byte transfers, won't the probe and
debugfs features still fail despite this property being set?

>  	/*
>  	 * Check which sleep modes we can support. Power-off requires the
>  	 * reset-pin to ensure correct power-down/power-up behaviour. Start with

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723-b4-ft5426-=
v1-0-d4b4e32be042@gmail.com?part=3D3
