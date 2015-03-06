From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 5/7] HID: wacom: Report battery status for Intuos Pro and Intuos5
Date: Fri,  6 Mar 2015 11:47:35 -0800
Message-ID: <1425671264-4944-5-git-send-email-killertofu@gmail.com>
References: <1425671264-4944-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:44004 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693AbbCFTr6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Mar 2015 14:47:58 -0500
Received: by pablj1 with SMTP id lj1so44786889pab.10
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2015 11:47:58 -0800 (PST)
In-Reply-To: <1425671264-4944-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org
Cc: pinglinux@gmail.com, benjamin.tissoires@redhat.com, Jason Gerecke <killertofu@gmail.com>

Calls the wacom_status_irq function to report battery status for the
Intuos Pro and Intuos5 (in addition to the already-reporting Intuos
and last-generation Bamboo).

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/hid/wacom_wac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f1e53f1..726fedb 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2062,6 +2062,8 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	case INTUOSPL:
 		if (len == WACOM_PKGLEN_BBTOUCH3)
 			sync = wacom_bpt3_touch(wacom_wac);
+		else if (wacom_wac->data[0] == WACOM_REPORT_USB)
+			sync = wacom_status_irq(wacom_wac, len);
 		else
 			sync = wacom_intuos_irq(wacom_wac);
 		break;
-- 
2.3.0

