From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [RFC v3 4/5] hid-multitouch: added support for Cypress TrueTouch panels
Date: Fri,  7 Jan 2011 19:42:41 +0100
Message-ID: <1294425762-29730-5-git-send-email-benjamin.tissoires@enac.fr>
References: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1294425762-29730-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephane Chatty <chatty@enac.fr>, Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.orglinux
Cc: Benjamin Tissoires <benjamin.tissoires@enac.fr>
List-Id: linux-input@vger.kernel.org

Added support for Cypress TrueTouch panels, which detect up to 10 finge=
rs

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Signed-off-by: St=C3=A9phane Chatty <chatty@enac.fr>
---
 drivers/hid/Kconfig          |    1 +
 drivers/hid/hid-core.c       |    1 +
 drivers/hid/hid-ids.h        |    1 +
 drivers/hid/hid-multitouch.c |   19 +++++++++++++++++++
 4 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 511554d..de31d75 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -293,6 +293,7 @@ config HID_MULTITOUCH
=20
 	  Say Y here if you have one of the following devices:
 	  - PixCir touchscreen
+	  - Cypress TrueTouch
=20
 config HID_NTRIG
 	tristate "N-Trig touch screen"
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 2b4d9b9..e6a86bf 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1298,6 +1298,7 @@ static const struct hid_device_id hid_blacklist[]=
 =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE=
_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE=
_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE) =
},
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_TRUETOU=
CH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTIT=
OUCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DWAV, USB_DEVICE_ID_DWAV_EGALAX_MULTIT=
OUCH1) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 17b444b..c258c42 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -180,6 +180,7 @@
 #define USB_DEVICE_ID_CYPRESS_BARCODE_1	0xde61
 #define USB_DEVICE_ID_CYPRESS_BARCODE_2	0xde64
 #define USB_DEVICE_ID_CYPRESS_BARCODE_3	0xbca1
+#define USB_DEVICE_ID_CYPRESS_TRUETOUCH	0xc001
=20
 #define USB_VENDOR_ID_DEALEXTREAME	0x10c5
 #define USB_DEVICE_ID_DEALEXTREAME_RADIO_SI4701	0x819a
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
index 3b05dfe..7af9f71 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -32,6 +32,7 @@ MODULE_LICENSE("GPL");
 /* quirks to control the device */
 #define MT_QUIRK_NOT_SEEN_MEANS_UP	(1 << 0)
 #define MT_QUIRK_SLOT_IS_CONTACTID	(1 << 1)
+#define MT_QUIRK_CYPRESS	(1 << 2)
=20
 struct mt_slot {
 	__s32 x, y, p, w, h;
@@ -62,6 +63,7 @@ struct mt_class {
 /* classes of device behavior */
 #define MT_CLS_DEFAULT 0
 #define MT_CLS_DUAL1 1
+#define MT_CLS_CYPRESS 2
=20
 /*
  * these device-dependent functions determine what slot corresponds
@@ -73,6 +75,14 @@ static int slot_is_contactid(struct mt_device *td)
 	return td->curdata.contactid;
 }
=20
+static int cypress_compute_slot(struct mt_device *td)
+{
+	if (td->curdata.contactid !=3D 0 || td->num_received =3D=3D 0)
+		return td->curdata.contactid;
+	else
+		return -1;
+}
+
 static int find_slot_from_contactid(struct mt_device *td)
 {
 	int i;
@@ -95,6 +105,7 @@ static int find_slot_from_contactid(struct mt_device=
 *td)
 struct mt_class mt_classes[] =3D {
 	{ 0, 0, 0, 10 },                             /* MT_CLS_DEFAULT */
 	{ MT_QUIRK_SLOT_IS_CONTACTID, 0, 0, 2 },     /* MT_CLS_DUAL1 */
+	{ MT_QUIRK_CYPRESS | MT_QUIRK_NOT_SEEN_MEANS_UP, 0, 0, 10 }, /* MT_CL=
S_CYPRESS */
 };
=20
 static void mt_feature_mapping(struct hid_device *hdev, struct hid_inp=
ut *hi,
@@ -223,6 +234,9 @@ static int mt_compute_slot(struct mt_device *td)
 	if (cls->quirks & MT_QUIRK_SLOT_IS_CONTACTID)
 		return slot_is_contactid(td);
=20
+	if (cls->quirks & MT_QUIRK_CYPRESS)
+		return cypress_compute_slot(td);
+
 	return find_slot_from_contactid(td);
 }
=20
@@ -422,6 +436,11 @@ static void mt_remove(struct hid_device *hdev)
=20
 static const struct hid_device_id mt_devices[] =3D {
=20
+	/* Cypress panel */
+	{ .driver_data =3D MT_CLS_CYPRESS,
+		HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS,
+			USB_DEVICE_ID_CYPRESS_TRUETOUCH) },
+
 	/* PixCir-based panels */
 	{ .driver_data =3D MT_CLS_DUAL1,
 		HID_USB_DEVICE(USB_VENDOR_ID_HANVON,
--=20
1.7.3.4
