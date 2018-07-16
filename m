From: KT Liao <kt.liao@emc.com.tw>
Subject: [PATCH] Input: elan_i2c - Add antoher ACPI ID for Lenovo Ideapad 330-15AST
Date: Mon, 16 Jul 2018 19:26:29 +0800
Message-ID: <1531740389-4040-1-git-send-email-kt.liao@emc.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, ulrik.debie-os@e2big.org
Cc: anantshende@gmail.com, kt.liao@emc.com.tw
List-Id: linux-input@vger.kernel.org

Add ELAN0622 in ACPI mapping table to support Ideapad 330-15AST ELAN touchpad

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Reported-by: Anant Shende <anantshende@gmail.com>
---
 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 2690a4b..f7e75f0 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1344,6 +1344,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN060B", 0 },
 	{ "ELAN060C", 0 },
 	{ "ELAN0611", 0 },
+	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },
 	{ }
 };
-- 
2.7.4
