From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: [PATCH 4/7] input: use module_i2c_driver in mouse i2c driver
Date: Mon, 19 Dec 2011 22:23:22 +0800
Message-ID: <1324304605-18193-5-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1324304605-18193-1-git-send-email-gaowanlong@cn.fujitsu.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40758 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab1LSOYx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Dec 2011 09:24:53 -0500
Received: by mail-iy0-f174.google.com with SMTP id h11so8615511iae.19
        for <linux-input@vger.kernel.org>; Mon, 19 Dec 2011 06:24:53 -0800 (PST)
In-Reply-To: <1324304605-18193-1-git-send-email-gaowanlong@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dtor@mail.ru>, Greg Kroah-Hartman <gregkh@suse.de>, Wanlong Gao <gaowanlong@cn.fujitsu.com>

module_i2c_driver has added by commit:
http://git.kernel.org/?p=linux/kernel/git/gregkh/driver-core.git;a=commitdiff;h=7c92784a546d2945b6d6973a30f7134be78eb7a4
in driver-core-next.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/input/mouse/synaptics_i2c.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index 4b755cb..e50c15f 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -672,18 +672,7 @@ static struct i2c_driver synaptics_i2c_driver = {
 	.id_table	= synaptics_i2c_id_table,
 };
 
-static int __init synaptics_i2c_init(void)
-{
-	return i2c_add_driver(&synaptics_i2c_driver);
-}
-
-static void __exit synaptics_i2c_exit(void)
-{
-	i2c_del_driver(&synaptics_i2c_driver);
-}
-
-module_init(synaptics_i2c_init);
-module_exit(synaptics_i2c_exit);
+module_i2c_driver(synaptics_i2c_driver);
 
 MODULE_DESCRIPTION("Synaptics I2C touchpad driver");
 MODULE_AUTHOR("Mike Rapoport, Igor Grinberg, Compulab");
-- 
1.7.8

