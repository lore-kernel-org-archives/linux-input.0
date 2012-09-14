From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 2/2] HID: sensors: remove some unneeded checks
Date: Fri, 14 Sep 2012 09:53:46 +0300
Message-ID: <20120914065346.GE11886@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:32331 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab2INGyB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Sep 2012 02:54:01 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: srinivas pandruvada <srinivas.pandruvada@intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

"report_id" is unsigned so it's never less than zero.  These checks can
be removed without any problem.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 0c93b10..22ec3c6 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -214,9 +214,6 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
 	int ret = 0;
 
-	if (report_id < 0)
-		return -EINVAL;
-
 	mutex_lock(&data->mutex);
 	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
 	if (!report || (field_index >=  report->maxfield)) {
@@ -241,9 +238,6 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 	struct sensor_hub_data *data =  hid_get_drvdata(hsdev->hdev);
 	int ret = 0;
 
-	if (report_id < 0)
-		return -EINVAL;
-
 	mutex_lock(&data->mutex);
 	report = sensor_hub_report(report_id, hsdev->hdev, HID_FEATURE_REPORT);
 	if (!report || (field_index >=  report->maxfield)) {
@@ -271,9 +265,6 @@ int sensor_hub_input_attr_get_raw_value(struct hid_sensor_hub_device *hsdev,
 	struct hid_report *report;
 	int ret_val = 0;
 
-	if (report_id < 0)
-		return -EINVAL;
-
 	mutex_lock(&data->mutex);
 	memset(&data->pending, 0, sizeof(data->pending));
 	init_completion(&data->pending.ready);
