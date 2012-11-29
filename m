From: Alban Bedel <alban.bedel@avionic-design.de>
Subject: Re: [PATCH 4/5] Input: tca8418_keypad - increase severity of
 failures in probe()
Date: Thu, 29 Nov 2012 14:49:26 +0100
Message-ID: <20121129144926.783f12c6@avionic-0020.adnet.avionic-design.de>
References: <1352911688-5001-1-git-send-email-dmitry.torokhov@gmail.com>
	<1352911688-5001-4-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61187 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753420Ab2K2Nt1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Nov 2012 08:49:27 -0500
In-Reply-To: <1352911688-5001-4-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Wed, 14 Nov 2012 08:48:07 -0800
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Failures to build a keymap, request an IRQ, or register input device are
> fatal for the driver, therefore the messages should have "error" severity
> instead of "debug".
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Alban Bedel <alban.bedel@avionic-design.de>

> ---
>  drivers/input/keyboard/tca8418_keypad.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
> index 35340c3..10047eb 100644
> --- a/drivers/input/keyboard/tca8418_keypad.c
> +++ b/drivers/input/keyboard/tca8418_keypad.c
> @@ -348,7 +348,7 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
>  	error = matrix_keypad_build_keymap(keymap_data, NULL, rows, cols,
>  					   keypad_data->keymap, input);
>  	if (error) {
> -		dev_dbg(dev, "Failed to build keymap\n");
> +		dev_err(dev, "Failed to build keymap\n");
>  		goto fail2;
>  	}
>  
> @@ -367,14 +367,14 @@ static int __devinit tca8418_keypad_probe(struct i2c_client *client,
>  				     IRQF_ONESHOT,
>  				     client->name, keypad_data);
>  	if (error) {
> -		dev_dbg(dev, "Unable to claim irq %d; error %d\n",
> +		dev_err(dev, "Unable to claim irq %d; error %d\n",
>  			client->irq, error);
>  		goto fail2;
>  	}
>  
>  	error = input_register_device(input);
>  	if (error) {
> -		dev_dbg(dev, "Unable to register input device, error: %d\n",
> +		dev_err(dev, "Unable to register input device, error: %d\n",
>  			error);
>  		goto fail3;
>  	}

