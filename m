Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E642D7DEA
	for <linux-input@vger.kernel.org>; Thu, 23 Jul 2026 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821792; cv=none; b=DIl8u1VYBGP9+Vem0sSdGMrLJNIPrS3NaKVuZXG0y1GbXbmdIot9mn8NMyJwwW/DEOKhfTwdCFC+LFph5lF6rk586AmOcRZQT1TkhpStuD6sksK1xIJEXEeYMLumdrz450PWZUITn5A3HBSjrn+CbjysgMfGg9/mQzhIkpE5zFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821792; c=relaxed/simple;
	bh=wVotfD/kQTNR6sxr46A2r1Jra03Di9E+GD295JrlDtA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tjvEdmtKZrIbck1lYKzeiGxxcMSI6Q6BmuddGdsAeHJFQYWD0cvojM2kluvcK+rfNJRjjUWxBih4aQzYMJqWTbVePPMbrEdkOFWpXdi9OuFg8MIYeVfNnogtFcLDperqknYLw2oljirvzX08Jn1NGhXEiN9uuRfPgA5j7bTuSPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLQ0Hb5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLQ0Hb5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73971F000E9;
	Thu, 23 Jul 2026 15:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784821781;
	bh=8zwRmSiDZuaAkQo7ct0IjL3QRFXsWg+U48e39mfZYoM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OLQ0Hb5T4OkPNYUS/uuWXwJ/dCm3DeSBnamSSRvyD/mhEpVoLKUmPbArPwVwpokPD
	 cMJnzwZlu3NQZuwx3M82tGoSIJ9dRjr8fHqC366581Gc4iMhg7ck8vyxtIWIg0pT08
	 XU9KTFJ6hXcVg+vJ0nNpVsGBkZl88r0VBCVzZXNZpDnPvRiiLW8JqWFOqQKTGwQCaO
	 zHbZtE5uDEmuoUk5H6snHQaYmInZr4F08tnKYODeLME7o0M5m3w84/PmHXdo8tNwF7
	 cfknEaBljU4KOidVyfo8GNZkNKr8eYqbKTr2MQxZKePdco2ZK5iyQCaP801crO27/f
	 66Se323H2owiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] Input: ilitek_ts: ratelimit unexpected report
 logging
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kristian Mide" <kristian@mide.dk>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260723152244.11252-4-kristian@mide.dk>
References: <20260709182602.7308-1-kristian@mide.dk>
 <20260723152244.11252-1-kristian@mide.dk>
 <20260723152244.11252-4-kristian@mide.dk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 15:49:41 +0000
Message-Id: <20260723154941.A73971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `enable_irq()` on error paths in PM suspend and resume cal=
lbacks, leaving the touchscreen interrupt permanently disabled.
- [High] The driver unconditionally disables the device IRQ during suspend,=
 breaking system wakeup.
--

--- Patch [3]: [PATCH v3 3/3] Input: ilitek_ts: ratelimit unexpected report=
 logging ---
commit d857848ba27cfb246552c60fc75946ecead183d4
Author: Kristian Mide <kristian@mide.dk>

Input: ilitek_ts: ratelimit unexpected report logging

This commit replaces dev_err() with dev_err_ratelimited() when logging
unexpected report IDs in the ilitek touchscreen driver. It adds the first
16 bytes of the raw packet to the log for better debugging context. It also
returns success after logging to prevent duplicate errors from being emitted
by the IRQ handler.

> diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/to=
uchscreen/ilitek_ts_i2c.c
> index a184d024d6c4f..2f1741d77e6a9 100644
> --- a/drivers/input/touchscreen/ilitek_ts_i2c.c
> +++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
> @@ -238,8 +238,10 @@ static int ilitek_process_and_report_v6(struct ilite=
k_ts_data *ts)
>  		return ilitek_process_pen_report(ts, buf);
> =20
>  	if (buf[0] !=3D ILITEK_TP_I2C_REPORT_ID) {
> -		dev_err(dev, "get touch info failed. Wrong id: 0x%02X\n", buf[0]);
> -		return -EINVAL;
> +		dev_err_ratelimited(dev,
> +				    "get touch info failed. Wrong id: 0x%02X raw[0:16]=3D%*ph\n",
> +				    buf[0], 16, buf);
> +		return 0;
>  	}
> =20
>  	report_max_point =3D buf[REPORT_COUNT_ADDRESS];

[ ... ]

While looking at this driver, I noticed a few pre-existing issues in the
power management callbacks:

> static int ilitek_suspend(struct device *dev)
> {
> 	struct i2c_client *client =3D to_i2c_client(dev);
> 	struct ilitek_ts_data *ts =3D i2c_get_clientdata(client);
> 	int error;
>=20
> 	disable_irq(client->irq);
>=20
> 	if (!device_may_wakeup(dev)) {

[Severity: High]
This is a pre-existing issue, but does unconditionally masking the IRQ here
break system wakeup?

By calling disable_irq(), the interrupt controller is prevented from seeing
the event and waking the CPU. Even though the sleep command is skipped when
device_may_wakeup(dev) is true, the unconditionally disabled IRQ line ensur=
es
that any touch events generated by the hardware while suspended are dropped.

> 		error =3D api_protocol_set_cmd(ts, SET_IC_SLEEP, NULL, NULL);
> 		if (error)
> 			return error;

[Severity: High]
This isn't a bug introduced by this patch, but if api_protocol_set_cmd()
fails, does this error path leave the touchscreen interrupt permanently
disabled?

If this returns early without calling enable_irq(), the PM core aborts the
suspend process. Since the suspend failed, the resume callback is never
invoked for this device, leaving the IRQ depth unbalanced and the touchscre=
en
unresponsive until a reboot or module reload.

> 	}
>=20
> 	return 0;
> }
>=20
> static int ilitek_resume(struct device *dev)
> {
> 	struct i2c_client *client =3D to_i2c_client(dev);
> 	struct ilitek_ts_data *ts =3D i2c_get_clientdata(client);
> 	int error;
>=20
> 	if (!device_may_wakeup(dev)) {
> 		error =3D api_protocol_set_cmd(ts, SET_IC_WAKE, NULL, NULL);
> 		if (error)
> 			return error;

[Severity: High]
This is a pre-existing issue, but could this error path also leave the IRQ
disabled?

Similar to the suspend callback, if SET_IC_WAKE fails here, the function
returns an error before reaching enable_irq(client->irq). This would also
leave the interrupt permanently disabled.

>=20
> 		ilitek_reset(ts, ts->reset_time);
> 	}
>=20
> 	enable_irq(client->irq);
>=20
> 	return 0;
> }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723152244.1125=
2-1-kristian@mide.dk?part=3D3
