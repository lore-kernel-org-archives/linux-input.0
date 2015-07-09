From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] HID: input: call input_sync() when automatically releasing a
 key
Date: Thu, 9 Jul 2015 14:33:21 -0700
Message-ID: <20150709213321.GA9268@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35255 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235AbbGIVd0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jul 2015 17:33:26 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

We need to emit EV_SYN/SYN_REPORT between key press and release, otherwise
userspace is allowed to "swallow" the event.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Observed this with Plantronics headsets...

 drivers/hid/hid-input.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 008e89b..50caf14 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1162,8 +1162,11 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 
 	input_event(input, usage->type, usage->code, value);
 
-	if ((field->flags & HID_MAIN_ITEM_RELATIVE) && (usage->type == EV_KEY))
+	if ((field->flags & HID_MAIN_ITEM_RELATIVE) &&
+	    usage->type == EV_KEY && value) {
+		input_sync(input);
 		input_event(input, usage->type, usage->code, 0);
+	}
 }
 
 void hidinput_report_event(struct hid_device *hid, struct hid_report *report)
-- 
2.4.3.573.g4eafbef


-- 
Dmitry
