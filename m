From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: ALPS - switch to using input_mt_report_finger_count
Date: Mon, 23 Apr 2012 23:07:41 -0700
Message-ID: <20120424060740.GA32333@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:51720 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889Ab2DXGHs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Apr 2012 02:07:48 -0400
Received: by dadz8 with SMTP id z8so443186dad.10
        for <linux-input@vger.kernel.org>; Mon, 23 Apr 2012 23:07:47 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Seth Forshee <seth.forshee@canonical.com>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>

Instead of open-coded reporting number of fingers on the touchpad
let's use input_mt_report_finger_count() helper.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

Just compiled, not tested.

 drivers/input/mouse/alps.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index ecd9389..4a1347e 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -553,10 +553,7 @@ static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
 
 	alps_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
 
-	input_report_key(dev, BTN_TOOL_FINGER, fingers == 1);
-	input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers == 2);
-	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers == 3);
-	input_report_key(dev, BTN_TOOL_QUADTAP, fingers == 4);
+	input_mt_report_finger_count(dev, fingers);
 
 	input_report_key(dev, BTN_LEFT, left);
 	input_report_key(dev, BTN_RIGHT, right);
@@ -685,10 +682,7 @@ static void alps_process_packet_v4(struct psmouse *psmouse)
 
 	alps_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
 
-	input_report_key(dev, BTN_TOOL_FINGER, fingers == 1);
-	input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers == 2);
-	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers == 3);
-	input_report_key(dev, BTN_TOOL_QUADTAP, fingers == 4);
+	input_mt_report_finger_count(dev, fingers);
 
 	input_report_key(dev, BTN_LEFT, left);
 	input_report_key(dev, BTN_RIGHT, right);
-- 
1.7.7.6


-- 
Dmitry
