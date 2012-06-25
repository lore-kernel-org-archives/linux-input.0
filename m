From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/4] input - wacom: fix retrieving touch_max bug
Date: Mon, 25 Jun 2012 14:35:45 -0700
Message-ID: <1340660145-27361-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59989 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756633Ab2FYVbv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jun 2012 17:31:51 -0400
Received: by dady13 with SMTP id y13so5874918dad.19
        for <linux-input@vger.kernel.org>; Mon, 25 Jun 2012 14:31:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

rep_data has already been declared as a pointer.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 9e8fdcf..c2fb698 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -213,7 +213,7 @@ static void wacom_retrieve_report_data(struct usb_interface *intf,
 
 		rep_data[0] = 12;
 		result = wacom_get_report(intf, WAC_HID_FEATURE_REPORT,
-					  rep_data[0], &rep_data, 2,
+					  rep_data[0], rep_data, 2,
 					  WAC_MSG_RETRIES);
 
 		if (result >= 0 && rep_data[1] > 2)
-- 
1.7.7.6

