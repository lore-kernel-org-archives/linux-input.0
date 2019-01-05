From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: rotary_encoder - Support key events
Date: Sat, 5 Jan 2019 17:12:40 -0600
Message-ID: <CAKdAkRQKnH++VuL37EGBaFSMmFPvbpCkVkZLwuMU9eWo+KsaXA@mail.gmail.com>
References: <20190105202659.20198-1-nazgul33@gmail.com> <20190105202659.20198-2-nazgul33@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190105202659.20198-2-nazgul33@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Donghoon Han <nazgul33@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Daniel Mack <daniel@caiaq.de>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sat, Jan 5, 2019 at 2:27 PM Donghoon Han <nazgul33@gmail.com> wrote:
>
> From: Steven Han <nazgul33@gmail.com>
>
> Support generating EV_KEY pair, instead of EV_REL.
>
> Signed-off-by: Donghoon Han <nazgul33@gmail.com>
> ---
>  drivers/input/misc/rotary_encoder.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
> index 72eee6d55527..180e35884289 100644
> --- a/drivers/input/misc/rotary_encoder.c
> +++ b/drivers/input/misc/rotary_encoder.c
> @@ -41,6 +41,8 @@ struct rotary_encoder {
>         u32 steps;
>         u32 axis;
>         bool relative_axis;
> +       bool relative_keys;
> +       u32 keycodes[2];
>         bool rollover;
>         enum rotary_encoder_encoding encoding;
>
> @@ -79,6 +81,10 @@ static void rotary_encoder_report_event(struct rotary_encoder *encoder)
>         if (encoder->relative_axis) {
>                 input_report_rel(encoder->input,
>                                  encoder->axis, encoder->dir);
> +       } else if (encoder->relative_keys) {
> +               u32 keycode = encoder->keycodes[encoder->dir > 0];
> +               input_event(encoder->input, EV_KEY, keycode, 1);

You need input_sync() here.

> +               input_event(encoder->input, EV_KEY, keycode, 0);
>         } else {
>                 unsigned int pos = encoder->pos;
>
> @@ -237,6 +243,16 @@ static int rotary_encoder_probe(struct platform_device *pdev)
>         device_property_read_u32(dev, "linux,axis", &encoder->axis);
>         encoder->relative_axis =
>                 device_property_read_bool(dev, "rotary-encoder,relative-axis");
> +       encoder->relative_keys =
> +               device_property_read_bool(dev, "rotary-encoder,relative-keys");
> +       if (encoder->relative_keys) {
> +               err = device_property_read_u32_array(dev,
> +                                       "rotary-encoder,relative-keycodes",
> +                                       encoder->keycodes, 2);
> +               if (err)
> +                       dev_err(dev, "unable to get keycodes: %d\n", err);
> +               return err;
> +       }
>
>         encoder->gpios = devm_gpiod_get_array(dev, NULL, GPIOD_IN);
>         if (IS_ERR(encoder->gpios)) {
> @@ -260,9 +276,12 @@ static int rotary_encoder_probe(struct platform_device *pdev)
>         input->id.bustype = BUS_HOST;
>         input->dev.parent = dev;
>
> -       if (encoder->relative_axis)
> +       if (encoder->relative_axis) {
>                 input_set_capability(input, EV_REL, encoder->axis);
> -       else
> +       } else if (encoder->relative_keys) {
> +               input_set_capability(input, EV_KEY, encoder->keycodes[0]);
> +               input_set_capability(input, EV_KEY, encoder->keycodes[1]);
> +       } else
>                 input_set_abs_params(input,
>                                      encoder->axis, 0, encoder->steps, 0, 1);
>
> --
> 2.17.1
>

Thanks.

-- 
Dmitry
