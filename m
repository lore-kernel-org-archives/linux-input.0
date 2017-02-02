From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 05/15] HID: logitech-hidpp: forward device info in power_supply
Date: Thu,  2 Feb 2017 15:12:19 +0100
Message-ID: <20170202141229.17322-6-benjamin.tissoires@redhat.com>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Better forwarding the device name, manufacturer and serial to upower.
Note that serial is still empty, it will be filled in a later patch
in this series.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v2:
* model stripped of Logitech
* vendor Logitech -> Logitech, Inc.
* use hidpp->name for the power_supply name (so that it can be overloaded)
---
 drivers/hid/hid-logitech-hidpp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 3c57886..6124481 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -758,6 +758,9 @@ static enum power_supply_property hidpp_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
 
 static int hidpp_battery_get_property(struct power_supply *psy,
@@ -783,6 +786,18 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 					hidpp->battery.status ==
 					      POWER_SUPPLY_STATUS_FULL;
 			break;
+		case POWER_SUPPLY_PROP_MODEL_NAME:
+			if (!strncmp(hidpp->name, "Logitech ", 9))
+				val->strval = hidpp->name + 9;
+			else
+				val->strval = hidpp->name;
+			break;
+		case POWER_SUPPLY_PROP_MANUFACTURER:
+			val->strval = "Logitech, Inc.";
+			break;
+		case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+			val->strval = hidpp->hid_dev->uniq;
+			break;
 		default:
 			ret = -EINVAL;
 			break;
-- 
2.9.3
