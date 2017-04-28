From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] input: touchscreen: ar1021_i2c: enable touch mode
 during open
Date: Fri, 28 Apr 2017 10:02:00 -0700
Message-ID: <20170428170200.GA4949@dtor-ws>
References: <1493295756-17812-1-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34034 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422821AbdD1RCD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 28 Apr 2017 13:02:03 -0400
Content-Disposition: inline
In-Reply-To: <1493295756-17812-1-git-send-email-martin.kepplinger@ginzinger.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Apr 27, 2017 at 02:22:35PM +0200, Martin Kepplinger wrote:
> The device could as well be in command mode, in which this driver cannot
> handle the device. When opening the device, let's make sure the device
> will be in the mode we expect it to be for this driver.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>  drivers/input/touchscreen/ar1021_i2c.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
> index 1a94d8b..2a76231 100644
> --- a/drivers/input/touchscreen/ar1021_i2c.c
> +++ b/drivers/input/touchscreen/ar1021_i2c.c
> @@ -18,6 +18,12 @@
>  #define AR1021_MAX_X	4095
>  #define AR1021_MAX_Y	4095
>  
> +#define AR1021_CMD	0x55
> +#define AR1021_TOUCH	0x80
> +
> +#define AR1021_CMD_ENABLE_TOUCH		0x12
> +#define AR1021_CMD_DISABLE_TOUCH	0x13
> +
>  struct ar1021_i2c {
>  	struct i2c_client *client;
>  	struct input_dev *input;
> @@ -58,6 +64,15 @@ static int ar1021_i2c_open(struct input_dev *dev)
>  {
>  	struct ar1021_i2c *ar1021 = input_get_drvdata(dev);
>  	struct i2c_client *client = ar1021->client;
> +	int error;
> +	u8 cmd_enable_touch[3] = {AR1021_CMD,
> +				  0x01, /* number of bytes after this */
> +				  AR1021_CMD_ENABLE_TOUCH };

Changed to static const and applied, thank you.

> +
> +	error = i2c_master_send(ar1021->client, cmd_enable_touch,
> +				sizeof(cmd_enable_touch));
> +	if (error < 0)
> +		return error;
>  
>  	enable_irq(client->irq);
>  
> -- 
> 2.1.4
> 

-- 
Dmitry
