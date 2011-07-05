From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/3 v2] input : wacom - Cleanup a return value for the old Bamboo
Date: Tue,  5 Jul 2011 16:26:00 -0700
Message-ID: <1309908360-18866-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59063 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741Ab1GEXY2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 19:24:28 -0400
Received: by iwn6 with SMTP id 6so5619237iwn.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 16:24:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

The old code may call input_sync without sending any other events.
Although the sync event will be ignored in the userland, eliminating
unnecessary kernel events is the right way to go.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 19554a4..03ebcc8 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -300,8 +300,8 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 				wacom->id[1] = 0;
 			input_report_abs(input, ABS_MISC, wacom->id[1]);
 			input_event(input, EV_MSC, MSC_SERIAL, 0xf0);
+			retval = 1;
 		}
-		retval = 1;
 		break;
 	}
 exit:
-- 
1.7.5.4

