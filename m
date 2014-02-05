From: Courtney Cavin <courtney.cavin@sonymobile.com>
Subject: Re: [PATCH 05/15] Input: synaptics-rmi4 - remove gpio handling and
 polling
Date: Tue, 4 Feb 2014 18:31:14 -0800
Message-ID: <20140205023113.GE1706@sonymobile.com>
References: <1390521623-6491-1-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-2-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-3-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-4-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-5-git-send-email-courtney.cavin@sonymobile.com>
 <1390521623-6491-6-git-send-email-courtney.cavin@sonymobile.com>
 <52F172F3.7090003@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from seldrel01.sonyericsson.com ([212.209.106.2]:13568 "EHLO
	seldrel01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754612AbaBEC3a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Feb 2014 21:29:30 -0500
Content-Disposition: inline
In-Reply-To: <52F172F3.7090003@synaptics.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, linus.walleij@stericsson.com, linus.walleij@linaro.org

On Wed, Feb 05, 2014 at 12:08:35AM +0100, Christopher Heiny wrote:
> On 01/23/2014 04:00 PM, Courtney Cavin wrote:
> > Since all the configuration needed for an irq can be provided in other
> > ways, remove all gpio->irq functionality. This cleans up the code quite
> > a bit.
>
> In certain diagnostic modes, we need to be able to release the IRQ so
> the GPIO can be monitored from userspace.  This patch removes that
> capability.
>

Polling a GPIO from userspace is poor design regardless of the use-case, if
you ask me.  It certainly doesn't motivate the extra gpio<->IRQ code.

> > This also gets rid of polling functionality, as this should be done
> > elsewhere if absolutely needed.
>
> As mentioned in previous patch discussions, the polling functionality is
> quite useful during new system integration, so we need to retain that.
> If you have a proposal for where else it could be done, we'd certainly
> entertain a patch that implements that.

Do you actually have systems that have these hooked up to GPIOs without
IRQ support?

Regardless, if this is the case, implementing a GPIO polling IRQ chip
should be possible, if extremely ugly.

Linus may have some comments in this area, though.  Linus?

>
>                                         Thanks,
>                                                 Chris
>
> >
> > Cc: Christopher Heiny <cheiny@synaptics.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Signed-off-by: Courtney Cavin <courtney.cavin@sonymobile.com>
> > ---
> >   drivers/input/rmi4/rmi_driver.c | 143 +++++-----------------------------------
> >   drivers/input/rmi4/rmi_driver.h |   7 --
> >   drivers/input/rmi4/rmi_i2c.c    |  24 +------
> >   include/linux/rmi.h             |  31 +--------
> >   4 files changed, 20 insertions(+), 185 deletions(-)
> >
> > diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> > index 5fb582c..780742f 100644
> > --- a/drivers/input/rmi4/rmi_driver.c
> > +++ b/drivers/input/rmi4/rmi_driver.c
> > @@ -20,7 +20,6 @@
> >   #include <linux/delay.h>
> >   #include <linux/device.h>
> >   #include <linux/fs.h>
> > -#include <linux/gpio.h>
> >   #include <linux/kconfig.h>
> >   #include <linux/list.h>
> >   #include <linux/module.h>
> > @@ -50,74 +49,17 @@ static irqreturn_t rmi_irq_thread(int irq, void *p)
> >       struct rmi_transport_dev *xport = p;
> >       struct rmi_device *rmi_dev = xport->rmi_dev;
> >       struct rmi_driver *driver = rmi_dev->driver;
> > -     struct rmi_device_platform_data *pdata = xport->dev->platform_data;
> >       struct rmi_driver_data *data;
> >
> >       data = dev_get_drvdata(&rmi_dev->dev);
> > -
> > -     if (IRQ_DEBUG(data))
> > -             dev_dbg(xport->dev, "ATTN gpio, value: %d.\n",
> > -                             gpio_get_value(pdata->attn_gpio));
> > -
> > -     if (gpio_get_value(pdata->attn_gpio) == pdata->attn_polarity) {
> > -             data->attn_count++;
> > -             if (driver && driver->irq_handler && rmi_dev)
> > -                     driver->irq_handler(rmi_dev, irq);
> > -     }
> > +     if (driver && driver->irq_handler && rmi_dev)
> > +             driver->irq_handler(rmi_dev, irq);
> >
> >       return IRQ_HANDLED;
> >   }
> >
> >   static int process_interrupt_requests(struct rmi_device *rmi_dev);
> >
> > -static void rmi_poll_work(struct work_struct *work)
> > -{
> > -     struct rmi_driver_data *data =
> > -                     container_of(work, struct rmi_driver_data, poll_work);
> > -     struct rmi_device *rmi_dev = data->rmi_dev;
> > -
> > -     process_interrupt_requests(rmi_dev);
> > -}
> > -
> > -/*
> > - * This is the timer function for polling - it simply has to schedule work
> > - * and restart the timer.
> > - */
> > -static enum hrtimer_restart rmi_poll_timer(struct hrtimer *timer)
> > -{
> > -     struct rmi_driver_data *data =
> > -                     container_of(timer, struct rmi_driver_data, poll_timer);
> > -
> > -     if (!data->enabled)
> > -             return HRTIMER_NORESTART;
> > -     if (!work_pending(&data->poll_work))
> > -             schedule_work(&data->poll_work);
> > -     hrtimer_start(&data->poll_timer, data->poll_interval, HRTIMER_MODE_REL);
> > -     return HRTIMER_NORESTART;
> > -}
> > -
> > -static int enable_polling(struct rmi_device *rmi_dev)
> > -{
> > -     struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> > -
> > -     dev_dbg(&rmi_dev->dev, "Polling enabled.\n");
> > -     INIT_WORK(&data->poll_work, rmi_poll_work);
> > -     hrtimer_init(&data->poll_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> > -     data->poll_timer.function = rmi_poll_timer;
> > -     hrtimer_start(&data->poll_timer, data->poll_interval, HRTIMER_MODE_REL);
> > -
> > -     return 0;
> > -}
> > -
> > -static void disable_polling(struct rmi_device *rmi_dev)
> > -{
> > -     struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> > -
> > -     dev_dbg(&rmi_dev->dev, "Polling disabled.\n");
> > -     hrtimer_cancel(&data->poll_timer);
> > -     cancel_work_sync(&data->poll_work);
> > -}
> > -
> >   static void disable_sensor(struct rmi_device *rmi_dev)
> >   {
> >       struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> > @@ -125,9 +67,6 @@ static void disable_sensor(struct rmi_device *rmi_dev)
> >       if (!data->enabled)
> >               return;
> >
> > -     if (!data->irq)
> > -             disable_polling(rmi_dev);
> > -
> >       if (rmi_dev->xport->ops->disable_device)
> >               rmi_dev->xport->ops->disable_device(rmi_dev->xport);
> >
> > @@ -155,20 +94,14 @@ static int enable_sensor(struct rmi_device *rmi_dev)
> >       }
> >
> >       xport = rmi_dev->xport;
> > -     if (data->irq) {
> > -             retval = request_threaded_irq(data->irq,
> > -                             xport->hard_irq ? xport->hard_irq : NULL,
> > -                             xport->irq_thread ?
> > -                                     xport->irq_thread : rmi_irq_thread,
> > -                             data->irq_flags,
> > -                             dev_name(&rmi_dev->dev), xport);
> > -             if (retval)
> > -                     return retval;
> > -     } else {
> > -             retval = enable_polling(rmi_dev);
> > -             if (retval < 0)
> > -                     return retval;
> > -     }
> > +     retval = request_threaded_irq(data->irq,
> > +                     xport->hard_irq ? xport->hard_irq : NULL,
> > +                     xport->irq_thread ?
> > +                             xport->irq_thread : rmi_irq_thread,
> > +                     IRQF_ONESHOT,
> > +                     dev_name(&rmi_dev->dev), xport);
> > +     if (retval)
> > +             return retval;
> >
> >       data->enabled = true;
> >
> > @@ -751,16 +684,9 @@ static SIMPLE_DEV_PM_OPS(rmi_driver_pm, rmi_driver_suspend, rmi_driver_resume);
> >   static int rmi_driver_remove(struct device *dev)
> >   {
> >       struct rmi_device *rmi_dev = to_rmi_device(dev);
> > -     const struct rmi_device_platform_data *pdata =
> > -                                     to_rmi_platform_data(rmi_dev);
> > -     const struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> > -
> >       disable_sensor(rmi_dev);
> >       rmi_free_function_list(rmi_dev);
> >
> > -     if (data->gpio_held)
> > -             gpio_free(pdata->attn_gpio);
> > -
> >       return 0;
> >   }
> >
> > @@ -895,51 +821,12 @@ static int rmi_driver_probe(struct device *dev)
> >               mutex_init(&data->suspend_mutex);
> >       }
> >
> > -     if (gpio_is_valid(pdata->attn_gpio)) {
> > -             static const char GPIO_LABEL[] = "attn";
> > -             unsigned long gpio_flags = GPIOF_DIR_IN;
> > -
> > -             data->irq = gpio_to_irq(pdata->attn_gpio);
> > -             if (pdata->level_triggered) {
> > -                     data->irq_flags = IRQF_ONESHOT |
> > -                             ((pdata->attn_polarity == RMI_ATTN_ACTIVE_HIGH)
> > -                             ? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW);
> > -             } else {
> > -                     data->irq_flags =
> > -                             (pdata->attn_polarity == RMI_ATTN_ACTIVE_HIGH)
> > -                             ? IRQF_TRIGGER_RISING : IRQF_TRIGGER_FALLING;
> > -             }
> > +     data->irq = pdata->irq;
> > +     if (data->irq < 0) {
> > +             dev_err(dev, "Failed to get attn IRQ.\n");
> > +             retval = data->irq;
> > +             goto err_free_data;
> >
> > -             if (IS_ENABLED(CONFIG_RMI4_DEV))
> > -                     gpio_flags |= GPIOF_EXPORT;
> > -
> > -             retval = gpio_request_one(pdata->attn_gpio, gpio_flags,
> > -                                       GPIO_LABEL);
> > -             if (retval) {
> > -                     dev_warn(dev, "WARNING: Failed to request ATTN gpio %d, code=%d.\n",
> > -                              pdata->attn_gpio, retval);
> > -                     retval = 0;
> > -             } else {
> > -                     dev_info(dev, "Obtained ATTN gpio %d.\n",
> > -                                     pdata->attn_gpio);
> > -                     data->gpio_held = true;
> > -                     if (IS_ENABLED(CONFIG_RMI4_DEV)) {
> > -                             retval = gpio_export_link(dev,
> > -                                             GPIO_LABEL, pdata->attn_gpio);
> > -                             if (retval) {
> > -                                     dev_warn(dev,
> > -                                             "WARNING: Failed to symlink ATTN gpio!\n");
> > -                                     retval = 0;
> > -                             } else {
> > -                                     dev_info(dev, "Exported ATTN gpio %d.",
> > -                                             pdata->attn_gpio);
> > -                             }
> > -                     }
> > -             }
> > -     } else {
> > -             data->poll_interval = ktime_set(0,
> > -                     (pdata->poll_interval_ms ? pdata->poll_interval_ms :
> > -                     DEFAULT_POLL_INTERVAL_MS) * 1000 * 1000);
> >       }
> >
> >       if (data->f01_container->dev.driver) {
> > diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
> > index 4f44a54..aef5521 100644
> > --- a/drivers/input/rmi4/rmi_driver.h
> > +++ b/drivers/input/rmi4/rmi_driver.h
> > @@ -39,9 +39,7 @@ struct rmi_driver_data {
> >
> >       u32 attn_count;
> >       u32 irq_debug;  /* Should be bool, but debugfs wants u32 */
> > -     bool gpio_held;
> >       int irq;
> > -     int irq_flags;
> >       int num_of_irq_regs;
> >       int irq_count;
> >       unsigned long *irq_status;
> > @@ -50,11 +48,6 @@ struct rmi_driver_data {
> >       bool irq_stored;
> >       struct mutex irq_mutex;
> >
> > -     /* Following are used when polling. */
> > -     struct hrtimer poll_timer;
> > -     struct work_struct poll_work;
> > -     ktime_t poll_interval;
> > -
> >       struct mutex pdt_mutex;
> >       u8 pdt_props;
> >       u8 bsr;
> > diff --git a/drivers/input/rmi4/rmi_i2c.c b/drivers/input/rmi4/rmi_i2c.c
> > index 910f05c..aebf974 100644
> > --- a/drivers/input/rmi4/rmi_i2c.c
> > +++ b/drivers/input/rmi4/rmi_i2c.c
> > @@ -196,8 +196,7 @@ static int rmi_i2c_probe(struct i2c_client *client,
> >               return -EINVAL;
> >       }
> >
> > -     dev_dbg(&client->dev, "Probing %#02x (GPIO %d).\n",
> > -             client->addr, pdata->attn_gpio);
> > +     dev_dbg(&client->dev, "Probing %#02x.\n", client->addr);
> >
> >       if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> >               dev_err(&client->dev,
> > @@ -205,15 +204,6 @@ static int rmi_i2c_probe(struct i2c_client *client,
> >               return -ENODEV;
> >       }
> >
> > -     if (pdata->gpio_config) {
> > -             retval = pdata->gpio_config(pdata->gpio_data, true);
> > -             if (retval < 0) {
> > -                     dev_err(&client->dev, "Failed to configure GPIOs, code: %d.\n",
> > -                             retval);
> > -                     return retval;
> > -             }
> > -     }
> > -
> >       rmi_i2c = devm_kzalloc(&client->dev, sizeof(struct rmi_i2c_xport),
> >                               GFP_KERNEL);
> >       if (!rmi_i2c)
> > @@ -240,7 +230,7 @@ static int rmi_i2c_probe(struct i2c_client *client,
> >       if (retval) {
> >               dev_err(&client->dev, "Failed to register transport driver at 0x%.2X.\n",
> >                       client->addr);
> > -             goto err_gpio;
> > +             goto err;
> >       }
> >
> >       i2c_set_clientdata(client, rmi_i2c);
> > @@ -249,24 +239,16 @@ static int rmi_i2c_probe(struct i2c_client *client,
> >                       client->addr);
> >       return 0;
> >
> > -err_gpio:
> > -     if (pdata->gpio_config)
> > -             pdata->gpio_config(pdata->gpio_data, false);
> > -
> > +err:
> >       return retval;
> >   }
> >
> >   static int rmi_i2c_remove(struct i2c_client *client)
> >   {
> > -     const struct rmi_device_platform_data *pdata =
> > -                             dev_get_platdata(&client->dev);
> >       struct rmi_i2c_xport *rmi_i2c = i2c_get_clientdata(client);
> >
> >       rmi_unregister_transport_device(&rmi_i2c->xport);
> >
> > -     if (pdata->gpio_config)
> > -             pdata->gpio_config(pdata->gpio_data, false);
> > -
> >       return 0;
> >   }
> >
> > diff --git a/include/linux/rmi.h b/include/linux/rmi.h
> > index 65b59b5..326e741 100644
> > --- a/include/linux/rmi.h
> > +++ b/include/linux/rmi.h
> > @@ -23,11 +23,6 @@
> >   #include <linux/wait.h>
> >   #include <linux/debugfs.h>
> >
> > -enum rmi_attn_polarity {
> > -     RMI_ATTN_ACTIVE_LOW = 0,
> > -     RMI_ATTN_ACTIVE_HIGH = 1
> > -};
> > -
> >   /**
> >    * struct rmi_f11_axis_alignment - target axis alignment
> >    * @swap_axes: set to TRUE if desired to swap x- and y-axis
> > @@ -194,25 +189,10 @@ struct rmi_device_platform_data_spi {
> >   /**
> >    * struct rmi_device_platform_data - system specific configuration info.
> >    *
> > + * @irq - attention IRQ
> >    * @firmware_name - if specified will override default firmware name,
> >    * for reflashing.
> >    *
> > - * @attn_gpio - the index of a GPIO that will be used to provide the ATTN
> > - * interrupt from the touch sensor.
> > - * @attn_polarity - indicates whether ATTN is active high or low.
> > - * @level_triggered - by default, the driver uses edge triggered interrupts.
> > - * However, this can cause problems with suspend/resume on some platforms.  In
> > - * that case, set this to 1 to use level triggered interrupts.
> > - * @gpio_config - a routine that will be called when the driver is loaded to
> > - * perform any platform specific GPIO configuration, and when it is unloaded
> > - * for GPIO de-configuration.  This is typically used to configure the ATTN
> > - * GPIO and the I2C or SPI pins, if necessary.
> > - * @gpio_data - platform specific data to be passed to the GPIO configuration
> > - * function.
> > - *
> > - * @poll_interval_ms - the time in milliseconds between reads of the interrupt
> > - * status register.  This is ignored if attn_gpio is non-zero.
> > - *
> >    * @reset_delay_ms - after issuing a reset command to the touch sensor, the
> >    * driver waits a few milliseconds to give the firmware a chance to
> >    * to re-initialize.  You can override the default wait period here.
> > @@ -245,14 +225,7 @@ struct rmi_device_platform_data_spi {
> >    * functions.
> >    */
> >   struct rmi_device_platform_data {
> > -     int attn_gpio;
> > -     enum rmi_attn_polarity attn_polarity;
> > -     bool level_triggered;
> > -     void *gpio_data;
> > -     int (*gpio_config)(void *gpio_data, bool configure);
> > -
> > -     int poll_interval_ms;
> > -
> > +     int irq;
> >       int reset_delay_ms;
> >
> >       struct rmi_device_platform_data_spi spi_data;
> >
