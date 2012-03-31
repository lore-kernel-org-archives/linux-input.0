From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: [PATCH v4] HID: lg4ff: Remove sysfs iface before deallocating memory
Date: Sat, 31 Mar 2012 11:35:05 +0200
Message-ID: <2198552.DMoMTvshKQ@qosmio-x300>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3178980.T11KAyJOT4"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:59078 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755545Ab2CaJfT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Mar 2012 05:35:19 -0400
Received: by wibhr17 with SMTP id hr17so1258079wib.1
        for <linux-input@vger.kernel.org>; Sat, 31 Mar 2012 02:35:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, simon@mungewell.org


--nextPart3178980.T11KAyJOT4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

This patch fixes a possible race condition caused by the sysfs
interface being removed after the memory used by the interface
was already kfree'd.
Please note that this patch depends on "hid-lg: Allow for custom
device-specific properties to be stored in private drv data" because
it also fixes a tiny glitch - a leftover #include in the hid-lg.h

I have another lg4ff patch pending that makes use of the new possibilit=
y to
store device-specific data which is currently being review by Simon.
The patch as it is right now will depend on this patch.

Signed-off-by: Michal Mal=FD <madcatsxter@gmail.com>

---
 drivers/hid/hid-lg.h    |    2 --
 drivers/hid/hid-lg4ff.c |    6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

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
index 6ecc9e2..1145292 100644
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
+=09=09hid_err(hid, "Device entry not found!\n");
 =09=09return -1;
 =09}
=20
-=09device_remove_file(&hid->dev, &dev_attr_range);
 =09dbg_hid("Device successfully unregistered\n");
 =09return 0;
 }
--=20
1.7.9.5


--nextPart3178980.T11KAyJOT4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAABAgAGBQJPds/TAAoJEERrVaOJCK16sLQH/0MzCq2mh+CnBEM5QIGtWBLi
fzfh37s3tSo+nmFw1yiz/uDt+HeJ9M0OwLtlpEjGg5rjyIrokLIb8Y9ISPi+AdYp
tz6ym5tKUQh+bjEDpr2HOx2MegRD5jENgu7W6IPgz0kubUyYMPIqpVwJoWxtHcgl
u99cMCMf+FMsWdrJ/yzkAik+/NSnj+RZsddey7DSBqiE9rwuvXFas9D57FCNaUip
T6of1UwETm0SW69PLwEawgwBtT5rKUuFHhB7bfGqDh/M5PfM6W8TsxjaGGa68vrf
kH9CgIXm56GYuEwXBsabuzrEERFW9Bty3wvOQBCDtOl0lP3IE4P4aGzy810vfME=
=+kOv
-----END PGP SIGNATURE-----

--nextPart3178980.T11KAyJOT4--

