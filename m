From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 4/4] Only report multi-touch when pen is out of range
Date: Thu,  7 Jul 2011 14:05:00 -0700
Message-ID: <1310072700-2829-4-git-send-email-killertofu@gmail.com>
References: <1310072700-2829-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:44523 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391Ab1GGVFi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2011 17:05:38 -0400
Received: by pzk9 with SMTP id 9so1031139pzk.19
        for <linux-input@vger.kernel.org>; Thu, 07 Jul 2011 14:05:37 -0700 (PDT)
In-Reply-To: <1310072700-2829-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jgerecke@wacom.com>, Dima Zavin <dima@android.com>, Jason Gerecke <killertofu@gmail.com>

Don't bother evaluating multi-touch packets from the hardware
when the pen is in range. Single-touch is already filtered, but
not MT.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 Now being sent upstream to LKML at the behest of Google.

 drivers/input/touchscreen/wacom_w8001.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 40ed685..393fd3c 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -379,7 +379,10 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 	/* 2 finger touch packet */
 	case W8001_PKTLEN_TOUCH2FG - 1:
 		w8001->idx = 0;
-		parse_multi_touch(w8001);
+		if (w8001->type != BTN_TOOL_PEN &&
+		    w8001->type != BTN_TOOL_RUBBER) {
+			parse_multi_touch(w8001);
+		}
 		break;
 	}
 
-- 
1.7.5.2

