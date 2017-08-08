From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] Input: ati_remote2: constify usb_device_id
Date: Tue,  8 Aug 2017 22:24:12 +0530
Message-ID: <8d2f77c37ab938f3b4ed124b02aff2021714e591.1502211151.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: syrjala@sci.fi, dmitry.torokhov@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

usb_device_id are not supposed to change at runtime. All functions
working with usb_device_id provided by <linux/usb.h> work with
const usb_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/input/misc/ati_remote2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_remote2.c
index 1c5914c..ebf4448 100644
--- a/drivers/input/misc/ati_remote2.c
+++ b/drivers/input/misc/ati_remote2.c
@@ -110,7 +110,7 @@ static const struct kernel_param_ops param_ops_mode_mask = {
 module_param(mode_mask, mode_mask, 0644);
 MODULE_PARM_DESC(mode_mask, "Bitmask of modes to accept <4:PC><3:AUX4><2:AUX3><1:AUX2><0:AUX1>");
 
-static struct usb_device_id ati_remote2_id_table[] = {
+static const struct usb_device_id ati_remote2_id_table[] = {
 	{ USB_DEVICE(0x0471, 0x0602) },	/* ATI Remote Wonder II */
 	{ }
 };
-- 
2.7.4
