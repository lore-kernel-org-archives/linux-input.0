From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Input: edt-ft5x06 - Add support for regulator
Date: Tue, 23 Jan 2018 09:04:14 +0100
Message-ID: <20180123090414.47bcf118@karo-electronics.de>
References: <20171228163336.28131-1-mylene.josserand@free-electrons.com>
        <20171228163336.28131-2-mylene.josserand@free-electrons.com>
        <CAKdAkRQme1Y+t4qxLGOFojEji1L6z3L0XS4+W0FdQ36-2hxW=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKdAkRQme1Y+t4qxLGOFojEji1L6z3L0XS4+W0FdQ36-2hxW=A@mail.gmail.com>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi,

On Mon, 22 Jan 2018 09:42:08 -0800 Dmitry Torokhov wrote:
> Hi Mylène,
> 
> On Thu, Dec 28, 2017 at 8:33 AM, Mylène Josserand
> <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > Add the support of regulator to use it as VCC source.
> >
> > Signed-off-by: Mylène Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > ---
> >  .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +
> >  drivers/input/touchscreen/edt-ft5x06.c             | 33 ++++++++++++++++++++++
> >  2 files changed, 34 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > index 025cf8c9324a..48e975b9c1aa 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> > @@ -30,6 +30,7 @@ Required properties:
> >  Optional properties:
> >   - reset-gpios: GPIO specification for the RESET input
> >   - wake-gpios:  GPIO specification for the WAKE input
> > + - vcc-supply:  Regulator that supplies the touchscreen
> >
> >   - pinctrl-names: should be "default"
> >   - pinctrl-0:   a phandle pointing to the pin settings for the
> > diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> > index c53a3d7239e7..5ee14a25a382 100644
> > --- a/drivers/input/touchscreen/edt-ft5x06.c
> > +++ b/drivers/input/touchscreen/edt-ft5x06.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/input/mt.h>
> >  #include <linux/input/touchscreen.h>
> >  #include <linux/of_device.h>
> > +#include <linux/regulator/consumer.h>
> >
> >  #define WORK_REGISTER_THRESHOLD                0x00
> >  #define WORK_REGISTER_REPORT_RATE      0x08
> > @@ -91,6 +92,7 @@ struct edt_ft5x06_ts_data {
> >         struct touchscreen_properties prop;
> >         u16 num_x;
> >         u16 num_y;
> > +       struct regulator *vcc;
> >
> >         struct gpio_desc *reset_gpio;
> >         struct gpio_desc *wake_gpio;
> > @@ -993,6 +995,23 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
> >
> >         tsdata->max_support_points = chip_data->max_support_points;
> >
> > +       tsdata->vcc = devm_regulator_get(&client->dev, "vcc");
> > +       if (IS_ERR(tsdata->vcc)) {
> > +               error = PTR_ERR(tsdata->vcc);
> > +               dev_err(&client->dev, "failed to request regulator: %d\n",
> > +                       error);
>
I would check for -EPROBE_DEFER here and omit the error message in this
case.


Lothar Waßmann
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
