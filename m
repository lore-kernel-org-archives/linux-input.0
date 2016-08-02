From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0278/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:56:00 +0800
Message-ID: <20160802105600.32343-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: syrjala@sci.fi, dmitry.torokhov@gmail.com, hal.rosenstock@gmail.com, dledford@redhat.com, sean.hefty@intel.com, bp@alien8.de
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, haggaie@mellanox.com
List-Id: linux-input@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/input/misc/ati_remote2.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index 1c5914c..2c03a41 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -98,7 +98,7 @@ static const struct kernel_param_ops param_ops_channel_mask = {
 	.set = ati_remote2_set_channel_mask,
 	.get = ati_remote2_get_channel_mask,
 };
-module_param(channel_mask, channel_mask, 0644);
+module_param(channel_mask, channel_mask, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(channel_mask, "Bitmask of channels to accept <15:Channel16>...<1:Channel2><0:Channel1>");
 
 static unsigned int mode_mask = ATI_REMOTE2_MAX_MODE_MASK;
@@ -107,7 +107,7 @@ static const struct kernel_param_ops param_ops_mode_mask = {
 	.set = ati_remote2_set_mode_mask,
 	.get = ati_remote2_get_mode_mask,
 };
-module_param(mode_mask, mode_mask, 0644);
+module_param(mode_mask, mode_mask, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(mode_mask, "Bitmask of modes to accept <4:PC><3:AUX4><2:AUX3><1:AUX2><0:AUX1>");
 
 static struct usb_device_id ati_remote2_id_table[] = {
@@ -785,10 +785,10 @@ static ssize_t ati_remote2_store_mode_mask(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(channel_mask, 0644, ati_remote2_show_channel_mask,
+static DEVICE_ATTR(channel_mask, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, ati_remote2_show_channel_mask,
 		   ati_remote2_store_channel_mask);
 
-static DEVICE_ATTR(mode_mask, 0644, ati_remote2_show_mode_mask,
+static DEVICE_ATTR(mode_mask, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, ati_remote2_show_mode_mask,
 		   ati_remote2_store_mode_mask);
 
 static struct attribute *ati_remote2_attrs[] = {
-- 
2.9.2
