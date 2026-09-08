Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B83E33469C
	for <linux-input@vger.kernel.org>; Tue,  8 Sep 2026 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788838516; cv=none; b=RaGO+azEUCSONaEop0aHK8FBYKZVOS7F18JCcVf9QQP3xNPDZM6MuqDsYq0622pkGmjnvQB18UPubW1elY+Lq1AIPEy+uhzZ2rmX/GzTInMaKbpQi5A0fdvV6q9kyQNX2dRnp36hrOyqSpldTAxf86yDxdfjlrjie7g3AXODpSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788838516; c=relaxed/simple;
	bh=z+SX2OlTky5jn3cuGNHMxhimaDyG0PEPv63T8ltjt/o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PoKTwPNDjmS7kmZZ2UE41GkpL9OWFa5otXpv7iIH+R/wCsrNskJstcjC8pO1K4jcF1rUvEiFXX1Hzaa0/mKQOvTZiF+8cYpmODLci3yahcnoRVl6OltiWctndTJm4q2I8Atj6v5cACzr6NsSR3z0LL4us73xGKA97VlVHWq6LCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGeP2uTb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGeP2uTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F581F00A3A;
	Tue,  8 Sep 2026 03:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788838462;
	bh=sgNVSydwaVMjRLMn6WzOBEq0FmA3i80fBYMNe2ndXUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hGeP2uTbm0hqRms15CwPK+z+Uon/icHPGqFLuVwNYXQvlZd27g6BQWBdfRzRj/QPO
	 Q1IEaXilFfcCgQ12PDbfwuE0VZ/iBy9lfHGDPejGIrHX5zimmTSiN/rVaxAvaSX6d3
	 gO2tnwybBdYuQ+DwhNcYu8vbpINiax0Pa9NMHsHlbk7rXCptinyUtH4pFGAS5kv+Em
	 bsiqREug2GOhy6Cxfz75TKOvU9f9wKFZymzWs/yl0ZBM3zhHzmqdmTrumJXYc1SCSI
	 PWTCYpec6oEwoIRkHf3YBhFCvCAubjifWjuXsBTSayVVkWMK3mN69r1zKo2EpW9Rx8
	 HeBz2onwODO2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/12] Input: xpad - Remove Xbox One support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vicki Pfau" <vi@endrift.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260908032145.2118234-3-vi@endrift.com>
References: <20260908032145.2118234-1-vi@endrift.com>
 <20260908032145.2118234-3-vi@endrift.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 03:34:21 +0000
Message-Id: <20260908033422.11F581F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The `flags` field in `struct xpad_device` is now unused and should =
be removed.
- [Low] Documentation Typo: 'Protocl' instead of 'Protocol'.
--

commit 30879d88695dc1f5b4aa4e33ed67c80e554e4b56
Author: Vicki Pfau <vi@endrift.com>

Input: xpad - Remove Xbox One support

This commit removes Xbox One controller support from the xpad driver.
It notes that this functionality is fully superseded by the xbox_gip driver,
which specializes in the Xbox One Gaming Input Protocol.

> diff --git a/Documentation/input/devices/xpad.rst b/Documentation/input/d=
evices/xpad.rst
> index a480bc781565e..fd2afdd7b4059 100644
> --- a/Documentation/input/devices/xpad.rst
> +++ b/Documentation/input/devices/xpad.rst
> @@ -2,19 +2,19 @@
>  xpad - Linux USB driver for Xbox compatible controllers
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> =20
> -This driver exposes all first-party and third-party Xbox compatible
> -controllers. It has a long history and has enjoyed considerable usage
> -as Windows' xinput library caused most PC games to focus on Xbox
> -controller compatibility.
> +This driver exposes all first-party and third-party Xbox and Xbox 360
> +compatible controllers. It has a long history and has enjoyed considerab=
le
> +usage as Windows' xinput library caused most PC games to focus on Xbox
> +controller compatibility. Xbox One/Series controller support has been
> +superseded by the xbox_gip driver, which specializes in the Gaming Input
> +Protocl that is introduced on the Xbox One.

[Severity: Low]
This isn't a bug, but there's a typo in the documentation: Protocl instead =
of
Protocol.

> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..206007e0cafb6 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
[ ... ]
> @@ -2080,18 +1462,13 @@ static int xpad_probe(struct usb_interface *intf,=
 const struct usb_device_id *id
>  	xpad->mapping =3D xpad_device[i].mapping;
>  	xpad->xtype =3D xpad_device[i].xtype;
>  	xpad->name =3D xpad_device[i].name;
> -	if (xpad_device[i].flags & FLAG_DELAY_INIT)
> -		xpad->delay_init =3D true;
> =20
> -	xpad->packet_type =3D PKT_XB;
>  	INIT_WORK(&xpad->work, xpad_presence_work);

[Severity: Low]
Since the only flag (FLAG_DELAY_INIT) and its usage here in xpad_probe() ha=
ve
been removed, is it intended to leave the flags field inside the definition
of struct xpad_device?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908032145.2118=
234-1-vi@endrift.com?part=3D2
