From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 3/3] HID: sony: Rename worker function
Date: Sat, 11 Jan 2014 15:13:54 -0500 (EST)
Message-ID: <alpine.DEB.2.10.1401111447070.2563@franz-virtual-machine>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:53002 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbaAKUNz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Jan 2014 15:13:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

Rename sony_state_worker to sixaxis_state_worker since the function is now 
sixaxis specific.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---

 Apply against jikos/hid.git/for-3.14/sony

 drivers/hid/hid-sony.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 79e0d58..1dfed23 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -632,7 +632,7 @@ error_leds:
 	return ret;
 }
 
-static void sony_state_worker(struct work_struct *work)
+static void sixaxis_state_worker(struct work_struct *work)
 {
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
 	unsigned char buf[] = {
@@ -771,7 +771,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
 		hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
 		ret = sixaxis_set_operational_usb(hdev);
-		INIT_WORK(&sc->state_worker, sony_state_worker);
+		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
 	}
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
-- 
1.8.3.2

