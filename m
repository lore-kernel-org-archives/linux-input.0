From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH v2 4/9] HID: multitouch: fix Win8 protocol for Sharp like devices
Date: Thu, 31 Jan 2013 17:22:26 +0100
Message-ID: <1359649351-11092-5-git-send-email-benjamin.tissoires@gmail.com>
References: <1359649351-11092-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359649351-11092-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Sharp LC-20FE1-W screen (04dd:9681) behaves like the Nexio 42".
It may report out of ranges values that are filtered out by relying
on the Contact Count HID field.
Adding the quirk MT_QUIRK_CONTACT_CNT_ACCURATE makes hid-multitouch
strongest against this kind of device, without breaking the current
devices.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c9b8fe5..585a813 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -311,6 +311,7 @@ static void mt_feature_mapping(struct hid_device *hdev,
 			*quirks |= MT_QUIRK_ALWAYS_VALID;
 			*quirks |= MT_QUIRK_IGNORE_DUPLICATES;
 			*quirks |= MT_QUIRK_HOVERING;
+			*quirks |= MT_QUIRK_CONTACT_CNT_ACCURATE;
 			*quirks &= ~MT_QUIRK_NOT_SEEN_MEANS_UP;
 			*quirks &= ~MT_QUIRK_VALID_IS_INRANGE;
 			*quirks &= ~MT_QUIRK_VALID_IS_CONFIDENCE;
-- 
1.8.1
