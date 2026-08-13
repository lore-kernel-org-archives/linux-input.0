Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E23A3812;
	Thu, 13 Aug 2026 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786657329; cv=none; b=rC+n9PDSkj25Ig26no8dkvqYIH0k2bCvIGAPD74twQRkr4qUzB+mm+n1FEQWjDLbxMyibtYXrs77F6tR4aLIbn4UaLP8XwePsjp9l18ZVNHJE7gqVF/fMms4qWqrhSlo7DwUf8XQ//LBkQqt/AyGckXEkRn6GSeie9Jw9Al5zS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786657329; c=relaxed/simple;
	bh=78PPVrMugYqRrcxs9oLfaz+hq9OcVtzvz2ZEEZd1rlU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hoiA2vyjlkb0m62JoQlFIAWjSF1w3cmbiMowBAWOAcUgmyKYGx1J2oCidZqHKXdHfA024YufS+zlY11mI79qHFed9eQtddhr/UzD+vb5wxmjG4KQobupAb7FXbYFJkeKbhMUkPBuUgKhutqIvBV9G0YQL8HWe71cAnJHOLRHJmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HlsdZ2nw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HlsdZ2nw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8064D1F000E9;
	Thu, 13 Aug 2026 21:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786657327;
	bh=VCeJEUjiWGObsGnJkERMuK/1uUhTjYYu8L7ilWbgB+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HlsdZ2nwtztrp2UGRyWZetClIcjYtY6NTkc6hjnb9Ov7QY5g3ubC3YE1udwpnbrnp
	 OTcVO+YUT1ydIoPXtLQBypCvFvTaUH37HMZnv/9VCAp+dH4KKqTEF9tOH8q1KJ2L3w
	 /98cw6p5+EzDU77UsclfeGoo51bM6n0ynXkHHJUkJPXB2QTdpufAi+q8a89s/IWYbg
	 xciKEKHWj++CW5quUkZ+Uv5l+phsFDNv9QZiAy6y1lZh3onR5I1BC3ckrXDuT5dYON
	 2XVLXOmpzVpBn2VCvXp20K0z/hU2VGJZcigIOV2llwd1ewL9N8OvwJiL7Fdbx4XEah
	 U5lIo7G84Kmbw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH WIP v2 08/11] Input: stmfts - add optional reset GPIO
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Heidelberg via B4 Relay" <devnull+david.ixit.cz@kernel.org>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20260315-stmfts5-v2-8-70bc83ee9591@ixit.cz>
References: <20260315-stmfts5-v2-8-70bc83ee9591@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 21:42:02 +0000
Message-Id: <20260813214206.8064D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The `stmfts_power_on` error path fails to assert the reset GPIO be=
fore disabling regulators, creating a back-powering risk.

Pre-existing issues:
- [High] The `stmfts_power_on` error path fails to disable the device inter=
rupt if a failure occurs after the IRQ is enabled.
--

--- Patch [8]: [PATCH WIP v2 08/11] Input: stmfts - add optional reset GPIO=
 support ---
commit af8956cdddb1b976c94ce0f3a47253f42629d7bf
Author: Petr Hodina <petr.hodina@protonmail.com>

Input: stmfts - add optional reset GPIO support
   =20
Add support for an optional "reset-gpios" property. If present, the
driver drives the reset line high at probe time and releases it during
power-on, after the regulators have been enabled.

> diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscre=
en/stmfts.c
> index 4dfaf3a6077d9..2c10256e09c5e 100644
> --- a/drivers/input/touchscreen/stmfts.c
> +++ b/drivers/input/touchscreen/stmfts.c

[ ... ]

> @@ -549,6 +559,9 @@ static int stmfts_power_on(struct stmfts_data *sdata)
>  	if (err)
>  		return err;
> =20
> +	if (sdata->reset_gpio)
> +		stmfts_reset(sdata);
> +

[Severity: High]
Does this error path properly unwind the reset GPIO state?

If an error occurs later in stmfts_power_on() (for example, if
stmfts_read_system_info() fails), the code jumps to the power_off label:

power_off:
	regulator_bulk_disable(ARRAY_SIZE(stmfts_supplies),
			       sdata->supplies);
	return err;

Since this disables the regulators unconditionally without first reverting =
the
reset GPIO to its asserted state (as done in stmfts_power_off()), could this
leave the GPIO driving a voltage into an unpowered touchscreen controller?

This could potentially back-power the chip through its internal ESD protect=
ion
diodes, risking power leakage or hardware damage.

[Severity: High]
This is a pre-existing issue, but does the power_off label also fail to unw=
ind
the IRQ state if a failure occurs after the IRQ is enabled?

If stmfts_command(sdata, STMFTS_SYSTEM_RESET) fails:

	enable_irq(sdata->client->irq);

	msleep(50);

	err =3D stmfts_command(sdata, STMFTS_SYSTEM_RESET);
	if (err)
		goto power_off;

The power_off label disables the regulators but fails to call disable_irq().

Could this leak an enabled IRQ line while powering down the device,
potentially triggering an interrupt storm or an IRQ depth imbalance WARN on
subsequent resumes?

>  	/*
>  	 * The datasheet does not specify the power on time, but considering
>  	 * that the reset time is < 10ms, I sleep 20ms to be sure

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260315-stmfts5-v2=
-0-70bc83ee9591@ixit.cz?part=3D8
