From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/7] HID: input: add mapping for Expose/Overview key
Date: Fri, 18 Jan 2019 15:30:34 -0800
Message-ID: <20190118233037.87318-4-dmitry.torokhov@gmail.com>
References: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118233037.87318-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

According to HUTRR77 usage 0x29f from the consumer page is reserved for
the Desktop application to present all running user’s application windows.
Linux defines KEY_SCALE to request Compiz Scale (Expose) mode, so let's
add the mapping.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

This can be applied independently.

 drivers/hid/hid-input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index def58c6aa835..5f800e7b04f2 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1030,6 +1030,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x2cb: map_key_clear(KEY_KBDINPUTASSIST_ACCEPT);	break;
 		case 0x2cc: map_key_clear(KEY_KBDINPUTASSIST_CANCEL);	break;
 
+		case 0x29f: map_key_clear(KEY_SCALE);		break;
+
 		default: map_key_clear(KEY_UNKNOWN);
 		}
 		break;
-- 
2.20.1.321.g9e740568ce-goog
