From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] HID: input: throttle battery uevents
Date: Thu, 10 Aug 2017 12:47:56 -0700
Message-ID: <20170810194756.GA15567@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36945 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753122AbdHJTr7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Aug 2017 15:47:59 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The power_supply subsystem tends to emit uevent every time
power_supply_changed() is called, so we should call this API only when
battery strength reported by the device is actually different from the
previous readings, otherwise we'll drown the system in uevents.

Fixes: 581c4484769e ("HID: input: map digitizer battery usage")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-input.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 27d8442b017d..199f6a01fc62 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -520,15 +520,21 @@ static void hidinput_cleanup_battery(struct hid_device *dev)
 
 static void hidinput_update_battery(struct hid_device *dev, int value)
 {
+	int capacity;
+
 	if (!dev->battery)
 		return;
 
 	if (value == 0 || value < dev->battery_min || value > dev->battery_max)
 		return;
 
-	dev->battery_capacity = hidinput_scale_battery_capacity(dev, value);
-	dev->battery_reported = true;
-	power_supply_changed(dev->battery);
+	capacity = hidinput_scale_battery_capacity(dev, value);
+
+	if (!dev->battery_reported || capacity != dev->battery_capacity) {
+		dev->battery_capacity = capacity;
+		dev->battery_reported = true;
+		power_supply_changed(dev->battery);
+	}
 }
 #else  /* !CONFIG_HID_BATTERY_STRENGTH */
 static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
-- 
2.14.0.434.g98096fd7a8-goog


-- 
Dmitry
