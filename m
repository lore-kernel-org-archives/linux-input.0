From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCHv2 3/7] input/cma3000_d0x: Keep configuration on poweroff
Date: Tue, 18 Oct 2011 14:06:32 +0200
Message-ID: <1318939596-27330-4-git-send-email-ricardo.ribalda__48195.1666334227$1318939795$gmane$org@gmail.com>
References: <1318939596-27330-1-git-send-email-ricardo.ribalda@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53163 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224Ab1JRMGy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Oct 2011 08:06:54 -0400
In-Reply-To: <1318939596-27330-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, sameo@linux.intel.com, peter.ujfalusi@ti.com, aghayal@codeaurora.org, david@hardeman.nu, Shubhrajyoti@ti.com, saaguirre@ti.com, jic23@cam.ac.uk, hemanthv@ti
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>

When the device goes to poweroff keep the spi/i2c configuration.
Otherwhise the device could not wake up if it was in spi mode.

---

v2: Fixes suggested by Jonathan Cameron
    -Code Style

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/input/misc/cma3000_d0x.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/cma3000_d0x.c
index 3877cbe..e1d27d0 100644
--- a/drivers/input/misc/cma3000_d0x.c
+++ b/drivers/input/misc/cma3000_d0x.c
@@ -44,6 +44,7 @@
 #define CMA3000_RANGE2G    (1 << 7)
 #define CMA3000_RANGE8G    (0 << 7)
 #define CMA3000_BUSI2C     (0 << 4)
+#define CMA3000_BUSSPI     (1 << 4)
 #define CMA3000_MODEMASK   (7 << 1)
 #define CMA3000_GRANGEMASK (1 << 7)
 
@@ -230,8 +231,11 @@ static int cma3000_poweron(struct cma3000_accl_data *data)
 static int cma3000_poweroff(struct cma3000_accl_data *data)
 {
 	int ret;
+	u8 ctrl = CMAMODE_POFF;
 
-	ret = CMA3000_SET(data, CMA3000_CTRL, CMAMODE_POFF, "Mode setting");
+	ctrl |= data->bus_ops->ctrl_mod;
+
+	ret = CMA3000_SET(data, CMA3000_CTRL, ctrl, "Mode setting");
 	msleep(CMA3000_SETDELAY);
 
 	return ret;
-- 
1.7.7

