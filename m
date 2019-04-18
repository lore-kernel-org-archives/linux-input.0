From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: input: add GPIO controllable vibrator
Date: Wed, 17 Apr 2019 20:35:27 -0500
Message-ID: <CAL_JsqL7awWWLK3G6u2yzse2aU7KUSuUELuacCnCpfErWA_UaQ@mail.gmail.com>
References: <20190412150625.28384-1-luca@z3ntu.xyz> <15255825.75VNnaJK3T@g550jk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <15255825.75VNnaJK3T@g550jk>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Weiss <luca@z3ntu.xyz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Pascal PAILLET-LME <p.paillet@st.com>, Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>, Xiaotong Lu <xiaotong.lu@spreadtrum.com>, Brian Masney <masneyb@onstation.org>, Rob Herring <robh@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, David Brown <david.brown@linaro.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Apr 17, 2019 at 11:02 AM Luca Weiss <luca@z3ntu.xyz> wrote:
>
> On Freitag, 12. April 2019 17:06:23 CEST Luca Weiss wrote:
> > Provide a simple driver for GPIO controllable vibrators.
> > It will be used by the Fairphone 2.
> >
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> >  .../bindings/input/gpio-vibrator.txt          | 20 +++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/input/gpio-vibrator.txt
> >
> > diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.txt
> > b/Documentation/devicetree/bindings/input/gpio-vibrator.txt new file mode
> > 100644
> > index 000000000000..93e5a8e7622d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/gpio-vibrator.txt
> > @@ -0,0 +1,20 @@
> > +* GPIO vibrator device tree bindings
> > +
> > +Registers a GPIO device as vibrator, where the vibration motor just has the
> > +capability to turn on or off. If the device is connected to a pwm, you
> > should +use the pwm-vibrator driver instead.
> > +
> > +Required properties:
> > +- compatible: should contain "gpio-vibrator"
> > +- enable-gpios: Should contain a GPIO handle
> > +
> > +Optional properties:
> > +- vcc-supply: Phandle for the regulator supplying power
> > +
> > +Example from Fairphone 2:
> > +
> > +vibrator {
> > +     compatible = "gpio-vibrator";
> > +     enable-gpios = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
> > +     vcc-supply = <&pm8941_l18>;
> > +};
>
> I see that the yaml based device tree binding docs seem to be the new hotness?
> Is there any "policy" / preference about new drivers?

Not required yet, but welcomed. It's still a trickle so we can work
out any issues and in some cases the common bindings still need to be
done. I'm starting to ask subsystem maintainers to require DT schemas
though.

This one looks straightforward to use the schema.

Rob
