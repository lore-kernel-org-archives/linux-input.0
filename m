From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v3] Input: synaptics-rmi4: Support regulator supplies
Date: Fri, 24 Jun 2016 17:40:00 -0700
Message-ID: <576DD2E0.9000002@synaptics.com>
References: <1465622722-31714-1-git-send-email-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx1.synaptics.com ([192.147.44.131]:18529 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbcFYAkE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Jun 2016 20:40:04 -0400
In-Reply-To: <1465622722-31714-1-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Christopher Heiny <cheiny@synaptics.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Bjorn Andersson <bjorn.andersson@sonymobile.com>

On 06/10/2016 10:25 PM, Bjorn Andersson wrote:
> From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>
> Support the two supplies - vdd and vio - to make it possible to control
> power to the Synaptics chip.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Andrew Duggan <aduggan@synaptics.com>

> ---
>   .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |  9 +++++
>   drivers/input/rmi4/rmi_i2c.c                       | 41 ++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
> index 95fa715c6046..ec908b91fd90 100644
> --- a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
> +++ b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
> @@ -22,6 +22,15 @@ See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>   - syna,reset-delay-ms: The number of milliseconds to wait after resetting the
>   			device.
>   
> +- syna,startup-delay-ms: The number of milliseconds to wait after powering on
> +			 the device.
> +
> +- vdd-supply: VDD power supply.
> +See ../regulator/regulator.txt
> +
> +- vio-supply: VIO power supply
> +See ../regulator/regulator.txt
> +
>   Function Parameters:
>   Parameters specific to RMI functions are contained in child nodes of the rmi device
>    node. Documentation for the parameters of each function can be found in:
> diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
> index a96a326b53bd..71dc6cdde8ac 100644
> --- a/drivers/input/rmi4/rmi_i2c.c
> +++ b/drivers/input/rmi4/rmi_i2c.c
> @@ -11,6 +11,8 @@
>   #include <linux/rmi.h>
>   #include <linux/irq.h>
>   #include <linux/of.h>
> +#include <linux/delay.h>
> +#include <linux/regulator/consumer.h>
>   #include "rmi_driver.h"
>   
>   #define BUFFER_SIZE_INCREMENT 32
> @@ -37,6 +39,9 @@ struct rmi_i2c_xport {
>   
>   	u8 *tx_buf;
>   	size_t tx_buf_size;
> +
> +	struct regulator_bulk_data supplies[2];
> +	u32 startup_delay;
>   };
>   
>   #define RMI_PAGE_SELECT_REGISTER 0xff
> @@ -246,6 +251,24 @@ static int rmi_i2c_probe(struct i2c_client *client,
>   		return -ENODEV;
>   	}
>   
> +	rmi_i2c->supplies[0].supply = "vdd";
> +	rmi_i2c->supplies[1].supply = "vio";
> +	retval = devm_regulator_bulk_get(&client->dev,
> +					 ARRAY_SIZE(rmi_i2c->supplies),
> +					 rmi_i2c->supplies);
> +	if (retval < 0)
> +		return retval;
> +
> +	retval = regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies),
> +				       rmi_i2c->supplies);
> +	if (retval < 0)
> +		return retval;
> +
> +	of_property_read_u32(client->dev.of_node, "syna,startup-delay-ms",
> +			     &rmi_i2c->startup_delay);
> +
> +	msleep(rmi_i2c->startup_delay);
> +
>   	rmi_i2c->client = client;
>   	mutex_init(&rmi_i2c->page_mutex);
>   
> @@ -286,6 +309,7 @@ static int rmi_i2c_remove(struct i2c_client *client)
>   	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
>   
>   	rmi_unregister_transport_device(&rmi_i2c->xport);
> +	regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies), rmi_i2c->supplies);
>   
>   	return 0;
>   }
> @@ -308,6 +332,9 @@ static int rmi_i2c_suspend(struct device *dev)
>   			dev_warn(dev, "Failed to enable irq for wake: %d\n",
>   				ret);
>   	}
> +
> +	regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies), rmi_i2c->supplies);
> +
>   	return ret;
>   }
>   
> @@ -317,6 +344,12 @@ static int rmi_i2c_resume(struct device *dev)
>   	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
>   	int ret;
>   
> +	ret = regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies), rmi_i2c->supplies);
> +	if (ret)
> +		return ret;
> +
> +	msleep(rmi_i2c->startup_delay);
> +
>   	enable_irq(rmi_i2c->irq);
>   	if (device_may_wakeup(&client->dev)) {
>   		ret = disable_irq_wake(rmi_i2c->irq);
> @@ -346,6 +379,8 @@ static int rmi_i2c_runtime_suspend(struct device *dev)
>   
>   	disable_irq(rmi_i2c->irq);
>   
> +	regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies), rmi_i2c->supplies);
> +
>   	return 0;
>   }
>   
> @@ -355,6 +390,12 @@ static int rmi_i2c_runtime_resume(struct device *dev)
>   	struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
>   	int ret;
>   
> +	ret = regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies), rmi_i2c->supplies);
> +	if (ret)
> +		return ret;
> +
> +	msleep(rmi_i2c->startup_delay);
> +
>   	enable_irq(rmi_i2c->irq);
>   
>   	ret = rmi_driver_resume(rmi_i2c->xport.rmi_dev);

