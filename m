From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Input: stmfts - mark all PM functions as __maybe_unused
Date: Fri,  9 Jun 2017 12:32:48 +0200
Message-ID: <20170609103328.3130682-1-arnd@arndb.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:53013 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751519AbdFIKdt (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Jun 2017 06:33:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Andi Shyti <andi.shyti@samsung.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

We get a harmless warning when CONFIG_RUNTIME_PM is disabled:

drivers/input/touchscreen/stmfts.c:760:12: error: 'stmfts_runtime_resume' defined but not used [-Werror=unused-function]
 static int stmfts_runtime_resume(struct device *dev)
drivers/input/touchscreen/stmfts.c:748:12: error: 'stmfts_runtime_suspend' defined but not used [-Werror=unused-function]
 static int stmfts_runtime_suspend(struct device *dev)

The regular PM functions are already marked as __maybe_unused, so let's
do the same for the runtime-PM as well.

Fixes: 78bcac7b2ae1 ("Input: add support for the STMicroelectronics FingerTip touchscreen")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/input/touchscreen/stmfts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/stmfts.c b/drivers/input/touchscreen/stmfts.c
index 802d0e82d034..157fdb4bb2e8 100644
--- a/drivers/input/touchscreen/stmfts.c
+++ b/drivers/input/touchscreen/stmfts.c
@@ -745,7 +745,7 @@ static int stmfts_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int stmfts_runtime_suspend(struct device *dev)
+static int __maybe_unused stmfts_runtime_suspend(struct device *dev)
 {
 	struct stmfts_data *sdata = dev_get_drvdata(dev);
 	int ret;
@@ -757,7 +757,7 @@ static int stmfts_runtime_suspend(struct device *dev)
 	return ret;
 }
 
-static int stmfts_runtime_resume(struct device *dev)
+static int __maybe_unused stmfts_runtime_resume(struct device *dev)
 {
 	struct stmfts_data *sdata = dev_get_drvdata(dev);
 	int ret;
-- 
2.9.0

