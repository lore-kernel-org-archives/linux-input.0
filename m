From: Anshul Garg <aksgarg1989@gmail.com>
Subject: [PATCH] Input: Optimize Auto Repeat Loop
Date: Mon,  5 Jan 2015 08:12:56 -0800
Message-ID: <1420474376-22138-1-git-send-email-aksgarg1989@gmail.com>
References: <anshul.g@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:62430 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbbAEQN3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jan 2015 11:13:29 -0500
Received: by mail-wg0-f54.google.com with SMTP id z12so10019047wgg.27
        for <linux-input@vger.kernel.org>; Mon, 05 Jan 2015 08:13:28 -0800 (PST)
In-Reply-To: <anshul.g@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com, anshul.g@samsung.com, p.shailesh@samsung.com

From: Anshul Garg <aksgarg1989@gmail.com>

As input_pass_values function is called everytime when EV_SYN is sent
from input driver or input event buffer becomes full. So avoid running
auto repeat code if input device doesn't support EV_KEY and EV_REP
event type.

Signed-off-by: Anshul Garg <anshul.g@samsung.com>
---
 drivers/input/input.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 213e3a1..601171b 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -152,12 +152,14 @@ static void input_pass_values(struct input_dev *dev,
 	add_input_randomness(vals->type, vals->code, vals->value);
 
 	/* trigger auto repeat for key events */
-	for (v = vals; v != vals + count; v++) {
-		if (v->type == EV_KEY && v->value != 2) {
-			if (v->value)
-				input_start_autorepeat(dev, v->code);
-			else
-				input_stop_autorepeat(dev);
+	if (test_bit(EV_KEY, dev->evbit) && test_bit(EV_REP, dev->evbit)) {
+		for (v = vals; v != vals + count; v++) {
+			if (v->type == EV_KEY && v->value != 2) {
+				if (v->value)
+					input_start_autorepeat(dev, v->code);
+				else
+					input_stop_autorepeat(dev);
+			}
 		}
 	}
 }
-- 
1.7.9.5


---
This email has been checked for viruses by Avast antivirus software.
http://www.avast.com

