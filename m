From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 05/14] iio: triggers: add helper function to retrieve trigger
Date: Fri, 22 Dec 2017 17:07:12 +0200
Message-ID: <1513955241-10985-6-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

Add a helper function that will retrieve a trigger by index
from a device. This is intended to be used in trigger consumer drivers.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/iio_core_trigger.h     | 21 +++++++++++++++++++++
 drivers/iio/industrialio-trigger.c | 23 +++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/iio/iio_core_trigger.h b/drivers/iio/iio_core_trigger.h
index 1fdb1e4..14c4253 100644
--- a/drivers/iio/iio_core_trigger.h
+++ b/drivers/iio/iio_core_trigger.h
@@ -21,6 +21,15 @@ void iio_device_register_trigger_consumer(struct iio_dev *indio_dev);
  **/
 void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev);
 
+/**
+ * iio_trigger_find_from_device() - get the trigger from the device having the
+ * index given.
+ * @indio_dev: iio_dev where to get the trigger from
+ * @index: the index of the trigger to retrieve
+ **/
+__maybe_unused struct iio_trigger *
+iio_trigger_find_from_device(struct iio_dev *indio_dev, u32 index);
+
 #else
 
 /**
@@ -40,4 +49,16 @@ static void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
 {
 }
 
+/**
+ * iio_trigger_find_from_device() - get the trigger from the device having the
+ * index given.
+ * @indio_dev: iio_dev where to get the trigger from
+ * @index: the index of the trigger to retrieve
+ **/
+static __maybe_unused struct iio_trigger *
+iio_trigger_find_from_device(struct iio_dev *indio_dev, u32 index)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_TRIGGER_CONSUMER */
diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index ce66699..cbaa079 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -134,6 +134,29 @@ int iio_trigger_set_immutable(struct iio_dev *indio_dev, struct iio_trigger *tri
 }
 EXPORT_SYMBOL(iio_trigger_set_immutable);
 
+/* Find the trigger from the given device corresponding to given index */
+struct __maybe_unused iio_trigger *
+iio_trigger_find_from_device(struct iio_dev *indio_dev, u32 index)
+{
+	struct iio_trigger *iter, *trig = NULL;
+	u32 i = 0;
+
+	mutex_lock(&iio_trigger_list_lock);
+
+	list_for_each_entry(iter, &iio_trigger_list, list) {
+		if (!iio_trigger_validate_own_device(iter, indio_dev)) {
+			if (i == index) {
+				trig = iter;
+				break;
+			}
+			i++;
+		}
+	}
+	mutex_unlock(&iio_trigger_list_lock);
+
+	return trig;
+}
+
 /* Search for trigger by name, assuming iio_trigger_list_lock held */
 static struct iio_trigger *__iio_trigger_find_by_name(const char *name)
 {
-- 
2.7.4
