From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH 3/4] Input: atmel_mxt_ts - Add objects of mXT1386 chip
Date: Mon, 07 Mar 2011 17:42:15 +0900
Message-ID: <1299487335-24139-3-git-send-email-jy0922.shim@samsung.com>
References: <1299487335-24139-1-git-send-email-jy0922.shim@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:50812 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355Ab1CGImJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Mar 2011 03:42:09 -0500
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LHO00746IS6VJ90@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Mar 2011 17:40:54 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LHO00I3DIS6T0@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 07 Mar 2011 17:40:54 +0900 (KST)
In-reply-to: <1299487335-24139-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, iiro.valkonen@atmel.com, kyungmin.park@samsung.com

Atmel mXT1386 chip is operated by atmel_mxt_ts driver and it has some
different objects.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 0ed0b1f..fd1fda5 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -60,11 +60,15 @@
 #define MXT_PROCG_NOISE		22
 #define MXT_PROCI_ONETOUCH	24
 #define MXT_PROCI_TWOTOUCH	27
+#define MXT_PROCI_GRIP		40
+#define MXT_PROCI_PALM		41
 #define MXT_SPT_COMMSCONFIG	18
 #define MXT_SPT_GPIOPWM		19
 #define MXT_SPT_SELFTEST	25
 #define MXT_SPT_CTECONFIG	28
 #define MXT_SPT_USERDATA	38
+#define MXT_SPT_DIGITIZER	43
+#define MXT_SPT_MESSAGECOUNT	44
 
 /* MXT_GEN_COMMAND field */
 #define MXT_COMMAND_RESET	0
@@ -263,6 +267,8 @@ static bool mxt_object_readable(unsigned int type)
 	case MXT_PROCG_NOISE:
 	case MXT_PROCI_ONETOUCH:
 	case MXT_PROCI_TWOTOUCH:
+	case MXT_PROCI_GRIP:
+	case MXT_PROCI_PALM:
 	case MXT_SPT_COMMSCONFIG:
 	case MXT_SPT_GPIOPWM:
 	case MXT_SPT_SELFTEST:
@@ -287,6 +293,8 @@ static bool mxt_object_writable(unsigned int type)
 	case MXT_PROCG_NOISE:
 	case MXT_PROCI_ONETOUCH:
 	case MXT_PROCI_TWOTOUCH:
+	case MXT_PROCI_GRIP:
+	case MXT_PROCI_PALM:
 	case MXT_SPT_GPIOPWM:
 	case MXT_SPT_SELFTEST:
 	case MXT_SPT_CTECONFIG:
-- 
1.7.0.4

