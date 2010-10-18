From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] input: adp5588-keys: use obvious i2c_device_id name string
Date: Mon, 18 Oct 2010 18:23:00 -0400
Message-ID: <1287440580-1497-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:46825 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755444Ab0JRWUi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 18:20:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: device-drivers-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

KBUILD_MODNAME normalizes "-" to "_".  This is non-obvious and results in
the id name for ADP5588 being "adp5588_keys" while the other supported id
is "adp5587-keys".  So avoid this define and use an explicit string as the
id name.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/input/keyboard/adp5588-keys.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index d6918cb..b92d1cd 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -660,7 +660,7 @@ static const struct dev_pm_ops adp5588_dev_pm_ops = {
 #endif
 
 static const struct i2c_device_id adp5588_id[] = {
-	{ KBUILD_MODNAME, 0 },
+	{ "adp5588-keys", 0 },
 	{ "adp5587-keys", 0 },
 	{ }
 };
-- 
1.7.3.1

