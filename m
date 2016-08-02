From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0276/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:55:51 +0800
Message-ID: <20160802105551.32158-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, sean.hefty@intel.com, hal.rosenstock@gmail.com, dledford@redhat.com, bp@alien8.de
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
 drivers/input/keyboard/lm8323.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/lm8323.c b/drivers/input/keyboard/lm8323.c
index 21bea52..78a0ca6 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -556,7 +556,7 @@ static ssize_t lm8323_pwm_store_time(struct device *dev,
 
 	return strlen(buf);
 }
-static DEVICE_ATTR(time, 0644, lm8323_pwm_show_time, lm8323_pwm_store_time);
+static DEVICE_ATTR(time, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, lm8323_pwm_show_time, lm8323_pwm_store_time);
 
 static struct attribute *lm8323_pwm_attrs[] = {
 	&dev_attr_time.attr,
@@ -625,7 +625,7 @@ static ssize_t lm8323_set_disable(struct device *dev,
 
 	return count;
 }
-static DEVICE_ATTR(disable_kp, 0644, lm8323_show_disable, lm8323_set_disable);
+static DEVICE_ATTR(disable_kp, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, lm8323_show_disable, lm8323_set_disable);
 
 static int lm8323_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
-- 
2.9.2
