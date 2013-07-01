From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] Input: touchscreen: ads7846: keep copy of
 pdata in private struct
Date: Sun, 30 Jun 2013 18:33:24 -0700
Message-ID: <20130701013324.GA10755@core.coreip.homeip.net>
References: <1372626555-29479-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:47136 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab3GABd2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Jun 2013 21:33:28 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj3so4432952pad.0
        for <linux-input@vger.kernel.org>; Sun, 30 Jun 2013 18:33:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1372626555-29479-1-git-send-email-zonque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, broonie@kernel.org, grant.likely@linaro.org, agust@denx.de, imre.deak@nokia.com, chf@fritzc.com

Hi Daniel,

On Sun, Jun 30, 2013 at 11:09:14PM +0200, Daniel Mack wrote:
> +
> +	if (!pdata->model)
> +		pdata->model = 7846;
> +
> +	if (!pdata->vref_delay_usecs)
> +		pdata->vref_delay_usecs = 100;
> +
> +	if (!pdata->x_plate_ohms)
> +		pdata->x_plate_ohms = 400;
> +
> +	if (!pdata->pressure_max)
> +		pdata->pressure_max = ~0;

We should not be changing the platform data as the device does not own
it and it may well be declared as a constant structure.

In fact, I have a patch that declares pdata pointer as const.

-- 
Dmitry


Input: ads7846 - make sure we do not change platform data

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Let's declare platform data a const pointer so that we don't accitentally
change it. Also fetch it with dev_get_platdata().

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/ads7846.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 84ccf14..5ff0419 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -961,9 +961,9 @@ static int ads7846_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(ads7846_pm, ads7846_suspend, ads7846_resume);
 
 static int ads7846_setup_pendown(struct spi_device *spi,
-					   struct ads7846 *ts)
+				 struct ads7846 *ts,
+				 const struct ads7846_platform_data *pdata)
 {
-	struct ads7846_platform_data *pdata = spi->dev.platform_data;
 	int err;
 
 	/*
@@ -1003,7 +1003,7 @@ static int ads7846_setup_pendown(struct spi_device *spi,
  * use formula #2 for pressure, not #3.
  */
 static void ads7846_setup_spi_msg(struct ads7846 *ts,
-				const struct ads7846_platform_data *pdata)
+				  const struct ads7846_platform_data *pdata)
 {
 	struct spi_message *m = &ts->msg[0];
 	struct spi_transfer *x = ts->xfer;
@@ -1203,10 +1203,10 @@ static void ads7846_setup_spi_msg(struct ads7846 *ts,
 
 static int ads7846_probe(struct spi_device *spi)
 {
+	const struct ads7846_platform_data *pdata = dev_get_platdata(&spi->dev);
 	struct ads7846 *ts;
 	struct ads7846_packet *packet;
 	struct input_dev *input_dev;
-	struct ads7846_platform_data *pdata = spi->dev.platform_data;
 	unsigned long irq_flags;
 	int err;
 
@@ -1281,7 +1281,7 @@ static int ads7846_probe(struct spi_device *spi)
 		ts->filter = ads7846_no_filter;
 	}
 
-	err = ads7846_setup_pendown(spi, ts);
+	err = ads7846_setup_pendown(spi, ts, pdata);
 	if (err)
 		goto err_cleanup_filter;
 
