From: "Junge, Terry" <Terry.Junge@plantronics.com>
Subject: RE: [RFC/RFT] HID: primax: Fix wireless keyboards descriptor
Date: Thu, 28 Feb 2019 17:02:50 +0000
Message-ID: <BYAPR02MB56078ADD429292DF89F8C694ED750@BYAPR02MB5607.namprd02.prod.outlook.com>
References: <20190228135556.14713-1-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228135556.14713-1-nsaenzjulienne@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "oneukum@suse.de" <oneukum@suse.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

This could also be a parser error. In the HID specification section 6.2.2.8=
 it states that the last declared Usage Page is applied to Usages when the =
Main item is encountered.

"If the bSize field =3D 1 or 2 then the Usage is interpreted as an unsigned=
 value
that selects a Usage ID on the currently defined Usage Page. When the parse=
r
encounters a main item it concatenates the last declared Usage Page with a
Usage to form a complete usage value. Extended usages can be used to
override the currently defined Usage Page for individual usages."

-----Original Message-----
From: linux-input-owner@vger.kernel.org <linux-input-owner@vger.kernel.org>=
 On Behalf Of Nicolas Saenz Julienne
Sent: Thursday, February 28, 2019 5:56 AM
To: Jiri Kosina <jikos@kernel.org>; Benjamin Tissoires <benjamin.tissoires@=
redhat.com>
Cc: oneukum@suse.de; Nicolas Saenz Julienne <nsaenzjulienne@suse.de>; linux=
-input@vger.kernel.org; linux-kernel@vger.kernel.org
Subject: [RFC/RFT] HID: primax: Fix wireless keyboards descriptor

A whole set of Primax manufactured wireless keyboards won't work out of the=
 box as they provide wrong HID descriptors. In this case the offense being =
defining the "Usage Maximum/Minimum" local items before the "Usage Page". T=
his will make the parser use the previous "Usage Page" on those local items=
, generating a wrong HID report. This is not a parser error as the spec cle=
arly states that "Usage Page" applies to any item that follows it (see 6.2.=
2.7).

In other words, we get this:

15 00          Logical Minimum (0),
26 ff 00       Logical Maximum (255),
19 00          Usage Minimum (00h),
2a ff 00       Usage Maximum (FFh),
05 07          Usage Page (Keyboard),          ; Keyboard/keypad (07h)
75 08          Report Size (8),
95 06          Report Count (6),
81 00          Input,

Yet they meant this:

15 00          Logical Minimum (0),
26 ff 00       Logical Maximum (255),
05 07          Usage Page (Keyboard),          ; Keyboard/keypad (07h)
19 00          Usage Minimum (00h),
2a ff 00       Usage Maximum (FFh),
75 08          Report Size (8),
95 06          Report Count (6),
81 00          Input,

This patch fixes the issue by overwriting the offending report with a corre=
ct one.

This was made thanks to the user's answers provided here, also full HID des=
criptors are available there:
https://unix.stackexchange.com/questions/377830/linux-hid-driver-for-primax=
-wireless-keyboards/

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

NOTE: This is an RFC as I'm unable to test my fix. Apart from the
  devices mentioned in the patch there is a whole list of them, yet I
  didn't include them as I was unable to access their HID descriptors.

 drivers/hid/hid-ids.h    |  3 +++
 drivers/hid/hid-primax.c | 30 +++++++++++++++++++++++++++++-  drivers/hid/=
hid-quirks.c |  3 +++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h index 24f846d674=
78..b39f9f36d41f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -714,6 +714,7 @@
 #define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
 #define USB_DEVICE_ID_LENOVO_X1_COVER	0x6085
 #define USB_DEVICE_ID_LENOVO_X1_TAB	0x60a3
+#define USB_DEVICE_ID_LENOVO_WIRELESS_PROFESSIONAL	0x609b
=20
 #define USB_VENDOR_ID_LG		0x1fd2
 #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
@@ -1225,6 +1226,8 @@
 #define USB_DEVICE_ID_PRIMAX_REZEL	0x4e72
 #define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4D0F	0x4d0f
 #define USB_DEVICE_ID_PRIMAX_PIXART_MOUSE_4E22	0x4e22
+#define USB_DEVICE_ID_PRIMAX_WIRELESS_KEYBOARD_4E63	0x4e63
+#define USB_DEVICE_ID_PRIMAX_WIRELESS_KEYBOARD_4E80	0x4e80
=20
=20
 #define USB_VENDOR_ID_RISO_KAGAKU	0x1294	/* Riso Kagaku Corp. */
diff --git a/drivers/hid/hid-primax.c b/drivers/hid/hid-primax.c index 3a1c=
3c4c50dc..033f6660e8b6 100644
--- a/drivers/hid/hid-primax.c
+++ b/drivers/hid/hid-primax.c
@@ -2,9 +2,11 @@
  * HID driver for primax and similar keyboards with in-band modifiers
  *
  * Copyright 2011 Google Inc. All Rights Reserved
+ * Copyright 2019 Nicolas Saenz Julienne
  *
- * Author:
+ * Authors:
  *	Terry Lambert <tlambert@google.com>
+ *	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
  *
  * This software is licensed under the terms of the GNU General Public
  * License version 2, as published by the Free Software Foundation, and @@=
 -27,6 +29,9 @@ static int px_raw_event(struct hid_device *hid, struct hid_=
report *report,  {
 	int idx =3D size;
=20
+	if (hid->product !=3D USB_DEVICE_ID_PRIMAX_KEYBOARD)
+		return 0;
+
 	switch (report->id) {
 	case 0:		/* keyboard input */
 		/*
@@ -64,8 +69,29 @@ static int px_raw_event(struct hid_device *hid, struct h=
id_report *report,
 	return 0;
 }
=20
+/*
+ * Some Primax manufactured keyboards set "Usage Minimum/Maximum"=20
+values before
+ * setting the "Usage Page". This is not supported as per spec 6.2.2.7.
+ */
+static __u8 *px_fixup(struct hid_device *hid, __u8 *rdesc, unsigned int=20
+*rsize) {
+	__u8 wrong_report[] =3D { 0x19, 0x00, 0x2a, 0xff, 0x05, 0x07 };
+	__u8 fixed_report[] =3D { 0x05, 0x07, 0x19, 0x00, 0x2a, 0xff };
+
+	if (*rsize > 57 &&
+	    !memcmp(&rdesc[51], wrong_report, ARRAY_SIZE(wrong_report))) {
+		hid_info(hid, "fixing up Primax report descriptor\n");
+		memcpy(&rdesc[51], fixed_report, ARRAY_SIZE(fixed_report));
+	}
+
+	return rdesc;
+}
+
 static const struct hid_device_id px_devices[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_WIRELESS_KEYB=
OARD_4E63) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_WIRELESS_KEYB=
OARD_4E80) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO,=20
+USB_DEVICE_ID_LENOVO_WIRELESS_PROFESSIONAL) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, px_devices);
@@ -74,8 +100,10 @@ static struct hid_driver px_driver =3D {
 	.name =3D "primax",
 	.id_table =3D px_devices,
 	.raw_event =3D px_raw_event,
+	.report_fixup =3D px_fixup,
 };
 module_hid_driver(px_driver);
=20
 MODULE_AUTHOR("Terry Lambert <tlambert@google.com>");
+MODULE_AUTHOR("Nicolas Saenz Julienne <nsaenzjulienne@suse.de");
 MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c index 9408=
8c0ed68a..9fd256fea231 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -563,6 +563,9 @@ static const struct hid_device_id hid_have_special_driv=
er[] =3D {  #endif  #if IS_ENABLED(CONFIG_HID_PRIMAX)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_KEYBOARD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_WIRELESS_KEYB=
OARD_4E63) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PRIMAX, USB_DEVICE_ID_PRIMAX_WIRELESS_KEYB=
OARD_4E80) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO,=20
+USB_DEVICE_ID_LENOVO_WIRELESS_PROFESSIONAL) },
 #endif
 #if IS_ENABLED(CONFIG_HID_PRODIKEYS)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_PRODIKEYS_PCMI=
DI) },
--
2.20.1
