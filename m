From: Goffredo Baroncelli <kreijack@gmail.com>
Subject: [PATCH 1/3] Don't copy more than 'count' byte
Date: Sat, 23 Aug 2014 14:40:27 +0200
Message-ID: <1408797629-3474-2-git-send-email-kreijack@inwind.it>
References: <1408797629-3474-1-git-send-email-kreijack@inwind.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:47242 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbaHWMeY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Aug 2014 08:34:24 -0400
Received: by mail-wg0-f42.google.com with SMTP id l18so11179499wgh.13
        for <linux-input@vger.kernel.org>; Sat, 23 Aug 2014 05:34:23 -0700 (PDT)
In-Reply-To: <1408797629-3474-1-git-send-email-kreijack@inwind.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Goffredo Baroncelli <kreijack@inwind.it>

Don't copy more than 'count' byte, because *buf may be
shorter than DJREPORT_SHORT_LENGTH,and this means an
access violation. Of course count cannot be greather
than the result buffer.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 drivers/hid/hid-logitech-dj.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 486dbde..ca0ab51 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -557,7 +557,7 @@ static int logi_dj_ll_raw_request(struct hid_device *hid,
 	if (!out_buf)
 		return -ENOMEM;
 
-	if (count < DJREPORT_SHORT_LENGTH - 2)
+	if (count > DJREPORT_SHORT_LENGTH - 2)
 		count = DJREPORT_SHORT_LENGTH - 2;
 
 	out_buf[0] = REPORT_ID_DJ_SHORT;
-- 
1.9.3

