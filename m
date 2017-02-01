From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: silead - Do not try to directly access the
 GPIO when using ACPI pm
Date: Wed, 1 Feb 2017 09:42:57 -0800
Message-ID: <20170201174257.GE40045@dtor-ws>
References: <20170122200008.27027-1-hdegoede@redhat.com>
 <20170122222015.GA31009@dtor-ws>
 <8a23b7b2-a7aa-d62d-947d-31301a0c92cc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33702 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753859AbdBARnF (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Feb 2017 12:43:05 -0500
Received: by mail-pf0-f194.google.com with SMTP id e4so32187484pfg.0
        for <linux-input@vger.kernel.org>; Wed, 01 Feb 2017 09:43:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8a23b7b2-a7aa-d62d-947d-31301a0c92cc@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, Gregor Riepl <onitake@gmail.com>, linux-input@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>

On Mon, Jan 23, 2017 at 11:05:14AM +0100, Hans de Goede wrote:
> Hi,
> 
> On 22-01-17 23:20, Dmitry Torokhov wrote:
> >On Sun, Jan 22, 2017 at 09:00:08PM +0100, Hans de Goede wrote:
> >>On some x86 tablets we cannot directly access the GPIOs as they are
> >>claimed by the ACPI tables, so check it the i2c client is not being
> >>power-managed by ACPI before trying to get the power pin GPIO.
> >
> >Why do we even get this GPIO if driver is not supposed to be using it?
> >I'd much rather gpio provider hid it from the driver instead of every
> >driver having this check.
> 
> The problem is that the gpio subsys does not really know about ACPI
> managed GPIOs the way this works is that the firmware sets a special
> "reserved for firmware use" bit in the gpio control register and
> directly bit-bangs the gpio control register when it wants to toggle
> the gpio. So there is no awareness of these gpios being reserved
> (as gpios) at the ACPI level AFAICT.
> 
> The hardware specific low-level gpio chip driver checks this bit
> when we request the gpio and returns -EBUSY.

I'd say that, if GPIOs are reserved for firmware use, and kernel should
not or can not touch them, then they should not be visible, if not to
the gpio core, then to consumers for sure.

Let's add Mika and Linus.

Thanks.

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> >
> >Thanks.
> >
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >>Changes in v2:
> >>-Check acpi_bus_power_manageable() instead of trying to directly
> >> control the acpi power level ourselves
> >>---
> >> drivers/input/touchscreen/silead.c | 22 ++++++++++++++++------
> >> 1 file changed, 16 insertions(+), 6 deletions(-)
> >>
> >>diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> >>index 404830a..2fbcd7f 100644
> >>--- a/drivers/input/touchscreen/silead.c
> >>+++ b/drivers/input/touchscreen/silead.c
> >>@@ -31,6 +31,7 @@
> >> #include <linux/irq.h>
> >> #include <linux/regulator/consumer.h>
> >>
> >>+#include <acpi/acpi_bus.h>
> >> #include <asm/unaligned.h>
> >>
> >> #define SILEAD_TS_NAME		"silead_ts"
> >>@@ -494,12 +495,21 @@ static int silead_ts_probe(struct i2c_client *client,
> >> 	if (error)
> >> 		return error;
> >>
> >>-	/* Power GPIO pin */
> >>-	data->gpio_power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
> >>-	if (IS_ERR(data->gpio_power)) {
> >>-		if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
> >>-			dev_err(dev, "Shutdown GPIO request failed\n");
> >>-		return PTR_ERR(data->gpio_power);
> >>+	/*
> >>+	 * If device power is not managed by ACPI, get the power_gpio
> >>+	 * and manage it ourselves.
> >>+	 */
> >>+#ifdef CONFIG_ACPI
> >>+	if (!acpi_bus_power_manageable(ACPI_HANDLE(dev)))
> >>+#endif
> >>+	{
> >>+		data->gpio_power = devm_gpiod_get_optional(dev, "power",
> >>+							   GPIOD_OUT_LOW);
> >>+		if (IS_ERR(data->gpio_power)) {
> >>+			if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
> >>+				dev_err(dev, "Power GPIO request failed\n");
> >>+			return PTR_ERR(data->gpio_power);
> >>+		}
> >> 	}
> >>
> >> 	error = silead_ts_setup(client);
> >>--
> >>2.9.3
> >>
> >

-- 
Dmitry
