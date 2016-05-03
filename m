From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] HID: wacom: add missed stylus_in_proximity line back
Date: Mon,  2 May 2016 21:17:34 -0700
Message-ID: <1462249054-3515-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35470 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbcECERv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 May 2016 00:17:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id r187so616130pfr.2
        for <linux-input@vger.kernel.org>; Mon, 02 May 2016 21:17:51 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, benjamin.tissoires@gmail.com
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Patch 7e12978 removed stylus_in_proximity flag for Intuos series.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_wac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index bd198bb..e3e4377 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -684,6 +684,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 
 		wacom->tool[idx] = wacom_intuos_get_tool_type(wacom->id[idx]);
 
+		wacom->shared->stylus_in_proximity = true;
 		return 1;
 	}
 
-- 
2.1.0

