Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385369;
	b=uX49tH7iCo7y8dJynfDNtSXJL824IN7f+eVm5d4KyePweEGSs7w6E664go3iEfgEPogb
	 en+ATpvzje4gvvhV7DSTXtoZiKgq0efiHIlzA/n81REEOE04e53FV8QcqqaYKtd3g49cF
	 9mqmqA8ZEi8PAR6z+DLx7ltq1pGQyl6sTRhM+nz1pAdhEEIQFnqwH+ePVcSsSJdW6Ho1K
	 4bXIuzRBa5Idb+FkHEElIn2PUfrnCLm+p/3FhuJHGaz+ZlSt+KO2KyPfFQ37vs5QvgeVC
	 pGMPcd6p6OmUXlbSc0VXzn5SnKbclXT0NTYpyxXseISANnr7OBOHOeYJK2QyfL6ZZxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385369;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZsJpIKQTB4bE4FVcTJDVCLkgvRJ1S+zErpW4oZinJCc=;
	b=GkvhxPrBNngSSBlM+n6ptJPNyrPcbzrW4nqvv5/vxSu/sDn5lsP0W2qUfygC+AU6gUla
	 NthMNAsL+TbPwkEitVNUfR3PbKqvocIpuJPBt3JHLm3qwDjDMrli3AL/ieJ9fcYwKM7E3
	 KbCf1Jyn5Uc06+MJ5LQmC9mxW+JVLxqOfnaEE93v5wHd3WaJ35HR61Xbdv4G8Z8B/nwHu
	 xN8YY4Qcd1UuCPBaUbw0VTpowbW8c8NUHbqaAbgNrqVb9+ko+yo3vJh/PHDRk4odot6ny
	 z3u4Z7dlfgKWqdBXGLmz5T89QRypzl1FUpAYPlN2DfY/yt9v3Su0VbEdnpBNsfJIf5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDuaax2s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE05860A2627
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QDuaax2s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A332C1F00A06;
	Wed, 11 Nov 2026 08:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794385368;
	bh=ZsJpIKQTB4bE4FVcTJDVCLkgvRJ1S+zErpW4oZinJCc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QDuaax2s1potX3lHev520cmj6wAW/LSVtLrTxIZloV00vpQAlgrimjRqjPsEKz7Gk
	 h+p6B+Xxy3Kn+Ps+0ddugtSLJ2VgY/F1vp9pimhQ1m2IViUSVSHHK4g/rxM82s8/oO
	 fXW9v13MdYpn5TrBBhi3VzV8o78IOdFHh1HCz9OdlI+OVBY/idPlIJihCsdFLSqWfY
	 4xP9r3UXnOdqJQaauG/Q9utU9WAwQzj+JKPGQufcyYnla49AlS9LED2neMiIsYmuHD
	 zdIXJm5W/lqnqxzrdXoLYn3aEBxMDZizaQ1+Le0uYCBG1hX/YiDuUQHX8sxZoq5Na1
	 2VNITih0pQz3Q==
Message-ID: <sashiko-outbox-208598@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/33] HID: logitech-hidpp: mark device online on
 unified battery 0x1004 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
In-Reply-To: <20261110-hid-logitech-hidpp-v2-12-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
 <20261110-hid-logitech-hidpp-v2-12-30743e91d83b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 08:22:48 +0000
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
- [High] HID: logitech-hidpp: 0x1000/0x1004 collision in
  hidpp20_battery_event_1004()
--

commit ac0aae22ff219439085bc6982cf3dda4b4fdc13a
Author: Dmitry Torokhov <dmitry.torokhov@gmail.com>

HID: logitech-hidpp: mark device online on unified battery 0x1004 events

This commit marks hidpp->battery.online as true and includes
!hidpp->battery.online in the changed check when handling unified battery
status events in hidpp20_battery_event_1004().

> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-=
hidpp.c
> index 28402baf04fb6..f717f03084548 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -1761,12 +1761,15 @@ static int hidpp20_battery_event_1004(struct hidp=
p_device *hidpp,
>  	status =3D hidpp20_unifiedbattery_map_status(hidpp, params[2], params[3=
]);
>  	level =3D hidpp20_unifiedbattery_map_level(hidpp, params[1]);
> =20
> -	changed =3D status !=3D hidpp->battery.status ||
> +	changed =3D !hidpp->battery.online ||
> +		  status !=3D hidpp->battery.status ||
>  		  (state_of_charge !=3D hidpp->battery.capacity &&
>  		   hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_PERCENTAGE) ||
>  		  (level !=3D hidpp->battery.level &&
>  		   hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS);
> =20
> +	hidpp->battery.online =3D true;
> +
>  	if (changed) {
>  		hidpp->battery.capacity =3D state_of_charge;
>  		hidpp->battery.status =3D status;

[Severity: High]
Does this cause a regression on feature 0x1000 devices by overwriting
hidpp->battery when a charging event arrives, and corrupt 0x1004 events by
running hidpp20_battery_event_1000() first?

Both feature 0x1000 and feature 0x1004 store their index in
hidpp->battery.feature_index and use event ID 0x00, and
hidpp_raw_hidpp_event() calls both handlers unconditionally:

drivers/hid/hid-logitech-hidpp.c:hidpp_raw_hidpp_event() {
	...
	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_BATTERY) {
		ret =3D hidpp20_battery_event_1000(hidpp, data, size);
		if (ret !=3D 0)
			return ret;
		ret =3D hidpp20_battery_event_1004(hidpp, data, size);
		if (ret !=3D 0)
			return ret;
	...
}

On a 0x1000 device, a charging report sets hidpp->battery.online to false
in hidpp20_battery_event_1000() and returns 0.  With this change,
hidpp20_battery_event_1004() then sees !hidpp->battery.online, forces
changed to true, sets hidpp->battery.online back to true, and overwrites
capacity, status, and level using 0x1004 decoding, which also prevents the
0 to 1 online transition needed to schedule reset_hi_res_work when the
charging cable is unplugged.

Conversely, on a 0x1004 device, hidpp20_battery_event_1000() runs first on
every 0x1004 event and mutates hidpp->battery.online before
hidpp20_battery_event_1004() checks !hidpp->battery.online, setting online
to false on every charging event and true on discharging or full reconnect
events.

Gating hidpp20_battery_event_1000() and hidpp20_battery_event_1004() on
HIDPP_CAPABILITY_UNIFIED_BATTERY would avoid both handlers matching the
same event.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-hid-logite=
ch-hidpp-v2-0-30743e91d83b@gmail.com?part=3D12
