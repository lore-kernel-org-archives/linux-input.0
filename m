From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] Input: wacom - Fix wacom->shared guards for dual input devices
Date: Wed, 15 Jan 2014 14:04:17 -0800
Message-ID: <1389823457-3649-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:40905 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754546AbaAOWE1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Jan 2014 17:04:27 -0500
Received: by mail-pb0-f54.google.com with SMTP id un15so1754007pbc.27
        for <linux-input@vger.kernel.org>; Wed, 15 Jan 2014 14:04:27 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

features->quirks can have multiple bits set. For dual input, we only
need to check WACOM_QUIRK_MULTI_INPUT.

Reviewed-by: Jason Gerecke <killertofu@gmail.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 048e5b3..0bcc7a6 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -331,7 +331,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 
 	/* Enter report */
 	if ((data[1] & 0xfc) == 0xc0) {
-		if (features->quirks == WACOM_QUIRK_MULTI_INPUT)
+		if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
 			wacom->shared->stylus_in_proximity = true;
 
 		/* serial number of the tool */
@@ -436,7 +436,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 
 	/* Exit report */
 	if ((data[1] & 0xfe) == 0x80) {
-		if (features->quirks == WACOM_QUIRK_MULTI_INPUT)
+		if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
 			wacom->shared->stylus_in_proximity = false;
 
 		/*
-- 
1.8.3.2

