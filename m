From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 19/25] HID: multitouch: optimize ActionStar panels
Date: Fri, 25 Jan 2013 14:23:04 +0100
Message-ID: <1359120190-18281-20-git-send-email-benjamin.tissoires@gmail.com>
References: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Relying on ALWAYS_VALID enhance a little the processing time of
the events.
Also the slot can be extracted faster by using MINUS_ONE.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 0ea98ae..189a8fd 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -955,7 +955,7 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_3M3266) },
 
 	/* ActionStar panels */
-	{ .driver_data = MT_CLS_DEFAULT,
+	{ .driver_data = MT_CLS_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_ACTIONSTAR,
 			USB_DEVICE_ID_ACTIONSTAR_1011) },
 
-- 
1.8.1
