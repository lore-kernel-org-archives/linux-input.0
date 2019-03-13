From: KT Liao <kt.liao@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Add many hardware ID for lenovo laptop
Date: Wed, 13 Mar 2019 20:17:43 +0800
Message-ID: <1552479463-3686-1-git-send-email-kt.liao@emc.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: kt.liao@emc.com.tw
List-Id: linux-input@vger.kernel.org

There are many Lenovo laptop which need elan_i2c support.
Elan collects the list ands add to add to elan_acpi_id[]

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
---
 drivers/input/mouse/elan_i2c_core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index a94b649..f9525d6 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1337,21 +1337,48 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0000", 0 },
 	{ "ELAN0100", 0 },
 	{ "ELAN0600", 0 },
+	{ "ELAN0601", 0 },
 	{ "ELAN0602", 0 },
+	{ "ELAN0603", 0 },
+	{ "ELAN0604", 0 },
 	{ "ELAN0605", 0 },
+	{ "ELAN0606", 0 },
+	{ "ELAN0607", 0 },
 	{ "ELAN0608", 0 },
 	{ "ELAN0609", 0 },
 	{ "ELAN060B", 0 },
 	{ "ELAN060C", 0 },
+	{ "ELAN060F", 0 },
+	{ "ELAN0610", 0 },
 	{ "ELAN0611", 0 },
 	{ "ELAN0612", 0 },
+	{ "ELAN0615", 0 },
+	{ "ELAN0616", 0 },
+	{ "ELAN0617", 0 },
 	{ "ELAN0618", 0 },
+	{ "ELAN0619", 0 },
+	{ "ELAN061A", 0 },
+	{ "ELAN061B", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
 	{ "ELAN061E", 0 },
+	{ "ELAN061F", 0 },
 	{ "ELAN0620", 0 },
 	{ "ELAN0621", 0 },
 	{ "ELAN0622", 0 },
+	{ "ELAN0623", 0 },
+	{ "ELAN0624", 0 },
+	{ "ELAN0625", 0 },
+	{ "ELAN0626", 0 },
+	{ "ELAN0627", 0 },
+	{ "ELAN0628", 0 },
+	{ "ELAN0629", 0 },
+	{ "ELAN062A", 0 },
+	{ "ELAN062B", 0 },
+	{ "ELAN062C", 0 },
+	{ "ELAN062D", 0 },
+	{ "ELAN0631", 0 },
+	{ "ELAN0632", 0 },
 	{ "ELAN1000", 0 },
 	{ }
 };
-- 
2.7.4
