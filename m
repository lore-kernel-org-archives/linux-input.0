From: Alban Bedel <alban.bedel@avionic-design.de>
Subject: Re: [PATCH 3/5] Input: tca8418_keypad - move device ID tables
 closer to where they are used
Date: Thu, 29 Nov 2012 14:49:05 +0100
Message-ID: <20121129144905.3940a793@avionic-0020.adnet.avionic-design.de>
References: <1352911688-5001-1-git-send-email-dmitry.torokhov@gmail.com>
	<1352911688-5001-3-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61004 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753358Ab2K2NtG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Nov 2012 08:49:06 -0500
In-Reply-To: <1352911688-5001-3-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, 14 Nov 2012 08:48:06 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> This matches structure of most other input drivers.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Alban Bedel <alban.bedel@avionic-design.de>

> ---
>  drivers/input/keyboard/tca8418_keypad.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
> index 7f2869f..35340c3 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c
> @@ -110,21 +110,6 @@
>  #define KEY_EVENT_CODE		0x7f
>  #define KEY_EVENT_VALUE		0x80
>  
> -
> -static const struct i2c_device_id tca8418_id[] = {
> -	{ TCA8418_NAME, 8418, },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(i2c, tca8418_id);
> -
> -#ifdef CONFIG_OF
> -static const struct of_device_id tca8418_dt_ids[] __devinitconst = {
> -	{ .compatible = "ti,tca8418", },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, tca8418_dt_ids);
> -#endif
> -
>  struct tca8418_keypad {
>  	unsigned int irq;
>  	unsigned int row_shift;
> @@ -419,6 +404,20 @@ static int __devexit tca8418_keypad_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static const struct i2c_device_id tca8418_id[] = {
> +	{ TCA8418_NAME, 8418, },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tca8418_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id tca8418_dt_ids[] __devinitconst = {
> +	{ .compatible = "ti,tca8418", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, tca8418_dt_ids);
> +#endif
> +
>  static struct i2c_driver tca8418_keypad_driver = {
>  	.driver = {
>  		.name	= TCA8418_NAME,

