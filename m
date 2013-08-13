From: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Subject: [PATCH 2/4] input: ti_am335x_tsc: Increase sequencer delay time
Date: Tue, 13 Aug 2013 17:48:17 +0100
Message-ID: <1376412499-21007-3-git-send-email-zubair.lutfullah@gmail.com>
References: <1376412499-21007-1-git-send-email-zubair.lutfullah@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376412499-21007-1-git-send-email-zubair.lutfullah@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@cam.ac.uk, dmitry.torokhov@gmail.com, sameo@linux.intel.com, lee.jones@linaro.org
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, bigeasy@linutronix.de, gregkh@linuxfoundation.org, Russ.Dill@ti.com
List-Id: linux-input@vger.kernel.org

Before checking PEN UP event, IRQ delays for this amount
of time to let FSM stabilize. Previously, with only the
TSC driver in IRQ mode, this delay was sufficient.

The delay is increased slightly to accomodate if the ADC
is also being used simultaneously in continuous mode.

Signed-off-by: Zubair Lutfullah <zubair.lutfullah@gmail.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index e165fcb..766bc7e 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -31,7 +31,7 @@
 #include <linux/mfd/ti_am335x_tscadc.h>
 
 #define ADCFSM_STEPID		0x10
-#define SEQ_SETTLE		275
+#define SEQ_SETTLE		350
 #define MAX_12BIT		((1 << 12) - 1)
 
 static const int config_pins[] = {
-- 
1.7.9.5
