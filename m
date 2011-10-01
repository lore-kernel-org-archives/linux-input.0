From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] Revert "Input: wacom - Cintiq 21UX2 does not have menu strips"
Date: Fri, 30 Sep 2011 17:12:02 -0700
Message-ID: <1317427922-2277-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:43248 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523Ab1JAAMg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Sep 2011 20:12:36 -0400
Received: by iaqq3 with SMTP id q3so2317774iaq.19
        for <linux-input@vger.kernel.org>; Fri, 30 Sep 2011 17:12:35 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, pinglinux@gmail.com, Jason Gerecke <killertofu@gmail.com>

This reverts commit 71c86ce59791bcd67af937bbea719a508079d7c2.
The 21UX2 does have touchstrips, but they are in a somewhat-
hidden location.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index c1c2f7b..57227b5 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1120,11 +1120,8 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 		for (i = 0; i < 8; i++)
 			__set_bit(BTN_0 + i, input_dev->keybit);
 
-		if (wacom_wac->features.type != WACOM_21UX2) {
-			input_set_abs_params(input_dev, ABS_RX, 0, 4096, 0, 0);
-			input_set_abs_params(input_dev, ABS_RY, 0, 4096, 0, 0);
-		}
-
+		input_set_abs_params(input_dev, ABS_RX, 0, 4096, 0, 0);
+		input_set_abs_params(input_dev, ABS_RY, 0, 4096, 0, 0);
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		wacom_setup_cintiq(wacom_wac);
 		break;
-- 
1.7.6

