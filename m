From: =?us-ascii?B?PT9VVEYtOD9xP0NsPUMzPUE5bWVudD0yMFZ1Y2hlbmVyPz0=?=
	<clement.vuchener@gmail.com>
Subject: [PATCH 2/2] HID: corsair: Add K40 support
Date: Wed, 23 Mar 2016 18:33:06 +0100
Message-ID: <738ba88c7b19b1bc9424bf1eaa769c99268dde33.1458744569.git.clement.vuchener@gmail.com>
References: <cover.1458744569.git.clement.vuchener@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33769 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756198AbcCWRdN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Mar 2016 13:33:13 -0400
Content-Disposition: inline
In-Reply-To: <cover.1458744569.git.clement.vuchener@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

The Corsair K40 uses the same usage codes as the K90 for its special ke=
ys (although it has only 6 G-keys).

Signed-off-by: Cl=E9ment Vuchener <clement.vuchener@gmail.com>
---
 drivers/hid/hid-core.c    | 1 +
 drivers/hid/hid-corsair.c | 1 +
 drivers/hid/hid-ids.h     | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bdb8cc8..73860b9 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1871,6 +1871,7 @@ static const struct hid_device_id hid_have_specia=
l_driver[] =3D {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_WIRELES=
S2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_AK1D) }=
,
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_ACER_SW=
ITCH12) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K40) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K90) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CREATIVELABS, USB_DEVICE_ID_PRODIKEYS_=
PCMIDI) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYGNAL, USB_DEVICE_ID_CYGNAL_CP2112) }=
,
diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 98f40aa..85b5168 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -151,6 +151,7 @@ static int corsair_input_mapping(struct hid_device =
*dev,
 }
=20
 static const struct hid_device_id corsair_devices[] =3D {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K40) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_DEVICE_ID_CORSAIR_K90) },
 	{}
 };
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 5c0e43e..ea9fef9 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -256,6 +256,7 @@
 #define USB_DEVICE_ID_CODEMERCS_IOW_LAST	0x15ff
=20
 #define USB_VENDOR_ID_CORSAIR		0x1b1c
+#define USB_DEVICE_ID_CORSAIR_K40	0x1b0e
 #define USB_DEVICE_ID_CORSAIR_K90	0x1b02
=20
 #define USB_VENDOR_ID_CREATIVELABS	0x041e
--=20
2.5.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
