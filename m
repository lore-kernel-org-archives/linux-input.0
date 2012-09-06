From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/5] Input: wacom - Allow any multi-input Intuos device to set prox
Date: Thu,  6 Sep 2012 15:53:26 -0700
Message-ID: <1346972010-1330-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51702 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab2IFWxm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Sep 2012 18:53:42 -0400
Received: by pbbrr13 with SMTP id rr13so3164584pbb.19
        for <linux-input@vger.kernel.org>; Thu, 06 Sep 2012 15:53:42 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com, chris@cnpbagwell.com
Cc: Jason Gerecke <killertofu@gmail.com>

The ability to set the proximity flag should apply to any device
that has both pen and touch input. Rather than listing classes of
devices known to meet this criteria, simply filter on the quirk
defining all such devices.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 532d067..a8bc6c9 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -326,7 +326,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 
 	/* Enter report */
 	if ((data[1] & 0xfc) == 0xc0) {
-		if (features->type >= INTUOS5S && features->type <= INTUOS5L)
+		if (features->quirks == WACOM_QUIRK_MULTI_INPUT)
 			wacom->shared->stylus_in_proximity = true;
 
 		/* serial number of the tool */
@@ -414,7 +414,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 
 	/* Exit report */
 	if ((data[1] & 0xfe) == 0x80) {
-		if (features->type >= INTUOS5S && features->type <= INTUOS5L)
+		if (features->quirks == WACOM_QUIRK_MULTI_INPUT)
 			wacom->shared->stylus_in_proximity = false;
 
 		/*
-- 
1.7.12

