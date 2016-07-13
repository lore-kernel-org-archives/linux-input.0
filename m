From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 28/30] HID: wacom: power_supply: mark the type as USB
Date: Wed, 13 Jul 2016 18:06:15 +0200
Message-ID: <1468425977-4819-29-git-send-email-benjamin.tissoires@redhat.com>
References: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41815 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752553AbcGMQHg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jul 2016 12:07:36 -0400
In-Reply-To: <1468425977-4819-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

When upowerd detects a new device, it tries to map this new device to
an input to guess its kind. It works OK for wired tablets when the
wireless module and its battery are attached, but not so well when
connected over wireless.
In that case, the battery is attached to the wireless HID node, not
the Pen or Pad HID node. So there is no input node as a parent of the
reported battery, which means it will be showed as a computer battery
in gnome-control-center.

If we set the power supply type to USB, upowerd has a heuristic that
detects "wacom_" in the name of the power_supply, and set the type to
tablet. So it's now clear that the reported battery of from a tablet.
(see https://cgit.freedesktop.org/upower/tree/src/linux/up-device-supply.c)

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

New in v2
---
 drivers/hid/wacom_sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 7e83352..792708b 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1429,7 +1429,7 @@ static int __wacom_initialize_battery(struct wacom *wacom,
 	bat_desc->get_property = wacom_battery_get_property;
 	sprintf(battery->bat_name, "wacom_battery_%ld", n);
 	bat_desc->name = battery->bat_name;
-	bat_desc->type = POWER_SUPPLY_TYPE_BATTERY;
+	bat_desc->type = POWER_SUPPLY_TYPE_USB;
 	bat_desc->use_for_apm = 0;
 
 	ac_desc->properties = wacom_ac_props;
-- 
2.5.5

