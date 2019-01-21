From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2] Input: elantech: Enable SMBus on new (2018+) systems
Date: Mon, 21 Jan 2019 15:02:58 +0800
Message-ID: <20190121070258.1844-1-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: benjamin.tissoires@redhat.com, kt.liao@emc.com.tw, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: linux-input@vger.kernel.org

There are some new HP laptops with Elantech touchpad don't support
multitouch.

Currently we use ETP_NEW_IC_SMBUS_HOST_NOTIFY() to check if SMBus is
supported, but in addition to firmware version, the bus type also
informs us if the IC can support SMBus, so also check that.

In case of breaking old ICs, only enables SMBus on systems manufactured
after 2018, alongsides aforementioned checks.

Lastly, consolidats all check into elantech_use_host_notify() and use it
to determine whether to use PS/2 or SMBus.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
- Wording.
- Further restrain on older systems (< 2018).

 drivers/input/mouse/elantech.c | 63 ++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 9fe075c137dc..2594130b0079 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1799,6 +1799,39 @@ static int elantech_create_smbus(struct psmouse *psmouse,
 				  leave_breadcrumbs);
 }
 
+static bool elantech_use_host_notify(struct psmouse *psmouse,
+				     struct elantech_device_info *info)
+{
+	bool host_notify = false;
+
+	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
+		host_notify = true;
+	else {
+		switch (info->bus) {
+		case ETP_BUS_PS2_ONLY:
+			/* expected case */
+			break;
+		case ETP_BUS_SMB_ALERT_ONLY:
+			/* fall-through  */
+		case ETP_BUS_PS2_SMB_ALERT:
+			psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
+			break;
+		case ETP_BUS_SMB_HST_NTFY_ONLY:
+			/* fall-through  */
+		case ETP_BUS_PS2_SMB_HST_NTFY:
+			host_notify = true;
+			break;
+		default:
+			psmouse_dbg(psmouse,
+				    "Ignoring SMBus bus provider %d.\n",
+				    info->bus);
+		}
+	}
+
+	/* SMbus implementation is stable after 2018 */
+	return host_notify && (dmi_get_bios_year() >= 2018);
+}
+
 /**
  * elantech_setup_smbus - called once the PS/2 devices are enumerated
  * and decides to instantiate a SMBus InterTouch device.
@@ -1818,7 +1851,7 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
 		 * i2c_blacklist_pnp_ids.
 		 * Old ICs are up to the user to decide.
 		 */
-		if (!ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version) ||
+		if (!elantech_use_host_notify(psmouse, info) ||
 		    psmouse_matches_pnp_id(psmouse, i2c_blacklist_pnp_ids))
 			return -ENXIO;
 	}
@@ -1838,34 +1871,6 @@ static int elantech_setup_smbus(struct psmouse *psmouse,
 	return 0;
 }
 
-static bool elantech_use_host_notify(struct psmouse *psmouse,
-				     struct elantech_device_info *info)
-{
-	if (ETP_NEW_IC_SMBUS_HOST_NOTIFY(info->fw_version))
-		return true;
-
-	switch (info->bus) {
-	case ETP_BUS_PS2_ONLY:
-		/* expected case */
-		break;
-	case ETP_BUS_SMB_ALERT_ONLY:
-		/* fall-through  */
-	case ETP_BUS_PS2_SMB_ALERT:
-		psmouse_dbg(psmouse, "Ignoring SMBus provider through alert protocol.\n");
-		break;
-	case ETP_BUS_SMB_HST_NTFY_ONLY:
-		/* fall-through  */
-	case ETP_BUS_PS2_SMB_HST_NTFY:
-		return true;
-	default:
-		psmouse_dbg(psmouse,
-			    "Ignoring SMBus bus provider %d.\n",
-			    info->bus);
-	}
-
-	return false;
-}
-
 int elantech_init_smbus(struct psmouse *psmouse)
 {
 	struct elantech_device_info info;
-- 
2.17.1
