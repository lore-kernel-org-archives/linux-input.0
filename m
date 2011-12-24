From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] input: mpu3050: Ensure we enable interrupts
Date: Sat, 24 Dec 2011 00:09:58 -0800
Message-ID: <20111224080958.GB13020@core.coreip.homeip.net>
References: <20111215221732.8657.63987.stgit@bob.linux.org.uk>
 <20111215221857.8657.57262.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48801 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754369Ab1LXIKE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 24 Dec 2011 03:10:04 -0500
Received: by iaeh11 with SMTP id h11so16254131iae.19
        for <linux-input@vger.kernel.org>; Sat, 24 Dec 2011 00:10:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111215221857.8657.57262.stgit@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-input@vger.kernel.org

On Thu, Dec 15, 2011 at 10:18:59PM +0000, Alan Cox wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> This also changes the devname parameter delivered to
> request_threaded_irq() from "mpu_int" to "mpu3050".
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/input/misc/mpu3050.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
> index 89c7160..cf42c78 100644
> --- a/drivers/input/misc/mpu3050.c
> +++ b/drivers/input/misc/mpu3050.c
> @@ -437,12 +437,20 @@ static int __devinit mpu3050_probe(struct i2c_client *client,
>  		error = request_threaded_irq(client->irq,
>  				NULL, mpu3050_interrupt_thread,
>  				IRQF_TRIGGER_RISING,
> -				"mpu_int", sensor);
> +				"mpu3050", sensor);
>  		if (error) {
>  			dev_err(&client->dev, "can't get IRQ %d, error %d\n",
>  					client->irq, error);
>  			goto err_pm_set_suspended;
>  		}
> +
> +		/* Enable interrupts */
> +		i2c_smbus_write_byte_data(sensor->client, MPU3050_INT_CFG,
> +					MPU3050_LATCH_INT_EN
> +					| MPU3050_RAW_RDY_EN
> +					| MPU3050_MPU_RDY_EN);
> +		if (ret < 0)
> +			goto err_free_irq;

You are testing a random variable here. Also, this belongs in open()
method. I will apply the patch below.

Thanks.

-- 
Dmitry

Input: mpu3050 - ensure we enable interrupts

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This also changes the devname parameter delivered to
request_threaded_irq() from "mpu_int" to "mpu3050".

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/misc/mpu3050.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)


diff --git a/drivers/input/misc/mpu3050.c b/drivers/input/misc/mpu3050.c
index 28a7b19..76905ae 100644
--- a/drivers/input/misc/mpu3050.c
+++ b/drivers/input/misc/mpu3050.c
@@ -148,9 +148,20 @@ static void mpu3050_set_power_mode(struct i2c_client *client, u8 val)
 static int mpu3050_input_open(struct input_dev *input)
 {
 	struct mpu3050_sensor *sensor = input_get_drvdata(input);
+	int error;
 
 	pm_runtime_get(sensor->dev);
 
+	/* Enable interrupts */
+	error = i2c_smbus_write_byte_data(sensor->client, MPU3050_INT_CFG,
+					  MPU3050_LATCH_INT_EN |
+					  MPU3050_RAW_RDY_EN |
+					  MPU3050_MPU_RDY_EN);
+	if (error < 0) {
+		pm_runtime_put(sensor->dev);
+		return error;
+	}
+
 	return 0;
 }
 
@@ -259,7 +270,7 @@ static int __devinit mpu3050_probe(struct i2c_client *client,
 	error = request_threaded_irq(client->irq,
 				     NULL, mpu3050_interrupt_thread,
 				     IRQF_TRIGGER_RISING,
-				     "mpu_int", sensor);
+				     "mpu3050", sensor);
 	if (error) {
 		dev_err(&client->dev,
 			"can't get IRQ %d, error %d\n", client->irq, error);
