From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/3 v2] input : wacom - Add serial number for Graphire4 and old Bamboo
Date: Tue,  5 Jul 2011 16:25:04 -0700
Message-ID: <1309908304-18792-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65079 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567Ab1GEXXf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Jul 2011 19:23:35 -0400
Received: by iyb12 with SMTP id 12so5629017iyb.19
        for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 16:23:34 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

With the removal of BTN_TOOL_FINGER for tablet buttons and
expresskeys, serial number is needed to distingush if the
events were from a regular tool (stylus, eraser, or mouse)
or the attribures (buttons, strips, or wheels) on the tablet
since there are overlapped events between the tools and the
tablet attributes.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 7ce1294..b93501a 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -265,6 +265,7 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 			wacom->id[0] = 0;
 		input_report_abs(input, ABS_MISC, wacom->id[0]); /* report tool id */
 		input_report_key(input, wacom->tool[0], prox);
+		input_event(input, EV_MSC, MSC_SERIAL, 1);
 		input_sync(input); /* sync last event */
 	}
 
-- 
1.7.5.4

