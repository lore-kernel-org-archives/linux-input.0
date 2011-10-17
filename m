From: chris@cnpbagwell.com
Subject: [PATCH 2/6] Input: wacom - remove unused bamboo HID parsing
Date: Sun, 16 Oct 2011 20:29:37 -0500
Message-ID: <1318814981-30607-3-git-send-email-chris@cnpbagwell.com>
References: <1318814981-30607-1-git-send-email-chris@cnpbagwell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:41288 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567Ab1JQB3v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 16 Oct 2011 21:29:51 -0400
Received: by mail-gy0-f174.google.com with SMTP id 13so2513599gyb.19
        for <linux-input@vger.kernel.org>; Sun, 16 Oct 2011 18:29:50 -0700 (PDT)
In-Reply-To: <1318814981-30607-1-git-send-email-chris@cnpbagwell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com
Cc: Chris Bagwell <chris@cnpbagwell.com>

From: Chris Bagwell <chris@cnpbagwell.com>

Bamboo's do not declared a Digitizer-Stylus so the if() was
never executed.  wacom_features already contains correct stylus
packet length.

Signed-off-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/input/tablet/wacom_sys.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 4f35473..620f0c3 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -245,8 +245,6 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 						/* penabled only accepts exact bytes of data */
 						if (features->type == TABLETPC2FG)
 							features->pktlen = WACOM_PKGLEN_GRAPHIRE;
-						if (features->type == BAMBOO_PT)
-							features->pktlen = WACOM_PKGLEN_BBFUN;
 						features->device_type = BTN_TOOL_PEN;
 						features->x_max =
 							get_unaligned_le16(&report[i + 3]);
@@ -295,8 +293,6 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 						/* penabled only accepts exact bytes of data */
 						if (features->type == TABLETPC2FG)
 							features->pktlen = WACOM_PKGLEN_GRAPHIRE;
-						if (features->type == BAMBOO_PT)
-							features->pktlen = WACOM_PKGLEN_BBFUN;
 						features->device_type = BTN_TOOL_PEN;
 						features->y_max =
 							get_unaligned_le16(&report[i + 3]);
-- 
1.7.6.4

