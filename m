From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] input: ad7877: increase timeout
Date: Tue,  9 Mar 2010 13:05:33 -0500
Message-ID: <1268157933-16810-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:40256 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755128Ab0CISCR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 13:02:17 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

The time interval between consecutive interrupts depends on a number of
tunables: first_conversion_delay, acquisition_time, averaging and foremost
the pen_down_acc_interval.

Since the mod_timer() action for the PEN UP event happens in the
spi_async() callback function, latencies incurred by the spi bus drivers
also need to be taken into account.

So all in all, give the PEN UP event a bit more wiggle room and increase
timeout to 100ms.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/input/touchscreen/ad7877.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index eb83939..e019d53 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -46,7 +46,7 @@
 #include <linux/spi/ad7877.h>
 #include <asm/irq.h>
 
-#define	TS_PEN_UP_TIMEOUT	msecs_to_jiffies(50)
+#define	TS_PEN_UP_TIMEOUT	msecs_to_jiffies(100)
 
 #define MAX_SPI_FREQ_HZ			20000000
 #define	MAX_12BIT			((1<<12)-1)
-- 
1.7.0.2

