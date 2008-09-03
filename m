From: Henrik Rydberg <rydberg@euromail.se>
Subject: [PATCH 3/3] bcm5974-0.64: BTN_TOUCH event added for mousedev
Date: Wed, 03 Sep 2008 22:25:40 +0200
Message-ID: <48BEF2C4.70105@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:57004 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756259AbYICUZn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Sep 2008 16:25:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, akpm@osdl.org, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

The mousedev driver requires the use of BTN_TOUCH events to process
ABS_X and ABS_Y events properly, which is what is needed for the
bcm5974-based apple computers to have a functional pointer out-of-the-box.
This patch adds the BTN_TOUCH events to bcm5974.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/mouse/bcm5974.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index 8568211..18f4d7f 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -253,6 +253,7 @@ static void setup_events_to_report(struct input_dev *input_dev,
 				0, cfg->y.dim, cfg->y.fuzz, 0);

 	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(BTN_TOUCH, input_dev->keybit);
 	__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
 	__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
 	__set_bit(BTN_TOOL_TRIPLETAP, input_dev->keybit);
@@ -320,6 +321,7 @@ static int report_tp_state(struct bcm5974 *dev, int size)
 	if (dev->fingers > nmax)
 		dev->fingers = nmax;

+	input_report_key(input, BTN_TOUCH, dev->fingers > 0);
 	input_report_key(input, BTN_TOOL_FINGER, dev->fingers == 1);
 	input_report_key(input, BTN_TOOL_DOUBLETAP, dev->fingers == 2);
 	input_report_key(input, BTN_TOOL_TRIPLETAP, dev->fingers > 2);
-- 
1.5.4.3

Diff is against v2.6.27-rc5-103-g0a7574e
