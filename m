From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] Add a new stylus (0x100802) for Intuos5 and Cintiqs
Date: Tue, 11 Jun 2013 15:02:25 -0700
Message-ID: <1370988145-12850-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:53840 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753253Ab3FKWCg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Jun 2013 18:02:36 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so3223312pdj.38
        for <linux-input@vger.kernel.org>; Tue, 11 Jun 2013 15:02:35 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 518282d..384fbcd 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -363,6 +363,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		case 0x140802: /* Intuos4/5 13HD/24HD Classic Pen */
 		case 0x160802: /* Cintiq 13HD Pro Pen */
 		case 0x180802: /* DTH2242 Pen */
+		case 0x100802: /* Intuos4/5 13HD/24HD General Pen */
 			wacom->tool[idx] = BTN_TOOL_PEN;
 			break;
 
@@ -401,6 +402,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		case 0x10080c: /* Intuos4/5 13HD/24HD Art Pen Eraser */
 		case 0x16080a: /* Cintiq 13HD Pro Pen Eraser */
 		case 0x18080a: /* DTH2242 Eraser */
+		case 0x10080a: /* Intuos4/5 13HD/24HD General Pen Eraser */
 			wacom->tool[idx] = BTN_TOOL_RUBBER;
 			break;
 
-- 
1.8.1.2

