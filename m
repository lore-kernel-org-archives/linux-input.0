From: Duan Jiong <duanj.fnst@cn.fujitsu.com>
Subject: [PATCH] libcrc32c: replace IS_ERR and PTR_ERR with PTR_ERR_OR_ZERO
Date: Wed, 6 Nov 2013 15:55:00 +0800
Message-ID: <1383724500-15568-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kernel@pengutronix.de, linux@arm.linux.org.uk, a.zummo@towertech.it, airlied@linux.ie, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, linux-input@vger.kernel.org, Duan Jiong <duanj.fnst@cn.fujitsu.com>
List-Id: linux-input@vger.kernel.org

This patch fixes coccinelle error regarding usage of IS_ERR and
PTR_ERR instead of PTR_ERR_OR_ZERO.

Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
---
 lib/libcrc32c.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/libcrc32c.c b/lib/libcrc32c.c
index 244f548..b3131f5 100644
--- a/lib/libcrc32c.c
+++ b/lib/libcrc32c.c
@@ -62,10 +62,7 @@ EXPORT_SYMBOL(crc32c);
 static int __init libcrc32c_mod_init(void)
 {
 	tfm = crypto_alloc_shash("crc32c", 0, 0);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(tfm);
 }
 
 static void __exit libcrc32c_mod_fini(void)
-- 
1.8.3.1
