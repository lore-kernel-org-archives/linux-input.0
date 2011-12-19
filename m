From: Wanlong Gao <wanlong.gao@gmail.com>
Subject: [PATCH 1/7] input:use module_i2c_driver in joystick i2c driver
Date: Mon, 19 Dec 2011 22:23:19 +0800
Message-ID: <1324304605-18193-2-git-send-email-gaowanlong@cn.fujitsu.com>
References: <1324304605-18193-1-git-send-email-gaowanlong@cn.fujitsu.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55913 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab1LSOYn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Dec 2011 09:24:43 -0500
Received: by ggdk6 with SMTP id k6so4006254ggd.19
        for <linux-input@vger.kernel.org>; Mon, 19 Dec 2011 06:24:42 -0800 (PST)
In-Reply-To: <1324304605-18193-1-git-send-email-gaowanlong@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dtor@mail.ru>, Greg Kroah-Hartman <gregkh@suse.de>, Wanlong Gao <gaowanlong@cn.fujitsu.com>

Use module_i2c_dirver in joystick i2c driver, since
commit http://git.kernel.org/?p=linux/kernel/git/gregkh/driver-core.git;a=commitdiff;h=7c92784a546d2945b6d6973a30f7134be78eb7a4
has added this to driver-core-next.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/input/joystick/as5011.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
index 6d6e741..3063464 100644
--- a/drivers/input/joystick/as5011.c
+++ b/drivers/input/joystick/as5011.c
@@ -355,14 +355,4 @@ static struct i2c_driver as5011_driver = {
 	.id_table	= as5011_id,
 };
 
-static int __init as5011_init(void)
-{
-	return i2c_add_driver(&as5011_driver);
-}
-module_init(as5011_init);
-
-static void __exit as5011_exit(void)
-{
-	i2c_del_driver(&as5011_driver);
-}
-module_exit(as5011_exit);
+module_i2c_driver(as5011_driver);
-- 
1.7.8

