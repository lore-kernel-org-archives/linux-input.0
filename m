From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/3] Input: wacom - Provide a range for the ABS_MISC axis
Date: Thu, 22 Aug 2013 18:15:36 -0700
Message-ID: <1377220537-1474-2-git-send-email-killertofu@gmail.com>
References: <1377220537-1474-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:37238 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301Ab3HWBQ2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Aug 2013 21:16:28 -0400
Received: by mail-pd0-f176.google.com with SMTP id q10so14025pdj.35
        for <linux-input@vger.kernel.org>; Thu, 22 Aug 2013 18:16:28 -0700 (PDT)
In-Reply-To: <1377220537-1474-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, pinglinux@gmail.com
Cc: Jason Gerecke <killertofu@gmail.com>

Android marks found axes as 'valid' only if they have a minimum
and maximum value that aren't equal. Since we don't actually
assign any range information for ABS_MISC, Android doesn't bother
to mark it such. This prevents userspace from being able to make
use of tool serial information.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 8ccfe91..869e9c9 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1468,6 +1468,8 @@ static void wacom_abs_set_axis(struct input_dev *input_dev,
 {
 	struct wacom_features *features = &wacom_wac->features;
 
+	input_set_abs_params(input_dev, ABS_MISC, INT_MIN, INT_MAX, 0, 0);
+
 	if (features->device_type == BTN_TOOL_PEN) {
 		input_set_abs_params(input_dev, ABS_X, 0, features->x_max,
 				     features->x_fuzz, 0);
-- 
1.8.3.4

