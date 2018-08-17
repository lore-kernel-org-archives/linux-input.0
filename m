From: RaviChandra Sadineni <ravisadineni@chromium.org>
Subject: Input: cros_ec_keyb: Remove check before calling pm_wakeup_event.
Date: Fri, 17 Aug 2018 14:21:35 -0700
Message-ID: <20180817212135.222689-1-ravisadineni@chromium.org>
References: <20180810082344eucas1p2c525a61cb176b4ab1dab22347afd539b~JeE3uTBkU1731217312eucas1p2T@eucas1p2.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810082344eucas1p2c525a61cb176b4ab1dab22347afd539b~JeE3uTBkU1731217312eucas1p2T@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, ravisadineni@chromium.org, ravisadineni@google.com, dtor@google.com, linux-samsung-soc@vger.kernel.org, tbroch@google.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, tfiga@chromium.org
List-Id: linux-input@vger.kernel.org

From: RaviChandra Sadineni <ravisadineni@google.com>

hi Merek,

Unfortunately I could not get the device to boot even after using the exynos_defconfig. 
Can you please try this patch and see if this fixes the issue. If not can you enable the
debug logs and send me the logs.


Currently on every resume we check for mkbp events and notify the
clients. This helps in identifying the wakeup sources. But on devices
that do not support mkbp protocol, we might end up getting key state of
the keyboard in a loop and block the resume. Instead check for events only
if  mkbp is supported.

Signed-off-by: RaviChandra Sadineni <ravisadineni@chromium.org>
---
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
