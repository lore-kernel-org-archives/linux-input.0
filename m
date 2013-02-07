From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/7] input: atmel_mxt_ts: allow to read/display MXT_GEN_MESSAGE_T5 object
Date: Thu,  7 Feb 2013 15:17:43 +0100
Message-ID: <1360246668-2291-3-git-send-email-pmeerw@pmeerw.net>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47041 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757499Ab3BGOSA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Feb 2013 09:18:00 -0500
In-Reply-To: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, djkurtz@chromium.org, y0922.shim@samsung.com, Peter Meerwald <p.meerwald@bct-electronic.com>

From: Peter Meerwald <p.meerwald@bct-electronic.com>

Signed-off-by: Peter Meerwald <p.meerwald@bct-electronic.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index fc52dc5..63a82bb 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -251,6 +251,7 @@ struct mxt_data {
 static bool mxt_object_readable(unsigned int type)
 {
 	switch (type) {
+	case MXT_GEN_MESSAGE_T5:
 	case MXT_GEN_COMMAND_T6:
 	case MXT_GEN_POWER_T7:
 	case MXT_GEN_ACQUIRE_T8:
-- 
1.7.9.5

