From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] HID: input: add mapping for KEY_KBD_LAYOUT_NEXT
Date: Thu, 25 Apr 2019 09:38:46 -0700
Message-ID: <20190425163846.51730-2-dmitry.torokhov@gmail.com>
References: <20190425163846.51730-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425163846.51730-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, gwink@chromium.org
List-Id: linux-input@vger.kernel.org

HUTRR56 defined a new usage code on consumer page to cycle through
set of keyboard layouts, let's add this mapping.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index b607286a0bc8..0579b8d3f912 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1051,6 +1051,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x28b: map_key_clear(KEY_FORWARDMAIL);	break;
 		case 0x28c: map_key_clear(KEY_SEND);		break;
 
+		case 0x29d: map_key_clear(KEY_KBD_LAYOUT_NEXT);	break;
+
 		case 0x2c7: map_key_clear(KEY_KBDINPUTASSIST_PREV);		break;
 		case 0x2c8: map_key_clear(KEY_KBDINPUTASSIST_NEXT);		break;
 		case 0x2c9: map_key_clear(KEY_KBDINPUTASSIST_PREVGROUP);		break;
-- 
2.21.0.593.g511ec345e18-goog
