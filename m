From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH] Input: uinput - allow for max == min during input_absinfo
 validation
Date: Tue, 18 Sep 2018 15:22:56 +1000
Message-ID: <20180918052256.GA23446@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>
List-Id: linux-input@vger.kernel.org

These values are inclusive, so a range of 1 requires min == max.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/input/misc/uinput.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
index 96a887f33698..eb14ddf69346 100644
--- a/drivers/input/misc/uinput.c
+++ b/drivers/input/misc/uinput.c
@@ -410,7 +410,7 @@ static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
 	min = abs->minimum;
 	max = abs->maximum;
 
-	if ((min != 0 || max != 0) && max <= min) {
+	if ((min != 0 || max != 0) && max < min) {
 		printk(KERN_DEBUG
 		       "%s: invalid abs[%02x] min:%d max:%d\n",
 		       UINPUT_NAME, code, min, max);
-- 
2.17.1
