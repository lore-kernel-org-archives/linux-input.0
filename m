From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 10/13] gpio: max77650: add GPIO support
Date: Mon, 21 Jan 2019 18:07:24 +0100
Message-ID: <CAMRc=Me6OSKDk7bN4++M68DjoeArd+gZx16o0oQBXfRoCWBt2A@mail.gmail.com>
References: <20190118134244.22253-1-brgl@bgdev.pl> <20190118134244.22253-11-brgl@bgdev.pl>
 <CACRpkdZhy7yBZrGLxhRGaac7v5jZhgUSz9gZAhFXbevJbKjpZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdZhy7yBZrGLxhRGaac7v5jZhgUSz9gZAhFXbevJbKjpZw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Brian Masney <masneyb@onstation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

pon., 21 sty 2019 o 15:20 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> Hi Bartosz,
>
> thanks for the patch!
>
> On Fri, Jan 18, 2019 at 2:43 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
>
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add GPIO support for max77650 mfd device. This PMIC exposes a single
> > GPIO line.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Overall you know for sure what you're doing so not much to
> say about the GPIO chip etc. The .set_config() is nice and
> helpful (maybe you will be able to also add pull up/down
> using Thomas Petazzoni's new config interfaces!)
>
> However enlighten me on this:
>
> > +static int max77650_gpio_to_irq(struct gpio_chip *gc, unsigned int off=
set)
> > +{
> > +       struct max77650_gpio_chip *chip =3D gpiochip_get_data(gc);
> > +
> > +       return regmap_irq_get_virq(chip->irq_chip_data, MAX77650_INT_GP=
I);
> > +}
>
> I know this may be opening the gates to a lot of coding, but
> isn't this IRQ hierarchical? I.e. that irqchip is not in the
> node of the GPIO chip but in the node of the MFD top
> device, with a 1:1 mapping between some of the IRQs
> and a certain GPIO line.
>
> Using regmap IRQ makes it confusing for me so I do not
> know for sure if that is the case.
>
> I am worried that you are recreating a problem (present in many
> drivers, including some written by me, mea culpa) that Brian Masney
> has been trying to solve for the gpiochip inside the SPMI
> GPIO (drivers/pinctrl/qcom/pinctrl-spmi-gpio.c).
>
> I have queued Brians refactoring and solution here:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log=
/?h=3Dib-qcom-spmi
>
> And the overall description on what he's trying to achieve is
> here:
> https://marc.info/?l=3Dlinux-gpio&m=3D154793071511130&w=3D2
>
> My problem description (which I fear will apply also to this
> driver):
> https://www.spinics.net/lists/linux-gpio/msg34655.html
>
> I plan to merge Brians patches soon-ish to devel and then from
> there try to construct more helpers in the gpiolib core,
> and if possible fix some of the old drivers who rely on
> .to_irq().
>
> We will certainly fix ssbi-gpio as well, and that is a good start
> since the Qualdcomm platforms are so pervasive in the
> market.
>
> But maybe this doesn't apply here? I am not the smartest...
> Just want to make sure that it is possible to refer an
> interrupt directly to this DT node, as it is indeed marked
> as interrupt-controller.
>

Hi Linus,

Thank you for your review. While I think you're right about the issue
being present in this driver, I'm not sure it's really a problem. Do
we actually require every gpio-controller to also be a stand-alone
interrupt-controller? The binding document for the GPIO module doesn't
mention this - it only requires the gpio-controller property. Without
the "interrupt-controller" property dtc will bail-out if anyone uses
this node as the interrupt parent.

If I'm wrong and we do require it, then I think we need to update
Documentation/devicetree/bindings/gpio/gpio.txt.

Best regards,
Bartosz Golaszewski

PS: FYI since this submission I dropped the virtual irq number lookup
in sub-drivers in favor of resources setup by the parent driver[1] as
suggested by Dmitry in his review of the input module driver.

[1] https://github.com/brgl/linux/blob/topic/max77650_mfd_driver/drivers/gp=
io/gpio-max77650.c#L158
