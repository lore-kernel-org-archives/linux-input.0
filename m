From: Przemo Firszt <przemo@firszt.eu>
Subject: [PATCH 3/4] HID: wacom: Refactor battery/ac reporting for Graphire
Date: Thu, 22 Mar 2012 18:54:07 +0000
Message-ID: <1332442448-10473-3-git-send-email-przemo@firszt.eu>
References: <1332442448-10473-1-git-send-email-przemo@firszt.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:58115 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757052Ab2CVS4R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Mar 2012 14:56:17 -0400
In-Reply-To: <1332442448-10473-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: pinglinux@gmail.com, chris@cnpbagwell.com, linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Przemo Firszt <przemo@firszt.eu>

This patch doesn't change the way battery/ac is reported, but the changes are
required to facilitate battery reporting for Intuos4 WL.
wdata->battery_capacity now stores actual battery capacity as opposed to raw
value reported by wacom graphire previously. Power supply state is now stored
in a separate variable - it used to be calculated on-the-fly in
wacom_ac_get_property function. The raw value has to be stored as well to be
able to determine if it has changed.

Signed-off-by: Przemo Firszt <przemo@firszt.eu>
Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
---
 drivers/hid/hid-wacom.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 8045f9d..dafd240 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -39,13 +39,16 @@ struct wacom_data {
 	__u32 id;
 	__u32 serial;
 	unsigned char high_speed;
-	int battery_capacity;
+	__u8 battery_capacity;
+	__u8 power_raw;
+	__u8 ps_connected;
 	struct power_supply battery;
 	struct power_supply ac;
 };
 
-/*percent of battery capacity, 0 means AC online*/
-static unsigned short batcap[8] = { 1, 15, 25, 35, 50, 70, 100, 0 };
+/*percent of battery capacity for Graphire
+  8th value means AC online and show 100% capacity */
+static unsigned short batcap_gr[8] = { 1, 15, 25, 35, 50, 70, 100, 100 };
 
 static enum power_supply_property wacom_battery_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
@@ -65,7 +68,6 @@ static int wacom_battery_get_property(struct power_supply *psy,
 {
 	struct wacom_data *wdata = container_of(psy,
 					struct wacom_data, battery);
-	int power_state = batcap[wdata->battery_capacity];
 	int ret = 0;
 
 	switch (psp) {
@@ -76,11 +78,7 @@ static int wacom_battery_get_property(struct power_supply *psy,
 		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
 		break;
 	case POWER_SUPPLY_PROP_CAPACITY:
-		/* show 100% battery capacity when charging */
-		if (power_state == 0)
-			val->intval = 100;
-		else
-			val->intval = power_state;
+		val->intval = wdata->battery_capacity;
 		break;
 	default:
 		ret = -EINVAL;
@@ -94,17 +92,13 @@ static int wacom_ac_get_property(struct power_supply *psy,
 				union power_supply_propval *val)
 {
 	struct wacom_data *wdata = container_of(psy, struct wacom_data, ac);
-	int power_state = batcap[wdata->battery_capacity];
 	int ret = 0;
 
 	switch (psp) {
 	case POWER_SUPPLY_PROP_PRESENT:
 		/* fall through */
 	case POWER_SUPPLY_PROP_ONLINE:
-		if (power_state == 0)
-			val->intval = 1;
-		else
-			val->intval = 0;
+		val->intval = wdata->ps_connected;
 		break;
 	case POWER_SUPPLY_PROP_SCOPE:
 		val->intval = POWER_SUPPLY_SCOPE_DEVICE;
@@ -304,10 +298,16 @@ static int wacom_gr_parse_report(struct hid_device *hdev,
 		input_sync(input);
 	}
 
-	/* Store current battery capacity */
+	/* Store current battery capacity and power supply state*/
 	rw = (data[7] >> 2 & 0x07);
-	if (rw != wdata->battery_capacity)
-		wdata->battery_capacity = rw;
+	if (rw != wdata->power_raw) {
+		wdata->power_raw = rw;
+		wdata->battery_capacity = batcap_gr[rw];
+		if (rw == 7)
+			wdata->ps_connected = 1;
+		else
+			wdata->ps_connected = 0;
+	}
 	return 1;
 }
 
-- 
1.7.6.4

