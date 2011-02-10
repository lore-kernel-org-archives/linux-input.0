From: Iiro Valkonen <iiro.valkonen@atmel.com>
Subject: Re: [PATCH 4/5] Try IRQF_TRIGGER_NONE if IRQF_TRIGGER_FALLING returns
 error
Date: Thu, 10 Feb 2011 10:03:34 +0200
Message-ID: <4D539BD6.6010007@atmel.com>
References: <4D3DAE3C.6060806@atmel.com> <20110124170756.GB31066@core.coreip.homeip.net> <4D3EA7DD.6000601@atmel.com> <F619927BD5260540BACE9E197A0F2A699CF0FB@hammb01.corp.atmel.com> <20110203074318.GA5814@core.coreip.homeip.net> <4D4AB770.7090407@atmel.com> <20110204085336.GC13046@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:40463 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603Ab1BJIDB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Feb 2011 03:03:01 -0500
In-Reply-To: <20110204085336.GC13046@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Trilok Soni <tsoni@codeaurora.org>, linux-input@vger.kernel.org

Hi Dmitry,

On 02/04/2011 10:53 AM, Dmitry Torokhov wrote:
> 
> I guess we should pass irqflags in platfrom data so board code can
> adjust as needed.
> 

here the irqflags are put to the platform data, and used when the interrupt is requested.

-- 
Iiro

Input: qt602240_ts - Use irqflags from platform data to set the interrupt mode.

From: Iiro Valkonen <iiro.valkonen@atmel.com>

Use irqflags from platform data to set the interrupt mode

Signed-off-by: Iiro Valkonen <iiro.valkonen@atmel.com>
---
 arch/arm/mach-s5pv210/mach-goni.c       |    2 ++
 drivers/input/touchscreen/qt602240_ts.c |    2 +-
 include/linux/i2c/qt602240_ts.h         |    1 +
 3 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index e22d511..cb6a637 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -25,6 +25,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
+#include <linux/interrupt.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -231,6 +232,7 @@ static struct qt602240_platform_data qt602240_platform_data = {
 	.threshold	= 0x28,
 	.voltage	= 2800000,              /* 2.8V */
 	.orient		= QT602240_DIAGONAL,
+	.irqflags	= IRQF_TRIGGER_FALLING,
 };
 
 static struct s3c2410_platform_i2c i2c2_data __initdata = {
diff --git a/drivers/input/touchscreen/qt602240_ts.c b/drivers/input/touchscreen/qt602240_ts.c
index 115dcc4..08fd136 100644
--- a/drivers/input/touchscreen/qt602240_ts.c
+++ b/drivers/input/touchscreen/qt602240_ts.c
@@ -1162,7 +1162,7 @@ static int __devinit mxt_probe(struct i2c_client *client,
 		goto err_free_object;
 
 	error = request_threaded_irq(client->irq, NULL, mxt_interrupt,
-			IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
+			pdata->irqflags, client->dev.driver->name, data);
 	if (error) {
 		dev_err(&client->dev, "Failed to register interrupt\n");
 		goto err_free_object;
diff --git a/include/linux/i2c/qt602240_ts.h b/include/linux/i2c/qt602240_ts.h
index 219392a..550f2a8 100644
--- a/include/linux/i2c/qt602240_ts.h
+++ b/include/linux/i2c/qt602240_ts.h
@@ -35,6 +35,7 @@ struct mxt_platform_data {
 	unsigned char orient;
 	const u8 *config;
 	unsigned int config_length;
+	unsigned long irqflags;
 };
 
 #endif /* __LINUX_MAXTOUCH_TS_H */
-- 
1.7.0.4
