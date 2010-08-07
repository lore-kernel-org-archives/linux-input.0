From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [PATCH 1/1] mouse: add qci touchpad driver
Date: Sat, 07 Aug 2010 16:14:54 +0530
Message-ID: <4C5D3926.6050307@codeaurora.org>
References: <1281126776-20014-1-git-send-email-nleeder@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1281126776-20014-1-git-send-email-nleeder@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Leeder <nleeder@codeaurora.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Horace Fu <horace.fu@quantatw.com>, Mandeep Singh Baines <msb@chromium.org>
List-Id: linux-input@vger.kernel.org

Hi Neil,

On 8/7/2010 2:02 AM, Neil Leeder wrote:
> This driver is for the QCI trackpad used on Quanta smartbooks
> 
> Review URL: http://codereview.chromium.org/724001

Do we need such URLs? 

> +
> +/*
> + * Driver communicates over i2c to nuvoTon WPCE775x Embedded Controller,
> + * which has touchpad attached through PS/2 interface.
> + */

Why this driver is not developed through MFD architecture then? nuvoTon chip
looks like multi-function chip, isn't it?

> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/input.h>
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
> +#include <linux/input/qci_touchpad.h>
> +
> +#define TOUCHPAD_ID_NAME          "qci-i2cpad"
> +#define TOUCHPAD_NAME             "QCI Touchpad"
> +#define TOUCHPAD_DEVICE           "/qci_touchpad/input0"
> +#define TOUCHPAD_CMD_ENABLE       0xF4
> +#define TOUCHPAD_READ_DATA_LEN    3
> +
> +struct i2ctpad_drv_data {
> +	struct i2c_client *ti2c_client;
> +	struct input_dev *qcitp_dev;
> +	unsigned int qcitp_gpio;
> +	unsigned int qcitp_irq;
> +	char ecdata[8];
> +	bool opened;
> +};
> +
> +
> +static const struct i2c_device_id qcitp_idtable[] = {
> +	{ TOUCHPAD_ID_NAME, 0 },

This should be chip name instead of driver or ID name I think. 

> +
> +	err = gpio_request(context->qcitp_gpio, "qci-pad");
> +	if (err) {
> +		pr_err("[QCI TouchPad] gpio request failed\n");
> +		goto gpio_request_fail;
> +	}
> +
> +	context->qcitp_irq = gpio_to_irq(context->qcitp_gpio);

Please set the direction of the gpio as input, gpio_direction_input, even though gpios
are coming as input by default.

> +
> +static int __devexit qcitp_remove(struct i2c_client *client)
> +{
> +	struct i2ctpad_drv_data *context = i2c_get_clientdata(client);
> +
> +	free_irq(context->qcitp_irq, context);
> +	gpio_free(context->qcitp_gpio);
> +	input_unregister_device(context->qcitp_dev);
> +	i2c_set_clientdata(client, NULL);

Not required in latest kernels.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
