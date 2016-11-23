From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v6 1/2] Input: synaptics-rmi4 - add support for F34
 device reflash
Date: Wed, 23 Nov 2016 13:46:17 +0100
Message-ID: <20161123124617.GK2119@mail.corp.redhat.com>
References: <1479668642-376-1-git-send-email-nick@shmanahar.org>
 <1479668642-376-2-git-send-email-nick@shmanahar.org>
 <20161123112041.GJ2119@mail.corp.redhat.com>
 <20161123113138.GA5634@lava.h.shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161123113138.GA5634@lava.h.shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Nov 23 2016 or thereabouts, Nick Dyer wrote:
> On Wed, Nov 23, 2016 at 12:20:41PM +0100, Benjamin Tissoires wrote:
> > On Nov 20 2016 or thereabouts, Nick Dyer wrote:
> > > Add support for updating firmware, triggered by a sysfs attribute.
> > > 
> > > This patch has been tested on Synaptics S7300.
> > > 
> > > Signed-off-by: Nick Dyer <nick@shmanahar.org>
> > > Tested-by: Chris Healy <cphealy@gmail.com>
> > > ---
> > >  drivers/input/rmi4/Kconfig      |  11 +
> > >  drivers/input/rmi4/Makefile     |   1 +
> > >  drivers/input/rmi4/rmi_bus.c    |   3 +
> > >  drivers/input/rmi4/rmi_driver.c | 105 ++++++---
> > >  drivers/input/rmi4/rmi_driver.h |  24 ++
> > >  drivers/input/rmi4/rmi_f01.c    |   6 +
> > >  drivers/input/rmi4/rmi_f34.c    | 481 ++++++++++++++++++++++++++++++++++++++++
> > >  drivers/input/rmi4/rmi_f34.h    |  68 ++++++
> > >  include/linux/rmi.h             |   2 +
> > >  9 files changed, 670 insertions(+), 31 deletions(-)
> > >  create mode 100644 drivers/input/rmi4/rmi_f34.c
> > >  create mode 100644 drivers/input/rmi4/rmi_f34.h
> > > 
> > > diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
> > > index 8cbd362..9a24867 100644
> > > --- a/drivers/input/rmi4/Kconfig
> > > +++ b/drivers/input/rmi4/Kconfig
> > > @@ -74,6 +74,17 @@ config RMI4_F30
> > >  	  Function 30 provides GPIO and LED support for RMI4 devices. This
> > >  	  includes support for buttons on TouchPads and ClickPads.
> > >  
> > > +config RMI4_F34
> > > +	bool "RMI4 Function 34 (Device reflash)"
> > > +	depends on RMI4_CORE
> > > +	select FW_LOADER
> > > +	help
> > > +	  Say Y here if you want to add support for RMI4 function 34.
> > > +
> > > +	  Function 34 provides support for upgrading the firmware on the RMI4
> > > +	  device via the firmware loader interface. This is triggered using a
> > > +	  sysfs attribute.
> > > +
> > >  config RMI4_F54
> > >  	bool "RMI4 Function 54 (Analog diagnostics)"
> > >  	depends on RMI4_CORE
> > > diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
> > > index a6e2752..0250abf 100644
> > > --- a/drivers/input/rmi4/Makefile
> > > +++ b/drivers/input/rmi4/Makefile
> > > @@ -7,6 +7,7 @@ rmi_core-$(CONFIG_RMI4_2D_SENSOR) += rmi_2d_sensor.o
> > >  rmi_core-$(CONFIG_RMI4_F11) += rmi_f11.o
> > >  rmi_core-$(CONFIG_RMI4_F12) += rmi_f12.o
> > >  rmi_core-$(CONFIG_RMI4_F30) += rmi_f30.o
> > > +rmi_core-$(CONFIG_RMI4_F34) += rmi_f34.o
> > >  rmi_core-$(CONFIG_RMI4_F54) += rmi_f54.o
> > >  
> > >  # Transports
> > > diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> > > index 84b3212..ef7a662 100644
> > > --- a/drivers/input/rmi4/rmi_bus.c
> > > +++ b/drivers/input/rmi4/rmi_bus.c
> > > @@ -315,6 +315,9 @@ static struct rmi_function_handler *fn_handlers[] = {
> > >  #ifdef CONFIG_RMI4_F30
> > >  	&rmi_f30_handler,
> > >  #endif
> > > +#ifdef CONFIG_RMI4_F34
> > > +	&rmi_f34_handler,
> > > +#endif
> > >  #ifdef CONFIG_RMI4_F54
> > >  	&rmi_f54_handler,
> > >  #endif
> > > diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> > > index 4f8d197..2b17d8c 100644
> > > --- a/drivers/input/rmi4/rmi_driver.c
> > > +++ b/drivers/input/rmi4/rmi_driver.c
> > > @@ -35,14 +35,24 @@
> > >  #define RMI_DEVICE_RESET_CMD	0x01
> > >  #define DEFAULT_RESET_DELAY_MS	100
> > >  
> > > -static void rmi_free_function_list(struct rmi_device *rmi_dev)
> > > +void rmi_free_function_list(struct rmi_device *rmi_dev)
> > >  {
> > >  	struct rmi_function *fn, *tmp;
> > >  	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
> > >  
> > >  	rmi_dbg(RMI_DEBUG_CORE, &rmi_dev->dev, "Freeing function list\n");
> > >  
> > > +	mutex_lock(&data->irq_mutex);
> > 
> > Sorry for coming late in the party, but now that I am rebasing my
> > patches on top of Dmitry's branch, I realise that the mutex lock/unlock
> > operations are just wrong now.
> > 
> > irq_mutex used to protect the irq_mask of struct rmi_driver_data and
> > where only used sparsely by the .config call during reset. It was also
> > used by rmi_process_interrupt_requests() in the IRQ handler, but the
> > chances of the conflict where low. Side note, this should be a spinlock
> > given that it can be called in an interrupt context.
> 
> Ack
> 
> > But with this patch, the mutex now serves as a barrier for IRQs. It is
> > now taken by a lot of functions that can stall a lot, and so the IRQ
> > will not be happy to be put to sleep.
> > 
> > Looking at the code, I realise that we should be able to avoid the whole
> > locks by the firmware update if we simply disable/enable the interrupts
> > before attempting the firmware update (in rmi_firmware_update()).
> > 
> > If you agree with the general idea, I can revert those locks and simply
> > call enable_irq/disable_irq in a following patch.
> 
> I don't believe the firmware update will work without the interrupts
> being enabled - it uses a completion:
> 
> http://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/tree/drivers/input/rmi4/rmi_f34.c?h=synaptics-rmi4#n103
> 
> I would suggest that if this is a problem, we can change the F34 to not
> use the interrupt and poll instead?

No I was simply talking about disabling/re-enabling the interrupts:

---
diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
index 03df85a..e97770e 100644
--- a/drivers/input/rmi4/rmi_f34.c
+++ b/drivers/input/rmi4/rmi_f34.c
@@ -282,6 +282,7 @@ int rmi_f34_update_firmware(struct f34_data *f34, const struct firmware *fw)
 static int rmi_firmware_update(struct rmi_driver_data *data,
                               const struct firmware *fw)
 {
+       struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
        struct device *dev = &data->rmi_dev->dev;
        struct f34_data *f34;
        int ret;
@@ -305,6 +306,8 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
        if (ret)
                return ret;
 
+       disable_irq(pdata->irq);
+
        /* Tear down functions and re-probe */
        rmi_free_function_list(data->rmi_dev);
 
@@ -324,6 +327,8 @@ static int rmi_firmware_update(struct rmi_driver_data *data,
 
        f34 = dev_get_drvdata(&data->f34_container->dev);
 
+       enable_irq(pdata->irq);
+
        /* Perform firmware update */
        ret = rmi_f34_update_firmware(f34, fw);
 
---

This way, rmi_free_function_list() and rmi_init_functions() don't need to be
protected by the mutex and you avoid the deadlock possibilities.

Cheers,
Benjamin


> 
> cheers
> 
> Nick
