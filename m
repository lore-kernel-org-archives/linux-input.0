From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4/5] Input: edt-ft5x06 - Add support for regulator
Date: Fri, 8 Dec 2017 17:24:46 -0800
Message-ID: <20171209012446.4oha36s6pf2fjlvn@dtor-ws>
References: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
 <20171208215419.30396-5-mylene.josserand@free-electrons.com>
 <20171209011629.4nkcjxj2l2j7zyph@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f196.google.com ([209.85.223.196]:39634 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752240AbdLIBYu (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 8 Dec 2017 20:24:50 -0500
Content-Disposition: inline
In-Reply-To: <20171209011629.4nkcjxj2l2j7zyph@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org, linux-input@vger.kernel.org, simon.budig@kernelconcepts.de, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, thomas.petazzoni@free-electrons.com

On Fri, Dec 08, 2017 at 05:16:29PM -0800, Dmitry Torokhov wrote:
> Hi Mylène,
> 
> On Fri, Dec 08, 2017 at 10:54:18PM +0100, Mylène Josserand wrote:
> > Add the support of regulator to use them as VCC source.
> > 
> > Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
> > ---
> >  drivers/input/touchscreen/edt-ft5x06.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> > 
> > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> > index c53a3d7239e7..44b0e04a8f35 100644
> > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/input/mt.h>
> >  #include <linux/input/touchscreen.h>
> >  #include <linux/of_device.h>
> > +#include <linux/regulator/consumer.h>
> >  
> >  #define WORK_REGISTER_THRESHOLD		0x00
> >  #define WORK_REGISTER_REPORT_RATE	0x08
> > @@ -91,6 +92,7 @@ struct edt_ft5x06_ts_data {
> >  	struct touchscreen_properties prop;
> >  	u16 num_x;
> >  	u16 num_y;
> > +	struct regulator *supply;
> >  
> >  	struct gpio_desc *reset_gpio;
> >  	struct gpio_desc *wake_gpio;
> > @@ -993,6 +995,23 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
> >  
> >  	tsdata->max_support_points = chip_data->max_support_points;
> >  
> > +	tsdata->supply = devm_regulator_get_optional(&client->dev, "power");
> 
> I'd prefer if we used devm_regulator_get() instead. On a
> fully-constrained systems a missing regulator will be substituted with a
> dummy one that you can then use in regulator_enable() and
> regulator_disable(). The _optional regulator API is reserved for cases
> where some of chip functionality is optional and you can engage it by
> powering up parts of the chip. The reset is not such case: it is always
> present, but may not be exposed to the OS to control.
> 
> I think the preference is to call the supply by the name is a datasheet,
> something like "vcc" or "vdd", etc.

Looking at this some more, you need to make sure your new regulator
support plays well with reset/wake GPIOs. I.e. you probably want to
properly bring the chip out of reset in edt_ft5x06_ts_resume() and maybe
driver the reset line low in suspend to make sure you do not leak into
the unpowered chip?

Also, please update
Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt with
the additional binding data and cc device tree folks and Rob Herring.

Thanks.

-- 
Dmitry
