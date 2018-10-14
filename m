From: Mikhail Nikiforov <jackxviichaos@gmail.com>
Subject: [PATCH] Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15IGM
Date: Sun, 14 Oct 2018 04:46:32 +0300
Message-ID: <20181014014632.4331-1-jackxviichaos@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Mikhail Nikiforov <jackxviichaos@gmail.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add ELAN061C to the ACPI table to support Elan touchpad found in Lenovo
IdeaPad 330-15IGM.

Signed-off-by: Mikhail Nikiforov <jackxviichaos@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f5ae24865355..b0f9d19b3410 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1346,6 +1346,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0611", 0 },
 	{ "ELAN0612", 0 },
 	{ "ELAN0618", 0 },
+	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
 	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },
-- 
2.17.1
