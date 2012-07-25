From: Baodong Chen <chenbdchenbd@gmail.com>
Subject: [PATCH] fixed a macro coding style issue
Date: Wed, 25 Jul 2012 13:20:56 +0800
Message-ID: <1343193656-2643-1-git-send-email-chenbdchenbd@gmail.com>
References: <no>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51485 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2GYFVp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 01:21:45 -0400
In-Reply-To: <no>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Baodong Chen <chenbdchenbd@gmail.com>

Fixed a coding style issue in driver/input/input.c

Signed-off-by: Baodong Chen <chenbdchenbd@gmail.com>
---
 drivers/input/input.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 8921c61..c96e983 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -845,11 +845,13 @@ int input_set_keycode(struct input_dev *dev,
 EXPORT_SYMBOL(input_set_keycode);
 
 #define MATCH_BIT(bit, max) \
+	do { \
 		for (i = 0; i < BITS_TO_LONGS(max); i++) \
 			if ((id->bit[i] & dev->bit[i]) != id->bit[i]) \
 				break; \
-		if (i != BITS_TO_LONGS(max)) \
-			continue;
+			if (i != BITS_TO_LONGS(max)) \
+				continue; \
+	} while (0)
 
 static const struct input_device_id *input_match_device(struct input_handler *handler,
 							struct input_dev *dev)
-- 
1.7.0.4

