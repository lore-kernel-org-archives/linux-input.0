From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH 2/8] mfd: stpmu1: add stpmu1 pmic driver
Date: Tue, 10 Jul 2018 00:38:36 +0200
Message-ID: <CAFqH_51hua9S-_Hp5iKTT_UB2Dgdb6HhDkD1G4=NFq_2qvvJKA@mail.gmail.com>
References: <1530803657-17684-1-git-send-email-p.paillet@st.com> <1530803657-17684-3-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530803657-17684-3-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: p.paillet@st.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, wim@linux-watchdog.org, Guenter Roeck <linux@roeck-us.net>, linux-input@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-watchdog@vger.kernel.org, benjamin.gaignard@linaro.org
List-Id: linux-input@vger.kernel.org

Hi Pascal,

Thanks for the patch some comments below.

Missatge de Pascal PAILLET-LME <p.paillet@st.com> del dia dj., 5 de
jul. 2018 a les 17:17:
>
> From: pascal paillet <p.paillet@st.com>
>
> stpmu1 is a pmic from STMicroelectronics. The stpmu1 integrates 10
> regulators and 3 switches with various capabilities.
>
> Signed-off-by: pascal paillet <p.paillet@st.com>
> ---
>  drivers/mfd/Kconfig                 |  14 ++
>  drivers/mfd/Makefile                |   1 +
>  drivers/mfd/stpmu1.c                | 490 ++++++++++++++++++++++++++++++++++++
>  include/dt-bindings/mfd/st,stpmu1.h |  46 ++++
>  include/linux/mfd/stpmu1.h          | 220 ++++++++++++++++
>  5 files changed, 771 insertions(+)
>  create mode 100644 drivers/mfd/stpmu1.c
>  create mode 100644 include/dt-bindings/mfd/st,stpmu1.h
>  create mode 100644 include/linux/mfd/stpmu1.h
>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index b860eb5..e15140b 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1812,6 +1812,20 @@ config MFD_STM32_TIMERS
>           for PWM and IIO Timer. This driver allow to share the
>           registers between the others drivers.
>
> +config MFD_STPMU1
> +       tristate "Support for STPMU1 PMIC"
> +       depends on (I2C=y && OF)
> +       select REGMAP_I2C
> +       select REGMAP_IRQ
> +       select MFD_CORE
> +       help
> +         Support for ST Microelectronics STPMU1 PMIC. Stpmu1 mfd driver is
> +         the core driver for stpmu1 component that mainly handles interrupts.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called stpmu1.
> +
> +
Extra line not needed.

>  menu "Multimedia Capabilities Port drivers"
>         depends on ARCH_SA1100
>
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index e9fd20d..f1c4be1 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -220,6 +220,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)       += intel_soc_pmic_chtdc_ti.o
>  obj-$(CONFIG_MFD_MT6397)       += mt6397-core.o
>
>  obj-$(CONFIG_MFD_ALTERA_A10SR) += altera-a10sr.o
> +obj-$(CONFIG_MFD_STPMU1)       += stpmu1.o
>  obj-$(CONFIG_MFD_SUN4I_GPADC)  += sun4i-gpadc.o
>
>  obj-$(CONFIG_MFD_STM32_LPTIMER)        += stm32-lptimer.o
> diff --git a/drivers/mfd/stpmu1.c b/drivers/mfd/stpmu1.c
> new file mode 100644
> index 0000000..a284a3e
> --- /dev/null
> +++ b/drivers/mfd/stpmu1.c
> @@ -0,0 +1,490 @@
> +// SPDX-License-Identifier: GPL-2.0

There is a license mismatch between SPDX and MODULE_LICENSE. Or SPDX
identifier should be GPL-2.0-or-later or MODULE_LICENSE should be
("GPL v2")

See https://elixir.bootlin.com/linux/latest/source/include/linux/module.h#L175

> +/*
> + * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
> + * Author: Philippe Peurichard <philippe.peurichard@st.com>,
> + * Pascal Paillet <p.paillet@st.com> for STMicroelectronics.
> + */
> +
I think that Lee, like Linus, prefers the C++ style here

> +#include <linux/err.h>
That this include is not needed.

> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/stpmu1.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
ditto
> +#include <linux/pm_runtime.h>
ditto

> +#include <linux/pm_wakeirq.h>
> +#include <linux/regmap.h>
> +#include <dt-bindings/mfd/st,stpmu1.h>
> +

[snip]

> +
> +static int stpmu1_configure_from_dt(struct stpmu1_dev *pmic_dev)
> +{
> +       struct device_node *np = pmic_dev->np;
> +       u32 reg = 0;
You don't need to initialize reg to 0, anyway will be overwriten.

> +       int ret = 0;
You don't need to initialize ret to 0, anyway will be overwritten.

> +       int irq;
> +
> +       irq = of_irq_get(np, 0);
> +       if (irq <= 0) {
> +               dev_err(pmic_dev->dev,
> +                       "Failed to get irq config: %d\n", irq);
This can be in one line.

> +               return irq ? irq : -ENODEV;
nit: return irq ?: -ENODEV;

> +       }
> +       pmic_dev->irq = irq;
> +
> +       irq = of_irq_get(np, 1);
> +       if (irq <= 0) {
> +               dev_err(pmic_dev->dev,
> +                       "Failed to get irq_wake config: %d\n", irq);
> +               return irq ? irq : -ENODEV;
nit: return irq ?: -ENODEV;

> +       }
> +       pmic_dev->irq_wake = irq;
> +
> +       device_init_wakeup(pmic_dev->dev, true);
> +       ret = dev_pm_set_dedicated_wake_irq(pmic_dev->dev, pmic_dev->irq_wake);
> +       if (ret)
> +               dev_warn(pmic_dev->dev, "failed to set up wakeup irq");
> +
> +       if (!of_property_read_u32(np, "st,main_control_register", &reg)) {
> +               ret = regmap_update_bits(pmic_dev->regmap,
> +                                        SWOFF_PWRCTRL_CR,
> +                                        PWRCTRL_POLARITY_HIGH |
> +                                        PWRCTRL_PIN_VALID |
> +                                        RESTART_REQUEST_ENABLED,
> +                                        reg);
> +               if (ret) {
> +                       dev_err(pmic_dev->dev,
> +                               "Failed to update main control register: %d\n",
> +                               ret);
> +                       return ret;
> +               }
> +       }
> +
> +       if (!of_property_read_u32(np, "st,pads_pull_register", &reg)) {
> +               ret = regmap_update_bits(pmic_dev->regmap,
> +                                        PADS_PULL_CR,
> +                                        WAKEUP_DETECTOR_DISABLED |
> +                                        PWRCTRL_PD_ACTIVE |
> +                                        PWRCTRL_PU_ACTIVE |
> +                                        WAKEUP_PD_ACTIVE,
> +                                        reg);
> +               if (ret) {
> +                       dev_err(pmic_dev->dev,
> +                               "Failed to update pads control register: %d\n",
> +                               ret);
> +                       return ret;
> +               }
> +       }
> +
> +       if (!of_property_read_u32(np, "st,vin_control_register", &reg)) {
> +               ret = regmap_update_bits(pmic_dev->regmap,
> +                                        VBUS_DET_VIN_CR,
> +                                        VINLOW_CTRL_REG_MASK,
> +                                        reg);
> +               if (ret) {
> +                       dev_err(pmic_dev->dev,
> +                               "Failed to update vin control register: %d\n",
> +                               ret);
> +                       return ret;
> +               }
> +       }
> +
> +       if (!of_property_read_u32(np, "st,usb_control_register", &reg)) {
> +               ret = regmap_update_bits(pmic_dev->regmap, BST_SW_CR,
> +                                        BOOST_OVP_DISABLED |
> +                                        VBUS_OTG_DETECTION_DISABLED |
> +                                        SW_OUT_DISCHARGE |
> +                                        VBUS_OTG_DISCHARGE |
> +                                        OCP_LIMIT_HIGH,
> +                                        reg);
> +               if (ret) {
> +                       dev_err(pmic_dev->dev,
> +                               "Failed to update usb control register: %d\n",
> +                               ret);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +int stpmu1_device_init(struct stpmu1_dev *pmic_dev)
> +{
> +       int ret;
> +       unsigned int val;
> +
> +       pmic_dev->regmap =
> +           devm_regmap_init_i2c(pmic_dev->i2c, &stpmu1_regmap_config);
> +
> +       if (IS_ERR(pmic_dev->regmap)) {
> +               ret = PTR_ERR(pmic_dev->regmap);
You can remove this ...

> +               dev_err(pmic_dev->dev, "Failed to allocate register map: %d\n",
> +                       ret);
> +               return ret;
and just return PTR_ERR(pmic_dev->regmap);

> +       }
> +
> +       ret = stpmu1_configure_from_dt(pmic_dev);
> +       if (ret < 0) {
Is ret >0 return valid?  If not, perhaps "if (ret)" would be better.

> +               dev_err(pmic_dev->dev,
> +                       "Unable to configure PMIC from Device Tree: %d\n", ret);
> +               return ret;
> +       }
> +
> +       /* Read Version ID */
> +       ret = regmap_read(pmic_dev->regmap, VERSION_SR, &val);
> +       if (ret < 0) {
Is ret >0 return valid?  If not, perhaps "if (ret)" would be better.

> +               dev_err(pmic_dev->dev, "Unable to read pmic version\n");
> +               return ret;
> +       }
> +       dev_dbg(pmic_dev->dev, "PMIC Chip Version: 0x%x\n", val);
nit: Maybe that should be dev_info instead of dev_dbg?

> +
> +       /* Initialize PMIC IRQ Chip & IRQ domains associated */
> +       ret = devm_regmap_add_irq_chip(pmic_dev->dev, pmic_dev->regmap,
> +                                      pmic_dev->irq,
> +                                      IRQF_ONESHOT | IRQF_SHARED,
> +                                      0, &stpmu1_regmap_irq_chip,
> +                                      &pmic_dev->irq_data);
> +       if (ret < 0) {
Is ret >0 return valid?  If not, perhaps "if (ret)" would be better.

> +               dev_err(pmic_dev->dev, "IRQ Chip registration failed: %d\n",
> +                       ret);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct of_device_id stpmu1_dt_match[] = {
> +       {.compatible = "st,stpmu1"},
> +       {},
I'd rewrite this as
 +       { .compatible = "st,stpmu1" },
 +       { }
Space after/before brackets and no comma at the end.  The sentinel
indicates the last item on structure/arrays so no need to add a comma
at the end.

> +};
> +
Remove this line

> +MODULE_DEVICE_TABLE(of, stpmu1_dt_match);
> +
> +static int stpmu1_remove(struct i2c_client *i2c)
> +{
> +       struct stpmu1_dev *pmic_dev = i2c_get_clientdata(i2c);
> +
> +       of_platform_depopulate(pmic_dev->dev);
> +
> +       return 0;
> +}
You can remove this function, see below ...

> +
> +static int stpmu1_probe(struct i2c_client *i2c,
> +                       const struct i2c_device_id *id)
> +{
> +       struct stpmu1_dev *pmic;
> +       struct device *dev = &i2c->dev;
> +       int ret = 0;
No need to initialize to 0 if ...

> +
> +       pmic = devm_kzalloc(dev, sizeof(struct stpmu1_dev), GFP_KERNEL);
> +       if (!pmic)
> +               return -ENOMEM;
> +
> +       pmic->np = dev->of_node;
> +
> +       dev_set_drvdata(dev, pmic);
> +       pmic->dev = dev;
> +       pmic->i2c = i2c;
> +
> +       ret = stpmu1_device_init(pmic);
> +       if (ret < 0)
Is ret >0 return valid?  If not, perhaps "if (ret)" would be better.
> +               goto err;
return ret;

> +
> +       ret = of_platform_populate(pmic->np, NULL, NULL, pmic->dev);
> +
ret = devm_of_platform_populate(pmic->dev);

or even better

return  devm_of_platform_populate(pmic->dev);

And remove the stpmu1_remove function.

> +       dev_dbg(dev, "stpmu1 driver probed\n");
That message looks redundant to me. I'd remove it.

> +err:
And you can remove this label.

> +       return ret;
And this

> +}
> +
> +static const struct i2c_device_id stpmu1_id[] = {
> +       {"stpmu1", 0},
> +       {}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, stpmu1_id);
The above code shouldn't be needed anymore for DT-only devices. See
da10c06a044b ("i2c: Make I2C ID tables non-mandatory for DT'ed
devices")

> +
> +#ifdef CONFIG_PM_SLEEP
> +static int stpmu1_suspend(struct device *dev)
> +{
> +       struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> +       struct stpmu1_dev *pmic_dev = i2c_get_clientdata(i2c);
> +
> +       if (device_may_wakeup(dev))
> +               enable_irq_wake(pmic_dev->irq_wake);
> +
> +       disable_irq(pmic_dev->irq);
> +       return 0;
> +}
> +
> +static int stpmu1_resume(struct device *dev)
> +{
> +       struct i2c_client *i2c = container_of(dev, struct i2c_client, dev);
> +       struct stpmu1_dev *pmic_dev = i2c_get_clientdata(i2c);
> +
> +       regcache_sync(pmic_dev->regmap);
Maybe you would like to check for an error here.

> +
> +       if (device_may_wakeup(dev))
> +               disable_irq_wake(pmic_dev->irq_wake);
> +
> +       enable_irq(pmic_dev->irq);
> +       return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(stpmu1_pm, stpmu1_suspend, stpmu1_resume);
> +
> +static struct i2c_driver stpmu1_driver = {
> +       .driver = {
> +                  .name = "stpmu1",
> +                  .owner = THIS_MODULE,
This is not needed, the core does it for you.

> +                  .pm = &stpmu1_pm,
> +                  .of_match_table = of_match_ptr(stpmu1_dt_match),
It is a DT-only device so no need the of_match_ptr.

> +                  },
> +       .probe = stpmu1_probe,
> +       .remove = stpmu1_remove,
Now you can remove this

> +       .id_table = stpmu1_id,
And you can remove this also.

> +};
> +
> +module_i2c_driver(stpmu1_driver);
> +
> +MODULE_DESCRIPTION("STPMU1 PMIC I2C Client");
nit: PMIC I2C Client sounds weird to me, "STPMU1 PMIC driver" ? Note
that I am not english native so I could be wrong.

> +MODULE_AUTHOR("<philippe.peurichard@st.com>");
Use "Name <email>" or just "Name"

> +MODULE_LICENSE("GPL");
As I told you there is a license mismatch with SPDX.

[snip]

Best regards,
 Enric
