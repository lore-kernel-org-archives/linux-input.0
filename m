From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] Input: elantech - Disable elan-i2c for P52 and P72
Date: Wed, 12 Dec 2018 16:42:05 +0100
Message-ID: <20181212154205.24025-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, kt.liao@emc.com.tw, Aaron Ma <aaron.ma@canonical.com>, Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The current implementation of elan_i2c is known to not support those
2 laptops.

A proper fix is to tweak both elantech and elan_i2c to transmit the
correct information from PS/2, which would make a bad candidate for
stable.

So to give us some time for fixing the root of the problem, disable
elan_i2c for the devices we know are not behaving properly.

Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1803600
Link: https://bugs.archlinux.org/task/59714
Fixes: df077237cf55 Input: elantech - detect new ICs and setup Host Notify for them

Cc: stable@vger.kernel.org  # v4.18+
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elantech.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 2d95e8d93cc7..830ae9f07045 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1767,6 +1767,18 @@ static int elantech_smbus = IS_ENABLED(CONFIG_MOUSE_ELAN_I2C_SMBUS) ?
 module_param_named(elantech_smbus, elantech_smbus, int, 0644);
 MODULE_PARM_DESC(elantech_smbus, "Use a secondary bus for the Elantech device.");
 
+static const char * const i2c_blacklist_pnp_ids[] = {
+	/*
+	 * these are known to not be working properly as bits are missing
+	 * in elan_i2c
+	 */
+	"LEN2131", /* ThinkPad P52 w/ NFC */
+	"LEN2132", /* ThinkPad P52 */
+	"LEN2133", /* ThinkPad P72 w/ NFC */
+	"LEN2134", /* ThinkPad P72 */
+	NULL
+};
+
 static int elantech_create_smbus(struct psmouse *psmouse,
 				 struct elantech_device_info *info,
 				 bool leave_breadcrumbs)
@@ -1802,10 +1814,12 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
 
 	if (elantech_smbus == ELANTECH_SMBUS_NOT_SET) {
 		/*
-		 * New ICs are enabled by default.
+		 * New ICs are enabled by default, unless mentioned in
+		 * i2c_blacklist_pnp_ids.
 		 * Old ICs are up to the user to decide.
 		 */
-		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
+		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
+		    psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
 			return -ENXIO;
 	}
 
-- 
2.19.2
