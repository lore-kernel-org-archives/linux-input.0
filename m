From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] input: touchscreen: silead: Add regulator support
Date: Wed, 16 Nov 2016 17:01:11 -0800
Message-ID: <20161117010111.GA8133@dtor-ws>
References: <20161116115507.24220-1-hdegoede@redhat.com>
 <20161116175159.GB335@dtor-ws>
 <cdc827c1-f5ba-27b8-b7d0-4489fbd6da28@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <cdc827c1-f5ba-27b8-b7d0-4489fbd6da28-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Nov 16, 2016 at 07:58:26PM +0100, Hans de Goede wrote:
> HI,
> 
> On 16-11-16 18:51, Dmitry Torokhov wrote:
> >On Wed, Nov 16, 2016 at 12:55:07PM +0100, Hans de Goede wrote:
> >>On some tablets the touchscreen controller is powered by separate
> >>regulators, add support for this.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> >>Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >>---
> >>Changes in v2:
> >>-Use devm_regulator_bulk_get() and friends
> >>-Use devm_add_action_or_reset() to disable the regulator
> >>---
> >> .../bindings/input/touchscreen/silead_gsl1680.txt  |  2 ++
> >> drivers/input/touchscreen/silead.c                 | 29 ++++++++++++++++++++++
> >> 2 files changed, 31 insertions(+)
> >>
> >>diff --git a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> >>index e844c3f..b726823 100644
> >>--- a/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> >>+++ b/Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
> >>@@ -22,6 +22,8 @@ Optional properties:
> >> - touchscreen-inverted-y  : See touchscreen.txt
> >> - touchscreen-swapped-x-y : See touchscreen.txt
> >> - silead,max-fingers	  : maximum number of fingers the touchscreen can detect
> >>+- vddio-supply		  : regulator phandle for controller VDDIO
> >>+- avdd-supply		  : regulator phandle for controller AVDD
> >>
> >> Example:
> >>
> >>diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> >>index f502c84..404830a 100644
> >>--- a/drivers/input/touchscreen/silead.c
> >>+++ b/drivers/input/touchscreen/silead.c
> >>@@ -29,6 +29,7 @@
> >> #include <linux/input/touchscreen.h>
> >> #include <linux/pm.h>
> >> #include <linux/irq.h>
> >>+#include <linux/regulator/consumer.h>
> >>
> >> #include <asm/unaligned.h>
> >>
> >>@@ -73,6 +74,7 @@ struct silead_ts_data {
> >> 	struct i2c_client *client;
> >> 	struct gpio_desc *gpio_power;
> >> 	struct input_dev *input;
> >>+	struct regulator_bulk_data regulators[2];
> >> 	char fw_name[64];
> >> 	struct touchscreen_properties prop;
> >> 	u32 max_fingers;
> >>@@ -433,6 +435,13 @@ static int silead_ts_set_default_fw_name(struct silead_ts_data *data,
> >> }
> >> #endif
> >>
> >>+static void silead_disable_regulator(void *arg)
> >>+{
> >>+	struct silead_ts_data *data = arg;
> >>+
> >>+	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
> >>+}
> >>+
> >> static int silead_ts_probe(struct i2c_client *client,
> >> 			   const struct i2c_device_id *id)
> >> {
> >>@@ -465,6 +474,26 @@ static int silead_ts_probe(struct i2c_client *client,
> >> 	if (client->irq <= 0)
> >> 		return -ENODEV;
> >>
> >>+	data->regulators[0].supply = "vddio";
> >>+	data->regulators[1].supply = "avdd";
> >>+	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(data->regulators),
> >>+					data->regulators);
> >>+	if (error)
> >>+		return error;
> >>+
> >>+	/*
> >>+	 * Enable regulators at probe and disable them at remove, we need
> >>+	 * to keep the chip powered otherwise it forgets its firmware.
> >>+	 */
> >
> >Hmm, this burns power though. Why can't we reload firmware on resume (it
> >should be already cached)?
> 
> We already put the device in low-power mode using the power pin. Of the
> 20 or so different tablets I've with this touchscreen controller only
> 2 actually have a separate regulator for the controller, so I do not
> believe that powering down the regulator will be a big win, otherwise
> all tablets would have had this.
> 
> > Does it take too long?
> 
> It is a couple of kB written one 32-bit word at a time over i2c, so
> it's not fast.

OK, fair enough. Applied, thank you.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
