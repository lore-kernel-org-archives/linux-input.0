From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 2/4] HID: sony: Use standard output reports instead of raw
 reports to send data to the Dualshock 4.
Date: Thu, 16 Jan 2014 21:42:51 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1401162134560.15779@franz-virtual-machine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:43543 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbaAQCmx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jan 2014 21:42:53 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

Use regular HID output reports instead of raw reports in the 
dualshock4_state_worker function.  (Thanks Simon Mungewell)

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---

 Apply against jikos/hid.git/for-3.14/sony

 drivers/hid/hid-sony.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 2f992e1..e623131 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -664,28 +664,39 @@ static void sixaxis_state_worker(struct work_struct *work)
 static void dualshock4_state_worker(struct work_struct *work)
 {
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
-	unsigned char buf[] = {
-		0x05,
-		0x03, 0x00, 0x00, 0x00, 0x00,
-		0x00, 0x00, 0x00, 0x00, 0x00,
-		0x00, 0x00, 0x00, 0x00, 0x00,
-		0x00, 0x00, 0x00, 0x00, 0x00,
-		0x00, 0x00, 0x00, 0x00, 0x00,
-		0x00, 0x00, 0x00, 0x00, 0x00,
-		0x00,
-	};
+	struct hid_device *hdev = sc->hdev;
+	struct list_head *head, *list;
+	struct hid_report *report;
+	__s32 *value;
+
+	list = &hdev->report_enum[HID_OUTPUT_REPORT].report_list;
+
+	list_for_each(head, list) {
+		report = list_entry(head, struct hid_report, list);
+
+		/* Report 5 is used to send data to the controller via USB */
+		if ((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && report->id == 5)
+			break;
+	}
+
+	if (head == list) {
+		hid_err(hdev, "Dualshock 4 output report not found\n");
+		return;
+	}
+
+	value = report->field[0]->value;
+	value[0] = 0x03;
 
 #ifdef CONFIG_SONY_FF
-	buf[4] = sc->right;
-	buf[5] = sc->left;
+	value[3] = sc->right;
+	value[4] = sc->left;
 #endif
 
-	buf[6] = sc->led_state[0];
-	buf[7] = sc->led_state[1];
-	buf[8] = sc->led_state[2];
+	value[5] = sc->led_state[0];
+	value[6] = sc->led_state[1];
+	value[7] = sc->led_state[2];
 
-	sc->hdev->hid_output_raw_report(sc->hdev, buf, sizeof(buf),
-					HID_OUTPUT_REPORT);
+	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
 }
 
 #ifdef CONFIG_SONY_FF
-- 
1.8.3.2

