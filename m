From: Harsh Shandilya <harsh@prjkt.io>
Subject: [PATCH 1/1] input/mouse: elan_i2c_core: Add ELAN061E ID
Date: Sun, 18 Nov 2018 22:29:01 +0530
Message-ID: <20181118165901.31689-1-harsh@prjkt.io>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Harsh Shandilya <harsh@prjkt.io>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Trackpad found in the Lenovo IdeaPad 330-15ARR U SKU

Signed-off-by: Harsh Shandilya <harsh@prjkt.io>
Cc: stable@vger.kernel.org
---
 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fb8806c1a39a..5a27944fb8de 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1371,6 +1371,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0618", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
+	{ "ELAN061E", 0 },
 	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },
 	{ }
-- 
2.20.0.rc0
