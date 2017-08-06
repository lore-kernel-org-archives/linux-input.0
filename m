From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 5/8] Input: appletouch: constify usb_device_id.
Date: Sun,  6 Aug 2017 13:11:24 +0530
Message-ID: <1502005287-17705-6-git-send-email-arvind.yadav.cs@gmail.com>
References: <1502005287-17705-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32835 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbdHFHly (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 6 Aug 2017 03:41:54 -0400
In-Reply-To: <1502005287-17705-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

usb_device_id are not supposed to change at runtime. All functions
working with usb_device_id provided by <linux/usb.h> work with
const usb_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/mouse/appletouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index ef234c9..81a695d 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -125,7 +125,7 @@ static const struct atp_info geyser4_info = {
  *  According to Info.plist Geyser IV is the same as Geyser III.)
  */
 
-static struct usb_device_id atp_table[] = {
+static const struct usb_device_id atp_table[] = {
 	/* PowerBooks Feb 2005, iBooks G4 */
 	ATP_DEVICE(0x020e, fountain_info),	/* FOUNTAIN ANSI */
 	ATP_DEVICE(0x020f, fountain_info),	/* FOUNTAIN ISO */
-- 
2.7.4

