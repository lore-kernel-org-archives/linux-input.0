Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FA84AA039
	for <linux-input@vger.kernel.org>; Wed,  2 Sep 2026 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366807; cv=none; b=CG3GFpFFL1Y46AfP97r9QPSBF3zOlF/yKkTy7or8s6CsUUqJ/w/Pu/EsR2QvQ2pOVgTa5BnnvKIoNv0ZTzjx4p/6zoyKSG/h7N79GIE05n+kAjqHuGfB9dIBUXKaFI1UswTq+GqX4GPH00zQZktUqSgKeVB+KICrJ+YI6xSF5Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366807; c=relaxed/simple;
	bh=FyeVveDMKCu2pFBsw56hVzn8Co7m7TJY2o67QUcAb/c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L5Vx+4LtMGn8bLwgKR1Dl5zCTkqARYsZy9EFmZ4ame2ldmjntXB0C7ZE0djhbV6Ai6HjUqm51Hz1H38jNZK4ZkcEMbnibgKy4LAGcjnAz26wqzOdVxaKkTT6BY6osLnuBDMMaAl9/sND1XSTl0d2sM+NfzmFOn7L4xe4IwXvEnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oYjq9f7h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYjq9f7h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130181F000E9;
	Wed,  2 Sep 2026 16:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788366805;
	bh=cXFz3pn+c6uxszPjg6gq4k03nwB8RlX0EHR7JL5pYMQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oYjq9f7h6HoZPDFtgvuBx/eN62CTaYFRsKAaku8pp7oUsIM5mV3A613qWosARTPoM
	 ORuON4KNEoMCer/R+21wXPfUrIZDuUXmDfrVAe7gIzzeZpowa6jT16XPzpgFZnYU8C
	 l0GLJbRnFRJcqL5AUv3GLKwijnEqu+ML4VqNoGHI68AmhDoBDRUca0ZYcksPujMS3N
	 HQC5Ue9fjGRoPu9EgGe1tSRhxSUUXZlQd2bGQHgckPi3OEoWplASsXDePjjUKm+U29
	 lnBHuV6+ulTH1JksWY6QBD4tGE8cdzElnYII8dRJhAXp3TsJSKlzHDKU6XuE+TuyJG
	 /oVuI5KkoKkFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] HID: pulsar: add driver for Pulsar gaming mice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolas Koesling" <nikolas@koesling.info>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
In-Reply-To: <20260902161350.22233-1-nikolas@koesling.info>
References: <20260902161350.22233-1-nikolas@koesling.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 16:33:24 +0000
Message-Id: <20260902163325.130181F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The driver leaks uninitialized kernel stack memory to userspac=
e and allows a deterministic kernel crash because `battery_get_property` re=
turns `1` without initializing the property value.
--

commit 6987787f50bcfdb5c82e17e354bba7b71293f806
Author: Nikolas Koesling <nikolas@koesling.info>

HID: pulsar: add driver for Pulsar gaming mice

Add a HID driver for Pulsar wireless gaming mice (X2 V2, X2H, X2A,
Xlite V3). The driver exposes battery level, voltage, and charging
status through the power supply framework.

[ ... ]
> diff --git a/drivers/hid/hid-pulsar.c b/drivers/hid/hid-pulsar.c
> new file mode 100644
> index 0000000000000..a6ff6e436d407
> --- /dev/null
> +++ b/drivers/hid/hid-pulsar.c
[ ... ]
> +static int read_power(struct pulsar_data *drvdata)
> +{
[ ... ]
> +	if (need_status) {
> +		ret =3D read_status(drvdata);
> +		if (ret < 0) {
[ ... ]
> +			goto unlock;
> +		}
> +
> +		battery->last_status =3D now;
> +
> +		if (!ret) {
> +			battery->available =3D false;
> +			battery->refresh =3D false;
> +			goto unlock;
> +		}
> +
> +		/* device just became available, force power read */
> +		if (!battery->available)
> +			need_power =3D true;
> +	}
> +
> +	if (!need_power)
> +		goto unlock;
[ ... ]
> +unlock:
> +	up_write(&drvdata->lock_bat);
> +	return ret;
> +}

[Severity: Critical]
When read_status() succeeds and the device is available, it returns 1. If=20
need_power is false (e.g., between 5 and 60 seconds after a previous read),=
=20
read_power() jumps to unlock and returns this 1.

Does this unintentionally return 1 on success instead of 0?

> +
> +static int battery_get_property(struct power_supply *psy,
> +				enum power_supply_property psp,
> +				union power_supply_propval *val)
> +{
> +	struct pulsar_data *drvdata;
> +	int ret;
> +
> +	drvdata =3D power_supply_get_drvdata(psy);
> +
> +	ret =3D read_power(drvdata);
> +	if (ret)
> +		return ret;

[Severity: Critical]
Will this leak uninitialized kernel stack memory or cause a kernel crash?

If read_power() returns 1 as described above, this branch returns 1=20
immediately, bypassing the switch statement that initializes the property=20
value.=20

The power supply core (e.g., in power_supply_format_property) only consider=
s=20
strictly negative values as errors. It treats 1 as success and will proceed=
=20
to read the uninitialized union value. For integer properties, this leaks=20
stack memory to userspace. For string properties like=20
POWER_SUPPLY_PROP_MODEL_NAME, it dereferences the garbage stack pointer in=
=20
val->strval, which can cause a direct kernel panic.

> +
> +	down_read(&drvdata->lock_bat);
> +
> +	switch (psp) {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902161350.2223=
3-1-nikolas@koesling.info?part=3D1
