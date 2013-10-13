From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] Input: wacom - Export battery scope
Date: Sun, 13 Oct 2013 21:49:22 +0200
Message-ID: <1381693762.21482.2.camel@nuvo>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49405 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab3JMTtj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Oct 2013 15:49:39 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, peter.hutterer@who-t.net, chris@cnpbagwell.com, killertofu@gmail.com


This will stop UPower from detecting the tablet as a power supply,
and using its battery status to hibernate or switch off the machine.

https://bugs.freedesktop.org/show_bug.cgi?id=70321

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/input/tablet/wacom_sys.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 79b69ea..e53416a 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -1031,6 +1031,7 @@ static void wacom_destroy_leds(struct wacom *wacom)
 }
 
 static enum power_supply_property wacom_battery_props[] = {
+	POWER_SUPPLY_PROP_SCOPE,
 	POWER_SUPPLY_PROP_CAPACITY
 };
 
@@ -1042,6 +1043,9 @@ static int wacom_battery_get_property(struct power_supply *psy,
 	int ret = 0;
 
 	switch (psp) {
+		case POWER_SUPPLY_PROP_SCOPE:
+			val->intval = POWER_SUPPLY_SCOPE_DEVICE;
+			break;
 		case POWER_SUPPLY_PROP_CAPACITY:
 			val->intval =
 				wacom->wacom_wac.battery_capacity * 100 / 31;
-- 
1.8.3.1


