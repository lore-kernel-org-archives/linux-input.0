From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/4 v3] input: wacom - Scale up touch width and height values for Intuos Pro
Date: Fri, 15 Nov 2013 11:58:24 -0800
Message-ID: <1384545504-15434-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:65171 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446Ab3KOT6c (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Nov 2013 14:58:32 -0500
Received: by mail-pb0-f45.google.com with SMTP id mc8so4034538pbc.4
        for <linux-input@vger.kernel.org>; Fri, 15 Nov 2013 11:58:31 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, killertofu@gmail.com, chris@cnpbagwell.com, peter.hutterer@who-t.net

From: Signed-off-by: Jason Gerecke <killertofu@gmail.com>

The width and height values reported by the Intuos Pro are not in
surface units as required by the MT protocol. A simple multiplier
of 100x corrects it.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
Acked-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 9c8eded..3f75f1d 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1151,8 +1151,8 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 		int width, height;
 
 		if (features->type >= INTUOSPS && features->type <= INTUOSPL) {
-			width  = data[5];
-			height = data[6];
+			width  = data[5] * 100;
+			height = data[6] * 100;
 		} else {
 			/*
 			 * "a" is a scaled-down area which we assume is
-- 
1.8.3.2

