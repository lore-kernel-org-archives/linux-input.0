From: RaviChandra Sadineni <ravisadineni@chromium.org>
Subject: mfd: cros_ec: Check for mkbp events on resume only if supported.
Date: Mon, 20 Aug 2018 08:34:19 -0700
Message-ID: <20180820153419.32098-1-ravisadineni@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, dmitry.torokhov@gmail.com, ravisadineni@chromium.org, ravisadineni@google.com, dtor@google.com, linux-samsung-soc@vger.kernel.org, tbroch@google.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com
List-Id: linux-input@vger.kernel.org

Currently on every resume we check for mkbp events and notify the
clients. This helps in identifying the wakeup sources. But on devices
that do not support mkbp protocol, we might end up querying key state of
the keyboard in a loop which blocks the resume. Instead check for events
only if mkbp is supported.

Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>
---

 Note: This patch fixes the suspend/resume issue on Snow and Peach-Pit
 Chromebooks, both on vanilla v4.18 as well as linux-next from 20 August 
 2018. Further info at: https://lkml.org/lkml/2018/6/5/1076
 
 drivers/mfd/cros_ec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
index 65a9757a6d21..fe6f83766144 100644
--- a/drivers/mfd/cros_ec.c
+++ b/drivers/mfd/cros_ec.c
@@ -218,7 +218,8 @@ EXPORT_SYMBOL(cros_ec_suspend);
 
 static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
 {
-	while (cros_ec_get_next_event(ec_dev, NULL) > 0)
+	while (ec_dev->mkbp_event_supported &&
+	       cros_ec_get_next_event(ec_dev, NULL) > 0)
 		blocking_notifier_call_chain(&ec_dev->event_notifier,
 					     1, ec_dev);
 }
-- 
2.16.4
