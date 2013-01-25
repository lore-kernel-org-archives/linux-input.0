From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 04/25] HID: multitouch: ensure that serial devices make no use of contact count
Date: Fri, 25 Jan 2013 14:22:49 +0100
Message-ID: <1359120190-18281-5-git-send-email-benjamin.tissoires@gmail.com>
References: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359120190-18281-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The serial protocol makes contact count a redondant information, and
sometimes it is not reliable (TRS-Star are in this case).
Disabling the use of contact count for these devices is thus safer.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 8d0a9f9..0566fd4 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -761,6 +761,7 @@ static void mt_post_parse_default_settings(struct mt_device *td)
 		quirks &= ~MT_QUIRK_NOT_SEEN_MEANS_UP;
 		quirks &= ~MT_QUIRK_VALID_IS_INRANGE;
 		quirks &= ~MT_QUIRK_VALID_IS_CONFIDENCE;
+		quirks &= ~MT_QUIRK_CONTACT_CNT_ACCURATE;
 	}
 
 	td->mtclass.quirks = quirks;
-- 
1.8.1
