From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2] HID: wacom: do not send pen events before touch is up/forced out
Date: Fri, 20 Feb 2015 14:25:58 -0800
Message-ID: <1424471158-4668-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:39800 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbbBTW0H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 17:26:07 -0500
Received: by pdjy10 with SMTP id y10so10605645pdj.6
        for <linux-input@vger.kernel.org>; Fri, 20 Feb 2015 14:26:05 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

If pen comes in proximity while touch is down, we force touch up
before sending pen events. Otherwise, there can be unfinished
touch events compete with pen events. This idea has been fully
implemented for Tablet PCs. But other tablets that support both
pen and touch are not fully considered.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 046351c..69827c9 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -554,6 +554,9 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 	if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
 		wacom->shared->stylus_in_proximity = true;
 
+	if (wacom->shared->touch_down)
+		return 1;
+
 	/* in Range while exiting */
 	if (((data[1] & 0xfe) == 0x20) && wacom->reporting_data) {
 		input_report_key(input, BTN_TOUCH, 0);
@@ -1759,6 +1762,9 @@ static int wacom_bpt_pen(struct wacom_wac *wacom)
 		return 0;
 	}
 
+	if (wacom->shared->touch_down)
+		return 0;
+
 	prox = (data[1] & 0x20) == 0x20;
 
 	/*
-- 
1.9.1

