From: Ben Gamari <ben@smart-cactus.org>
Subject: RE: Dell Latitude E7470 touchpad status
Date: Tue, 17 May 2016 08:03:45 +0200
Message-ID: <87bn45gr0e.fsf@smart-cactus.org>
References: <87eg9j6zf7.fsf@smart-cactus.org> <23E0F704395E694FA4710C833FA087E50D40B8BF13@TPEX7ADC101.APAC.DELL.COM>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:55993 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753752AbcEQGDx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2016 02:03:53 -0400
In-Reply-To: <23E0F704395E694FA4710C833FA087E50D40B8BF13@TPEX7ADC101.APAC.DELL.COM>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Allen_Hung@Dell.com, Mario_Limonciello@Dell.com
Cc: linux-input@vger.kernel.org

--=-=-=
Content-Type: text/plain

Allen_Hung@Dell.com writes:

> Dell - Internal Use - Confidential
> Hi Ben,
>
> We have just confirmed the touchpad on Latitude E7470 is a PS/2
> device, not an I2C-HID input device. The code you listed is common
> among many Dell products and the value of SDS0 should be provided
> somewhere (I can't find it out) to specify a PS/2 device.
>
Thanks Allen,

I rather suspected this; I suppose it's probably hard to find I2C-HID
hardware that integrates a touchstick. This explains why SDS0 is 0 on my
hardware.

In this case I suppose this is yet another Alps device? I've tried
bringing it up with all of the recent Alps protocols supported by the
alps.ko driver but sadly nothing seems to emit multitouch events, so
it seems likely that there is yet another protocol variant waiting to be
implemented. Is there any chance you could see whether Alps might now be
more willing to provide protocol documentation? If not, perhaps there's
a Linux binary driver available?

Cheers,

- Ben

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXOrRCAAoJEHPt6ejPuu8BqZMIAK7X3YIfQYWyACurpfjWugXu
dYez9MuSkGEv299aIKpOmMxR+koU9d3ch9QGCXrlnSAc1Vgu89FcikMtBfklEhUw
rCvpKTgFJY8iUsGE958iSM34FtFq/im6nCRdsHe25BGsxDHQha0QmLqmUyvoWjzf
N+8lKwSLg1ztQ6aRFX+diQ6FQIt1ghEJtZ9AC3QKwCcyF1BviIQveaQAVC5105vR
+LiyY4eggY6N2o8v5ylAUd8Eutg0HaPkqxTksHyRCfX4BgTM3ABIRwsdWjd0fl0+
BlN9UTO+vBm7/+bGz+3mn1y7mq250TqiGz6hTzZGuTAbvEFXtjKOkX+Y6TSKpEU=
=knxT
-----END PGP SIGNATURE-----
--=-=-=--
