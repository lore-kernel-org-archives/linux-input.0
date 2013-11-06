From: Duan Jiong <duanj.fnst@cn.fujitsu.com>
Subject: [PATCH] net:drivers/net: replace IS_ERR and PTR_ERR with PTR_ERR_OR_ZERO
Date: Wed, 6 Nov 2013 15:58:13 +0800
Message-ID: <1383724693-16220-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:60401 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751361Ab3KFIAz (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Nov 2013 03:00:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kernel@pengutronix.de, linux@arm.linux.org.uk, a.zummo@towertech.it, airlied@linux.ie, dmitry.torokhov@gmail.com, axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, linux-input@vger.kernel.org, devel@driverdev.osuosl.org, netdev@vger.kernel.org, Duan Jiong <duanj.fnst@cn.fujitsu.com>

This patch fixes coccinelle error regarding usage of IS_ERR and
PTR_ERR instead of PTR_ERR_OR_ZERO.

Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
---
 drivers/net/ethernet/i825xx/82596.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/i825xx/82596.c b/drivers/net/ethernet/i825xx/82596.c
index a15877a..7ce6379 100644
--- a/drivers/net/ethernet/i825xx/82596.c
+++ b/drivers/net/ethernet/i825xx/82596.c
@@ -1527,9 +1527,7 @@ int __init init_module(void)
 	if (debug >= 0)
 		i596_debug = debug;
 	dev_82596 = i82596_probe(-1);
-	if (IS_ERR(dev_82596))
-		return PTR_ERR(dev_82596);
-	return 0;
+	return PTR_ERR_OR_ZERO(dev_82596);
 }
 
 void __exit cleanup_module(void)
-- 
1.8.3.1

