From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 13/19] HID: logitech-hidpp: notify battery on connect
Date: Mon, 27 Mar 2017 16:59:33 +0200
Message-ID: <20170327145939.29824-14-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When a device reconnects, there is a high chance its power supply has
been changed (for a battery replacement for instance). Just forward
the battery state here.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v3:
- moved up in the series

no changes in v2
---
 drivers/hid/hid-logitech-hidpp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 22129dd..0781d2b 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2463,6 +2463,13 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 
 	hidpp_initialize_battery(hidpp);
 
+	/* forward current battery state */
+	if (hidpp->capabilities & HIDPP_CAPABILITY_HIDPP20_BATTERY) {
+		hidpp20_query_battery_info(hidpp);
+		if (hidpp->battery.ps)
+			power_supply_changed(hidpp->battery.ps);
+	}
+
 	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT) || hidpp->delayed_input)
 		/* if the input nodes are already created, we can stop now */
 		return;
-- 
2.9.3
