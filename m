From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: edt-ft5x06 - Add support for regulator
Date: Tue, 23 Jan 2018 09:58:29 -0800
Message-ID: <20180123175829.2axe3pdntrueqlnw@dtor-ws>
References: <20171228163336.28131-1-mylene.josserand@free-electrons.com>
 <20171228163336.28131-2-mylene.josserand@free-electrons.com>
 <CAKdAkRQme1Y+t4qxLGOFojEji1L6z3L0XS4+W0FdQ36-2hxW=A@mail.gmail.com>
 <20180123101055.28c4786a@dell-desktop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180123101055.28c4786a@dell-desktop.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Mylene Josserand <mylene.josserand@free-electrons.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, devicetree@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Quentin Schulz <quentin.schulz@free-electrons.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 23, 2018 at 10:10:55AM +0100, Mylene Josserand wrote:
> Hello Dimitry,
> 
> Thank you for the review!
> 
> Le Mon, 22 Jan 2018 09:42:08 -0800,
> Dmitry Torokhov <dmitry.torokhov@gmail.com> a écrit :
> 
> > Hi Mylène,
> > 
> > On Thu, Dec 28, 2017 at 8:33 AM, Mylène Josserand
> > <mylene.josserand@free-electrons.com> wrote:
> > > Add the support of regulator to use it as VCC source.
> > >
> > > Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
> > > ---
> > >  .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +
> > >  drivers/input/touchscreen/edt-ft5x06.c             | 33 ++++++++++++++++++++++
> > >  2 files changed, 34 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > > index 025cf8c9324a..48e975b9c1aa 100644
> > > --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > > @@ -30,6 +30,7 @@ Required properties:
> > >  Optional properties:
> > >   - reset-gpios: GPIO specification for the RESET input
> > >   - wake-gpios:  GPIO specification for the WAKE input
> > > + - vcc-supply:  Regulator that supplies the touchscreen
> > >
> > >   - pinctrl-names: should be "default"
> > >   - pinctrl-0:   a phandle pointing to the pin settings for the
> > > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> > > index c53a3d7239e7..5ee14a25a382 100644
> > > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > > @@ -39,6 +39,7 @@
> > >  #include <linux/input/mt.h>
> > >  #include <linux/input/touchscreen.h>
> > >  #include <linux/of_device.h>
> > > +#include <linux/regulator/consumer.h>
> > >
> > >  #define WORK_REGISTER_THRESHOLD                0x00
> > >  #define WORK_REGISTER_REPORT_RATE      0x08
> > > @@ -91,6 +92,7 @@ struct edt_ft5x06_ts_data {
> > >         struct touchscreen_properties prop;
> > >         u16 num_x;
> > >         u16 num_y;
> > > +       struct regulator *vcc;
> > >
> > >         struct gpio_desc *reset_gpio;
> > >         struct gpio_desc *wake_gpio;
> > > @@ -993,6 +995,23 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
> > >
> > >         tsdata->max_support_points = chip_data->max_support_points;
> > >
> > > +       tsdata->vcc = devm_regulator_get(&client->dev, "vcc");
> > > +       if (IS_ERR(tsdata->vcc)) {
> > > +               error = PTR_ERR(tsdata->vcc);
> > > +               dev_err(&client->dev, "failed to request regulator: %d\n",
> > > +                       error);
> > > +               return error;
> > > +       };  
> > 
> > As 0-day pounted out, this semicolon is not needed.
> 
> Yes, thanks, I will fix that in next version.
> 
> > 
> > > +
> > > +       if (tsdata->vcc) {  
> > 
> > You do not need to check for non-NULL here, devm_regulator_get() wil
> > lnever give you a NULL. If regulator is not defined in DT/board
> > mappings, then dummy regulator will be provided. You can call
> > regulator_enable() and regulator_disable() and other regulator APIs
> > with dummy regulator.
> 
> Okay, thanks for the explanation, I will remove that.
> 
> > 
> > > +               error = regulator_enable(tsdata->vcc);
> > > +               if (error < 0) {
> > > +                       dev_err(&client->dev, "failed to enable vcc: %d\n",
> > > +                               error);
> > > +                       return error;
> > > +               }
> > > +       }
> > > +
> > >         tsdata->reset_gpio = devm_gpiod_get_optional(&client->dev,
> > >                                                      "reset", GPIOD_OUT_HIGH);
> > >         if (IS_ERR(tsdata->reset_gpio)) {
> > > @@ -1122,20 +1141,34 @@ static int edt_ft5x06_ts_remove(struct i2c_client *client)
> > >  static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
> > >  {
> > >         struct i2c_client *client = to_i2c_client(dev);
> > > +       struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
> > >
> > >         if (device_may_wakeup(dev))
> > >                 enable_irq_wake(client->irq);
> > >
> > > +       if (tsdata->vcc)  
> > 
> > Same here.
> 
> yep
> 
> > 
> > > +               regulator_disable(tsdata->vcc);
> > > +
> > >         return 0;
> > >  }
> > >
> > >  static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
> > >  {
> > >         struct i2c_client *client = to_i2c_client(dev);
> > > +       struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
> > > +       int ret;
> > >
> > >         if (device_may_wakeup(dev))
> > >                 disable_irq_wake(client->irq);
> > >
> > > +       if (tsdata->vcc) {  
> > 
> > And here.
> 
> yep
> 
> > 
> > > +               ret = regulator_enable(tsdata->vcc);
> > > +               if (ret < 0) {
> > > +                       dev_err(dev, "failed to enable vcc: %d\n", ret);
> > > +                       return ret;
> > > +               }  
> > 
> > Since power to the device may have been cut, I think you need to
> > restore the register settings to whatever it was (factory vs work
> > mode, threshold, gain and offset registers, etc, etc).
> 
> Okay. Could you tell me how can I do that?

If you take a look at edt_ft5x06_work_mode() at the end ther eis code to
restore parameters. You want to factor it out and apply to the device
when resuming. You probably also want to see what mode (factory/normal)
the device was before suspend and restore the previous mode on resume.

> 
> > 
> > > +       }
> > > +
> > >         return 0;
> > >  }
> > >
> > > --
> > > 2.11.0
> > >  
> > 
> > Thanks.
> > 
> 
> About your V2's review, you suggested to add support for wake/reset in
> suspend/resume (that I forgot in this version). I wanted to add it but
> with my board, I can't test suspend/resume. What should I do about
> that?

See if Simon Budig <simon.budig@kernelconcepts.de> can help us here.

> 
> If I send a V3 in next few days, do you think you will have time to
> merge it for v4.16?

It all depends on the patch shape...

Thanks.

-- 
Dmitry
