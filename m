From: Anshul@vger.kernel.org, Garg@vger.kernel.org
Subject: [PATCH] Input: Optimize input_to_handler and input_pass_values function
Date: Tue, 30 Dec 2014 11:03:57 +0530
Message-ID: <1419917637-14744-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:37711 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbaL3Fem (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Dec 2014 00:34:42 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0NHD00LD0RHS4GD0@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Tue, 30 Dec 2014 14:34:40 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru, linux-input@vger.kernel.org
Cc: aksgarg1989@gmail.com, anshul.g@samsung.com, p.shailesh@samsung.com

From: Anshul Garg <anshul.g@samsung.com>

As input_pass_values function is called everytime when EV_SYN is sent from
input driver or input event buffer becomes full.

1. In case of regular handler, event filter code should not run so added check 
   whether handler supports filter or not.
2. If input device doesn't support EV_KEY event type avoid running auto repeat code.

Signed-off-by: Anshul Garg <anshul.g@samsung.com>
---
 drivers/input/input.c |   37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index bbec2dc..9d6609b 100644
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
@@ -143,8 +144,10 @@ static void input_pass_values(struct input_dev *dev,
 		count = input_to_handler(handle, vals, count);
 	} else {
 		list_for_each_entry_rcu(handle, &dev->h_list, d_node)
-			if (handle->open)
+			if (handle->open && count)
 				count = input_to_handler(handle, vals, count);
+			else
+				break;
 	}
 
 	rcu_read_unlock();
@@ -152,12 +155,14 @@ static void input_pass_values(struct input_dev *dev,
 	add_input_randomness(vals->type, vals->code, vals->value);
 
 	/* trigger auto repeat for key events */
-	for (v = vals; v != vals + count; v++) {
-		if (v->type == EV_KEY && v->value != 2) {
-			if (v->value)
-				input_start_autorepeat(dev, v->code);
-			else
-				input_stop_autorepeat(dev);
+	if (test_bit(EV_KEY, dev->evbit)) {
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

