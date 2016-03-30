From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] Input: synaptics-rmi4: Support regulator supplies
Date: Wed, 30 Mar 2016 10:02:47 -0700
Message-ID: <CAOCOHw4sZapv9BzYeqsh-ni20AajkaXT0+cF8KdgNLXZC5Og5g@mail.gmail.com>
References: <1459357023-5560-1-git-send-email-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459357023-5560-1-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@sonymobile.com>
List-Id: linux-input@vger.kernel.org

On Wed, Mar 30, 2016 at 9:57 AM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>
> Support the two supplies - vdd and vio - to make it possible to control
> power to the Synaptics chip.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Sorry for the spam, ^C'ed this and resent it with a valid
Signed-off-by before I saw that this actually did hit the list.

Please ignore this and consider the same patch sent 20 seconds later.

Regards,
Bjorn

> ---
>  .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |  7 ++++
>  drivers/input/rmi4/rmi_i2c.c                       | 45 ++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
> index 95fa715c6046..a8c31f40f816 100644
> --- a/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
> +++ b/Documentation/devicetree/bindings/input/rmi4/rmi_i2c.txt
> @@ -22,6 +22,13 @@ See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
>  - syna,reset-delay-ms: The number of milliseconds to wait after resetting the
>                         device.
>
> +- vdd-supply: VDD power supply.
> +See Documentation/devicetree/bindings/regulator/regulator.txt
> +
> +- vio-supply: VIO power supply
> +See Documentation/devicetree/bindings/regulator/regulator.txt
> +
> +
>  Function Parameters:
>  Parameters specific to RMI functions are contained in child nodes of the rmi device
>   node. Documentation for the parameters of each function can be found in:
> diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
> index a96a326b53bd..a8c794daba04 100644
> --- a/drivers/input/rmi4/rmi_i2c.c
> +++ b/drivers/input/rmi4/rmi_i2c.c
> @@ -11,6 +11,8 @@
>  #include <linux/rmi.h>
>  #include <linux/irq.h>
>  #include <linux/of.h>
> +#include <linux/delay.h>
> +#include <linux/regulator/consumer.h>
>  #include "rmi_driver.h"
>
>  #define BUFFER_SIZE_INCREMENT 32
> @@ -37,6 +39,8 @@ struct rmi_i2c_xport {
>
>         u8 *tx_buf;
>         size_t tx_buf_size;
> +
> +       struct regulator_bulk_data supplies[2];
>  };
>
>  #define RMI_PAGE_SELECT_REGISTER 0xff
> @@ -246,6 +250,22 @@ static int rmi_i2c_probe(struct i2c_client *client,
>                 return -ENODEV;
>         }
>
> +       rmi_i2c->supplies[0].supply = "vdd";
> +       rmi_i2c->supplies[1].supply = "vio";
> +       retval = devm_regulator_bulk_get(&client->dev,
> +                                        ARRAY_SIZE(rmi_i2c->supplies),
> +                                        rmi_i2c->supplies);
> +       if (retval < 0)
> +               return retval;
> +
> +       retval = regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies),
> +                                      rmi_i2c->supplies);
> +       if (retval < 0)
> +               return retval;
> +
> +       /* Allow the firmware to get ready */
> +       msleep(10);
> +
>         rmi_i2c->client = client;
>         mutex_init(&rmi_i2c->page_mutex);
>
> @@ -286,6 +306,8 @@ static int rmi_i2c_remove(struct i2c_client *client)
>         struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
>
>         rmi_unregister_transport_device(&rmi_i2c->xport);
> +       regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies),
> +                              rmi_i2c->supplies);
>
>         return 0;
>  }
> @@ -308,6 +330,10 @@ static int rmi_i2c_suspend(struct device *dev)
>                         dev_warn(dev, "Failed to enable irq for wake: %d\n",
>                                 ret);
>         }
> +
> +       regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies),
> +                              rmi_i2c->supplies);
> +
>         return ret;
>  }
>
> @@ -317,6 +343,14 @@ static int rmi_i2c_resume(struct device *dev)
>         struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
>         int ret;
>
> +       ret = regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies),
> +                                   rmi_i2c->supplies);
> +       if (ret)
> +               return ret;
> +
> +       /* Allow the firmware to get ready */
> +       msleep(10);
> +
>         enable_irq(rmi_i2c->irq);
>         if (device_may_wakeup(&client->dev)) {
>                 ret = disable_irq_wake(rmi_i2c->irq);
> @@ -346,6 +380,9 @@ static int rmi_i2c_runtime_suspend(struct device *dev)
>
>         disable_irq(rmi_i2c->irq);
>
> +       regulator_bulk_disable(ARRAY_SIZE(rmi_i2c->supplies),
> +                              rmi_i2c->supplies);
> +
>         return 0;
>  }
>
> @@ -355,6 +392,14 @@ static int rmi_i2c_runtime_resume(struct device *dev)
>         struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
>         int ret;
>
> +       ret = regulator_bulk_enable(ARRAY_SIZE(rmi_i2c->supplies),
> +                                   rmi_i2c->supplies);
> +       if (ret)
> +               return ret;
> +
> +       /* Allow the firmware to get ready */
> +       msleep(10);
> +
>         enable_irq(rmi_i2c->irq);
>
>         ret = rmi_driver_resume(rmi_i2c->xport.rmi_dev);
> --
> 2.5.0
>
