From: Chung-yih Wang <cywang@chromium.org>
Subject: [PATCH] CHROMIUM: Input: synaptics - filter out the events with low z values
Date: Tue, 21 Feb 2012 23:07:38 +0800
Message-ID: <1329836858-9369-1-git-send-email-cywang@chromium.org>
Mime-Version: 1.0
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f202.google.com ([209.85.161.202]:43861 "EHLO
	mail-gx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab2BUPIE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Feb 2012 10:08:04 -0500
Received: by ggnp1 with SMTP id p1so814758ggn.1
        for <linux-input@vger.kernel.org>; Tue, 21 Feb 2012 07:08:02 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessandro Rubini <rubini@ipvvis.unipv.it>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, djkurtz@chromium.org, Chung-yih Wang <cywang@chromium.org>

The single touch path imposes a minimum z value (with hysterisis) before
registering BTN_TOUCH. Apply the same (hard coded) threshold when
deciding how many fingers to report in the semi-mt path.

This patch improves performance of the Google Cr-48 chromebook's
extremely sensitive Synaptics profile sensor touchpad by filtering out
touch events for hovering fingers.

Note: We continue to use the same hard coded threshold value used in the
single touch case as it appears this works just as well on these
multitouch profile sensor pads as on whatever pads it was originally
discovered.

Signed-off-by: Chung-Yih Wang <cywang@chromium.org>
---
 drivers/input/mouse/synaptics.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 8081a0a..7936a1a 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -568,17 +568,22 @@ static void synaptics_report_semi_mt_slot(struct input_dev *dev, int slot,
 	}
 }
 
+static bool finger_touched(const struct synaptics_hw_state *hw)
+{
+	return (hw->z > 30);
+}
+
 static void synaptics_report_semi_mt_data(struct input_dev *dev,
 					  const struct synaptics_hw_state *a,
 					  const struct synaptics_hw_state *b,
 					  int num_fingers)
 {
-	if (num_fingers >= 2) {
+	if ((num_fingers >= 2) && finger_touched(a) && finger_touched(b)) {
 		synaptics_report_semi_mt_slot(dev, 0, true, min(a->x, b->x),
 					      min(a->y, b->y));
 		synaptics_report_semi_mt_slot(dev, 1, true, max(a->x, b->x),
 					      max(a->y, b->y));
-	} else if (num_fingers == 1) {
+	} else if ((num_fingers == 1) && finger_touched(a)) {
 		synaptics_report_semi_mt_slot(dev, 0, true, a->x, a->y);
 		synaptics_report_semi_mt_slot(dev, 1, false, 0, 0);
 	} else {
@@ -1040,7 +1045,8 @@ static void synaptics_process_packet(struct psmouse *psmouse)
 	 * BTN_TOUCH has to be first as mousedev relies on it when doing
 	 * absolute -> relative conversion
 	 */
-	if (hw.z > 30) input_report_key(dev, BTN_TOUCH, 1);
+	if (finger_touched(&hw))
+		input_report_key(dev, BTN_TOUCH, 1);
 	if (hw.z < 25) input_report_key(dev, BTN_TOUCH, 0);
 
 	if (num_fingers > 0) {
-- 
1.7.7.3

