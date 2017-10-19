From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] Input: elan_i2c - add ELAN0611 to the ACPI table
Date: Fri, 20 Oct 2017 01:12:52 +0800
Message-ID: <20171019171252.15365-1-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: kt.liao@emc.com.tw, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: linux-input@vger.kernel.org

ELAN0611 touchpad uses elan_i2c as its driver. It can be found
on Lenovo ideapad 320-15IKB.

So add it to ACPI table to enable the touchpad.

BugLink: https://bugs.launchpad.net/bugs/1723736
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 0e761d079dc4..6d6b092e2da9 100644
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
