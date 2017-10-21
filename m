From: Ido Adiv <idoad123@gmail.com>
Subject: [PATCH] Added acpi device id ELAN0611 to support lenovo ideapad 520 touchpad
Date: Sat, 21 Oct 2017 22:19:03 +0300
Message-ID: <20171021191903.24752-1-idoad123@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ido Adiv <idoad123@gmail.com>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Ido Adiv <idoad123@gmail.com>
---
 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 0e761d07..6d6b092e 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1258,6 +1258,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0605", 0 },
 	{ "ELAN0609", 0 },
 	{ "ELAN060B", 0 },
+	{ "ELAN0611", 0 },
 	{ "ELAN1000", 0 },
 	{ }
 };
-- 
2.14.1
