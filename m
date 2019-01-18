From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6/7] HID: input: add mapping for "Full Screen" key
Date: Fri, 18 Jan 2019 15:30:36 -0800
Message-ID: <20190118233037.87318-6-dmitry.torokhov@gmail.com>
References: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

According to HUT 1.12 usage 0x232 from the consumer page is reserved for
switching application between full screen and windowed mode, so let's add
the mapping.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This needs the new key definition.

 drivers/hid/hid-input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index cebe8a8cce2e..ecb1b6f26853 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1014,6 +1014,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x22d: map_key_clear(KEY_ZOOMIN);		break;
 		case 0x22e: map_key_clear(KEY_ZOOMOUT);		break;
 		case 0x22f: map_key_clear(KEY_ZOOMRESET);	break;
+		case 0x232: map_key_clear(KEY_FULL_SCREEN);	break;
 		case 0x233: map_key_clear(KEY_SCROLLUP);	break;
 		case 0x234: map_key_clear(KEY_SCROLLDOWN);	break;
 		case 0x238: map_rel(REL_HWHEEL);		break;
-- 
2.20.1.321.g9e740568ce-goog
