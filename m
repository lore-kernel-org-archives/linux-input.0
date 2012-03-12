From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] input: wacom: Fix physical size calculation for 3rd-gen Bamboo
Date: Mon, 12 Mar 2012 15:53:04 -0700
Message-ID: <1331592784-6894-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:56290 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757699Ab2CLWxN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Mar 2012 18:53:13 -0400
Received: by yhmm54 with SMTP id m54so3148813yhm.19
        for <linux-input@vger.kernel.org>; Mon, 12 Mar 2012 15:53:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, chris@cnpbagwell.com, linuxwacom-devel@lists.sourceforge.net
Cc: Jason Gerecke <killertofu@gmail.com>

This calculation determines the physical dimensions of the tablet,
used later on in calculate_touch_res to obtain the touch sensor
resolution.

Instead of dividing the logical size by the resolution, the current
code performs a multiplication. This doesn't pose a problem for the
3rd-gen Bamboo since the resolution and scale factor happen to be
identical, but will produce an incorrect result for other cases.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_sys.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index c9588ee..dc07821 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -184,9 +184,9 @@ static int wacom_parse_logical_collection(unsigned char *report,
 		 * data before its overwritten.
 		 */
 		features->x_phy =
-			(features->x_max * features->x_resolution) / 100;
+			(features->x_max * 100) / features->x_resolution;
 		features->y_phy =
-			(features->y_max * features->y_resolution) / 100;
+			(features->y_max * 100) / features->y_resolution;
 
 		features->x_max = features->y_max =
 			get_unaligned_le16(&report[10]);
-- 
1.7.9.1

