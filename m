From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: [PATCH] Input: ar1021 - do not force raising edge IRQ trigger
Date: Fri, 14 Apr 2017 07:50:25 +0200
Message-ID: <4da4b1d7-bbae-9a19-e3fc-13e99a58e272@ginzinger.com>
References: <20170413234923.GA38321@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.ginzinger.com ([31.193.165.229]:58914 "EHLO
        mail.ginzinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbdDNFua (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Apr 2017 01:50:30 -0400
In-Reply-To: <20170413234923.GA38321@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, Christian Gmeiner <christian.gmeiner@gmail.com>, linux-kernel@vger.kernel.org

On 2017-04-14 01:49, Dmitry Torokhov wrote:
> We should not be forcing edge triggered interrupt, but rather let platform
> decide the kind of trigger it needs to use. Also, the driver is not quite
> safe with regard to edge-triggered interrupts as it does not try to kick
> the controller after requesting/enabling IRQ.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/ar1021_i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
> index 6797e123925a..6c3c79b7ff51 100644
> --- a/drivers/input/touchscreen/ar1021_i2c.c
> +++ b/drivers/input/touchscreen/ar1021_i2c.c
> @@ -109,7 +109,7 @@ static int ar1021_i2c_probe(struct i2c_client *client,
>  
>  	error = devm_request_threaded_irq(&client->dev, client->irq,
>  					  NULL, ar1021_i2c_irq,
> -					  IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +					  IRQF_ONESHOT,
>  					  "ar1021_i2c", ar1021);
>  	if (error) {
>  		dev_err(&client->dev,
> 

makes sense, if users have to expect that this default can change. it works.

Tested-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>

                     martin
