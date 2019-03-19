From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/1] hid: hid-sensor-custom: simplify getting .driver_data
Date: Tue, 19 Mar 2019 17:36:38 +0100
Message-ID: <20190319163638.31003-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/hid/hid-sensor-custom.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index bb012bc032e0..462e653a7bbb 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -157,8 +157,7 @@ static int usage_id_cmp(const void *p1, const void *p2)
 static ssize_t enable_sensor_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
 
 	return sprintf(buf, "%d\n", sensor_inst->enable);
 }
@@ -237,8 +236,7 @@ static ssize_t enable_sensor_store(struct device *dev,
 				   struct device_attribute *attr,
 				   const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
 	int value;
 	int ret = -EINVAL;
 
@@ -283,8 +281,7 @@ static const struct attribute_group enable_sensor_attr_group = {
 static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
 	struct hid_sensor_hub_attribute_info *attribute;
 	int index, usage, field_index;
 	char name[HID_CUSTOM_NAME_LENGTH];
@@ -392,8 +389,7 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
 static ssize_t store_value(struct device *dev, struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct hid_sensor_custom *sensor_inst = platform_get_drvdata(pdev);
+	struct hid_sensor_custom *sensor_inst = dev_get_drvdata(dev);
 	int index, field_index, usage;
 	char name[HID_CUSTOM_NAME_LENGTH];
 	int value;
-- 
2.11.0
