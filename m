From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 07/25] HID: multitouch: optimize 3M panels
Date: Fri, 25 Jan 2013 14:22:52 +0100
Message-ID: <1359120190-18281-8-git-send-email-benjamin.tissoires@gmail.com>
References: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Not very different in terms of processing time. However, this
uniformizes the handling of devices.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 7dfe891..199e320 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -186,7 +186,8 @@ static struct mt_class mt_classes[] = {
 	 * vendor specific classes
 	 */
 	{ .name = MT_CLS_3M,
-		.quirks = MT_QUIRK_VALID_IS_CONFIDENCE |
+		.quirks = MT_QUIRK_ALWAYS_VALID |
+			MT_QUIRK_CONTACT_CNT_ACCURATE |
 			MT_QUIRK_SLOT_IS_CONTACTID,
 		.sn_move = 2048,
 		.sn_width = 128,
-- 
1.8.1
