From: KT Liao <kt.liao@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Add antoher Lenovo ACPI ID for Yoga310 Add ELAN0602 in ACPI mapping table to support Yoga310's ELAN touchpad Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Date: Thu, 27 Jul 2017 20:57:23 +0800
Message-ID: <1501160243-4156-1-git-send-email-kt.liao@emc.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: phoenix@emc.com.tw, kt.liao@emc.com.tw
List-Id: linux-input@vger.kernel.org

---
 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 3b616cb..88fc0f8 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1247,6 +1247,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0000", 0 },
 	{ "ELAN0100", 0 },
 	{ "ELAN0600", 0 },
+	{ "ELAN0602", 0 },
 	{ "ELAN0605", 0 },
 	{ "ELAN1000", 0 },
 	{ }
-- 
2.7.4
