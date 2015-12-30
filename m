From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: evdev - Avoid duplicate checking of empty SYN_REPORT
Date: Thu, 31 Dec 2015 04:55:58 +0530
Message-ID: <1451517958-2173-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36699 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751132AbbL3XYQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Dec 2015 18:24:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, aniroop.mathur@gmail.com, Aniroop Mathur <a.mathur@samsung.com>

Input core already drops empty syn_report event so there is no need
to check again for dropping empty syn_report event in evdev handler
for all clients on every new event.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/evdev.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index e9ae3d5..6e242b7 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -276,13 +276,8 @@ static void evdev_pass_values(struct evdev_client *client,
 		if (__evdev_is_filtered(client, v->type, v->code))
 			continue;
 
-		if (v->type == EV_SYN && v->code == SYN_REPORT) {
-			/* drop empty SYN_REPORT */
-			if (client->packet_head == client->head)
-				continue;
-
+		if (v->type == EV_SYN && v->code == SYN_REPORT)
 			wakeup = true;
-		}
 
 		event.type = v->type;
 		event.code = v->code;
-- 
2.6.2

