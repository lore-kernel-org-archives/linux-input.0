From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v3 6/8] HID: sony: Use the controller Bluetooth MAC address as the unique value in the battery name string
Date: Sat, 15 Mar 2014 09:41:20 -0400
Message-ID: <1394890882-2039-7-git-send-email-frank.praznik@oh.rr.com>
References: <1394890882-2039-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:38466 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756567AbaCONlg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Mar 2014 09:41:36 -0400
In-Reply-To: <1394890882-2039-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Use the controller Bluetooth MAC address as the unique identifier in the
battery name string instead of the atomic integer that was used before.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

 v3 moves the IDA code to patch 7 since it isn't needed here anymore.

 drivers/hid/hid-sony.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index a9bcfbe..449d08f 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1413,8 +1413,6 @@ static int sony_battery_get_property(struct power_supply *psy,
 
 static int sony_battery_probe(struct sony_sc *sc)
 {
-	static atomic_t power_id_seq = ATOMIC_INIT(0);
-	unsigned long power_id;
 	struct hid_device *hdev = sc->hdev;
 	int ret;
 
@@ -1424,15 +1422,13 @@ static int sony_battery_probe(struct sony_sc *sc)
 	 */
 	sc->battery_capacity = 100;
 
-	power_id = (unsigned long)atomic_inc_return(&power_id_seq);
-
 	sc->battery.properties = sony_battery_props;
 	sc->battery.num_properties = ARRAY_SIZE(sony_battery_props);
 	sc->battery.get_property = sony_battery_get_property;
 	sc->battery.type = POWER_SUPPLY_TYPE_BATTERY;
 	sc->battery.use_for_apm = 0;
-	sc->battery.name = kasprintf(GFP_KERNEL, "sony_controller_battery_%lu",
-				     power_id);
+	sc->battery.name = kasprintf(GFP_KERNEL, "sony_controller_battery_%pMR",
+				     sc->mac_address);
 	if (!sc->battery.name)
 		return -ENOMEM;
 
-- 
1.8.5.3

