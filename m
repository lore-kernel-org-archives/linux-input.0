From: Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH v3 2/3] Input: add a driver for GPIO controllable vibrators
Date: Tue, 16 Apr 2019 18:02:15 +0200
Message-ID: <1633425.a675zxgQUS@g550jk>
References: <20190412150625.28384-1-luca@z3ntu.xyz> <20190412150625.28384-2-luca@z3ntu.xyz> <155509103299.20095.15957232326393337000@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <155509103299.20095.15957232326393337000@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Pascal PAILLET-LME <p.paillet@st.com>, Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>, Xiaotong Lu <xiaotong.lu@spreadtrum.com>, Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, David Brown <david.brown@linaro.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, "open list:INPUT KEYBOARD, MOUSE, JOYSTICK , TOUCHSCREEN..." <linux-input@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Freitag, 12. April 2019 19:43:52 CEST Stephen Boyd wrote:
> Quoting Luca Weiss (2019-04-12 08:06:24)
> 
> > diff --git a/drivers/input/misc/gpio-vibra.c
> > b/drivers/input/misc/gpio-vibra.c new file mode 100644
> > index 000000000000..3fd2dfd4f670
> > --- /dev/null
> > +++ b/drivers/input/misc/gpio-vibra.c
> > @@ -0,0 +1,209 @@
> > +
> > +static int gpio_vibrator_probe(struct platform_device *pdev)
> > +{
> 
> [...]
> 
> > +       vibrator->input->id.bustype = BUS_HOST;
> > +       vibrator->input->close = gpio_vibrator_close;
> > +
> > +       input_set_drvdata(vibrator->input, vibrator);
> > +       input_set_capability(vibrator->input, EV_FF, FF_RUMBLE);
> > +
> > +       err = input_ff_create_memless(vibrator->input, NULL,
> > +                                     gpio_vibrator_play_effect);
> > +       if (err) {
> > +               dev_err(&pdev->dev, "Couldn't create FF dev: %d", err);
> > +               return err;
> > +       }
> > +
> > +       err = input_register_device(vibrator->input);
> > +       if (err) {
> > +               dev_err(&pdev->dev, "Couldn't register input dev: %d",
> > err);
> All the printks in this file need a newline.
Fixed.
> > +               return err;
> > +       }
> > +
> > +       platform_set_drvdata(pdev, vibrator);
> > +
> > +       return 0;
> > +}
> > +
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id gpio_vibra_dt_match_table[] = {
> > +       { .compatible = "gpio-vibrator" },
> > +       {},
> 
> Nitpick: Drop the comma on the sentinel so nothing can go after it
> without causing a compilation error.
Changed as well.
> > +};
> > +MODULE_DEVICE_TABLE(of, gpio_vibra_dt_match_table);
> > +#endif
> > +

Thanks for the review! Will send a v4 shortly.
Luca
