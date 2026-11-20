Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164932;
	b=vs22hAT4LTQUIPP8PHNxJfqGNLKUwg5jtZSnhSbGdgPyjVdx5FQkQ9O9Q9xt+l8m6je4
	 7jmTQJAlTxiOqaCEb82aHL6n2VSj0siuVxQL4QAbd6bQqWKifFcbfhii3roac28RzEwl+
	 NnL/zzhfncz7Pzt/TRCSQeEV5EBJfgBgzOzKmhhEDkkl8pwApjHwers4GH+WgqfxYDsZn
	 HlM19eRWBboWG3BaGtrOuUQ9rCf8WZoL1qpINy6B05mcSFied5UJFOd5D1bBthq7fL72c
	 dPGSRQFGE9oU2a0UjClF/YB4nOsrr8Jf1lAwvilXRMBceNPy1zIyHSSacmT49Etq9eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164932;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VO03xHwcwH1qHi1wuFTxnmTR3+SyhcyHqnttN55JeEM=;
	b=dS0SCxd3h5RQ1jcrN/L2Dw3aXzXDXrIk9BkXBGWDCBbodPxtxZ5NoF91Bu5mDm34Nuf/
	 6tBkolFZg171DTmyojfwcfegpzrAr5dYwzskX+SaXv5JEuByMCn5KO4cX3mkTU7uwEs/B
	 uV3JCx6/E5EdUl3sKub+QeCdnnQKliPjDRGzDkrnxVqvrqD71QzdXNhUYguz2r08WxF1i
	 UCbpGA/PCs6XkM3e9yJ1iNF0H3NJPWpZL6Nl0FLwn7wy5tqG8bWafh1k6TH8vL5SrDlj9
	 TrQ7RGzTQTppp9Nmle8bajj5AdNFWzDf+MOUkSNSH5jyvQRL++M+eeMa9uxY8QmXJ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZK0Ubs6R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9FE606A325
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZK0Ubs6R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BC01F000C4;
	Fri, 20 Nov 2026 08:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795164931;
	bh=VO03xHwcwH1qHi1wuFTxnmTR3+SyhcyHqnttN55JeEM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZK0Ubs6Rkr6MWuA11Ls58lxN5vi6d0lZidfxSepSpzIPDwrhh/n+YjAYMw2VdAuuq
	 mT6pMNJ9Xud7Us1KRAcQz7axd4UyOBwfFs/pxxwt6oB0txLCPQqFlS6oTW94J8EcSK
	 vxA0R6e0oM0C2CGpk+Og/DeN1Y6wY9hn+DFEtWi9PmGb76iEL2BbvEm39mA0mXCcUb
	 RehIR6dOT5e5DCtZ+f//mqt1aX+rFRYhe0xSq5rSgfrdO73jnjKhvxBve4VoLdP8+h
	 4S/w34QNcCsHiDn8c9UYVQcFDNtiWmEo9ovFdWdQoHUQsS3F8yzfJ37+yH0Hk/OQD0
	 aPeFHFGxYgmGw==
Message-ID: <sashiko-outbox-224800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/14] HID: logitech-hidpp: expose charge_type
 property for battery voltage feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
In-Reply-To: <20261120-hid-logitech-hidpp-v3-14-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
 <20261120-hid-logitech-hidpp-v3-14-cfe2caa1d0eb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:55:31 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] HID: logitech-hidpp: unexposed capacity_level for battery
  voltage feature
--

commit b4d76869d226ccd595e36b0b248b61047a51210e
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

HID: logitech-hidpp: expose charge_type property for battery voltage feature

This commit exposes POWER_SUPPLY_PROP_CHARGE_TYPE for devices supporting
the 0x1001 battery voltage feature, refines charge_type mapping based on
battery status, updates change detection in
hidpp20_battery_voltage_event(), and resets charge_type on disconnect.

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index dbf8f15f5a5b0..966c5932528de 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c

[ ... ]

> @@ -1553,7 +1558,10 @@ static int hidpp20_battery_voltage_event(struct hi=
dpp_device *hidpp,
> =20
>  	hidpp->battery.online =3D status !=3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> =20
> -	if (voltage !=3D hidpp->battery.voltage || status !=3D hidpp->battery.s=
tatus) {
> +	if (voltage !=3D hidpp->battery.voltage ||
> +	    status !=3D hidpp->battery.status ||
> +	    level !=3D hidpp->battery.level ||
> +	    charge_type !=3D hidpp->battery.charge_type) {
>  		hidpp->battery.voltage =3D voltage;
>  		hidpp->battery.capacity =3D hidpp20_map_battery_capacity(hidpp->hid_de=
v,
>  								       voltage);

[ ... ]

> @@ -4416,6 +4425,10 @@ static int hidpp_initialize_battery(struct hidpp_d=
evice *hidpp)
>  		battery_props[num_battery_props++] =3D
>  			POWER_SUPPLY_PROP_VOLTAGE_NOW;
> =20
> +	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
> +		battery_props[num_battery_props++] =3D
> +				POWER_SUPPLY_PROP_CHARGE_TYPE;

[Severity: Medium]
Should hidpp_initialize_battery() also register
POWER_SUPPLY_PROP_CAPACITY_LEVEL when HIDPP_CAPABILITY_BATTERY_VOLTAGE is
set?

hidpp20_battery_map_status_voltage() populates battery.level (setting
POWER_SUPPLY_CAPACITY_LEVEL_FULL when full and
POWER_SUPPLY_CAPACITY_LEVEL_CRITICAL when bit 5 of flags is set), and
hidpp20_battery_voltage_event() now checks level !=3D hidpp->battery.level
before calling power_supply_changed().  However, hidpp_initialize_battery()
only appends POWER_SUPPLY_PROP_CAPACITY_LEVEL to battery_props[] for
HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS:

drivers/hid/hid-logitech-hidpp.c:hidpp_initialize_battery() {
    ...
	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS)
		battery_props[num_battery_props++] =3D
				POWER_SUPPLY_PROP_CAPACITY_LEVEL;
    ...
}

As a result, capacity_level is never exposed in sysfs for 0x1001 battery
voltage devices, and a change in battery.level alone (such as the critical
flag toggling at the same voltage and status) emits a power_supply_changed()
uevent with no user-visible property change.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-hid-logite=
ch-hidpp-v3-0-cfe2caa1d0eb@gmail.com?part=3D14
