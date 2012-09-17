From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] HID: cypress: Use swap macro
Date: Mon, 17 Sep 2012 21:35:32 +0800
Message-ID: <1347888932.7521.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62235 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab2IQNfk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 09:35:40 -0400
Received: by oago6 with SMTP id o6so4711282oag.19
        for <linux-input@vger.kernel.org>; Mon, 17 Sep 2012 06:35:40 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-input@vger.kernel.org

This simplify the implementation.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hid/hid-cypress.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hid/hid-cypress.c b/drivers/hid/hid-cypress.c
index 3e159a5..3b795a2 100644
--- a/drivers/hid/hid-cypress.c
+++ b/drivers/hid/hid-cypress.c
@@ -41,13 +41,9 @@ static __u8 *cp_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 
 	for (i = 0; i < *rsize - 4; i++)
 		if (rdesc[i] == 0x29 && rdesc[i + 2] == 0x19) {
-			__u8 tmp;
-
 			rdesc[i] = 0x19;
 			rdesc[i + 2] = 0x29;
-			tmp = rdesc[i + 3];
-			rdesc[i + 3] = rdesc[i + 1];
-			rdesc[i + 1] = tmp;
+			swap(rdesc[i + 1], rdesc[i + 3]);
 		}
 	return rdesc;
 }
-- 
1.7.9.5



