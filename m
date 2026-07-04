Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB73AFCFD
	for <linux-input@vger.kernel.org>; Sat,  4 Jul 2026 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783168123; cv=none; b=H06uBlwcik0UG6aO/zhNUpscYS6eeLH1nSgUbe01yNmOJXHh+B1Ruad/6jIzszYYLh2fnBKLxdWP7is1PTnGTFuvamJ4HDn2rtDzTrrLrtWtTreROMmJ5hWTFb/fGuUH8HmbyNSWRyjk7ymzS7D2WdAlZI0H+ny7iuusLZaJ4m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783168123; c=relaxed/simple;
	bh=wAyQlWCc5mnNbITewje4Mr9WgXCU2oYVmVpj46sx4JU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UgKVs+Fn5QFjEeDfZfPySbv2IoKTbwCFKPyJcLQ6LHh2xB38gYztb/N6/yQBQ1hr7fYThgY8CVT+p2uLzQFvotchc0cgw0bW2unxGxVGDmUXIKaiwYVGQUwxrfwIfL0COvIeoOempz3oucbO2sqwQ0Zgkyr0lFs8IkDGn+YIVn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekUzuIHD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekUzuIHD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEFE1F000E9;
	Sat,  4 Jul 2026 12:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783168113;
	bh=7BaudhEyNyj2Ntjn06Jl/DfjzovXO/ynC2ZS1UTpz1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ekUzuIHD0XK7BoViTm6vmwxtVAjojI1++okC3ZCnRTZzrfmYVtGOwETwAqB7EDBBf
	 +0L35NVJj8/dQ/Dj1HTZ+8TlnYjSXn8eAv84XllDBjXzAAW9HcsOZcd914rfFP05qO
	 mqcyYMf68WNUX3CwU0/0Uhcy8AyOTZW+8dedCyLlYxg7paaD1n6uhA2tJpGvnoR6Kn
	 H0+SxQuBG/dMj7sfflw96B+05H7V7jtlzR8yicrOQr0BXR1B8hcR/35U7wa12UmGm+
	 hZYrpVnKR0UEMkSB9JJsbt1jnTfGmk1Q901GScnfM+eRVYEuRFGSN9R8wfDxjir0iw
	 9ErmfXxCL/duQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Input: elants_i2c - prevent divide-by-zero on invalid
 EKTH data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Laxman Acharya Padhya" <acharyalaxman8848@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260704121738.48071-1-acharyalaxman8848@gmail.com>
References: <20260704121738.48071-1-acharyalaxman8848@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 12:28:33 +0000
Message-Id: <20260704122833.9CEFE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A 0-byte firmware file causes out-of-bounds reads when verifying t=
he remark ID and when sending firmware pages to the device.
- [High] Stack-allocated arrays are passed to i2c_transfer(), which is unsa=
fe if the underlying I2C controller uses DMA.
--

commit 4ca9e1ffa7cb9eddbc7a0070d2fc1df01f66c3cd
Author: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>

Input: elants_i2c - prevent divide-by-zero on invalid EKTH data

This commit adds checks for physical dimensions in the eKTH query function.
It treats zero values as invalid data and skips resolution calculations
to prevent a divide-by-zero error during probe.

Fixes: 66aee90088da ("Input: add support for Elan eKTH I2C touchscreens")
Assisted-by: Codex:gpt-5

> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touch=
screen/elants_i2c.c
> index 17175adcaebbd..68c5ee3aa1904 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -566,10 +566,11 @@ static int elants_i2c_query_ts_info_ekth(struct ela=
nts_data *ts)
> =20
>  	dev_dbg(&client->dev, "phy_x=3D%d, phy_y=3D%d\n", phy_x, phy_y);
> =20
> -	if (rows =3D=3D 0 || cols =3D=3D 0 || osr =3D=3D 0) {
> +	if (rows =3D=3D 0 || cols =3D=3D 0 || osr =3D=3D 0 ||
> +	    phy_x =3D=3D 0 || phy_y =3D=3D 0) {
>  		dev_warn(&client->dev,
> -			 "invalid trace number data: %d, %d, %d\n",
> -			 rows, cols, osr);
> +			 "invalid data: rows=3D%u cols=3D%u osr=3D%u phy_x=3D%u phy_y=3D%u\n",
> +			 rows, cols, osr, phy_x, phy_y);
>  	} else {
>  		/* translate trace number to TS resolution */
>  		ts->x_max =3D ELAN_TS_RESOLUTION(rows, osr);

[Severity: High]
This isn't a bug introduced by this patch, but while looking at
elants_i2c_query_ts_info_ekth(), could there be an issue with how the comma=
nd
buffers are passed to the I2C subsystem?

drivers/input/touchscreen/elants_i2c.c:elants_i2c_query_ts_info_ekth() {
...
	u8 resp[17];
	const u8 get_resolution_cmd[] =3D {
		CMD_HEADER_6B_READ, 0x00, 0x00, 0x00, 0x00, 0x00
...
	error =3D elants_i2c_execute_command(client,
					   get_resolution_cmd,
					   sizeof(get_resolution_cmd),
					   resp, sizeof(resp), 1,
					   "get resolution");
}

When elants_i2c_execute_command() assigns these buffers directly to the I2C
message:

drivers/input/touchscreen/elants_i2c.c:elants_i2c_execute_command() {
...
		msgs[0].buf =3D (u8 *)cmd;
...
		msgs[1].buf =3D resp;

		ret =3D i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
}

If the I2C controller uses DMA, doesn't passing stack-allocated buffers like
get_resolution_cmd and resp cause a DMA mapping failure since stack memory
is virtually mapped?

[Severity: High]
This is a pre-existing issue, but does the firmware update routine properly
validate an empty firmware file?

If a 0-byte firmware file is loaded, the modulo check in
elants_i2c_fw_update() evaluates to 0:

drivers/input/touchscreen/elants_i2c.c:elants_i2c_fw_update() {
...
	if (fw->size % ELAN_FW_PAGESIZE) {
		dev_err(&client->dev, "Invalid firmware format: %zu\n",
			fw->size);
...
}

This would allow the empty firmware to proceed. Later, when validating the
remark ID, wouldn't the size calculation underflow and read out of bounds?

drivers/input/touchscreen/elants_i2c.c:elants_i2c_validate_remark_id() {
...
	fw_remark_id =3D get_unaligned_le16(&fw->data[fw->size - 4]);
...
}

Even if validation is skipped, could the actual update routine read out of
bounds when it unconditionally sends the first page?

drivers/input/touchscreen/elants_i2c.c:elants_i2c_do_update_firmware() {
...
	error =3D elants_i2c_send(client, fw->data, ELAN_FW_PAGESIZE);
...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704121738.4807=
1-1-acharyalaxman8848@gmail.com?part=3D1
