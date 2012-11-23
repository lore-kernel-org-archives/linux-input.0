From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 11/11] HID: hid-multitouch: use MT_QUIRK_CONTACT_COUNT_ACCURATE for win 8 devices
Date: Fri, 23 Nov 2012 16:31:34 +0100
Message-ID: <1353684694-5723-12-git-send-email-benjamin.tissoires@gmail.com>
References: <1353684694-5723-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353684694-5723-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Win 8 devices can use MT_QUIRK_CONTACT_COUNT_ACCURATE instead of
MT_QUIRK_IGNORE_DUPLICATES. The process is a little bit faster
for MT_QUIRK_CONTACT_COUNT_ACCURATE, so let's use it.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index b374a5a..15d2587 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -315,7 +315,7 @@ static void mt_feature_mapping(struct hid_device *hdev,
 			/* Win 8 devices need special quirks */
 			__s32 *quirks = &td->mtclass.quirks;
 			*quirks |= MT_QUIRK_ALWAYS_VALID;
-			*quirks |= MT_QUIRK_IGNORE_DUPLICATES;
+			*quirks |= MT_QUIRK_CONTACT_COUNT_ACCURATE;
 			*quirks |= MT_QUIRK_HOVERING;
 			*quirks &= ~MT_QUIRK_NOT_SEEN_MEANS_UP;
 			*quirks &= ~MT_QUIRK_VALID_IS_INRANGE;
-- 
1.8.0
