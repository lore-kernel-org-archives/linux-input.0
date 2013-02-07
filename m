From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 7/7] input: atmel_mxt_ts: check if all config pdata has been written to object table
Date: Thu,  7 Feb 2013 15:17:48 +0100
Message-ID: <1360246668-2291-8-git-send-email-pmeerw@pmeerw.net>
References: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47054 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758666Ab3BGOSD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Feb 2013 09:18:03 -0500
In-Reply-To: <1360246668-2291-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, djkurtz@chromium.org, y0922.shim@samsung.com, Peter Meerwald <p.meerwald@bct-electronic.com>

From: Peter Meerwald <p.meerwald@bct-electronic.com>

firmware revisions may introduce or alter device objects; error out if there
is an inconsistency (otherwise the device may silently fail)

mxt_platform_data.config is dangerous because the data must match the device object
exactly; if the order or size changes, or if device object disappear, garbage is written
to the device

Signed-off-by: Peter Meerwald <p.meerwald@bct-electronic.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 7ade272..b85fb30 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -636,6 +636,11 @@ static int mxt_check_reg_init(struct mxt_data *data)
 		index += size;
 	}
 
+	if (index != pdata->config_length) {
+		dev_err(dev, "Config data inconsistent with device objects!\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
1.7.9.5

