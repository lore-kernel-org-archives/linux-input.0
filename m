From: Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v3 2/4] Input: goodix - Add AVDD28-supply regulator support
Date: Fri, 1 Feb 2019 01:30:04 +0530
Message-ID: <CAMty3ZB_=VaX+_03B=ATVKzRyBHnTijC3Z8y3+DNAZcPf-=3-Q@mail.gmail.com>
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-3-jagan@amarulasolutions.com> <20190107230009.wfzozb6g6ucymngw@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107230009.wfzozb6g6ucymngw@penguin>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Michael Trimarchi <michael@amarulasolutions.com>, linux-amarula@amarulasolutions.com
List-Id: linux-input@vger.kernel.org

On Wed, Jan 9, 2019 at 1:10 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Hi Jagan,
>
> On Sat, Dec 15, 2018 at 08:48:00PM +0530, Jagan Teki wrote:
> > Goodix CTP controllers have AVDD28 pin connected to voltage
> > regulator which may not be turned on by default, like for GT5663.
> >
> > Add support for such ctp used boards by adding voltage regulator
> > handling code to goodix ctp driver.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  drivers/input/touchscreen/goodix.c | 33 +++++++++++++++++++++++++-----
> >  1 file changed, 28 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> > index f2d9c2c41885..7371f6946098 100644
> > --- a/drivers/input/touchscreen/goodix.c
> > +++ b/drivers/input/touchscreen/goodix.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/irq.h>
> >  #include <linux/interrupt.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> >  #include <linux/acpi.h>
> >  #include <linux/of.h>
> > @@ -47,6 +48,7 @@ struct goodix_ts_data {
> >       struct touchscreen_properties prop;
> >       unsigned int max_touch_num;
> >       unsigned int int_trigger_type;
> > +     struct regulator *avdd28;
> >       struct gpio_desc *gpiod_int;
> >       struct gpio_desc *gpiod_rst;
> >       u16 id;
> > @@ -786,25 +788,41 @@ static int goodix_ts_probe(struct i2c_client *client,
> >       if (error)
> >               return error;
> >
> > +     ts->avdd28 = devm_regulator_get(&client->dev, "AVDD28");
> > +     if (IS_ERR(ts->avdd28)) {
> > +             error = PTR_ERR(ts->avdd28);
> > +             if (error != -EPROBE_DEFER)
> > +                     dev_err(&client->dev,
> > +                             "Failed to get AVDD28 regulator: %d\n", error);
> > +             return error;
> > +     }
> > +
> > +     /* power the controller */
> > +     error = regulator_enable(ts->avdd28);
> > +     if (error) {
> > +             dev_err(&client->dev, "Controller fail to enable AVDD28\n");
> > +             return error;
> > +     }
> > +
> >       if (ts->gpiod_int && ts->gpiod_rst) {
> >               /* reset the controller */
> >               error = goodix_reset(ts);
> >               if (error) {
> >                       dev_err(&client->dev, "Controller reset failed.\n");
> > -                     return error;
> > +                     goto error;
> >               }
> >       }
> >
> >       error = goodix_i2c_test(client);
> >       if (error) {
> >               dev_err(&client->dev, "I2C communication failure: %d\n", error);
> > -             return error;
> > +             goto error;
> >       }
> >
> >       error = goodix_read_version(ts);
> >       if (error) {
> >               dev_err(&client->dev, "Read version failed.\n");
> > -             return error;
> > +             goto error;
> >       }
> >
> >       ts->chip = goodix_get_chip_data(ts->id);
> > @@ -823,23 +841,28 @@ static int goodix_ts_probe(struct i2c_client *client,
> >                       dev_err(&client->dev,
> >                               "Failed to invoke firmware loader: %d\n",
> >                               error);
> > -                     return error;
> > +                     goto error;
> >               }
> >
> >               return 0;
> >       } else {
> >               error = goodix_configure_dev(ts);
> >               if (error)
> > -                     return error;
> > +                     goto error;
> >       }
> >
> >       return 0;
> > +
> > +error:
> > +     regulator_disable(ts->avdd28);
> > +     return error;
> >  }
> >
> >  static int goodix_ts_remove(struct i2c_client *client)
> >  {
> >       struct goodix_ts_data *ts = i2c_get_clientdata(client);
> >
> > +     regulator_disable(ts->avdd28);
>
> This may be disabling the regulator too early. Please use
> devm_add_action_or_reset() to install a custom devm handler that would
> disable the regulator in line with the rest of devm unwinding flow.

Like handler with only regulator_disable? and would that call from
suspend or not need?
