Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A098647A88E
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151904; cv=none; b=o9n00lSjKPndV0bJTOF31fWR75JbZVOdoR+XKi/1ZOh7qlUb4+j0Xu/HWa5Ir2zKZ8Ld4eWtfCRrlZyUpkAjUH8dhVJU0Ytjewa8yaR9cIqOfrx9ukyEEe6fzn55bxheaQ2soJ4sxqJIpAvcSvnB3P+gg//NYhRRTJchyw2I6+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151904; c=relaxed/simple;
	bh=J/OHTk14Y0Zx/HAH5UQ6WqmuPKU5YlqcMDf8XOplA+g=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=uIIa/qDTECw66q1sOQMLTdLZfJsnPqqwvmvsHrddegLY7kJn+l0U9zeM2swav6rzAh3QOcEOVLZIK99oFMqYIB+s7ENUHgdgDSHrdm6qQI908tF+5Ke7pimcxUL4Ky9viVVMh8hU8Y/dfNvA0/+B+ynr51riiZ36dAJm21QGJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvNJ+ZsJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvNJ+ZsJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEB91F000C4;
	Fri, 16 Oct 2026 11:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792151903;
	bh=+kyATIk6rh3joVhRIGkdnywOLOsKkg1A6IlcbrsTLmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XvNJ+ZsJwBbDGxhzgUZbvXtj2DWPv54XOxupSetOC3HHoDWHKJxcTLVITqzlvzLeA
	 lTEQF/BVmvFwLL3X8aQI6SOZL1LegfYJU+mHjIXwSG00pIcJZSyyA8sIHfGckkZ4iJ
	 8oOAJtrYDfO3NgQbyt0Z+/lMQfv1OqLFYZZ1cDzEozTFNxDn+NRrma6BcSKbcIF9TL
	 1RfS6YsYNWiQdgTd3L0w76EBaXhmnQB2IWvxvjOMxJxd1cj7uuWq8x++2/Hjtj5kg2
	 T7t8wf3pJF/NsRVoMFzS97EnRDjdKUX8GEVGchMtZt1TFsKrREvxN7T4ma4yEyt79p
	 SeCe5psgTGXCw==
Message-ID: <sashiko-outbox-174261@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] HID: logitech-headset: add a battery driver for the
 PRO X 2
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TcOpdmVuIENhcg==?= <meven29@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261016114757.1099300-1-meven@kde.org>
References: <20261016114757.1099300-1-meven@kde.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 11:58:22 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] kconfig: unmet direct dependency on USB_HID for HID_LOGITECH_HEADSET
--

commit d9d20c74276791f547d49f85750e9fd359bb8c0c
Author: M=C3=A9ven Car <meven29@gmail.com>
Subject: HID: logitech-headset: add a battery driver for the PRO X 2

The PRO X 2 LIGHTSPEED receiver does not speak HID++, so
hid-logitech-hidpp cannot read its battery. Its report descriptor has a
consumer collection for the media keys and two vendor collections, and
no report 0x10 or 0x11.

> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 0e3a0ccd6901e..60f579be1da69 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -680,6 +680,7 @@ config HID_LOGITECH_DJ
>  	depends on HIDRAW
>  	depends on HID_LOGITECH
>  	select HID_LOGITECH_HIDPP
> +	select HID_LOGITECH_HEADSET
>  	help
>  	Say Y if you want support for Logitech receivers and devices.
>  	Logitech receivers are capable of pairing multiple Logitech compliant

[ ... ]

> @@ -687,6 +688,18 @@ config HID_LOGITECH_DJ
>  	generic USB_HID driver and all incoming events will be multiplexed
>  	into a single mouse and a single keyboard device.
> =20
> +config HID_LOGITECH_HEADSET
> +	tristate
> +	depends on USB_HID
> +	select POWER_SUPPLY
> +	help

[Severity: Low]
Could this select statement in HID_LOGITECH_DJ cause an unmet direct depend=
ency
warning?

HID_LOGITECH_DJ unconditionally selects HID_LOGITECH_HEADSET, but
HID_LOGITECH_HEADSET specifies a direct dependency on USB_HID.=20

Because Kconfig's select directive forces the symbol on without evaluating =
its
dependencies, enabling HID_LOGITECH_DJ in a configuration lacking USB_HID w=
ill
produce an 'unmet direct dependencies' build warning.

Should HID_LOGITECH_DJ inherit the dependency on USB_HID, or should the sel=
ect
be conditional?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016114757.1099=
300-1-meven@kde.org?part=3D1
