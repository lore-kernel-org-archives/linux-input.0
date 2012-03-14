From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: [PATCHv2 3/3] Cleanup: Fix a compile error in hid-lg4ff and remove an extra include in hid-lg.h
Date: Wed, 14 Mar 2012 18:41:21 +0100
Message-ID: <13733668.ppBnC2kbu5@qosmio-x300>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3145231.20dBcFrnoH"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:36506 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760621Ab2CNRl0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Mar 2012 13:41:26 -0400
Received: by bkcik5 with SMTP id ik5so1496141bkc.19
        for <linux-input@vger.kernel.org>; Wed, 14 Mar 2012 10:41:25 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, simon@mungewell.org


--nextPart3145231.20dBcFrnoH
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

My mind was apparently wandering around a bit which lead to a compile e=
rror in hid-lg4ff.
I also forgot to remove the spinlock.h include from hid-lg.h I am sorry=
 about this mess...

Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>

>From 61bbb9d5be1d8957ad8c6b63a4a6b911cb8aa12e Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Michal=3D20Mal=3DC3=3DBD?=3D <madcatxster@gmail.com>
Date: Wed, 14 Mar 2012 18:34:33 +0100
Subject: [PATCH 3/3] HID: hid-lg4ff: Fix hid_err call, hid-lg: Remove a=

 superfluous include

---
 drivers/hid/hid-lg.h    |    2 --
 drivers/hid/hid-lg4ff.c |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/hid-lg.h b/drivers/hid/hid-lg.h
index 500457b..d64cf8d 100644
--- a/drivers/hid/hid-lg.h
+++ b/drivers/hid/hid-lg.h
@@ -1,8 +1,6 @@
 #ifndef __HID_LG_H
 #define __HID_LG_H
=20
-#include <linux/spinlock.h>
-
 struct lg_drv_data {
 =09unsigned long quirks;
 =09void *device_props;=09/* Device specific properties */
diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index f70ae41..1145292 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -481,7 +481,7 @@ int lg4ff_deinit(struct hid_device *hid)
 =09}
=20
 =09if (!found) {
-=09=09dbg_err("Device entry not found!\n");
+=09=09hid_err(hid, "Device entry not found!\n");
 =09=09return -1;
 =09}
=20
--=20
1.7.9.4



--nextPart3145231.20dBcFrnoH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAABAgAGBQJPYNhBAAoJEERrVaOJCK165MsH/jUWBBqaATP0mn0CHPjSptyL
LP44olyh2UK06OMSppjKZGlzz6O0l/Mf1IUeIQHlKMRrF8R4pOnDunViGv+A/uKu
wkdHEL98GNtKCDGsXAWmwCxvifwIptqk4HgUQu753xblbNeoITFooTqrdHE1NnBh
8dbSy8/7Xz7/TRIzoelYCWpd5ISl9EmewmvxosgDCNuNAdZCxcdtbeU31EvZP+NF
1mr3N1JmxlDpztNnZF4SgNC9AfDSKw/GMrTgv8n9XzsSC19eApzc9V03/4Qzj4kR
Y9qIEXAQy8/5fpXbai2TDtVJLLdk4CeJ7eUSA/MCcKJ4vsnOjvKDXIKrvIX+yZE=
=7x98
-----END PGP SIGNATURE-----

--nextPart3145231.20dBcFrnoH--

