From: Xianhan Yu <aroundight77@gmail.com>
Subject: [PATCH 1/1] hid:Fix maxcontacts problem on GeneralTouch multi-touchscreen.
Date: Mon, 29 Oct 2012 23:04:37 +0800
Message-ID: <1351523077-2177-1-git-send-email-aroundight77@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:65255 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab2J2HDQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Oct 2012 03:03:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, yxhma <yxhma@163.com>, Xianhan Yu <aroundight77@gmail.com>

Fix maxcontacts problem for PWT GeneralTouch multi-touchscreen,modify driver for all GeneralTouch PWT touchscreen.

Signed-off-by: Xianhan Yu <aroundight77@gmail.com>
---
 drivers/hid/hid-multitouch.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 3eb02b9..7afeb77 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -210,8 +210,7 @@ static struct mt_class mt_classes[] = {
 	},
 	{ .name	= MT_CLS_GENERALTOUCH_PWT_TENFINGERS,
 		.quirks	= MT_QUIRK_NOT_SEEN_MEANS_UP |
-			MT_QUIRK_SLOT_IS_CONTACTNUMBER,
-		.maxcontacts = 10
+			MT_QUIRK_SLOT_IS_CONTACTNUMBER
 	},
 
 	{ .name = MT_CLS_FLATFROG,
-- 
1.7.9.5

