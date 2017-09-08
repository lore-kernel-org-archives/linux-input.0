From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/6] HID: wacom: generic: Clear ABS_MISC when tool leaves proximity
Date: Thu,  7 Sep 2017 17:47:38 -0700
Message-ID: <20170908004738.2893-1-ping.cheng@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32980 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752658AbdIHAry (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 7 Sep 2017 20:47:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, "stable # v4 . 10" <stable@vger.kernel.org>, Ping Cheng <ping.cheng@wacom.com>, Jason Gerecke <jason.gerecke@wacom.com>

From: Jason Gerecke <killertofu@gmail.com>

The tool ID information sent in ABS_MISC is expected to be reset to 0
when a tool leaves proximity. Not doing this can cause problems if a
tool is removed and then re-introduced. Kernel event filtering will
prevent the (identical) ABS_MISC event from being sent when the tool
re-enters proxmity. This can cause userspace to not properly set the
tool ID.

Fixes: f85c9dc678 ("HID: wacom: generic: Support tool ID and additional tool types")
Cc: stable # v4.10 <stable@vger.kernel.org>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index e2ba36d..aa692e2 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2272,7 +2272,7 @@ static void wacom_wac_pen_report(struct hid_device *hdev,
 		input_report_key(input, wacom_wac->tool[0], prox);
 		if (wacom_wac->serial[0]) {
 			input_event(input, EV_MSC, MSC_SERIAL, wacom_wac->serial[0]);
-			input_report_abs(input, ABS_MISC, id);
+			input_report_abs(input, ABS_MISC, prox ? id : 0);
 		}
 
 		wacom_wac->hid_data.tipswitch = false;
-- 
2.7.4

