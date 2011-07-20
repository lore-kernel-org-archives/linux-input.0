From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: [PATCH] drivers:input:change the statement be consistent with the style of the rest
Date: Wed, 20 Jul 2011 22:24:17 +0800
Message-ID: <1311171857-6869-1-git-send-email-wanlong.gao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:62169 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab1GTO0f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2011 10:26:35 -0400
Received: by yia27 with SMTP id 27so124882yia.19
        for <linux-input@vger.kernel.org>; Wed, 20 Jul 2011 07:26:34 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Wanlong Gao <wanlong.gao@gmail.com>, Wanlong Gao <gaowanlong@cn.fujitsu.com>

Change the statement of *_init() and *_exit() to be consistent
with the style of the rest.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/input/misc/ad714x-i2c.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index e21deb1..45a6c91 100644
--- a/drivers/input/misc/ad714x-i2c.c
+++ b/drivers/input/misc/ad714x-i2c.c
@@ -121,13 +121,13 @@ static struct i2c_driver ad714x_i2c_driver = {
 	.id_table = ad714x_id,
 };
 
-static __init int ad714x_i2c_init(void)
+static int __init ad714x_i2c_init(void)
 {
 	return i2c_add_driver(&ad714x_i2c_driver);
 }
 module_init(ad714x_i2c_init);
 
-static __exit void ad714x_i2c_exit(void)
+static void __exit ad714x_i2c_exit(void)
 {
 	i2c_del_driver(&ad714x_i2c_driver);
 }
-- 
1.7.4.1

