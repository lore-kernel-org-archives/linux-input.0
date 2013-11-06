From: Duan Jiong <duanj.fnst@cn.fujitsu.com>
Subject: [PATCH] block: replace IS_ERR and PTR_ERR with PTR_ERR_OR_ZERO
Date: Wed, 6 Nov 2013 15:56:00 +0800
Message-ID: <1383724560-15707-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:3291 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751259Ab3KFH6e (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Nov 2013 02:58:34 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kernel@pengutronix.de, linux@arm.linux.org.uk, a.zummo@towertech.it, airlied@linux.ie, dmitry.torokhov@gmail.com, axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, linux-input@vger.kernel.org, devel@driverdev.osuosl.org, Duan Jiong <duanj.fnst@cn.fujitsu.com>

This patch fixes coccinelle error regarding usage of IS_ERR and
PTR_ERR instead of PTR_ERR_OR_ZERO.

Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
---
 block/blk-timeout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 4e9cfd1..cdf5711 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -32,7 +32,7 @@ static int __init fail_io_timeout_debugfs(void)
 	struct dentry *dir = fault_create_debugfs_attr("fail_io_timeout",
 						NULL, &fail_io_timeout);
 
-	return IS_ERR(dir) ? PTR_ERR(dir) : 0;
+	return PTR_ERR_OR_ZERO(dir);
 }
 
 late_initcall(fail_io_timeout_debugfs);
-- 
1.8.3.1

