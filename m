From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 4/6] HID: wacom: generic: Leave tool in prox until it completely leaves sense
Date: Thu,  7 Sep 2017 17:49:50 -0700
Message-ID: <20170908004950.3034-1-ping.cheng@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34562 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752766AbdIHAuE (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 7 Sep 2017 20:50:04 -0400
Received: by mail-pf0-f194.google.com with SMTP id g65so402141pfe.1
        for <linux-input@vger.kernel.org>; Thu, 07 Sep 2017 17:50:04 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

From: Jason Gerecke <killertofu@gmail.com>

The legacy Intuos codepath and tablet behavior (e.g. the 1st-gen Intuos
Pro, Cintiq 27, etc.) would result in a BTN_TOOL_* event not being cleared
to zero until the tool had completely left the sensing range of the
tablet. Before the final "out of prox" packet would be sent, zero or
more "in range" packets could be sent to indicate that a pen was still
detectable but not within a useful distance. These "in range" packets
were used by the driver to keep touch input disabled at greater pen
distances. In addition to keeping the `stylus_in_proximity` flag set,
the driver would leave the current BTN_TOOL_* marked as being in
proximity as well.

The new HID codepath also sets `stylus_in_proximity` based on the "sense"
flag, but does not leave the current BTN_TOOL_* marked as being in prox.
This information is potentially useful to for a future userspace-based
palm rejection, so this patch modifies the driver to continue sending it.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
---
 drivers/hid/wacom_wac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index cdf95e1..9b3a247 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2217,8 +2217,8 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 	if (!usage->type || delay_pen_events(wacom_wac))
 		return;
 
-	/* send pen events only when the pen is in/entering/leaving range */
-	if (!wacom_wac->hid_data.inrange_state && !wacom_wac->tool[0])
+	/* send pen events only when the pen is in range */
+	if (!wacom_wac->hid_data.inrange_state)
 		return;
 
 	input_event(input, usage->type, usage->code, value);
@@ -2269,10 +2269,10 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 		 */
 		input_report_key(input, BTN_TOUCH,
 				wacom_wac->hid_data.tipswitch);
-		input_report_key(input, wacom_wac->tool[0], range);
+		input_report_key(input, wacom_wac->tool[0], sense);
 		if (wacom_wac->serial[0]) {
 			input_event(input, EV_MSC, MSC_SERIAL, wacom_wac->serial[0]);
-			input_report_abs(input, ABS_MISC, range ? id : 0);
+			input_report_abs(input, ABS_MISC, sense ? id : 0);
 		}
 
 		wacom_wac->hid_data.tipswitch = false;
@@ -2280,7 +2280,7 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 		input_sync(input);
 	}
 
-	if (!range) {
+	if (!sense) {
 		wacom_wac->tool[0] = 0;
 		wacom_wac->id[0] = 0;
 		wacom_wac->serial[0] = 0;
-- 
2.7.4

