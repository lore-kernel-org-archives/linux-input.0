From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2] input : wacom - Simplify type check for newer V5 devices
Date: Wed, 21 Nov 2012 10:42:40 -0800
Message-ID: <1353523360-6431-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:54786 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755689Ab2KUSmu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Nov 2012 13:42:50 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1834547dak.19
        for <linux-input@vger.kernel.org>; Wed, 21 Nov 2012 10:42:50 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

The updated type enum enables this implementation.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 7554a04..f09f39e 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -467,9 +467,7 @@ static void wacom_intuos_general(struct wacom_wac *wacom)
 	/* general pen packet */
 	if ((data[1] & 0xb8) == 0xa0) {
 		t = (data[6] << 2) | ((data[7] >> 6) & 3);
-		if ((features->type >= INTUOS4S && features->type <= INTUOS4L) ||
-                    (features->type >= INTUOS5S && features->type <= INTUOS5L) ||
-		    (features->type >= WACOM_21UX2 && features->type <= WACOM_24HD)) {
+		if ((features->type >= INTUOS4S && features->type <= WACOM_24HD)) {
 			t = (t << 1) | (data[1] & 1);
 		}
 		input_report_abs(input, ABS_PRESSURE, t);
-- 
1.7.10.4

