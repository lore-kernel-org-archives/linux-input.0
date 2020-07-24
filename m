Return-Path: <SRS0=Cf0f=BD=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A251C433DF
	for <linux-input@archiver.kernel.org>; Fri, 24 Jul 2020 08:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C072053B
	for <linux-input@archiver.kernel.org>; Fri, 24 Jul 2020 08:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGXIk2 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:40:28 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37376 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgGXIk2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Jul 2020 04:40:28 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9BB161C0BD7; Fri, 24 Jul 2020 10:40:26 +0200 (CEST)
Date:   Fri, 24 Jul 2020 10:40:25 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     dmitry.torokhov@gmail.com, corbet@lwn.net,
        linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: [PATCH] Input: fix typo in function name documentation
Message-ID: <20200724084025.GB31930@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix non-existing constant in documentation.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/Documentation/input/uinput.rst b/Documentation/input/uinput.rst
index b8e90b6a126c..10c62e62a0a6 100644
--- a/Documentation/input/uinput.rst
+++ b/Documentation/input/uinput.rst
@@ -99,7 +99,7 @@ the sake of simplicity.
=20
       /*
        * Give userspace some time to read the events before we destroy the
-       * device with UI_DEV_DESTOY.
+       * device with UI_DEV_DESTROY.
        */
       sleep(1);
=20
@@ -164,7 +164,7 @@ mouse.
=20
       /*
        * Give userspace some time to read the events before we destroy the
-       * device with UI_DEV_DESTOY.
+       * device with UI_DEV_DESTROY.
        */
       sleep(1);
=20
@@ -233,7 +233,7 @@ but interact with uinput via ioctl calls, or use libevd=
ev.
=20
       /*
        * Give userspace some time to read the events before we destroy the
-       * device with UI_DEV_DESTOY.
+       * device with UI_DEV_DESTROY.
        */
       sleep(1);
=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8annkACgkQMOfwapXb+vKE0ACgrmVjmgkfwf/Bsou77RWZSpSq
ZD4AnAo1MRXrFQwA1dmO4MjoZar8aG4q
=m7Ea
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
