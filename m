From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 4/7] input: atmel_mxt_ts: allow writing of SPT_USERDATA_T38 in atmel_mxt_ts driver
Date: Thu,  7 Feb 2013 15:17:45 +0100
Message-ID: <1360246668-2291-5-git-send-email-pmeerw@pmeerw.net>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47052 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758236Ab3BGOSB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Feb 2013 09:18:01 -0500
In-Reply-To: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, djkurtz@chromium.org, y0922.shim@samsung.com, Peter Meerwald <p.meerwald@bct-electronic.com>

From: Peter Meerwald <p.meerwald@bct-electronic.com>

beware: this may break boards using mxt_platform_data.config (which
is dangerous by design); boards in the kernel (mach-nuri.c, mach-goni.c)
don't use .config

Signed-off-by: Peter Meerwald <p.meerwald@bct-electronic.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 17cc15a..7fdd439 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -309,6 +309,7 @@ static bool mxt_object_writable(unsigned int type)
 	case MXT_SPT_GPIOPWM_T19:
 	case MXT_SPT_SELFTEST_T25:
 	case MXT_SPT_CTECONFIG_T28:
+	case MXT_SPT_USERDATA_T38:
 	case MXT_SPT_DIGITIZER_T43:
 	case MXT_SPT_CTECONFIG_T46:
 		return true;
-- 
1.7.9.5

