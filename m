From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2] Report In Range event according to the spec
Date: Fri,  9 Jan 2015 11:05:13 -0800
Message-ID: <1420830313-5092-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:46560 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbbAITFK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Jan 2015 14:05:10 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so18950155pdb.8
        for <linux-input@vger.kernel.org>; Fri, 09 Jan 2015 11:05:09 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

Some Cintiq and Intuos tablets report In Range event. This event
is sent before valid data is reported when tool enters proximity;
or before out of proximity event is reported when tool exits.

While entering proximity, In Range means a pen is detected. This
information can be used for palm/touch rejection on both pen and
touch enabled devices. While exiting, it means the tool has
reached its maximum detectable distance.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
v2: Updated typos in commit comments as pointed out by Bastien Nocera.
---
 drivers/hid/wacom_wac.c | 15 ++++++++-------
 drivers/hid/wacom_wac.h |  1 +
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 5276689..a4ba8ca 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -443,9 +443,6 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 
 	/* Enter report */
 	if ((data[1] & 0xfc) == 0xc0) {
-		if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
-			wacom->shared->stylus_in_proximity = true;
-
 		/* serial number of the tool */
 		wacom->serial[idx] = ((data[3] & 0x0f) << 28) +
 			(data[4] << 20) + (data[5] << 12) +
@@ -554,19 +551,22 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 	   (features->type == CINTIQ && !(data[1] & 0x40)))
 		return 1;
 
-	/* Range Report */
-	if ((data[1] & 0xfe) == 0x20) {
+	if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
+		wacom->shared->stylus_in_proximity = true;
+
+	/* in Range while exiting */
+	if (((data[1] & 0xfe) == 0x20) && wacom->reporting_data) {
 		input_report_key(input, BTN_TOUCH, 0);
 		input_report_abs(input, ABS_PRESSURE, 0);
 		input_report_abs(input, ABS_DISTANCE, wacom->features.distance_max);
-		if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
-			wacom->shared->stylus_in_proximity = true;
+		return 2;
 	}
 
 	/* Exit report */
 	if ((data[1] & 0xfe) == 0x80) {
 		if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
 			wacom->shared->stylus_in_proximity = false;
+		wacom->reporting_data = false;
 
 		/* don't report exit if we don't know the ID */
 		if (!wacom->id[idx])
@@ -952,6 +952,7 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	input_report_abs(input, ABS_MISC, wacom->id[idx]); /* report tool id */
 	input_report_key(input, wacom->tool[idx], 1);
 	input_event(input, EV_MSC, MSC_SERIAL, wacom->serial[idx]);
+	wacom->reporting_data = true;
 	return 1;
 }
 
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 7afd929..72e78cc 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -189,6 +189,7 @@ struct wacom_wac {
 	int tool[2];
 	int id[2];
 	__u32 serial[2];
+	bool reporting_data;
 	struct wacom_features features;
 	struct wacom_shared *shared;
 	struct input_dev *input;
-- 
1.9.1

