From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH RESEND v4] cap11xx: add runtime PM support
Date: Fri, 2 Oct 2015 16:38:00 +0200
Message-ID: <560E96C8.3060507@zonque.org>
References: <1443763140-16368-1-git-send-email-mranostay@gmail.com>
 <1443763140-16368-2-git-send-email-mranostay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:33062 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541AbbJBOiD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Oct 2015 10:38:03 -0400
In-Reply-To: <1443763140-16368-2-git-send-email-mranostay@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>, dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

On 10/02/2015 07:19 AM, Matt Ranostay wrote:
> Puts device into DEEP SLEEP when no LEDs are in in the on-state, and no
> input_handlers are in use. Also uses *_autosuspend to prevent a LED
> trigger from constantly suspending and resuming device.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> ---
>  drivers/input/keyboard/cap11xx.c | 84 +++++++++++++++++++++++++++++++---------
>  1 file changed, 65 insertions(+), 19 deletions(-)
> 

...

> +static void cap11xx_shutdown_act(void *data)
> +{
> +	struct i2c_client *i2c_client = data;
> +	struct cap11xx_priv *priv = i2c_get_clientdata(i2c_client);
> +
> +	cap11xx_set_sleep(priv, true);
> +	pm_runtime_disable(&i2c_client->dev);
> +	pm_runtime_set_suspended(&i2c_client->dev);
> +}
> +
>  static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
>  			     const struct i2c_device_id *id)
>  {
> @@ -363,6 +374,14 @@ static int cap11xx_i2c_probe(struct i2c_client *i2c_client,
>  	if (IS_ERR(priv->regmap))
>  		return PTR_ERR(priv->regmap);
>  
> +	error = devm_add_action(dev, cap11xx_shutdown_act, i2c_client);

Why not implement cap11xx_i2c_driver.remove or .shutdown for this?


Otherwise, this looks good to me.


Thanks,
Daniel

