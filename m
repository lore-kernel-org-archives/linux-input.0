From: Anshul Garg <aksgarg1989@gmail.com>
Subject: [PATCH] Input: Optimize Event Filter functionality
Date: Mon,  5 Jan 2015 08:27:32 -0800
Message-ID: <1420475252-22427-1-git-send-email-aksgarg1989@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:43782 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbbAEQ2A (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jan 2015 11:28:00 -0500
Received: by mail-we0-f171.google.com with SMTP id u56so8216918wes.16
        for <linux-input@vger.kernel.org>; Mon, 05 Jan 2015 08:27:59 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com, anshul.g@samsung.com, p.shailesh@samsung.com

From: Anshul Garg <aksgarg1989@gmail.com>

As input_pass_values function is called everytime when EV_SYN is sent
from input driver or input event buffer becomes full.
So in case of regular handler event filter code should not run so added
check whether handler supports filter or not.

Signed-off-by: Anshul Garg <anshul.g@samsung.com>
---
 drivers/input/input.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 213e3a1..de55279 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -100,23 +100,24 @@ static unsigned int input_to_handler(struct input_handle *handle,
 	struct input_value *end = vals;
 	struct input_value *v;
 
-	for (v = vals; v != vals + count; v++) {
-		if (handler->filter &&
-		    handler->filter(handle, v->type, v->code, v->value))
-			continue;
-		if (end != v)
-			*end = *v;
-		end++;
+	if (handler->filter) {
+		for (v = vals; v != vals + count; v++) {
+			if (handler->filter(handle, v->type, v->code, v->value))
+				continue;
+			if (end != v)
+				*end = *v;
+			end++;
+		}
+		count = end - vals;
 	}
 
-	count = end - vals;
 	if (!count)
 		return 0;
 
 	if (handler->events)
 		handler->events(handle, vals, count);
 	else if (handler->event)
-		for (v = vals; v != end; v++)
+		for (v = vals; v != vals + count; v++)
 			handler->event(handle, v->type, v->code, v->value);
 
 	return count;
@@ -143,8 +144,11 @@ static void input_pass_values(struct input_dev *dev,
 		count = input_to_handler(handle, vals, count);
 	} else {
 		list_for_each_entry_rcu(handle, &dev->h_list, d_node)
-			if (handle->open)
+			if (handle->open) {
 				count = input_to_handler(handle, vals, count);
+				if (!count)
+					break;
+			}
 	}
 
 	rcu_read_unlock();
-- 
1.7.9.5


---
This email has been checked for viruses by Avast antivirus software.
http://www.avast.com

