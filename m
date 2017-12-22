From: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 06/14] iio: triggers: expose attach and detach helpers for pollfuncs
Date: Fri, 22 Dec 2017 17:07:13 +0200
Message-ID: <1513955241-10985-7-git-send-email-eugen.hristev@microchip.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:56578 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756381AbdLVPKG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Dec 2017 10:10:06 -0500
In-Reply-To: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: nicolas.ferre@microchip.com, ludovic.desroches@microchip.com, alexandre.belloni@free-electrons.com, linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Eugen Hristev <eugen.hristev@microchip.com>

Make attach and detach functions for pollfuncs available as symbols.
These functions are required in the trigger consumer drivers in order
to register their own pollfunctions to iio devices.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/iio/industrialio-trigger.c   | 10 ++++++----
 include/linux/iio/trigger_consumer.h |  9 +++++++++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index cbaa079..8565c92 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -265,8 +265,8 @@ static void iio_trigger_put_irq(struct iio_trigger *trig, int irq)
  * the relevant function is in there may be the best option.
  */
 /* Worth protecting against double additions? */
-static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
-					struct iio_poll_func *pf)
+int iio_trigger_attach_poll_func(struct iio_trigger *trig,
+				 struct iio_poll_func *pf)
 {
 	int ret = 0;
 	bool notinuse
@@ -312,9 +312,10 @@ static int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	module_put(pf->indio_dev->driver_module);
 	return ret;
 }
+EXPORT_SYMBOL(iio_trigger_attach_poll_func);
 
-static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
-					 struct iio_poll_func *pf)
+int iio_trigger_detach_poll_func(struct iio_trigger *trig,
+				 struct iio_poll_func *pf)
 {
 	int ret = 0;
 	bool no_other_users
@@ -334,6 +335,7 @@ static int iio_trigger_detach_poll_func(struct iio_trigger *trig,
 
 	return ret;
 }
+EXPORT_SYMBOL(iio_trigger_detach_poll_func);
 
 irqreturn_t iio_pollfunc_store_time(int irq, void *p)
 {
diff --git a/include/linux/iio/trigger_consumer.h b/include/linux/iio/trigger_consumer.h
index c4f8c74..aeefcdb 100644
--- a/include/linux/iio/trigger_consumer.h
+++ b/include/linux/iio/trigger_consumer.h
@@ -60,4 +60,13 @@ void iio_trigger_notify_done(struct iio_trigger *trig);
 int iio_triggered_buffer_postenable(struct iio_dev *indio_dev);
 int iio_triggered_buffer_predisable(struct iio_dev *indio_dev);
 
+/*
+ * Two functions for the uncommon case when we need to attach or detach
+ * a specific pollfunc to and from a trigger
+ */
+int iio_trigger_attach_poll_func(struct iio_trigger *trig,
+				 struct iio_poll_func *pf);
+
+int iio_trigger_detach_poll_func(struct iio_trigger *trig,
+				 struct iio_poll_func *pf);
 #endif
-- 
2.7.4

