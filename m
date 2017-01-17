From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 10/17] HID: logitech-hidpp: notify battery on connect
Date: Tue, 17 Jan 2017 15:35:40 +0100
Message-ID: <20170117143547.30488-11-benjamin.tissoires@redhat.com>
References: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When a device reconnects, there is a high chance its power supply has
been changed (for a battery replacement for instance). Just forward
the battery state here.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 1fd95c2..3ae2f41 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2557,9 +2557,6 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 			return ret;
 		hidpp->quirks |= HIDPP_QUIRK_HIDPP20_BATTERY;
 	} else {
-		ret = hidpp10_enable_battery_reporting(hidpp);
-		if (ret)
-			return -ENOENT;
 		ret = hidpp10_query_battery_status(hidpp);
 		if (ret) {
 			ret = hidpp10_query_battery_mileage(hidpp);
@@ -2693,6 +2690,17 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 
 	hidpp_initialize_battery(hidpp);
 
+	/* forward current battery state */
+	if (hidpp->quirks & HIDPP_QUIRK_HIDPP10_BATTERY) {
+		hidpp10_enable_battery_reporting(hidpp);
+		hidpp10_query_battery_status(hidpp);
+		hidpp10_query_battery_mileage(hidpp);
+	} else if (hidpp->quirks & HIDPP_QUIRK_HIDPP20_BATTERY) {
+		hidpp20_query_battery_info(hidpp);
+	}
+	if (hidpp->battery.ps)
+		power_supply_changed(hidpp->battery.ps);
+
 	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT))
 		/* if HID created the input nodes for us, we can stop now */
 		return;
-- 
2.9.3
