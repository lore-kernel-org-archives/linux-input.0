From: David Jander <david@protonic.nl>
Subject: [PATCH] input: touchscreen: ads7846.c: Avoid pen up/down when reading hwmon
Date: Mon, 20 Mar 2017 13:46:33 +0100
Message-ID: <20170320124633.5341-1-david@protonic.nl>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([83.163.252.89]:19325 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754564AbdCTOsv (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Mar 2017 10:48:51 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Petr Cvek <petr.cvek@tul.cz>, linux-input@vger.kernel.org, Imre Deak <imre.deak@nokia.com>, David Jander <david@protonic.nl>

Each time the HWMON devices are read (e.g. battery voltage) while the
touchscreen is held pressed, extra pen-up and pen-down events are
generated. This is fixed by avoiding the UP event when the touchscreen is
stopped.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/input/touchscreen/ads7846.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index f5793e3..735a0be 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -871,7 +871,7 @@ static irqreturn_t ads7846_irq(int irq, void *handle)
 				   msecs_to_jiffies(TS_POLL_PERIOD));
 	}
 
-	if (ts->pendown) {
+	if (ts->pendown && !ts->stopped) {
 		struct input_dev *input = ts->input;
 
 		input_report_key(input, BTN_TOUCH, 0);
-- 
2.9.3

