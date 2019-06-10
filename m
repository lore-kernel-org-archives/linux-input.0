From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH] HID: input: fix a4tech horizontal wheel custom usage id
Date: Mon, 10 Jun 2019 20:53:43 +0200
Message-ID: <20190610185343.27614-1-nsaenzjulienne@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: dmitry.torokhov@gmail.com, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Some a4tech mice use the 'GenericDesktop.00b8' usage id to inform
whether the previous wheel report was horizontal or vertical. Before
c01908a14bf73 ("HID: input: add mapping for "Toggle Display" key") this
usage id was being mapped to 'Relative.Misc'. After the patch it's
simply ignored (usage->type == 0 & usage->code == 0). Checking the HID
Usage Tables it turns out it's a reserved usage_id, so it makes sense to
map it the way it was. Ultimately this makes hid-a4tech ignore the
WHEEL/HWHEEL selection event, as it has no usage->type.

The patch reverts the handling of the usage id back to it's previous
behavior.

Fixes: c01908a14bf73 ("HID: input: add mapping for "Toggle Display" key")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/hid/hid-input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 63855f275a38..6a956d5a195e 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -671,7 +671,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		if ((usage->hid & 0xf0) == 0xb0) {	/* SC - Display */
 			switch (usage->hid & 0xf) {
 			case 0x05: map_key_clear(KEY_SWITCHVIDEOMODE); break;
-			default: goto ignore;
+			default: goto unknown;
 			}
 			break;
 		}
-- 
2.21.0
