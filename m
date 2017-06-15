From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] USB: gtco: remove unnecessary variable assignments
Date: Wed, 14 Jun 2017 20:50:29 -0500
Message-ID: <20170615015029.GA5601@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gateway31.websitewelcome.com ([192.185.143.47]:44508 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752063AbdFOCMa (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Jun 2017 22:12:30 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id A490513BC33
        for <linux-input@vger.kernel.org>; Wed, 14 Jun 2017 20:50:30 -0500 (CDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

Remove unnecessary variable assignments.
Variable _val_ is overwritten before the value stored in it can be used.

Addresses-Coverity-ID: 1397695
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/input/tablet/gtco.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
index b796e89..d9de13c 100644
--- a/drivers/input/tablet/gtco.c
+++ b/drivers/input/tablet/gtco.c
@@ -652,8 +652,6 @@ static void gtco_urb_callback(struct urb *urbinfo)
 		switch (device->buffer[0]) {
 		case 5:
 			/* Pressure is 9 bits */
-			val = ((u16)(device->buffer[8]) << 1);
-			val |= (u16)(device->buffer[7] >> 7);
 			input_report_abs(inputdev, ABS_PRESSURE,
 					 device->buffer[8]);
 
-- 
2.5.0

