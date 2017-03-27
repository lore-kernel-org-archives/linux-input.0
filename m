From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 10/19] HID: logitech-hidpp: forward device info in power_supply
Date: Mon, 27 Mar 2017 16:59:30 +0200
Message-ID: <20170327145939.29824-11-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39836 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753617AbdC0PAz (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 11:00:55 -0400
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Better forwarding the device name, manufacturer and serial to upower.
Note that serial is still empty, it will be filled in a later patch
in this series.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v3:
- moved up in the series

changes in v2:
* model stripped of Logitech
* vendor Logitech -> Logitech, Inc.
* use hidpp->name for the power_supply name (so that it can be overloaded)
---
 drivers/hid/hid-logitech-hidpp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 3e2f716..421c374 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -813,6 +813,9 @@ static enum power_supply_property hidpp_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CAPACITY,
 	POWER_SUPPLY_PROP_SCOPE,
+	POWER_SUPPLY_PROP_MODEL_NAME,
+	POWER_SUPPLY_PROP_MANUFACTURER,
+	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
 
 static int hidpp_battery_get_property(struct power_supply *psy,
@@ -832,6 +835,18 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 		case POWER_SUPPLY_PROP_SCOPE:
 			val->intval = POWER_SUPPLY_SCOPE_DEVICE;
 			break;
+		case POWER_SUPPLY_PROP_MODEL_NAME:
+			if (!strncmp(hidpp->name, "Logitech ", 9))
+				val->strval = hidpp->name + 9;
+			else
+				val->strval = hidpp->name;
+			break;
+		case POWER_SUPPLY_PROP_MANUFACTURER:
+			val->strval = "Logitech";
+			break;
+		case POWER_SUPPLY_PROP_SERIAL_NUMBER:
+			val->strval = hidpp->hid_dev->uniq;
+			break;
 		default:
 			ret = -EINVAL;
 			break;
-- 
2.9.3

