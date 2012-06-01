From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] Input: wacom: Initialize and destroy LEDs for Intuos4 S tablets
Date: Fri,  1 Jun 2012 09:21:47 -0700
Message-ID: <1338567707-9831-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:59905 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965437Ab2FAQWK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Jun 2012 12:22:10 -0400
Received: by pbbrp8 with SMTP id rp8so3154173pbb.19
        for <linux-input@vger.kernel.org>; Fri, 01 Jun 2012 09:22:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jason Gerecke <killertofu@gmail.com>

This case appears to have been missed in the original commit.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_sys.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index b3a8bd3..d82d92d 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -855,6 +855,7 @@ static int wacom_initialize_leds(struct wacom *wacom)
 
 	/* Initialize default values */
 	switch (wacom->wacom_wac.features.type) {
+	case INTUOS4S:
 	case INTUOS4:
 	case INTUOS4L:
 		wacom->led.select[0] = 0;
@@ -908,6 +909,7 @@ static int wacom_initialize_leds(struct wacom *wacom)
 static void wacom_destroy_leds(struct wacom *wacom)
 {
 	switch (wacom->wacom_wac.features.type) {
+	case INTUOS4S:
 	case INTUOS4:
 	case INTUOS4L:
 		sysfs_remove_group(&wacom->intf->dev.kobj,
-- 
1.7.10.3

