From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@gmail.com>
Subject: [PATCH v4] HID: hid-lg: Allow for custom device-specific properties to be stored in private drv data
Date: Sat, 31 Mar 2012 11:17:25 +0200
Message-ID: <4193443.YXckiBU47J@qosmio-x300>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1942735.RN5sspUJ8Y"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:45418 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673Ab2CaJRk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Mar 2012 05:17:40 -0400
Received: by wejx9 with SMTP id x9so795869wej.19
        for <linux-input@vger.kernel.org>; Sat, 31 Mar 2012 02:17:38 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, simon@mungewell.org


--nextPart1942735.RN5sspUJ8Y
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

I (hopefully) sorted out the mess. This patch only adds support for
custom device-specific properties which can now be stored as
private driver data and read/saved using hid_get/set_drvdata().

Signed-off-by: Michal Mal=FD <madcatxster@gmail.com>

---
 drivers/hid/hid-lg.c |   55 +++++++++++++++++++++++++++++-------------=
--------
 drivers/hid/hid-lg.h |    7 +++++++
 2 files changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index e7a7bd1..fc37ed6 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -109,23 +109,23 @@ static __u8 dfp_rdesc_fixed[] =3D {
 static __u8 *lg_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 =09=09unsigned int *rsize)
 {
-=09unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
+=09struct lg_drv_data *drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hdev);
=20
-=09if ((quirks & LG_RDESC) && *rsize >=3D 90 && rdesc[83] =3D=3D 0x26 =
&&
+=09if ((drv_data->quirks & LG_RDESC) && *rsize >=3D 90 && rdesc[83] =3D=
=3D 0x26 &&
 =09=09=09rdesc[84] =3D=3D 0x8c && rdesc[85] =3D=3D 0x02) {
 =09=09hid_info(hdev,
 =09=09=09 "fixing up Logitech keyboard report descriptor\n");
 =09=09rdesc[84] =3D rdesc[89] =3D 0x4d;
 =09=09rdesc[85] =3D rdesc[90] =3D 0x10;
 =09}
-=09if ((quirks & LG_RDESC_REL_ABS) && *rsize >=3D 50 &&
+=09if ((drv_data->quirks & LG_RDESC_REL_ABS) && *rsize >=3D 50 &&
 =09=09=09rdesc[32] =3D=3D 0x81 && rdesc[33] =3D=3D 0x06 &&
 =09=09=09rdesc[49] =3D=3D 0x81 && rdesc[50] =3D=3D 0x06) {
 =09=09hid_info(hdev,
 =09=09=09 "fixing up rel/abs in Logitech report descriptor\n");
 =09=09rdesc[33] =3D rdesc[50] =3D 0x02;
 =09}
-=09if ((quirks & LG_FF4) && *rsize >=3D 101 &&
+=09if ((drv_data->quirks & LG_FF4) && *rsize >=3D 101 &&
 =09=09=09rdesc[41] =3D=3D 0x95 && rdesc[42] =3D=3D 0x0B &&
 =09=09=09rdesc[47] =3D=3D 0x05 && rdesc[48] =3D=3D 0x09) {
 =09=09hid_info(hdev, "fixing up Logitech Speed Force Wireless button d=
escriptor\n");
@@ -278,7 +278,7 @@ static int lg_input_mapping(struct hid_device *hdev=
, struct hid_input *hi,
 =09=09  0,  0,  0,  0,  0,183,184,185,186,187,
 =09=09188,189,190,191,192,193,194,  0,  0,  0
 =09};
-=09unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
+=09struct lg_drv_data *drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hdev);
 =09unsigned int hid =3D usage->hid;
=20
 =09if (hdev->product =3D=3D USB_DEVICE_ID_LOGITECH_RECEIVER &&
@@ -289,7 +289,7 @@ static int lg_input_mapping(struct hid_device *hdev=
, struct hid_input *hi,
 =09=09=09lg_dinovo_mapping(hi, usage, bit, max))
 =09=09return 1;
=20
-=09if ((quirks & LG_WIRELESS) && lg_wireless_mapping(hi, usage, bit, m=
ax))
+=09if ((drv_data->quirks & LG_WIRELESS) && lg_wireless_mapping(hi, usa=
ge, bit, max))
 =09=09return 1;
=20
 =09if ((hid & HID_USAGE_PAGE) !=3D HID_UP_BUTTON)
@@ -299,11 +299,11 @@ static int lg_input_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
=20
 =09/* Special handling for Logitech Cordless Desktop */
 =09if (field->application =3D=3D HID_GD_MOUSE) {
-=09=09if ((quirks & LG_IGNORE_DOUBLED_WHEEL) &&
+=09=09if ((drv_data->quirks & LG_IGNORE_DOUBLED_WHEEL) &&
 =09=09=09=09(hid =3D=3D 7 || hid =3D=3D 8))
 =09=09=09return -1;
 =09} else {
-=09=09if ((quirks & LG_EXPANDED_KEYMAP) &&
+=09=09if ((drv_data->quirks & LG_EXPANDED_KEYMAP) &&
 =09=09=09=09hid < ARRAY_SIZE(e_keymap) &&
 =09=09=09=09e_keymap[hid] !=3D 0) {
 =09=09=09hid_map_usage(hi, usage, bit, max, EV_KEY,
@@ -319,13 +319,13 @@ static int lg_input_mapped(struct hid_device *hde=
v, struct hid_input *hi,
 =09=09struct hid_field *field, struct hid_usage *usage,
 =09=09unsigned long **bit, int *max)
 {
-=09unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
+=09struct lg_drv_data *drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hdev);
=20
-=09if ((quirks & LG_BAD_RELATIVE_KEYS) && usage->type =3D=3D EV_KEY &&=

+=09if ((drv_data->quirks & LG_BAD_RELATIVE_KEYS) && usage->type =3D=3D=
 EV_KEY &&
 =09=09=09(field->flags & HID_MAIN_ITEM_RELATIVE))
 =09=09field->flags &=3D ~HID_MAIN_ITEM_RELATIVE;
=20
-=09if ((quirks & LG_DUPLICATE_USAGES) && (usage->type =3D=3D EV_KEY ||=

+=09if ((drv_data->quirks & LG_DUPLICATE_USAGES) && (usage->type =3D=3D=
 EV_KEY ||
 =09=09=09 usage->type =3D=3D EV_REL || usage->type =3D=3D EV_ABS))
 =09=09clear_bit(usage->code, *bit);
=20
@@ -335,9 +335,9 @@ static int lg_input_mapped(struct hid_device *hdev,=
 struct hid_input *hi,
 static int lg_event(struct hid_device *hdev, struct hid_field *field,
 =09=09struct hid_usage *usage, __s32 value)
 {
-=09unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
+=09struct lg_drv_data *drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hdev);
=20
-=09if ((quirks & LG_INVERT_HWHEEL) && usage->code =3D=3D REL_HWHEEL) {=

+=09if ((drv_data->quirks & LG_INVERT_HWHEEL) && usage->code =3D=3D REL=
_HWHEEL) {
 =09=09input_event(field->hidinput->input, usage->type, usage->code,
 =09=09=09=09-value);
 =09=09return 1;
@@ -348,13 +348,20 @@ static int lg_event(struct hid_device *hdev, stru=
ct hid_field *field,
=20
 static int lg_probe(struct hid_device *hdev, const struct hid_device_i=
d *id)
 {
-=09unsigned long quirks =3D id->driver_data;
 =09unsigned int connect_mask =3D HID_CONNECT_DEFAULT;
+=09struct lg_drv_data *drv_data;
 =09int ret;
=20
-=09hid_set_drvdata(hdev, (void *)quirks);
+=09drv_data =3D kzalloc(sizeof(struct lg_drv_data), GFP_KERNEL);
+=09if (!drv_data) {
+=09=09hid_err(hdev, "Insufficient memory, cannot allocate driver data\=
n");
+=09=09return -ENOMEM;
+=09}
+=09drv_data->quirks =3D id->driver_data;
+=09
+=09hid_set_drvdata(hdev, (void *)drv_data);
=20
-=09if (quirks & LG_NOGET)
+=09if (drv_data->quirks & LG_NOGET)
 =09=09hdev->quirks |=3D HID_QUIRK_NOGET;
=20
 =09ret =3D hid_parse(hdev);
@@ -363,7 +370,7 @@ static int lg_probe(struct hid_device *hdev, const =
struct hid_device_id *id)
 =09=09goto err_free;
 =09}
=20
-=09if (quirks & (LG_FF | LG_FF2 | LG_FF3 | LG_FF4))
+=09if (drv_data->quirks & (LG_FF | LG_FF2 | LG_FF3 | LG_FF4))
 =09=09connect_mask &=3D ~HID_CONNECT_FF;
=20
 =09ret =3D hid_hw_start(hdev, connect_mask);
@@ -392,27 +399,29 @@ static int lg_probe(struct hid_device *hdev, cons=
t struct hid_device_id *id)
 =09=09}
 =09}
=20
-=09if (quirks & LG_FF)
+=09if (drv_data->quirks & LG_FF)
 =09=09lgff_init(hdev);
-=09if (quirks & LG_FF2)
+=09if (drv_data->quirks & LG_FF2)
 =09=09lg2ff_init(hdev);
-=09if (quirks & LG_FF3)
+=09if (drv_data->quirks & LG_FF3)
 =09=09lg3ff_init(hdev);
-=09if (quirks & LG_FF4)
+=09if (drv_data->quirks & LG_FF4)
 =09=09lg4ff_init(hdev);
=20
 =09return 0;
 err_free:
+=09kfree(drv_data);
 =09return ret;
 }
=20
 static void lg_remove(struct hid_device *hdev)
 {
-=09unsigned long quirks =3D (unsigned long)hid_get_drvdata(hdev);
-=09if(quirks & LG_FF4)
+=09struct lg_drv_data *drv_data =3D (struct lg_drv_data *)hid_get_drvd=
ata(hdev);
+=09if (drv_data->quirks & LG_FF4)
 =09=09lg4ff_deinit(hdev);
=20
 =09hid_hw_stop(hdev);
+=09kfree(drv_data);
 }
=20
 static const struct hid_device_id lg_devices[] =3D {
diff --git a/drivers/hid/hid-lg.h b/drivers/hid/hid-lg.h
index 4b09728..500457b 100644
--- a/drivers/hid/hid-lg.h
+++ b/drivers/hid/hid-lg.h
@@ -1,6 +1,13 @@
 #ifndef __HID_LG_H
 #define __HID_LG_H
=20
+#include <linux/spinlock.h>
+
+struct lg_drv_data {
+=09unsigned long quirks;
+=09void *device_props;=09/* Device specific properties */
+};
+
 #ifdef CONFIG_LOGITECH_FF
 int lgff_init(struct hid_device *hdev);
 #else
--=20
1.7.9.5


--nextPart1942735.RN5sspUJ8Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAABAgAGBQJPdsuuAAoJEERrVaOJCK16JRUH/jeE3UjflWmFijX5k7Kgm6h8
cvHepHo/eIe8dH7RQYVz1+n72Swp/G/UnpvlOn+lf1rJ3FtgTe7kZs0f7PBBRYmK
OX/LfVPAXxY1lhqEr7PnRV5l/Fk12Tpog1YJcA5JzEATJH/8MooLf592fCVjb5ug
tiiWJ8lBPRZoqjhgCtE7fTOA2LH0R47fejGmFkaxwK0i3G6ZptB0XXPgFhwfB2Lk
IW9f3c7zsce97tC/o+VlWOvH4cCIXDhgDUSXsZ7YoL6CLBwR3jhRhqZJcrbq08G4
G1K4Azxcp/ZaEbtDIBvqaAzJp3X1Npx7eWgu92ZNwv3Nv21/IKYLj/5K3gtVA0w=
=b6gc
-----END PGP SIGNATURE-----

--nextPart1942735.RN5sspUJ8Y--

