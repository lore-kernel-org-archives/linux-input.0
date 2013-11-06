From: Duan Jiong <duanj.fnst@cn.fujitsu.com>
Subject: [PATCH] lustre/fld: replace IS_ERR and PTR_ERR with PTR_ERR_OR_ZERO
Date: Wed, 6 Nov 2013 15:55:31 +0800
Message-ID: <1383724531-15617-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:14311 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751318Ab3KFH5k (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 Nov 2013 02:57:40 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kernel@pengutronix.de, linux@arm.linux.org.uk, a.zummo@towertech.it, airlied@linux.ie, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, linux-input@vger.kernel.org, devel@driverdev.osuosl.org, Duan Jiong <duanj.fnst@cn.fujitsu.com>

This patch fixes coccinelle error regarding usage of IS_ERR and
PTR_ERR instead of PTR_ERR_OR_ZERO.

Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
---
 drivers/staging/lustre/lustre/fld/fld_request.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/lustre/lustre/fld/fld_request.c b/drivers/staging/lustre/lustre/fld/fld_request.c
index e47fd50..3191a39 100644
--- a/drivers/staging/lustre/lustre/fld/fld_request.c
+++ b/drivers/staging/lustre/lustre/fld/fld_request.c
@@ -504,10 +504,7 @@ static int __init fld_mod_init(void)
 	fld_type_proc_dir = lprocfs_register(LUSTRE_FLD_NAME,
 					     proc_lustre_root,
 					     NULL, NULL);
-	if (IS_ERR(fld_type_proc_dir))
-		return PTR_ERR(fld_type_proc_dir);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(fld_type_proc_dir);
 }
 
 static void __exit fld_mod_exit(void)
-- 
1.8.3.1

