From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 21/25] HID: multitouch: optimize Ideacom panels
Date: Fri, 25 Jan 2013 14:23:06 +0100
Message-ID: <1359120190-18281-22-git-send-email-benjamin.tissoires@gmail.com>
References: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The slot can be extracted by using MINUS_ONE.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index f50b359..fe1aa3b 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1095,10 +1095,10 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_HANVON_ALT_MULTITOUCH) },
 
 	/* Ideacom panel */
-	{ .driver_data = MT_CLS_SERIAL,
+	{ .driver_data = MT_CLS_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_IDEACOM,
 			USB_DEVICE_ID_IDEACOM_IDC6650) },
-	{ .driver_data = MT_CLS_SERIAL,
+	{ .driver_data = MT_CLS_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_IDEACOM,
 			USB_DEVICE_ID_IDEACOM_IDC6651) },
 
-- 
1.8.1
