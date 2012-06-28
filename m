From: Daniel Kurtz <djkurtz@chromium.org>
Subject: [PATCH 22/23 v6] Input: atmel_mxt_ts - send all MT-B slots in one input report
Date: Thu, 28 Jun 2012 21:08:23 +0800
Message-ID: <1340888904-15620-23-git-send-email-djkurtz@chromium.org>
References: <1340888904-15620-1-git-send-email-djkurtz@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vb0-f74.google.com ([209.85.212.74]:39781 "EHLO
	mail-vb0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709Ab2F1NIb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jun 2012 09:08:31 -0400
Received: by vbnl22 with SMTP id l22so203843vbn.1
        for <linux-input@vger.kernel.org>; Thu, 28 Jun 2012 06:08:30 -0700 (PDT)
In-Reply-To: <1340888904-15620-1-git-send-email-djkurtz@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, Yufeng Shen <miletus@chromium.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Benson Leung <bleung@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>

Each interrupt contains information for all contacts with changing
properties.  Process all of this information at once, and send it all in a
a single input report (ie input events ending in EV_SYN/SYN_REPORT).

This patch was tested using an MXT224E.

Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/input/touchscreen/atmel_mxt_ts.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 2746b0d..4c9a06c 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -547,9 +547,6 @@ static void mxt_input_touchevent(struct mxt_data *data,
 		input_report_abs(input_dev, ABS_MT_PRESSURE, pressure);
 		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, area);
 	}
-
-	input_mt_report_pointer_emulation(input_dev, false);
-	input_sync(input_dev);
 }
 
 static bool mxt_is_T9_message(struct mxt_data *data, struct mxt_message *msg)
@@ -565,6 +562,7 @@ static irqreturn_t mxt_interrupt(int irq, void *dev_id)
 	struct device *dev = &data->client->dev;
 	int id;
 	u8 reportid;
+	bool update_input = false;
 
 	do {
 		if (mxt_read_message(data, &message)) {
@@ -576,12 +574,19 @@ static irqreturn_t mxt_interrupt(int irq, void *dev_id)
 
 		id = reportid - data->T9_reportid_min;
 
-		if (mxt_is_T9_message(data, &message))
+		if (mxt_is_T9_message(data, &message)) {
 			mxt_input_touchevent(data, &message, id);
-		else
+			update_input = true;
+		} else {
 			mxt_dump_message(dev, &message);
+		}
 	} while (reportid != 0xff);
 
+	if (update_input) {
+		input_mt_report_pointer_emulation(data->input_dev, false);
+		input_sync(data->input_dev);
+	}
+
 end:
 	return IRQ_HANDLED;
 }
-- 
1.7.7.3

