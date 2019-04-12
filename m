From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 2/3] Input: add a driver for GPIO controllable vibrators
Date: Fri, 12 Apr 2019 10:43:52 -0700
Message-ID: <155509103299.20095.15957232326393337000@swboyd.mtv.corp.google.com>
References: <20190412150625.28384-1-luca@z3ntu.xyz> <20190412150625.28384-2-luca@z3ntu.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190412150625.28384-2-luca@z3ntu.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Weiss <luca@z3ntu.xyz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Pascal PAILLET-LME <p.paillet@st.com>, Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>, Xiaotong Lu <xiaotong.lu@spreadtrum.com>, Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, David Brown <david.brown@linaro.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, "open list:INPUT KEYBOARD, MOUSE, JOYSTICK , TOUCHSCREEN..." <linux-input@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>Luca Weiss <l>
List-Id: linux-input@vger.kernel.org

Quoting Luca Weiss (2019-04-12 08:06:24)
> diff --git a/drivers/input/misc/gpio-vibra.c b/drivers/input/misc/gpio-vi=
bra.c
> new file mode 100644
> index 000000000000..3fd2dfd4f670
> --- /dev/null
> +++ b/drivers/input/misc/gpio-vibra.c
> @@ -0,0 +1,209 @@
> +
> +static int gpio_vibrator_probe(struct platform_device *pdev)
> +{
[...]
> +       vibrator->input->id.bustype =3D BUS_HOST;
> +       vibrator->input->close =3D gpio_vibrator_close;
> +
> +       input_set_drvdata(vibrator->input, vibrator);
> +       input_set_capability(vibrator->input, EV_FF, FF_RUMBLE);
> +
> +       err =3D input_ff_create_memless(vibrator->input, NULL,
> +                                     gpio_vibrator_play_effect);
> +       if (err) {
> +               dev_err(&pdev->dev, "Couldn't create FF dev: %d", err);
> +               return err;
> +       }
> +
> +       err =3D input_register_device(vibrator->input);
> +       if (err) {
> +               dev_err(&pdev->dev, "Couldn't register input dev: %d", er=
r);

All the printks in this file need a newline.

> +               return err;
> +       }
> +
> +       platform_set_drvdata(pdev, vibrator);
> +
> +       return 0;
> +}
> +
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id gpio_vibra_dt_match_table[] =3D {
> +       { .compatible =3D "gpio-vibrator" },
> +       {},

Nitpick: Drop the comma on the sentinel so nothing can go after it
without causing a compilation error.

> +};
> +MODULE_DEVICE_TABLE(of, gpio_vibra_dt_match_table);
> +#endif
> +
