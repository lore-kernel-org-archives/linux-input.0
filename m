From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 5/6] HID: sony: Set initial battery level to 100% to avoid false low battery warnings
Date: Thu, 30 Jan 2014 12:24:07 -0500
Message-ID: <1391102648-19381-6-git-send-email-frank.praznik@oh.rr.com>
References: <1391102648-19381-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:46118 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbaA3RYQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jan 2014 12:24:16 -0500
In-Reply-To: <1391102648-19381-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Set initial battery level to 100% to avoid false low battery warnings if a the
battery level is polled before a report containing the battery information is
received.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---
 drivers/hid/hid-sony.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 9aa20ff..5564446 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1404,6 +1404,11 @@ static int sony_battery_probe(struct sony_sc *sc)
 	struct hid_device *hdev = sc->hdev;
 	int ret;
 
+	/* Set the default battery level to 100% to avoid low battery warnings
+	 * if the battery is polled before the first device report is received.
+	 */
+	sc->battery_capacity = 100;
+
 	power_id = (unsigned long)atomic_inc_return(&power_id_seq);
 
 	sc->battery.properties = sony_battery_props;
-- 
1.8.5.3

