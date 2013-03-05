From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] HID: hid-logitech-dj: add some range checks
Date: Tue, 5 Mar 2013 16:06:26 +0300
Message-ID: <20130305130626.GA17801@longonot.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:46668 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343Ab3CENIe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Mar 2013 08:08:34 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

We can't trust dj_report->device_index because it comes from the
user and hasn't been range checked.  It is used as an offset into
the djrcv_dev->paired_dj_devices[] array which has 7 elements.
There is one range check already in logi_dj_recv_add_djhid_device()
and I have copy and pasted that here.

DJ_DEVICE_INDEX_MIN is 1.
DJ_DEVICE_INDEX_MAX is 6.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This is a static checker fix and I'm not certain it's correct,
please look it over carefully.

I do not know this code well, so I don't know why a zero index is
invalid.

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 9500f2f..c01cd25 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -701,6 +701,13 @@ static int logi_dj_raw_event(struct hid_device *hdev,
 	 * anything else with it.
 	 */
 
+	if ((dj_report->device_index < DJ_DEVICE_INDEX_MIN) ||
+	    (dj_report->device_index > DJ_DEVICE_INDEX_MAX)) {
+		dev_err(&hdev->dev, "%s: invalid device index:%d\n", __func__,
+			dj_report->device_index);
+		return true;
+	}
+
 	spin_lock_irqsave(&djrcv_dev->lock, flags);
 	if (dj_report->report_id == REPORT_ID_DJ_SHORT) {
 		switch (dj_report->report_type) {
