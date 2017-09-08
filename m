From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 6/6] HID: wacom: generic: Reset events back to zero when pen leaves
Date: Thu,  7 Sep 2017 17:52:15 -0700
Message-ID: <20170908005215.3168-1-ping.cheng@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33130 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751981AbdIHAw1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 7 Sep 2017 20:52:27 -0400
Received: by mail-pf0-f195.google.com with SMTP id h4so641098pfk.0
        for <linux-input@vger.kernel.org>; Thu, 07 Sep 2017 17:52:27 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

From: Jason Gerecke <killertofu@gmail.com>

As a pen leaves, we need to be sure to reset all events back to zero
so that userspace is able to get the complete pen state when it enters
proximity again.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
---
 drivers/hid/wacom_wac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 929a1ce..2926e36 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2218,10 +2218,10 @@ static void wacom_wac_pen_event(struct hid_device *hdev, struct hid_field *field
 		return;
 
 	/* send pen events only when the pen is in range */
-	if (!wacom_wac->hid_data.inrange_state)
-		return;
-
-	input_event(input, usage->type, usage->code, value);
+	if (wacom_wac->hid_data.inrange_state)
+		input_event(input, usage->type, usage->code, value);
+	else if (wacom_wac->shared->stylus_in_proximity && !wacom_wac->hid_data.sense_state)
+		input_event(input, usage->type, usage->code, 0);
 }
 
 static void wacom_wac_pen_pre_report(struct hid_device *hdev,
-- 
2.7.4

