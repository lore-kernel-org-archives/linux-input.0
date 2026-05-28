Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1F37BE6D;
	Thu, 28 May 2026 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779957166; cv=none; b=Z7M/fs9TtfFuiY93aS4z0ohGkNet/AW08dS+hupcctUTKPUfAT9as3FIQjzKyx77LAyzFODDsSukDWGTKMJU6SOZlXwVCmFpe+/7NFaGbkkhqgkAiLjZJ613YNDmC75uPA/iTmRBTd3YTQhk4gVFOqNheoZjOXD8UxtisAQKDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779957166; c=relaxed/simple;
	bh=YU9a5uWZs3eNFJ5sWl6WN23NYFgASuOeSnSAi8aCZK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vFHH9Q/iNSivifCPqAkmLMhJkE8E9FUoN1ieXIIslgJa9Psu/IZQr0Sis181KDJbp6pwIC+xTMpsjIRRSVDrqYNIhXAWg1AI9Q4cARtBvbkdQn+oZKp3F+tJmMm21lHyjBZ5HTxc19rHa1zQW2zm7hI9KHT2n/qyly8eWUyl3wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9iWdr8T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9iWdr8T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EC31F000E9;
	Thu, 28 May 2026 08:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779957165;
	bh=xUFfceI4yOAGxlsuowFlWzIGqaexCjSF5g4S1Pq6I28=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l9iWdr8TyYe1cZALV9+EJt4/bOc3DrW20/FJ4SsxXumYweReAyNBsX7twppvs2FuG
	 VYEcU83Ebj/v9JZHePjITCqmNKfZQOzZlObXqIrKn/4VTigGaTGVQiKgcv1R5hTGAd
	 uDjjgXu/bk4QWV5j08dRqT8mSb5KVWsbxL5J+ofAlIQnZJt6NJq3CoiKbX9nE190nK
	 N0ughHnRWIMLZ6ZxSvcB3PrTnC5oOT4DROB4TRXc/RphWo92HrFdB3qFHzuyzauwit
	 Ny1/028+lPBXS4CGsWB+kp9gL3rrYQ9GxxYwD7CeV9m2wWkn7RVonIOrYyq64by/rs
	 QjwhBuq3UjUQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/7] power: supply: Add driver for ASUS Transformer
 battery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, robh@kernel.org
In-Reply-To: <20260528053203.9339-7-clamor95@gmail.com>
References: <20260528053203.9339-7-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 28 May 2026 08:32:30 +0000
Message-Id: <20260528083231.41EC31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Short I2C reads return a positive value that bypasses the caller=
's error check, leading to uninitialized data access and cache bypass.
- [Medium] Off-by-one error in length bounds check allows reading outside t=
he valid EC payload.
--

commit 04954fc98984d98f0039fee1c123ecdf16dc2ff7
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

power: supply: Add driver for ASUS Transformer battery

This commit adds a new driver for ASUS Transformer batteries, which impleme=
nts
one battery cell per EC controller and supports reading battery status for =
the
pad and mobile dock.

> diff --git a/drivers/power/supply/asus-transformer-ec-battery.c b/drivers=
/power/supply/asus-transformer-ec-battery.c
> new file mode 100644
> index 0000000000000..db6331352f7d4
> --- /dev/null
> +++ b/drivers/power/supply/asus-transformer-ec-battery.c
[ ... ]
> +static int asus_ec_battery_refresh(struct asus_ec_battery_data *priv)
> +{
> +	struct i2c_client *client =3D priv->ec->dockram;
> +	struct device *dev =3D &client->dev;
> +	int ret =3D 0;
> +
> +	if (time_before(jiffies, priv->batt_data_ts))
> +		return ret;
> +
> +	memset(priv->batt_data, 0, ASUSEC_ENTRY_BUFSIZE);
> +	ret =3D i2c_smbus_read_i2c_block_data(client, ASUSEC_DOCKRAM_BATT_CTL,
> +					    ASUSEC_ENTRY_SIZE, priv->batt_data);
> +	if (ret < ASUSEC_ENTRY_SIZE)
> +		return ret;

[Severity: Medium]
Since i2c_smbus_read_i2c_block_data() returns the number of bytes read on
success, could this return a positive value on a short read?

If this returns a positive value less than ASUSEC_ENTRY_SIZE, it bypasses
updating the batt_data_ts timestamp, which breaks the 5-second caching
mechanism and triggers an I2C transaction on every subsequent property read.

Additionally, asus_ec_battery_get_value() below only checks for errors with
if (ret < 0), which would fail to catch this positive short read value as
an error, potentially leading to the use of uninitialized data.

[ ... ]
> +static int asus_ec_battery_get_value(struct asus_ec_battery_data *priv,
> +				     enum power_supply_property psp)
> +{
> +	int ret, offs;
> +
> +	guard(mutex)(&priv->battery_lock);
> +
> +	if (psp >=3D ARRAY_SIZE(asus_ec_battery_prop_offs))
> +		return -EINVAL;
> +
> +	offs =3D asus_ec_battery_prop_offs[psp];
> +	if (!offs)
> +		return -EINVAL;
> +
> +	ret =3D asus_ec_battery_refresh(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (offs >=3D priv->batt_data[0])
> +		return -ENODATA;
> +
> +	return get_unaligned_le16(priv->batt_data + offs);
> +}

[Severity: Medium]
Does this bounds check properly account for the 16-bit read?

Since get_unaligned_le16() reads two bytes, if offs exactly equals
priv->batt_data[0] - 1, the bounds check passes. However, the second byte
read (offs + 1) would fall outside the valid payload length.

Could this silently combine one byte of valid data with a zero-padded byte
from the buffer, returning a corrupted value?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260528053203.9339=
-1-clamor95@gmail.com?part=3D6
