From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2] Input: wacom - DTH2242 Grip Pen id was off by one bit
Date: Mon, 15 Apr 2013 19:54:43 -0700
Message-ID: <1366080883-26423-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:52766 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935212Ab3DPCym (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Apr 2013 22:54:42 -0400
Received: by mail-pb0-f48.google.com with SMTP id xb4so26839pbc.7
        for <linux-input@vger.kernel.org>; Mon, 15 Apr 2013 19:54:42 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 49fdff0..9ec24df 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -359,7 +359,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		case 0x802: /* Intuos4 General Pen */
 		case 0x804: /* Intuos4 Marker Pen */
 		case 0x40802: /* Intuos4 Classic Pen */
-		case 0x18803: /* DTH2242 Grip Pen */
+		case 0x18802: /* DTH2242 Grip Pen */
 		case 0x022:
 			wacom->tool[idx] = BTN_TOOL_PEN;
 			break;
-- 
1.7.10.4

