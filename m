From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 07/14] iio: triggers: on pollfunc attach, complete iio_dev if NULL
Date: Fri, 22 Dec 2017 17:07:14 +0200
Message-ID: <1513955241-10985-8-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Eugen Hristev <eugen.hristev@microchip.com>
List-Id: linux-input@vger.kernel.org

When attaching a pollfunc to a trigger, if the pollfunc does not
have an associated iio_dev pointer, just use the private data
iio_dev pointer from the trigger to fill in the poll func required
iio_dev reference.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/industrialio-trigger.c   | 9 +++++++++
 include/linux/iio/trigger_consumer.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 8565c92..ab180bd 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -272,6 +272,15 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	bool notinuse
 		= bitmap_empty(trig->pool, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 
+	/*
+	 * If we did not get a iio_dev in the poll func, attempt to
+	 * obtain the trigger's owner's device struct
+	 */
+	if (!pf->indio_dev)
+		pf->indio_dev = iio_trigger_get_drvdata(trig);
+	if (!pf->indio_dev)
+		return -EINVAL;
+
 	/* Prevent the module from being removed whilst attached to a trigger */
 	__module_get(pf->indio_dev->driver_module);
 
diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
index aeefcdb..36e2a02 100644
--- a/include/linux/iio/trigger_consumer.h
+++ b/include/linux/iio/trigger_consumer.h
@@ -63,6 +63,8 @@ int iio_triggered_buffer_predisable(struct iio_dev *indio_dev);
 /*
  * Two functions for the uncommon case when we need to attach or detach
  * a specific pollfunc to and from a trigger
+ * If the pollfunc has a NULL iio_dev pointer, it will be filled from the
+ * trigger struct.
  */
 int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 				 struct iio_poll_func *pf);
-- 
2.7.4
