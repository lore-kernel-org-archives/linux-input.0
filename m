From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 20/25] HID: multitouch: optimize Atmel panels
Date: Fri, 25 Jan 2013 14:23:05 +0100
Message-ID: <1359120190-18281-21-git-send-email-benjamin.tissoires@gmail.com>
References: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The slot can be extracted using MINUS_ONE.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 189a8fd..f50b359 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -960,7 +960,7 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_ACTIONSTAR_1011) },
 
 	/* Atmel panels */
-	{ .driver_data = MT_CLS_SERIAL,
+	{ .driver_data = MT_CLS_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_ATMEL,
 			USB_DEVICE_ID_ATMEL_MULTITOUCH) },
 	{ .driver_data = MT_CLS_SERIAL,
-- 
1.8.1
