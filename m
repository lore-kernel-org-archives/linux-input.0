From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 6/7] input: atmel_mxt_ts: add PROCI_ADAPTIVETHRESHOLD_T55 object readable/writable
Date: Thu,  7 Feb 2013 15:17:47 +0100
Message-ID: <1360246668-2291-7-git-send-email-pmeerw@pmeerw.net>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47058 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758656Ab3BGOSB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Feb 2013 09:18:01 -0500
In-Reply-To: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, djkurtz@chromium.org, y0922.shim@samsung.com, Peter Meerwald <p.meerwald@bct-electronic.com>

From: Peter Meerwald <p.meerwald@bct-electronic.com>

Signed-off-by: Peter Meerwald <p.meerwald@bct-electronic.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 313b201..7ade272 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -66,6 +66,7 @@
 #define MXT_PROCI_PALM_T41		41
 #define MXT_PROCI_TOUCHSUPPRESSION_T42	42
 #define MXT_PROCI_STYLUS_T47		47
+#define MXT_PROCI_ADAPTIVETHRESHOLD_T55 55
 #define MXT_PROCG_NOISESUPPRESSION_T48	48
 #define MXT_SPT_COMMSCONFIG_T18		18
 #define MXT_SPT_GPIOPWM_T19		19
@@ -272,6 +273,7 @@ static bool mxt_object_readable(unsigned int type)
 	case MXT_PROCI_PALM_T41:
 	case MXT_PROCI_TOUCHSUPPRESSION_T42:
 	case MXT_PROCI_STYLUS_T47:
+	case MXT_PROCI_ADAPTIVETHRESHOLD_T55:
 	case MXT_PROCG_NOISESUPPRESSION_T48:
 	case MXT_SPT_COMMSCONFIG_T18:
 	case MXT_SPT_GPIOPWM_T19:
@@ -305,6 +307,7 @@ static bool mxt_object_writable(unsigned int type)
 	case MXT_PROCI_TOUCHSUPPRESSION_T42:
 	case MXT_PROCI_STYLUS_T47:
 	case MXT_PROCG_NOISESUPPRESSION_T48:
+	case MXT_PROCI_ADAPTIVETHRESHOLD_T55:
 	case MXT_SPT_COMMSCONFIG_T18:
 	case MXT_SPT_GPIOPWM_T19:
 	case MXT_SPT_SELFTEST_T25:
-- 
1.7.9.5

