From: Joey Pabalinas <joeypabalinas@gmail.com>
Subject: [PATCH 1/4] HID: multitouch: add MT_QUIRK_NOT_SEEN_MEANS_UP to MT_CLS_WIN_8 quirks
Date: Sat, 30 Jun 2018 14:19:50 -1000
Message-ID: <958e450a066289c94ba03429166c972c54be6fb3.1530402641.git.joeypabalinas@gmail.com>
References: <cover.1530402641.git.joeypabalinas@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1530402641.git.joeypabalinas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Daniel Martin <consume.noise@gmail.com>
List-Id: linux-input@vger.kernel.org

The firmware found in the touch screen of the Surface Pro 3 is slightly
buggy and occasionally doesn't send lift off reports for contacts; add
MT_QUIRK_NOT_SEEN_MEANS_UP to .quirks to compensate for the missed
reports.

Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>

 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 45968f7970f87775fa..a793076139d7d0db9b 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -242,11 +242,12 @@ static struct mt_class mt_classes[] = {
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_IGNORE_DUPLICATES |
 			MT_QUIRK_HOVERING |
 			MT_QUIRK_CONTACT_CNT_ACCURATE |
 			MT_QUIRK_STICKY_FINGERS |
-			MT_QUIRK_WIN8_PTP_BUTTONS },
+			MT_QUIRK_WIN8_PTP_BUTTONS |
+			MT_QUIRK_NOT_SEEN_MEANS_UP },
 	{ .name = MT_CLS_EXPORT_ALL_INPUTS,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_CONTACT_CNT_ACCURATE,
 		.export_all_inputs = true },
 	{ .name = MT_CLS_WIN_8_DUAL,
-- 
2.18.0
