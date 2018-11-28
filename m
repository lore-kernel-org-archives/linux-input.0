From: adam@adamwong.me
Subject: [PATCH] Input: mouse: elan_i2c_core: Added support for ELAN0621 touchpad.
Date: Wed, 28 Nov 2018 16:20:01 -0500
Message-ID: <20181128212001.20839-1-adam@adamwong.me>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: benjamin.tissoires@redhat.com, kt.liao@emc.com.tw, dshanty@protonmail.com, robh@kernel.org, jackxviichaos@gmail.com, ben.hutchings@codethink.co.uk, gregkh@linuxfoundation.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, TheWongGuy <adam@adamwong.me>
List-Id: linux-input@vger.kernel.org

From: TheWongGuy <adam@adamwong.me>

Added the ability to detect the ELAN0621 touchpad found in some Lenovo
laptops.

Signed-off-by: Adam Wong <adam@adamwong.me>
---
 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index b0f9d19b3410..a84362d0c99d 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1348,6 +1348,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0618", 0 },
 	{ "ELAN061C", 0 },
 	{ "ELAN061D", 0 },
+	{ "ELAN0621", 0 },
 	{ "ELAN0622", 0 },
 	{ "ELAN1000", 0 },
 	{ }
-- 
2.17.1
