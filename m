From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: input: touchscreen: goodix: Document
 AVDD28-supply property
Date: Wed, 9 Jan 2019 07:37:53 -0600
Message-ID: <CAL_JsqKTnPVM7Qahy9ejQbPfENpLCdzf5K5uUTcPh8j3EiqWRA@mail.gmail.com>
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-2-jagan@amarulasolutions.com> <20190107225810.ggmkkbrnkoy2ykx5@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107225810.ggmkkbrnkoy2ykx5@penguin>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Trimarchi <michael@amarulasolutions.com>, linux-amarula@amarulasolutions.com
List-Id: linux-input@vger.kernel.org

Please CC DT list if you want bindings reviewed.

On Wed, Jan 9, 2019 at 1:40 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Sat, Dec 15, 2018 at 08:47:59PM +0530, Jagan Teki wrote:
> > Most of the Goodix CTP controllers are supply with AVDD28 pin.
> > which need to supply for controllers like GT5663 on some boards
> > to trigger the power.
> >
> > So, document the supply property so-that the require boards
> > that used on GT5663 can enable it via device tree.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> >  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > index f7e95c52f3c7..c4622c983e08 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > @@ -23,6 +23,7 @@ Optional properties:
> >   - touchscreen-inverted-y  : Y axis is inverted (boolean)
> >   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
> >                               (swapping is done after inverting the axis)
> > + - AVDD28-supply     : Analog power supply regulator on AVDD28 pin
>
> I think we normally use lower case in DT bindings and rarely encode
> voltage in the supply name unless we are dealing with several supplies
> of the same kind, but I'll let Ron comment on this.

Yes on lowercase though there are some exceptions.

There's also a AVDD22 supply as well as DVDD12 and VDDIO. So we
probably need to keep the voltage, but the binding is incomplete.

Rob
