From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] Input: elan_i2c - add ELAN0608 to the ACPI table
Date: Thu, 10 Aug 2017 16:53:52 +0800
Message-ID: <20170810085352.795-1-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: ktalex.liao@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: linux-input@vger.kernel.org

Similar to commit 722c5ac708b4f ("Input: elan_i2c - add ELAN0605 to the
ACPI table"), ELAN0608 should be handled by elan_i2c.

This touchpad can be found in Lenovo ideapad 320-14IKB.

BugLink: https://bugs.launchpad.net/bugs/1708852

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/input/mouse/elan_i2c_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 3b616cb7c67f..9fe3908d12d5 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1248,6 +1248,7 @@ static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0100", 0 },
 	{ "ELAN0600", 0 },
 	{ "ELAN0605", 0 },
+	{ "ELAN0608", 0 },
 	{ "ELAN1000", 0 },
 	{ }
 };
-- 
2.14.0
