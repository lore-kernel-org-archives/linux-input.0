From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 5/6] HID: wacom: generic: Send BTN_TOOL_PEN in prox once the pen enters range
Date: Thu,  7 Sep 2017 17:51:06 -0700
Message-ID: <20170908005106.3116-1-ping.cheng@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36772 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbdIHAvQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 7 Sep 2017 20:51:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id f84so631349pfj.3
        for <linux-input@vger.kernel.org>; Thu, 07 Sep 2017 17:51:16 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>

From: Jason Gerecke <killertofu@gmail.com>

When a pen is first able to to be sensed by the tablet, we would like
to inform userspace that a tool is nearby so that it can attempt to
perform palm rejection. Unfortunately, we don't know any information
about the tool that is nearby, so the best we can do is send a prox
event for a generic BTN_TOOL_PEN. If the pen later comes closer and
enters proximity, we can determine the actual tool type and send
BTN_TOOL_PEN out of prox if necessary.

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 9b3a247..929a1ce 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2247,6 +2247,17 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 			wacom_wac->tool[0] = wacom_intuos_get_tool_type(wacom_wac->id[0]);
 		else
 			wacom_wac->tool[0] = BTN_TOOL_PEN;
+
+		if (wacom_wac->shared->stylus_in_proximity &&
+		    wacom_wac->tool[0] != BTN_TOOL_PEN) {
+			input_report_key(input, BTN_TOOL_PEN, 0);
+			input_sync(input);
+		}
+	}
+	else if (!wacom_wac->tool[0] && !range) { /* entering in sense */
+		input_report_key(input, BTN_TOOL_PEN, sense);
+		input_report_key(input, BTN_TOUCH, 0);
+		input_sync(input);
 	}
 
 	/* keep pen state for touch events */
-- 
2.7.4

