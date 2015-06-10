From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1 linux-next] HID: use swap() in cp_report_fixup()
Date: Wed, 10 Jun 2015 18:32:05 +0200
Message-ID: <1433953925-23857-1-git-send-email-fabf@skynet.be>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay110.isp.belgacom.be ([195.238.20.137]:6993 "EHLO
	mailrelay110.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933929AbbFJQcO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jun 2015 12:32:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Fabian Frederick <fabf@skynet.be>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

Use kernel.h macro definition.

Thanks to Julia Lawall for Coccinelle scripting support.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/hid/hid-cypress.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/hid/hid-cypress.c b/drivers/hid/hid-cypress.c
index c4ef3bc..1b764d1 100644
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
+			swap(rdesc[i + 3], rdesc[i + 1]);
 		}
 	return rdesc;
 }
-- 
2.4.2

