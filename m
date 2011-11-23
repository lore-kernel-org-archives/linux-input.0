From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [PATCH 8/8] hid-multitouch: correct eGalax a001 protocol
Date: Wed, 23 Nov 2011 10:54:34 +0100
Message-ID: <1322042074-3759-9-git-send-email-benjamin.tissoires@enac.fr>
References: <1322042074-3759-1-git-send-email-benjamin.tissoires@enac.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322042074-3759-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Cedric Sodhi <manday@gmx.net>, Chris Bagwell <chris@cnpbagwell.com>
List-Id: linux-input@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@gmail.com>

This device use another protocol while sending the events.
It's the same as the one described as "serial" by Microsoft.
We are keeping here the sn_move and sn_pressure parameters for
egalax devices.

CC: Cedric Sodhi <manday@gmx.net>
CC: Chris Bagwell <chris@cnpbagwell.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 77210d6..f0f3632 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -97,6 +97,7 @@ struct mt_device {
 #define MT_CLS_3M				0x0101
 #define MT_CLS_CYPRESS				0x0102
 #define MT_CLS_EGALAX				0x0103
+#define MT_CLS_EGALAX_SERIAL			0x0104
 
 #define MT_DEFAULT_MAXCONTACT	10
 
@@ -174,6 +175,12 @@ static struct mt_class mt_classes[] = {
 		.sn_move = 4096,
 		.sn_pressure = 32,
 	},
+	{ .name = MT_CLS_EGALAX_SERIAL,
+		.quirks =  MT_QUIRK_SLOT_IS_CONTACTID |
+			MT_QUIRK_ALWAYS_VALID,
+		.sn_move = 4096,
+		.sn_pressure = 32,
+	},
 
 	{ }
 };
@@ -705,7 +712,7 @@ static const struct hid_device_id mt_devices[] = {
 	{ .driver_data = MT_CLS_EGALAX,
 		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7302) },
-	{ .driver_data = MT_CLS_EGALAX,
+	{ .driver_data = MT_CLS_EGALAX_SERIAL,
 		HID_USB_DEVICE(USB_VENDOR_ID_DWAV,
 			USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001) },
 
-- 
1.7.4.4
