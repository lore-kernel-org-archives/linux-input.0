Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540FB260580;
	Thu, 28 May 2026 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949019; cv=none; b=pw41pUZQm8aX5y6yGLTs71FlAoFpBVJzALQcMZGGz8HyiH9P/9MAx9lVgrP1Z3YINm62bJzRbEy5Zogz6snZmk1VH4+TVszlqa4o5EJwatVkGgwcpLhfxKfjOHW/mvBQa1r7LJ6eb4TBokyKEdR21OkHbWXL7THrmby4hkiDX4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949019; c=relaxed/simple;
	bh=M/275JbtxKv3PMzBOnYBjC6WcWBjJqtUTErStfpPelY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gaGpuDAA2jnssSNjoAOqCw4IW/f2xlJJtvskeep4YYHiR695mRXTr+qyg+dhMSxhOdIN7DW26nTU32R6RJcbrIzq2uwWJee1mlfmH3fwBs3+hKCdhZKz+YNZ7Rw7t7mhlNjQbU44fG4Ny9U2/0i8IA47Y5IWxej7sRmzsKBWTik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvGW7eRF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvGW7eRF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E6F1F000E9;
	Thu, 28 May 2026 06:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779949017;
	bh=wHR9TwehavIPVk4XEUhyV+PhdyIjq9pAtyQh9/9EsNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AvGW7eRFaxVT27QIk3oPc7SHQ3PEeYCVgr8EsMz1TTqHeiC9EvtUOFwa2kANeRYBF
	 ZlXLUrStnhyF5Vy+WHB0mr3NBtOKcEh/DvBDEHED3Wa7EsMOaOaMIR8gmSNuh4JnWg
	 euBLjxBYiJ5jK5DAZfb3M77iLTdpPPtcXXnNdUYq5fWwLaULojBZr2BKf2QlHgl/Vh
	 5KDZo22Cz86Z1BwC7zv0gCBeFGX4ztUwNo4EKNzaFoJEdOjro0IV4QYfRBZGDg2BTc
	 FR0gQZxVO5KLOHbcjVke8hJd1vhuo22Dfz1gzHAHsBsR/6+TCqvYbHANPNaq8sevxj
	 r2IlU9iFRDsDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: robh@kernel.org, linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260528053203.9339-3-clamor95@gmail.com>
References: <20260528053203.9339-3-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 06:16:57 +0000
Message-Id: <20260528061657.A6E6F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Short I2C block reads return positive values or zero, violating AP=
I contract and causing false probe success or uninitialized variable usage.
--

commit 66708f4a4bcbbc5908e6fc11660dc174e28d7ee4
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

mfd: Add driver for ASUS Transformer embedded controller

Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201,
TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF101 dock
and TF600T, P1801-T and TF701T pad. This is a glue driver handling
detection and common operations for EC's functions.

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
> +	if (ret < ASUSEC_ENTRY_SIZE) {
> +		dev_err(&client->dev, "failed to access control buffer: %d\n",
> +			ret);
> +		return ret;

[Severity: High]
If i2c_smbus_read_i2c_block_data() returns a positive short read, will this
return a positive error code?

This positive value could propagate up to asus_ec_probe(). Returning a
positive value from probe causes __device_attach_driver() to interpret it
as a successful match and probe, leaving the device in an unbound, broken
state without a proper failure log.

Additionally, if it returns 0, the function will return success (0) without
populating output variables, potentially leading to uninitialized memory
usage in callers like asus_ec_susb_on_status().

> +	}
> +
> +	if (buf[0] !=3D ASUSEC_CTL_SIZE) {

[ ... ]

> +static int asus_ec_log_info(struct asus_ec_data *ddata, unsigned int reg,
> +			    const char *name, const char **out)
> +{
> +	struct device *dev =3D &ddata->client->dev;
> +	u8 buf[ASUSEC_ENTRY_BUFSIZE];
> +	int ret;
> +
> +	memset(buf, 0, ASUSEC_ENTRY_BUFSIZE);
> +	ret =3D i2c_smbus_read_i2c_block_data(ddata->ec.dockram, reg,
> +					    ASUSEC_ENTRY_SIZE, buf);
> +	if (ret < ASUSEC_ENTRY_SIZE)
> +		return ret;

[Severity: High]
Could this also return a positive short read or 0 to the caller?

Similar to asus_dockram_access_ctl(), this might propagate positive values
to the probe function or mask zero-byte read failures.

> +
> +	if (buf[0] > ASUSEC_ENTRY_SIZE) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528053203.9339=
-1-clamor95@gmail.com?part=3D2
