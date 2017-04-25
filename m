From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Have wacom_tpc_irq guard against possible NULL dereference
Date: Tue, 25 Apr 2017 11:29:56 -0700
Message-ID: <20170425182956.15406-1-killertofu@gmail.com>
References: <20170412203123.GA3915@mwanda>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35461 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1953084AbdDYSaD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 25 Apr 2017 14:30:03 -0400
Received: by mail-qt0-f196.google.com with SMTP id o36so26374092qtb.2
        for <linux-input@vger.kernel.org>; Tue, 25 Apr 2017 11:30:03 -0700 (PDT)
In-Reply-To: <20170412203123.GA3915@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

The following Smatch complaint was generated in response to commit
2a6cdbd ("HID: wacom: Introduce new 'touch_input' device"):

    drivers/hid/wacom_wac.c:1586 wacom_tpc_irq()
             error: we previously assumed 'wacom->touch_input' could be null (see line 1577)

The 'touch_input' and 'pen_input' variables point to the 'struct input_dev'
used for relaying touch and pen events to userspace, respectively. If a
device does not have a touch interface or pen interface, the associated
input variable is NULL. The 'wacom_tpc_irq()' function is responsible for
forwarding input reports to a more-specific IRQ handler function. An
unknown report could theoretically be mistaken as e.g. a touch report
on a device which does not have a touch interface. This can be prevented
by only calling the pen/touch functions are called when the pen/touch
pointers are valid.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 6b8f6b816195..b963499e3351 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1571,37 +1571,38 @@ static int wacom_tpc_irq(struct wacom_wac *wacom, size_t len)
 {
 	unsigned char *data = wacom->data;
 
-	if (wacom->pen_input)
+	if (wacom->pen_input) {
 		dev_dbg(wacom->pen_input->dev.parent,
 			"%s: received report #%d\n", __func__, data[0]);
-	else if (wacom->touch_input)
+
+		if (len == WACOM_PKGLEN_PENABLED ||
+		    data[0] == WACOM_REPORT_PENABLED)
+			return wacom_tpc_pen(wacom);
+	}
+	else if (wacom->touch_input) {
 		dev_dbg(wacom->touch_input->dev.parent,
 			"%s: received report #%d\n", __func__, data[0]);
 
-	switch (len) {
-	case WACOM_PKGLEN_TPC1FG:
-		return wacom_tpc_single_touch(wacom, len);
+		switch (len) {
+		case WACOM_PKGLEN_TPC1FG:
+			return wacom_tpc_single_touch(wacom, len);
 
-	case WACOM_PKGLEN_TPC2FG:
-		return wacom_tpc_mt_touch(wacom);
+		case WACOM_PKGLEN_TPC2FG:
+			return wacom_tpc_mt_touch(wacom);
 
-	case WACOM_PKGLEN_PENABLED:
-		return wacom_tpc_pen(wacom);
+		default:
+			switch (data[0]) {
+			case WACOM_REPORT_TPC1FG:
+			case WACOM_REPORT_TPCHID:
+			case WACOM_REPORT_TPCST:
+			case WACOM_REPORT_TPC1FGE:
+				return wacom_tpc_single_touch(wacom, len);
 
-	default:
-		switch (data[0]) {
-		case WACOM_REPORT_TPC1FG:
-		case WACOM_REPORT_TPCHID:
-		case WACOM_REPORT_TPCST:
-		case WACOM_REPORT_TPC1FGE:
-			return wacom_tpc_single_touch(wacom, len);
-
-		case WACOM_REPORT_TPCMT:
-		case WACOM_REPORT_TPCMT2:
-			return wacom_mt_touch(wacom);
+			case WACOM_REPORT_TPCMT:
+			case WACOM_REPORT_TPCMT2:
+				return wacom_mt_touch(wacom);
 
-		case WACOM_REPORT_PENABLED:
-			return wacom_tpc_pen(wacom);
+			}
 		}
 	}
 
-- 
2.12.2

