From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: [Patch 0/3] Some updates to the edt-ft5x06 driver...
Date: Thu, 05 Oct 2017 17:31:41 +0200
Message-ID: <1507217501.7345.9.camel@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-n1Cv001PmeCfsTvp02xb"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([188.40.83.200]:54616 "EHLO
        mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbdJEPbt (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Oct 2017 11:31:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>
Cc: "dmitry.torokhov" <dmitry.torokhov@gmail.com>


--=-n1Cv001PmeCfsTvp02xb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all.

I have a bunch of fixes/changes/extensions for the edt-ft5x06 driver.
Some of them are rotting for quite some while in my repository, sorry
for not sending them earlier.

0001-edt-ft5x06-fix-reset-pin-behaviour.patch:
This is a fix for a bug that creeped in at some point. The reset pin
actually needs toggling for a real reset....

0002-input-edt-ft5x06-make-distinction-between-m06-m09-ge.patch
This is a rework of the code, introducing the concept of a "generic"
focaltec based touchscreen. There are other manufacturers out there which
use the same chipset and actually work quite well with the driver.

0003-input-edt-ft5x06-implement-support-for-the-EDT-M12-s.patch
This is an extension for the EDT M12 series of touchscreens.

I hope this helps,
       Simon
--=20
     kernel concepts GmbH                 Simon Budig
     Sieghuetter Hauptweg 48              simon.budig@kernelconcepts.de
     D-57072 Siegen                       +49-271-771091-17
     http://www.kernelconcepts.de/
     HR Siegen, HR B 9613; Gesch=C3=A4ftsf=C3=BChrer: Ole Reinhardt
--=-n1Cv001PmeCfsTvp02xb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQTPAwhwx6BA+WIUvUM7Y79Fd6yIcAUCWdZQXQAKCRA7Y79Fd6yI
cDDLAKCbtn0xc2yjIFA7KMaiep5DEPd2JwCeIXZ0KiCw4dKw4yJRa7Mu6WymtgY=
=V0VG
-----END PGP SIGNATURE-----

--=-n1Cv001PmeCfsTvp02xb--

