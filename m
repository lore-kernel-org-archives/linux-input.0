From: "Ooi, Joyce" <joyce.ooi@intel.com>
Subject: [PATCH] hid: sensor: fix input and feature attributes in HID sensor custom sysfs interface
Date: Thu,  3 Nov 2016 18:55:15 +0800
Message-ID: <1478170515-24436-1-git-send-email-joyce.ooi@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34989 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752544AbcKCK42 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 3 Nov 2016 06:56:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Ooi Joyce <joyce.ooi@intel.com>, Kweh Hock Leong <hock.leong.kweh@intel.com>, Ong Boon Leong <boon.leong.ong@intel.com>, Lay Kuan Loon <kuan.loon.lay@intel.com>

User is unable to access to input-X-yyy and feature-X-yyy where
X is a hex value and more than 9 (e.g. input-a-yyy, feature-b-yyy) in HID
sensor custom sysfs interface.
This is because when creating the attribute, the attribute index is
written to using %x (hex). However, when reading and writing values into
the attribute, the attribute index is scanned using %d (decimal). Hence,
user is unable to access to attributes with index in hex values
(e.g. 'a', 'b', 'c') but able to access to attributes with index in
decimal values (e.g. 1, 2, 3,..).
This fix will change input-%d-%x-%s and feature-%d-%x-%s to input-%x-%x-%s
and feature-%x-%x-%s in show_values() and store_values() accordingly.

Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
---
 drivers/hid/hid-sensor-custom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 5614fee..3a84aaf 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -292,11 +292,11 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 	bool input = false;
 	int value = 0;
 
-	if (sscanf(attr->attr.name, "feature-%d-%x-%s", &index, &usage,
+	if (sscanf(attr->attr.name, "feature-%x-%x-%s", &index, &usage,
 		   name) == 3) {
 		feature = true;
 		field_index = index + sensor_inst->input_field_count;
-	} else if (sscanf(attr->attr.name, "input-%d-%x-%s", &index, &usage,
+	} else if (sscanf(attr->attr.name, "input-%x-%x-%s", &index, &usage,
 		   name) == 3) {
 		input = true;
 		field_index = index;
@@ -398,7 +398,7 @@ static ssize_t store_value(struct device *dev, struct device_attribute *attr,
 	char name[HID_CUSTOM_NAME_LENGTH];
 	int value;
 
-	if (sscanf(attr->attr.name, "feature-%d-%x-%s", &index, &usage,
+	if (sscanf(attr->attr.name, "feature-%x-%x-%s", &index, &usage,
 		   name) == 3) {
 		field_index = index + sensor_inst->input_field_count;
 	} else
-- 
1.9.1

