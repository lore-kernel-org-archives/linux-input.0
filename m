Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4119A3AD528;
	Tue, 21 Jul 2026 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784628265; cv=none; b=Di6BdGcni9wFOnV1FOYsWoLX75LUKvQaTXBU6CEK6uXQ8CdlJeYZP6AKbsE0T6QNFnlSeUF8c5AMP6Gu4Ol1yXMW3sYytATHDbf1TanmeqFpbSJuVCfqUKD51ZEVxgWZbaK9UZQlxNxoa7QQ1VTdHWt+WVcb+1lASytJ7Feg4xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784628265; c=relaxed/simple;
	bh=pAF/FRfBTCCPKT7aB+eBrOPsEqkoWzorWtV0h9d5Nms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tuTpLIcAJyQNY3CQE4E5CV2rVBV0vyfeH0FR5Hn/vbKB75trWLWM5CoAPPCVb3jIPrAf00LMGwsHXksr/leQ6pNj+9R9DHJWj+o/7SRKVB0S3IhcgcBVMlHCiR6fZKgO43hfEi0JcA6wim4/IYQLyQbgSE2Zv+GMdu2J40wIUME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haBPaJr+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haBPaJr+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9ED1F00A3A;
	Tue, 21 Jul 2026 10:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784628263;
	bh=Sh3NUnR8GCa6mOJOZo4KF++S5ekyvsxPV1QCBY/Otuw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=haBPaJr+zXIx3RYO1uZIzg/bGWnQ909/xBI1iCivSauE5ZNx7XBu//ihtMwz7Plim
	 oW7Kr/Y4rLNfvqeCo3RWHYQR754YpFuTyBdLHW3LRksyURsENbGpFsgnrvPWTq0oSE
	 dfIYfGlFE5skG0xjkEFNI9pG9tx2Lh0K4ZvRGds14RDFvM/LZC+QvXpZsBN3C3qHSQ
	 K9tQk40gKb+nijvJOjcggGVb0yeDzm10l4aax21q95IyapwX1IiDU3dNbvtV5wiXKC
	 JeKKhQtIU615f8tAs2pY3TeQh7Co/hF4h982gswdT8rwvWhKTJM9u7V6LNor/S2/Uu
	 b7OI5tSSP/f2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 6/7] power: supply: Add driver for ASUS Transformer
 battery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org, linux-leds@vger.kernel.org, lee@kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260721095233.420823-7-clamor95@gmail.com>
References: <20260721095233.420823-1-clamor95@gmail.com>
 <20260721095233.420823-7-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 10:04:22 +0000
Message-Id: <20260721100423.3C9ED1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The bounds check for battery property reading fails to account f=
or the 2-byte read size, allowing the second byte to be read from logically=
 invalid padding data.
- [Medium] Battery data cache is not invalidated on system resume, causing =
user-space to receive potentially stale battery readings.
--

--- Patch [6]: [PATCH v10 6/7] power: supply: Add driver for ASUS Transform=
er battery ---
commit 576ecafdda8cdf8e2dbf1964e8a1e9097bcefa55
Author: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

power: supply: Add driver for ASUS Transformer battery

This commit adds a new battery driver for Asus Transformer tablets and
mobile docks. It implements one battery cell per EC controller and
supports reading battery status via I2C.

> diff --git a/drivers/power/supply/asus-transformer-ec-battery.c b/drivers=
/power/supply/asus-transformer-ec-battery.c
> new file mode 100644
> index 0000000000000..4c0c6d4b09e2c
> --- /dev/null
> +++ b/drivers/power/supply/asus-transformer-ec-battery.c

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

[Severity: Medium]
Should the bounds check account for the 2-byte read size?

If the EC returns a length where offs =3D=3D priv->batt_data[0] - 1, the bo=
unds
check offs >=3D priv->batt_data[0] will pass.=20

Since get_unaligned_le16() reads two bytes, wouldn't it read a byte past the
logical data length and return corrupted data instead of -ENODATA?

> +}

[ ... ]

> +static int __maybe_unused asus_ec_battery_resume(struct device *dev)
> +{
> +	struct asus_ec_battery_data *priv =3D dev_get_drvdata(dev);
> +
> +	schedule_delayed_work(&priv->poll_work,
> +			      msecs_to_jiffies(ASUSEC_BATTERY_DATA_FRESH_MSEC));
> +
> +	return 0;
> +}

[Severity: Medium]
Should the data cache be explicitly invalidated here?

If priv->batt_data_ts is not reset on resume, and jiffies has not
sufficiently advanced past the expiration timestamp during suspend, could t=
he
driver serve stale battery data to user-space from before the sleep?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721095233.4208=
23-1-clamor95@gmail.com?part=3D6
