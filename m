From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 2/8] HID: sony: Set the HID quriks flag for Bluetooth controllers
Date: Thu,  6 Mar 2014 17:32:50 -0500
Message-ID: <1394145176-24174-3-git-send-email-frank.praznik@oh.rr.com>
References: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:4607 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752098AbaCFWdG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Mar 2014 17:33:06 -0500
In-Reply-To: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

The Sixaxis and DualShock 4 want HID output reports sent on the control
endpoint when connected via Bluetooth.  Set the
HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP flag for these devices so hidraw write()
works properly.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 4c445a0..908de27 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1632,11 +1632,21 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		sc->worker_initialized = 1;
 		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
 	} else if (sc->quirks & SIXAXIS_CONTROLLER_BT) {
+		/*
+		 * The Sixaxis wants output reports sent on the ctrl endpoint
+		 * when connected via Bluetooth.
+		 */
+		hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
 		ret = sixaxis_set_operational_bt(hdev);
 		sc->worker_initialized = 1;
 		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
 		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
+			/*
+			 * The DualShock 4 wants output reports sent on the ctrl
+			 * endpoint when connected via Bluetooth.
+			 */
+			hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
 			ret = dualshock4_set_operational_bt(hdev);
 			if (ret < 0) {
 				hid_err(hdev, "failed to set the Dualshock 4 operational mode\n");
-- 
1.8.5.3

