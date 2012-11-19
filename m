From: Bill Pemberton <wfp5p@virginia.edu>
Subject: [PATCH 309/493] input: remove use of __devinitdata
Date: Mon, 19 Nov 2012 13:24:18 -0500
Message-ID: <1353349642-3677-309-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from viridian.itc.Virginia.EDU ([128.143.12.139]:41461 "EHLO
	viridian.itc.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab2KSSeZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Nov 2012 13:34:25 -0500
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devinitdata is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com> 
Cc: linux-input@vger.kernel.org 
---
 drivers/input/keyboard/tegra-kbc.c | 4 ++--
 drivers/input/misc/bma150.c        | 2 +-
 drivers/input/touchscreen/mms114.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index 18c428316..cf8ab68 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -87,7 +87,7 @@ struct tegra_kbc {
 	struct clk *clk;
 };
 
-static const u32 tegra_kbc_default_keymap[] __devinitdata = {
+static const u32 tegra_kbc_default_keymap[] = {
 	KEY(0, 2, KEY_W),
 	KEY(0, 3, KEY_S),
 	KEY(0, 4, KEY_A),
@@ -223,7 +223,7 @@ static const u32 tegra_kbc_default_keymap[] __devinitdata = {
 };
 
 static const
-struct matrix_keymap_data tegra_kbc_default_keymap_data __devinitdata = {
+struct matrix_keymap_data tegra_kbc_default_keymap_data = {
 	.keymap		= tegra_kbc_default_keymap,
 	.keymap_size	= ARRAY_SIZE(tegra_kbc_default_keymap),
 };
diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index b009244..a3219c2 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -158,7 +158,7 @@ struct bma150_data {
  * are stated and verified by Bosch Sensortec where they are configured
  * to provide a generic sensitivity performance.
  */
-static struct bma150_cfg default_cfg __devinitdata = {
+static struct bma150_cfg default_cfg = {
 	.any_motion_int = 1,
 	.hg_int = 1,
 	.lg_int = 1,
diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 7a75a57..633737e 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -576,7 +576,7 @@ static const struct i2c_device_id mms114_id[] = {
 MODULE_DEVICE_TABLE(i2c, mms114_id);
 
 #ifdef CONFIG_OF
-static struct of_device_id __devinitdata mms114_dt_match[] = {
+static struct of_device_id mms114_dt_match[] = {
 	{ .compatible = "melfas,mms114" },
 	{ }
 };
-- 
1.8.0

