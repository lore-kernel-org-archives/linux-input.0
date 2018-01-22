From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Input: edt-ft5x06 - Add support for regulator
Date: Mon, 22 Jan 2018 09:42:08 -0800
Message-ID: <CAKdAkRQme1Y+t4qxLGOFojEji1L6z3L0XS4+W0FdQ36-2hxW=A@mail.gmail.com>
References: <20171228163336.28131-1-mylene.josserand@free-electrons.com> <20171228163336.28131-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171228163336.28131-2-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Myl=C3=A8ne,

On Thu, Dec 28, 2017 at 8:33 AM, Myl=C3=A8ne Josserand
<mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Add the support of regulator to use it as VCC source.
>
> Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org=
>
> ---
>  .../bindings/input/touchscreen/edt-ft5x06.txt      |  1 +
>  drivers/input/touchscreen/edt-ft5x06.c             | 33 ++++++++++++++++=
++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x=
06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> index 025cf8c9324a..48e975b9c1aa 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> @@ -30,6 +30,7 @@ Required properties:
>  Optional properties:
>   - reset-gpios: GPIO specification for the RESET input
>   - wake-gpios:  GPIO specification for the WAKE input
> + - vcc-supply:  Regulator that supplies the touchscreen
>
>   - pinctrl-names: should be "default"
>   - pinctrl-0:   a phandle pointing to the pin settings for the
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touch=
screen/edt-ft5x06.c
> index c53a3d7239e7..5ee14a25a382 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -39,6 +39,7 @@
>  #include <linux/input/mt.h>
>  #include <linux/input/touchscreen.h>
>  #include <linux/of_device.h>
> +#include <linux/regulator/consumer.h>
>
>  #define WORK_REGISTER_THRESHOLD                0x00
>  #define WORK_REGISTER_REPORT_RATE      0x08
> @@ -91,6 +92,7 @@ struct edt_ft5x06_ts_data {
>         struct touchscreen_properties prop;
>         u16 num_x;
>         u16 num_y;
> +       struct regulator *vcc;
>
>         struct gpio_desc *reset_gpio;
>         struct gpio_desc *wake_gpio;
> @@ -993,6 +995,23 @@ static int edt_ft5x06_ts_probe(struct i2c_client *cl=
ient,
>
>         tsdata->max_support_points =3D chip_data->max_support_points;
>
> +       tsdata->vcc =3D devm_regulator_get(&client->dev, "vcc");
> +       if (IS_ERR(tsdata->vcc)) {
> +               error =3D PTR_ERR(tsdata->vcc);
> +               dev_err(&client->dev, "failed to request regulator: %d\n"=
,
> +                       error);
> +               return error;
> +       };

As 0-day pounted out, this semicolon is not needed.

> +
> +       if (tsdata->vcc) {

You do not need to check for non-NULL here, devm_regulator_get() wil
lnever give you a NULL. If regulator is not defined in DT/board
mappings, then dummy regulator will be provided. You can call
regulator_enable() and regulator_disable() and other regulator APIs
with dummy regulator.

> +               error =3D regulator_enable(tsdata->vcc);
> +               if (error < 0) {
> +                       dev_err(&client->dev, "failed to enable vcc: %d\n=
",
> +                               error);
> +                       return error;
> +               }
> +       }
> +
>         tsdata->reset_gpio =3D devm_gpiod_get_optional(&client->dev,
>                                                      "reset", GPIOD_OUT_H=
IGH);
>         if (IS_ERR(tsdata->reset_gpio)) {
> @@ -1122,20 +1141,34 @@ static int edt_ft5x06_ts_remove(struct i2c_client=
 *client)
>  static int __maybe_unused edt_ft5x06_ts_suspend(struct device *dev)
>  {
>         struct i2c_client *client =3D to_i2c_client(dev);
> +       struct edt_ft5x06_ts_data *tsdata =3D i2c_get_clientdata(client);
>
>         if (device_may_wakeup(dev))
>                 enable_irq_wake(client->irq);
>
> +       if (tsdata->vcc)

Same here.

> +               regulator_disable(tsdata->vcc);
> +
>         return 0;
>  }
>
>  static int __maybe_unused edt_ft5x06_ts_resume(struct device *dev)
>  {
>         struct i2c_client *client =3D to_i2c_client(dev);
> +       struct edt_ft5x06_ts_data *tsdata =3D i2c_get_clientdata(client);
> +       int ret;
>
>         if (device_may_wakeup(dev))
>                 disable_irq_wake(client->irq);
>
> +       if (tsdata->vcc) {

And here.

> +               ret =3D regulator_enable(tsdata->vcc);
> +               if (ret < 0) {
> +                       dev_err(dev, "failed to enable vcc: %d\n", ret);
> +                       return ret;
> +               }

Since power to the device may have been cut, I think you need to
restore the register settings to whatever it was (factory vs work
mode, threshold, gain and offset registers, etc, etc).

> +       }
> +
>         return 0;
>  }
>
> --
> 2.11.0
>

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
