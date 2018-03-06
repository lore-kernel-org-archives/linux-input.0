From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] HID: hid-multitouch: Use true and false for boolean values
Date: Mon, 5 Mar 2018 18:10:46 -0600
Message-ID: <20180306001046.GA3433@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-input@vger.kernel.org

Assign true or false to boolean variables instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 2e1736b..a144d30 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -723,7 +723,7 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 		}
 
 		if (!(td->mtclass.quirks & MT_QUIRK_CONFIDENCE))
-			s->confidence_state = 1;
+			s->confidence_state = true;
 		active = (s->touch_state || s->inrange_state) &&
 							s->confidence_state;
 
-- 
2.7.4
