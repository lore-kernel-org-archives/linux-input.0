From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: [PATCHv2 2/3] HID: hid-lg4ff: Fix sysfs vs memory deallocation race condition
Date: Wed, 14 Mar 2012 18:32:24 +0100
Message-ID: <1838680.SEvr9qg2Jd@qosmio-x300>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1391554.oa4q73SzCb"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37900 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761302Ab2CNRc2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Mar 2012 13:32:28 -0400
Received: by bkcik5 with SMTP id ik5so1489217bkc.19
        for <linux-input@vger.kernel.org>; Wed, 14 Mar 2012 10:32:26 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, simon@mungewell.org


--nextPart1391554.oa4q73SzCb
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

The device specific data stored in the linked list were removed before =
the sysfs attrs were
properly removed. This patch corrects this issue

Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>

>From 267123534c3605011cebde0244e384de210cf901 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Michal=3D20Mal=3DC3=3DBD?=3D <madcatxster@gmail.com>
Date: Wed, 14 Mar 2012 18:15:37 +0100
Subject: [PATCH 2/2] HID: lg4ff: Remove the sysfs interface before
 deallocating memory

---
 drivers/hid/hid-lg4ff.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 6ecc9e2..f70ae41 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -466,6 +466,9 @@ int lg4ff_deinit(struct hid_device *hid)
 =09bool found =3D 0;
 =09struct lg4ff_device_entry *entry;
 =09struct list_head *h, *g;
+=09
+=09device_remove_file(&hid->dev, &dev_attr_range);
+
 =09list_for_each_safe(h, g, &device_list.list) {
 =09=09entry =3D list_entry(h, struct lg4ff_device_entry, list);
 =09=09if (strcmp(entry->device_id, (&hid->dev)->kobj.name) =3D=3D 0) {=

@@ -478,11 +481,10 @@ int lg4ff_deinit(struct hid_device *hid)
 =09}
=20
 =09if (!found) {
-=09=09dbg_hid("Device entry not found!\n");
+=09=09dbg_err("Device entry not found!\n");
 =09=09return -1;
 =09}
=20
-=09device_remove_file(&hid->dev, &dev_attr_range);
 =09dbg_hid("Device successfully unregistered\n");
 =09return 0;
 }
--=20
1.7.9.4


--nextPart1391554.oa4q73SzCb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAABAgAGBQJPYNYoAAoJEERrVaOJCK16+ggH/1m/zzMeGzYzZFZRC3DjQk2v
rfilMDedxzvskEEcXywTfmVMzMgWMPgALALFknTqZyxVjS8xFrRZvoHAQo7KXt9x
VBq7kHVvsFZkrplAZps/bk4o4p4z4h6enowXmeSE4z8Kg+PLl5kogr9SDjzwC2Dv
Mj8jOX7GLwAeSmhxnqfXsGAFWhYA77zsyNNV1fxPPuPNgfuwYfHB9azR89vlowMG
3SKkfFVKySozaAriPF7yII95vL/zqgk0JP1t7ebcSrip6bXH+1HUCqNXgOFS4TzQ
f0xFv33/UF1XigGUbA/U6Mxx7yRUhkYVEP+ZbuPCbyiMwLiUSW8QDgJ+FSLXr5c=
=Utn+
-----END PGP SIGNATURE-----

--nextPart1391554.oa4q73SzCb--

