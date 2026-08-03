Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C137B30E85B
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 02:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785722476; cv=none; b=ordaMpbTwxuBF7WO0w7ts1tR9bTlvJbPD2ZOfiU6iayzKs94cPFsl/FzQRwaKIWenVHzAX2BT+EpO+F4+4liH0TjJX6ip8U9FC9MP9dMG6uQ4JPMb1OYTwRUbsR0fWF+MzetOh7+ToCd815RQe3YCKPzK2NFD1IR43LRRbeHvNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785722476; c=relaxed/simple;
	bh=b/wpOMmsvZ4RBH35wrpLR40MOiTJagehCvcfAobkic4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S+uOgMzrygXvAfOA4uao/Lcg2KP8GCF4JUFI5XvhDdPlAKxYV2p72Goow/nfC1R3chSXly9jRZ3bwesoF3cgEPo40m8vd6LNMzW0zKl3GW9osF3Fcam6Y3CioBldizWt4WwyN8NIf4+0B6fLoBN4Oc1xLpbuwwoRvF+se3pKaVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wui/0IrA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wui/0IrA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53A771F000E9;
	Mon,  3 Aug 2026 02:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785722474;
	bh=FfwE2bT5zgV/HImlSCZiwhpU/gSzc/xDVjDYOS1RVlo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wui/0IrA2QqDTGFWC+lAsSGWztKRKwAqzQnncJfOTIYWI0MSH9v+oJcw2+eu18/HW
	 Ts7RBm4fnvbgxxT4oX7blahsde2jj2O4sG2PbhgmzWsUkF054/vn5jGUnrWYTtI6Iz
	 uuRfQhMxKTiM+MDdo5imYXNospLhhz/VJV+9xrr+34urhierFrqUXy8CpKstMAT3S6
	 bESwnW7fMrevZFM4UUqoCIIJuQ/vS/Z1bjPu5AGAmDdzkMawonHAJxbZrReO3jtBkw
	 4lUfK7COnlRV2WlIEuUkeASOT25+LenaB+G2Z4zA5SNCl+5DUOJ6tRfp8/SQa0dh38
	 NjaAcwntO5cEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: xpad - add Voyetra Turtle Beach PC Rematch
 Gamepad
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dongxu Su" <hj117@sz-huijia.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <178572174191.26980.4407731925140715976@sz-huijia.com>
References: <178572174191.26980.4407731925140715976@sz-huijia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 02:01:13 +0000
Message-Id: <20260803020114.53A771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The PC Rematch Gamepad (Wireless) (PID 0x6014) is incorrectly as=
signed `XTYPE_XBOX360W` instead of `XTYPE_XBOX360`, which will likely preve=
nt the device from functioning.
- [Low] The new device entries in `xpad_device[]` violate the explicit sort=
ing requirements of the array.
--

--- Patch [1]: [PATCH v2] Input: xpad - add Voyetra Turtle Beach PC Rematch=
 Gamepad ---
commit 4317954c8794979c77f86d1618e25d242148ef54
Author: Dongxu Su <hj117@sz-huijia.com>

Input: xpad - add Voyetra Turtle Beach PC Rematch Gamepad

This commit adds support for the Voyetra Turtle Beach PC Rematch Gamepad,
a triple-mode (wired, 2.4G wireless, Bluetooth) PC game controller. It
adds four new product IDs to the xpad_device array and adds the vendor
to the XInput whitelist.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..7f593fc6ebdff 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -267,6 +267,10 @@ static const struct xpad_device {
>  	{ 0x1038, 0x1431, "SteelSeries Stratus Duo", 0, XTYPE_XBOX360 },
>  	{ 0x10f5, 0x7005, "Turtle Beach Recon Controller", 0, XTYPE_XBOXONE },
>  	{ 0x10f5, 0x7008, "Turtle Beach Recon Controller", MAP_SHARE_BUTTON, XT=
YPE_XBOXONE },
> +	{ 0x10f5, 0x6013, "PC Rematch Gamepad", 0, XTYPE_XBOX360 },

[Severity: Low]
This isn't a bug, but the xpad_device array requires sorting by vendor ID
and product ID. Should the new 0x60xx entries be placed before the 0x70xx
entries for vendor 0x10f5?

> +	{ 0x10f5, 0x6014, "PC Rematch Gamepad (Wireless)", 0, XTYPE_XBOX360W },

[Severity: Medium]
Does this 2.4G wireless dongle actually use the proprietary Microsoft
multi-controller receiver format (Protocol 129)?

Typically, standard 3rd-party 2.4G dongles act transparently as wired XInput
controllers (Protocol 1). If this dongle sends standard packets (e.g.,
data[1] =3D=3D 0x14) rather than the legacy receiver format, assigning
XTYPE_XBOX360W will route it to xpad360w_process_packet() where the packets
will be silently discarded because they fail the multi-controller handshake
checks (such as data[1] !=3D 0x01).

Should this be assigned XTYPE_XBOX360 instead?

> +	{ 0x10f5, 0x6015, "PC Rematch Gamepad", 0, XTYPE_XBOXONE },
> +	{ 0x10f5, 0x6016, "PC Rematch Gamepad (Wireless)", 0, XTYPE_XBOXONE },
>  	{ 0x10f5, 0x7073, "Turtle Beach Stealth Ultra Controller", MAP_SHARE_BU=
TTON, XTYPE_XBOXONE },

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178572174191.26980.=
4407731925140715976@sz-huijia.com?part=3D1
