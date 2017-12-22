From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 08/14] iio: triggers: add private data to pollfuncs
Date: Fri, 22 Dec 2017 17:07:15 +0200
Message-ID: <1513955241-10985-9-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

Add a private data pointer field to pollfunc struct.
This is useful in the trigger handler to get specific data
for the driver registering the pollfunc.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 include/linux/iio/trigger_consumer.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
index 36e2a02..13be595 100644
--- a/include/linux/iio/trigger_consumer.h
+++ b/include/linux/iio/trigger_consumer.h
@@ -29,6 +29,7 @@ struct iio_trigger;
  * @timestamp:			some devices need a timestamp grabbed as soon
  *				as possible after the trigger - hence handler
  *				passes it via here.
+ * @p:				private data for the poll func owner.
  **/
 struct iio_poll_func {
 	struct iio_dev *indio_dev;
@@ -38,6 +39,7 @@ struct iio_poll_func {
 	char *name;
 	int irq;
 	s64 timestamp;
+	void *p;
 };
 
 
@@ -49,6 +51,13 @@ struct iio_poll_func
 		    const char *fmt,
 		    ...);
 void iio_dealloc_pollfunc(struct iio_poll_func *pf);
+
+static inline void
+iio_pollfunc_set_private_data(struct iio_poll_func *pf, void *p)
+{
+	pf->p = p;
+}
+
 irqreturn_t iio_pollfunc_store_time(int irq, void *p);
 
 void iio_trigger_notify_done(struct iio_trigger *trig);
-- 
2.7.4
