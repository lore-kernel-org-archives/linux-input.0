Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794386368;
	b=xhwS7DuAQDbo1MYr0X8WXPcIoyHOp/P3gMOCvOEPyi18//pZs1bi1bGIPFyJHVhz+/Zg
	 Jqz1EpQIGiLkea7hg4RLgP8Ezw29O4kQ5waaTLX+5oFBDJvyrfySkjzs/4maPZhO1VZhr
	 kuOV1sd7DZ1V1ydNE5RnKhylXnfdwzpGCT2ua0niJhApqbUa/Xg1mkKXHbTFXxQQqfqTM
	 +CO2slIh5Pcav2Ii1V3wvdcWOy9kYRi8gOOKVmSMf0UsNz7DDC6DdHw7aWiagaHwDdCPB
	 E5IcY0RKYeimWfqQG6i5/d5G7EMIbw0vyXpSWwqFIwEovecvsEGhZAQ4iDYG1hqQapw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794386368;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZnLdybdYEPaJGP7kHfFmC0d0eZzo8Oz12yT1Bs2/f/c=;
	b=U7HkKCYNdPHDKaX3MokbNO4OWTd73WML8hhNPVq6ifWRwARLVi7voLdp26LBPXa6FeJV
	 iiuI42FosBFf89LzkLr59cD7t/Biuy8JWL8HZ4Z0UuNndpBRGxFq766QlATsqqQ7gfeG/
	 CyVy61YK7pXD8yyemErF1JMSi6Y65GveBsY/LIRyNIk9bkRfEAGOqKzM5Ae/rX+mnhOcb
	 44qGRlVn/vqxnIdbdJUVeRLCtBoU9N11nuY7oDpIYchADMC+LLwpDHKyJuIPbPSjHJ1hD
	 SlhneUwCTb0eswkWq77w6M+ndSlvup5RVQKQtIu7jcpZrgIfyHU6nmEqqTpaBQ76+8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZ2HI57J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C1606A31C
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 08:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZ2HI57J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB371F00A05;
	Wed, 11 Nov 2026 08:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794386368;
	bh=ZnLdybdYEPaJGP7kHfFmC0d0eZzo8Oz12yT1Bs2/f/c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QZ2HI57JOrGJ6del7ZfFiM4JtS01pkCEHPwoXuKQrrDWJM5gifBJ+tNfd6Q6Tzjqv
	 mIe21WWcglXqFLE7EnAIWTyZ5GNwtV4CJ0uSNRWgKk+StWHPATs0hBsrNRNxzGwKQl
	 dR3xMIsNq1WeaJnKT2MH8s7cfErt7jqVqJTqib/H3E9j1dTTUssf4T4M8rJc7r+I5i
	 fsYeK1rITR+DTSBlctiefY79XZP9f/k8Htw7lyPT/micN+CtHj/M3rLAnXmtsF35XS
	 3PQ52xepkwsdnwO9C4wcBS+xZK0zUhxMhbwGIdaa8DZmX/TVgNFdhsFWR3wJYmIBWc
	 XAFOPHSrnaRUg==
Message-ID: <sashiko-outbox-208625@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/33] HID: logitech-hidpp: expose charge_type
 property for battery voltage feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
In-Reply-To: <20261110-hid-logitech-hidpp-v2-14-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
 <20261110-hid-logitech-hidpp-v2-14-30743e91d83b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:39:27 +0000
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
- [Medium] HID: logitech-hidpp: wrong charge_type in
  hidpp20_battery_map_status_voltage()
--

commit 17c7938d8f03bfe4c24215899bd92a24290ce9f0
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

HID: logitech-hidpp: expose charge_type property for battery voltage feature

This commit registers POWER_SUPPLY_PROP_CHARGE_TYPE in
hidpp_initialize_battery() for devices with the 0x1001 battery voltage
feature and checks level and charge_type for changes in
hidpp20_battery_voltage_event().

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index cdeb1b3c2f219..fb9ad4cfc5832 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
[ ... ]
> @@ -4416,6 +4420,10 @@ static int hidpp_initialize_battery(struct hidpp_d=
evice *hidpp)
>  		battery_props[num_battery_props++] =3D
>  			POWER_SUPPLY_PROP_VOLTAGE_NOW;
> =20
> +	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
> +		battery_props[num_battery_props++] =3D
> +				POWER_SUPPLY_PROP_CHARGE_TYPE;

[Severity: Medium]
Does exposing POWER_SUPPLY_PROP_CHARGE_TYPE here cause sysfs to report an
active charging rate even when the device is unplugged and discharging?

hidpp20_battery_map_status_voltage() unconditionally sets *charge_type to
POWER_SUPPLY_CHARGE_TYPE_STANDARD (or FAST / TRICKLE if bits 3 or 4 are
set) regardless of whether external power (flags & 0x80) is present or
status is POWER_SUPPLY_STATUS_CHARGING:

drivers/hid/hid-logitech-hidpp.c:hidpp20_battery_map_status_voltage() {
    ...
	} else
		status =3D POWER_SUPPLY_STATUS_DISCHARGING;

	*charge_type =3D POWER_SUPPLY_CHARGE_TYPE_STANDARD;
	if (test_bit(3, &flags)) {
		*charge_type =3D POWER_SUPPLY_CHARGE_TYPE_FAST;
	}
	if (test_bit(4, &flags)) {
		*charge_type =3D POWER_SUPPLY_CHARGE_TYPE_TRICKLE;
	}
    ...
}

When a device operates wirelessly on battery power, is full, or is not
charging, reading charge_type from sysfs returns Standard (or Fast/Trickle)
instead of N/A (POWER_SUPPLY_CHARGE_TYPE_NONE).  Also, when a wireless
device disconnects, hidpp_connect_event() resets online, status, and level
to unknown, but leaves hidpp->battery.charge_type at its previous active
value instead of POWER_SUPPLY_CHARGE_TYPE_UNKNOWN.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-hid-logite=
ch-hidpp-v2-0-30743e91d83b@gmail.com?part=3D14
