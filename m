From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Subject: RFC: making the aiptek.c tablet driver xf86-input-wacom compatible
Date: Wed, 26 Jun 2013 00:02:36 +0200
Message-ID: <1448859.K0oxtlBRpL@pebbles>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-out-1.rwth-aachen.de ([134.130.5.186]:54284 "EHLO
	mx-out-1.rwth-aachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab3FYWM0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jun 2013 18:12:26 -0400
Received: from pebbles.localnet ([unknown] [78.49.40.240])
 by relay-auth-2.ms.rz.rwth-aachen.de
 (Sun Java(tm) System Messaging Server 7.0-3.01 64bit (built Dec  9 2008))
 with ESMTPA id <0MOY002M5YKDSP90@relay-auth-2.ms.rz.rwth-aachen.de> for
 linux-input@vger.kernel.org; Wed, 26 Jun 2013 00:02:37 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi everyone,

I have started to modify the aiptek tablet driver to be compatible with=
 the=20
xf86-input-wacom driver.

Motivation:
=46irst, as wacom dominates the market, most configuration frontends ar=
e for=20
wacom, desktop integration only exists for wacom, and most application=20
developers only test with wacom tablets.
Second, the xf86-input-aiptek driver seems to be unmaintained, at least=
=20
opensuse has dropped it from distribution, and xf86-input-evdev is no=20
sufficient replacement.

So for me there are two possibilities, either replicating all the work =
done=20
for the wacom driver in the xorg stack and above, or just making the th=
e=20
aiptek driver mimic the output of the wacom kernel driver - I have take=
n the=20
second option.

Currently, I am cleaning up my changes, and I am investigating some bug=
s in=20
the original driver parsing the reports from the device.

I have tested my Aiptek 6000U with the xf86-input-wacom driver, and it =
is=20
working fine in Krita, Inkscape and The Gimp, configuring the tablet vi=
a
kcm_wacomtablet (KDE configuration module).

If anyone is interested, I will send my patches to this list after the=20
cleanup.

Regards,

Stefan


--=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
phone: +49 241 53809034     mobile: +49 151 50412019
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
