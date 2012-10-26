From: Bo Shen <voice.shen@atmel.com>
Subject: Re: [PATCH 1/2] input: qt1070: add pinctrl consumer
Date: Fri, 26 Oct 2012 11:51:22 +0800
Message-ID: <508A08BA.1070302@atmel.com>
References: <20121023131627.GE18964@game.jcrosoft.org> <1350998942-713-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:18351 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755886Ab2JZDvi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 25 Oct 2012 23:51:38 -0400
In-Reply-To: <1350998942-713-1-git-send-email-plagnioj@jcrosoft.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-input@vger.kernel.org

On 10/23/2012 21:29, Jean-Christophe PLAGNIOL-VILLARD wrote:
> If no pinctrl available just report a warning as some architecture may not
> need to do anything.
>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-input@vger.kernel.org
> ---
>   drivers/input/keyboard/qt1070.c |   11 +++++++++++
>   1 file changed, 11 insertions(+)

Test it on sam9x5ek board with qt1070. It works well.

Tested-by: Bo Shen <voice.shen@atmel.com>

> diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
> index ca68f29..967734e 100644
> --- a/drivers/input/keyboard/qt1070.c
> +++ b/drivers/input/keyboard/qt1070.c
> @@ -33,6 +33,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/jiffies.h>
>   #include <linux/delay.h>
> +#include <linux/pinctrl/consumer.h>
>
>   /* Address for each register */
>   #define CHIP_ID            0x00
> @@ -147,6 +148,7 @@ static int __devinit qt1070_probe(struct i2c_client *client,
>   	struct input_dev *input;
>   	int i;
>   	int err;
> +	struct pinctrl *pinctrl;
>
>   	err = i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE);
>   	if (!err) {
> @@ -155,6 +157,15 @@ static int __devinit qt1070_probe(struct i2c_client *client,
>   		return -ENODEV;
>   	}
>
> +	pinctrl = devm_pinctrl_get_select_default(&client->dev);
> +	if (IS_ERR(pinctrl)) {
> +		err = PTR_ERR(pinctrl);
> +		if (err == -EPROBE_DEFER)
> +			return err;
> +
> +		dev_warn(&client->dev, "No pinctrl provided\n");
> +	}
> +
>   	if (!client->irq) {
>   		dev_err(&client->dev, "please assign the irq to this device\n");
>   		return -EINVAL;
>

