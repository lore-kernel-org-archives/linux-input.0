From: Geliang Tang <geliangtang@163.com>
Subject: [PATCH 3/5] HID: add a new helper to_hid_driver()
Date: Sun, 27 Dec 2015 17:25:22 +0800
Message-ID: <1f3f9887783a36170a5972e6819c7841db95d888.1451206516.git.geliangtang@163.com>
References: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from m50-134.163.com ([123.125.50.134]:33320 "EHLO m50-134.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbbL0J0n (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Dec 2015 04:26:43 -0500
In-Reply-To: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com>
In-Reply-To: <3c9a720e58ea32c5df098cbe744c6b5821a756a6.1451206516.git.geliangtang@163.com>
References: <3490fef13d9af010ff2da07012eed189c46ee3fa.1451206516.git.geliangtang@163.com> <3c9a720e58ea32c5df098cbe744c6b5821a756a6.1451206516.git.geliangtang@163.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Geliang Tang <geliangtang@163.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Add a new helper to_hid_driver() and use it in hid-core.c.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/hid/hid-core.c | 7 +++----
 include/linux/hid.h    | 3 +++
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3abff97..ecf614b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2071,7 +2071,7 @@ struct hid_dynid {
 static ssize_t store_new_id(struct device_driver *drv, const char *buf,
 		size_t count)
 {
-	struct hid_driver *hdrv = container_of(drv, struct hid_driver, driver);
+	struct hid_driver *hdrv = to_hid_driver(drv);
 	struct hid_dynid *dynid;
 	__u32 bus, vendor, product;
 	unsigned long driver_data = 0;
@@ -2133,7 +2133,7 @@ static const struct hid_device_id *hid_match_device(struct hid_device *hdev,
 
 static int hid_bus_match(struct device *dev, struct device_driver *drv)
 {
-	struct hid_driver *hdrv = container_of(drv, struct hid_driver, driver);
+	struct hid_driver *hdrv = to_hid_driver(drv);
 	struct hid_device *hdev = to_hid_device(dev);
 
 	return hid_match_device(hdev, hdrv) != NULL;
@@ -2141,8 +2141,7 @@ static int hid_bus_match(struct device *dev, struct device_driver *drv)
 
 static int hid_device_probe(struct device *dev)
 {
-	struct hid_driver *hdrv = container_of(dev->driver,
-			struct hid_driver, driver);
+	struct hid_driver *hdrv = to_hid_driver(dev->driver);
 	struct hid_device *hdev = to_hid_device(dev);
 	const struct hid_device_id *id;
 	int ret = 0;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 1472026..75b66ec 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -717,6 +717,9 @@ struct hid_driver {
 	struct device_driver driver;
 };
 
+#define to_hid_driver(pdrv) \
+	container_of(pdrv, struct hid_driver, driver)
+
 /**
  * hid_ll_driver - low level driver callbacks
  * @start: called on probe to start the device
-- 
2.5.0


