From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/7] HID: input: fix mapping of aspect ratio key
Date: Fri, 18 Jan 2019 15:30:33 -0800
Message-ID: <20190118233037.87318-3-dmitry.torokhov@gmail.com>
References: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>
List-Id: linux-input@vger.kernel.org

According to HUTRR37 usage 0x6d from the consumer usage page corresponds
to action that selects the next available supported aspect ratio option
on a device which outputs or displays video. However KEY_ZOOM means
activate "Full Screen" mode, KEY_ASPECT_RATIO should be used instead.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d6fab5798487..def58c6aa835 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -891,7 +891,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x06a: map_key_clear(KEY_GREEN);		break;
 		case 0x06b: map_key_clear(KEY_BLUE);		break;
 		case 0x06c: map_key_clear(KEY_YELLOW);		break;
-		case 0x06d: map_key_clear(KEY_ZOOM);		break;
+		case 0x06d: map_key_clear(KEY_ASPECT_RATIO);	break;
 
 		case 0x06f: map_key_clear(KEY_BRIGHTNESSUP);		break;
 		case 0x070: map_key_clear(KEY_BRIGHTNESSDOWN);		break;
-- 
2.20.1.321.g9e740568ce-goog
