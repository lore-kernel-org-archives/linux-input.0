Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05084C433E9
	for <linux-input@archiver.kernel.org>; Wed, 17 Feb 2021 17:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D545A64E45
	for <linux-input@archiver.kernel.org>; Wed, 17 Feb 2021 17:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhBQRcz (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 17 Feb 2021 12:32:55 -0500
Received: from [139.28.40.42] ([139.28.40.42]:46876 "EHLO
        tarta.nabijaczleweli.xyz" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S234199AbhBQRcq (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 Feb 2021 12:32:46 -0500
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id CCF3C360145;
        Wed, 17 Feb 2021 18:22:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=nabijaczleweli.xyz;
        s=202006; t=1613582558;
        bh=b15Rm9F+Q8HK8S3bxl9+1GFx0SJ2qQ2WbsdlEjo8Ln8=;
        h=Date:From:Cc:Subject:References:In-Reply-To:From;
        b=jgvYsIZSqzKYyyroDahGpmA2ElYaCk8ow6rxR3yV5q7Rdhl4LNha7tsYcsSzx5Do1
         FLdHtMIm02myizRYwHm2CSMPHzzLsX0Vgy1WpvuMGG142kV19FfuNW5d56xhBkzBPu
         lLvxqalDuZGEtaOV22JOLM5r7WtEOP5HycbVhrJ3nZtdef/vJJfyCgax4MnRV4k4+d
         qRwMdpteJn+fDQgNaRkJdkGACLVF48TDpJUolzgvy5gIPTq2nNkY/lbvODupZJRWmQ
         bi0bGMSzK3e3WYdU89Ix2oqiVjhLHzMJ3RP16egIUBEnWAhqSW6kkbyeBm37+bgVCY
         NZ65WnZUlk5CA==
Date:   Wed, 17 Feb 2021 18:22:37 +0100
From:   Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] HID: multitouch: set Stylus suffix for
 Stylus-application devices, too
Message-ID: <b36ae565d481ca9f57a2b2e1832abd99c7da2031.1613582014.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1613582014.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ocw7ij72o57mqf5q"
Content-Disposition: inline
In-Reply-To: <cover.1613582014.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: NeoMutt/20210205
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


--ocw7ij72o57mqf5q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This re-adds the suffix to Win8 stylus-on-touchscreen devices,
now that they aren't erroneously marked as MT

Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
 drivers/hid/hid-multitouch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 8580ace596c2..e5a3704b9fe8 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1580,13 +1580,13 @@ static int mt_input_configured(struct hid_device *h=
dev, struct hid_input *hi)
 		/* we do not set suffix =3D "Touchscreen" */
 		hi->input->name =3D hdev->name;
 		break;
-	case HID_DG_STYLUS:
-		/* force BTN_STYLUS to allow tablet matching in udev */
-		__set_bit(BTN_STYLUS, hi->input->keybit);
-		break;
 	case HID_VD_ASUS_CUSTOM_MEDIA_KEYS:
 		suffix =3D "Custom Media Keys";
 		break;
+	case HID_DG_STYLUS:
+		/* force BTN_STYLUS to allow tablet matching in udev */
+		__set_bit(BTN_STYLUS, hi->input->keybit);
+		fallthrough;
 	case HID_DG_PEN:
 		suffix =3D "Stylus";
 		break;
--=20
2.20.1


--ocw7ij72o57mqf5q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmAtUN0ACgkQvP0LAY0m
WPGdtw//eA+19oRYkCnBKkpW/XJgXJW9gxaTXW0e6Aotrfc4IJJb8KO1t+7sBERJ
+5+9f7ZwvGGYDQ4zBPa578BcYOQpx/pUEZNL194OoBA3AN8GZpwi+Sc7ThDNW6Ox
EYptJolBaodY6Ek/PzupT2QJco5f0eHBXVCD498A/GsswkXwvgThghDR1vQLM1Ym
E0O2W/ULwBtBKVdXExEkCETZBQrATLNxCW23cStZ1Ts0zqe3axpxSS4TMSBkRzDs
6tUUHTg6D1I4UqmoaOPSOF6wAX/WbS+MYxj4P1XjmEVVJ84by13cqYudpgmhqbQ5
cF846MzLXtAjIjdQDombsJQqVr8ZMlB8luVj5mOnaF3zCePRdjgFSspijPm7RF0G
xJF+6yktDXOfGU10T3mefg1o6K5e8hJ7McbCAUXlBDOcOwauC+jXSWlqbTqTddUR
XNlJY57j/EK7nmKUeCwsjb5PJrfswAaaLPeyYyX9Tz9676UcXgsYq2YEsQGjB+5y
ghxARR01hEbb0d4tWfXXhPntfUrbIXWT3QRJB8Wfs+bODPAuh7xkt0FTwzjtKRf0
MN1QAsuwEu3NpblHY4EkCGyWw6iYzM9edzPlKPyvZ+xVmxYWsOpY1RG6bmO/0hAF
npFdV7mt0zFouc7NBedGz4zTjblHfebvsr/K8uN0qNu7yAPBHnQ=
=2bcP
-----END PGP SIGNATURE-----

--ocw7ij72o57mqf5q--
