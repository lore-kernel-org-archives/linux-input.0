From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the
 GPIO when using ACPI pm
Date: Fri, 10 Mar 2017 13:58:39 +0200
Message-ID: <1489147119.20145.187.camel@linux.intel.com>
References: <20170122200008.27027-1-hdegoede@redhat.com>
         <1487778778.20145.22.camel@linux.intel.com>
         <65b7a7ed-3199-84d2-c004-adedadce1d88@redhat.com>
         <1488454727.20145.71.camel@linux.intel.com>
         <e4dfd35b-cf7f-93bb-fb88-fb8d412d922a@redhat.com>
         <1488553076.20145.79.camel@linux.intel.com>
         <3be3837a-a57c-e6bf-538b-e135c1b37ff0@redhat.com>
         <1488554609.20145.81.camel@linux.intel.com>
         <693ce7b3-99e9-eb60-b164-50b27294a239@redhat.com>
         <1488887470.20145.108.camel@linux.intel.com>
         <015d1f87-fcfe-b08d-6934-732145d534ca@redhat.com>
         <a53cdb15-a0b8-5ae5-082c-b5cc8bc40661@redhat.com>
         <1488969002.20145.119.camel@linux.intel.com>
         <b19876e3-f36a-a6cf-453f-b0075ad6fadb@redhat.com>
         <1488973582.20145.125.camel@linux.intel.com>
         <654981a1-2493-01d6-13e6-1287b70e22f2@redhat.com>
         <1488997525.20145.161.camel@linux.intel.com>
         <114fa24e-b726-28e1-66c7-aa90bcf5c966@redhat.com>
         <1489068196.20145.169.camel@linux.intel.com>
         <93370dd7-f017-ff3a-5518-b01820452867@redhat.com>
         <97099577-181d-ac94-4d9e-ab5ca64f9ff6@redhat.com>
         <1489145625.20145.182.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:13882 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935812AbdCJL6u (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 10 Mar 2017 06:58:50 -0500
In-Reply-To: <1489145625.20145.182.camel@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On Fri, 2017-03-10 at 13:33 +0200, Andy Shevchenko wrote:
> On Thu, 2017-03-09 at 19:48 +0100, Hans de Goede wrote:
> > Hi,
> > 
> > On 09-03-17 15:45, Hans de Goede wrote:
> > > Hi,
> > > 
> > > On 09-03-17 15:03, Andy Shevchenko wrote:
> > > > On Thu, 2017-03-09 at 14:57 +0100, Hans de Goede wrote:
> > Ok, so there is one problem with the extcon-intel-int3496.c
> > together with your gpio patches:
> > 
> > [ 2382.484415] gpio gpiochip1: (INT33FF:01): gpiochip_lock_as_irq:
> > tried to flag a GPIO set as output for IRQ
> > [ 2382.484425] gpio gpiochip1: (INT33FF:01): unable to lock HW IRQ 3
> > for IRQ
> > [ 2382.484429] genirq: Failed to request resources for INT3496:00
> > (irq
> > 174) on irqchip chv-gpio
> > [ 2382.484518] intel-int3496 INT3496:00: can't request IRQ for USB
> > ID
> > GPIO: -22
> > [ 2382.500359] intel-int3496: probe of INT3496:00 failed with error
> > -22
> 
> By the way did not you see a warning from gpiolib-acpi.c that flags
> are
> overridden by firmware?

Yeah, it's dev_dbg(). Perhaps needs to be changed to dev_warn()?


> > --- a/drivers/extcon/extcon-intel-int3496.c
> > +++ b/drivers/extcon/extcon-intel-int3496.c

Just a reminder that we need
--- a/drivers/extcon/extcon-intel-int3496.c
+++ b/drivers/extcon/extcon-intel-int3496.c
@@ -107,9 +107,7 @@ static int int3496_probe(struct platform_device
*pdev)
        data->dev = dev;
        INIT_DELAYED_WORK(&data->work, int3496_do_usb_id);

-       data->gpio_usb_id = devm_gpiod_get_index(dev, "id",
-                                               INT3496_GPIO_USB_ID,
-                                               GPIOD_IN);
+       data->gpio_usb_id = devm_gpiod_get(dev, "id", GPIOD_IN);
        if (IS_ERR(data->gpio_usb_id)) {
                ret = PTR_ERR(data->gpio_usb_id);
                dev_err(dev, "can't request USB ID GPIO: %d\n", ret);
@@ -122,15 +120,11 @@ static int int3496_probe(struct platform_device
*pdev)
                return data->usb_id_irq;
        }

-       data->gpio_vbus_en = devm_gpiod_get_index(dev, "vbus",
-                                                INT3496_GPIO_VBUS_EN,
-                                                GPIOD_ASIS);
+       data->gpio_vbus_en = devm_gpiod_get(dev, "vbus", GPIOD_ASIS);
        if (IS_ERR(data->gpio_vbus_en))
                dev_info(dev, "can't request VBUS EN GPIO\n");

-       data->gpio_usb_mux = devm_gpiod_get_index(dev, "mux",
-                                                INT3496_GPIO_USB_MUX,
-                                                GPIOD_ASIS);
+       data->gpio_usb_mux = devm_gpiod_get(dev, "mux", GPIOD_ASIS);
        if (IS_ERR(data->gpio_usb_mux))
                dev_info(dev, "can't request USB MUX GPIO\n");


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
