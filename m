From: dev-harsh1998 <harshitjain6751@gmail.com>
Subject: [PATCH 09/11] touchscreen: raydium_ts: Use octal permissions
Date: Mon, 23 Jul 2018 18:49:24 +0530
Message-ID: <20180723131954.30739-8-harshitjain6751@gmail.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180723131954.30739-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: trivial@kernel.org
Cc: Harshit Jain <harshitjain6751@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Simon Budig <simon.budig@kernelconcepts.de>, Andi Shyti <andi@etezian.org>, Luca Ceresoli <luca@lucaceresoli.net>, Jeffrey Lin <jeffrey.lin@rad-ic.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(fw_version, S_IRUGO, raydium_i2c_fw_ver_show, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(hw_version, S_IRUGO, raydium_i2c_hw_ver_show, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(boot_mode, S_IRUGO, raydium_i2c_boot_mode_show, NULL);

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, raydium_i2c_update_fw_store);

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(calibrate, S_IWUSR, NULL, raydium_i2c_calibrate_store);

Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index d1c09e6a2cb6..eddbb51e55dd 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -934,9 +934,9 @@ static ssize_t raydium_i2c_calibrate_store(struct device *dev,
 	return error ?: count;
 }
 
-static DEVICE_ATTR(fw_version, S_IRUGO, raydium_i2c_fw_ver_show, NULL);
-static DEVICE_ATTR(hw_version, S_IRUGO, raydium_i2c_hw_ver_show, NULL);
-static DEVICE_ATTR(boot_mode, S_IRUGO, raydium_i2c_boot_mode_show, NULL);
+static DEVICE_ATTR(fw_version, 0444, raydium_i2c_fw_ver_show, NULL);
+static DEVICE_ATTR(hw_version, 0444, raydium_i2c_hw_ver_show, NULL);
+static DEVICE_ATTR(boot_mode, 0444, raydium_i2c_boot_mode_show, NULL);
 static DEVICE_ATTR(update_fw, S_IWUSR, NULL, raydium_i2c_update_fw_store);
 static DEVICE_ATTR(calibrate, S_IWUSR, NULL, raydium_i2c_calibrate_store);
 
-- 
2.17.1
