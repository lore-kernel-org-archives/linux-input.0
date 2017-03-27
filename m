From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 02/19] HID: logitech-hidpp: Add scope to battery
Date: Mon, 27 Mar 2017 16:59:22 +0200
Message-ID: <20170327145939.29824-3-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753528AbdC0PA2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 11:00:28 -0400
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bastien Nocera <hadess@hadess.net>

Without a scope defined, UPower assumes that the battery provides
power to the computer it's connected to, like a laptop battery or a UPS.

Tested-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v3

changes in v2:
* fixed typo in commit message
---
 drivers/hid/hid-logitech-hidpp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 4eeb550..4aaf237 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -761,6 +761,7 @@ static int hidpp20_battery_event(struct hidpp_device *hidpp,
 static enum power_supply_property hidpp_battery_props[] = {
 	POWER_SUPPLY_PROP_STATUS,
 	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_SCOPE,
 };
 
 static int hidpp_battery_get_property(struct power_supply *psy,
@@ -777,6 +778,9 @@ static int hidpp_battery_get_property(struct power_supply *psy,
 		case POWER_SUPPLY_PROP_CAPACITY:
 			val->intval = hidpp->battery.level;
 			break;
+		case POWER_SUPPLY_PROP_SCOPE:
+			val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+			break;
 		default:
 			ret = -EINVAL;
 			break;
-- 
2.9.3

