From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] Input: wacom: Remove code duplication
Date: Fri,  1 Jun 2012 09:39:01 -0700
Message-ID: <1338568741-28365-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62786 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965403Ab2FAQjM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Jun 2012 12:39:12 -0400
Received: by dady13 with SMTP id y13so3009157dad.19
        for <linux-input@vger.kernel.org>; Fri, 01 Jun 2012 09:39:09 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jason Gerecke <killertofu@gmail.com>

Replaces code to calculate Intuos5 physical dimensions with a call
to an existing function that performs the same task.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_sys.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index b3a8bd3..50a804d 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -1144,10 +1144,7 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 			features->device_type = BTN_TOOL_FINGER;
 			features->pktlen = WACOM_PKGLEN_BBTOUCH3;
 
-			features->x_phy =
-				(features->x_max * 100) / features->x_resolution;
-			features->y_phy =
-				(features->y_max * 100) / features->y_resolution;
+			wacom_set_phy_from_res(features);
 
 			features->x_max = 4096;
 			features->y_max = 4096;
-- 
1.7.10.3

