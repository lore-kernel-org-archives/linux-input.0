From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: input: touchscreen: goodix: Document
 AVDD28-supply property
Date: Wed, 13 Feb 2019 15:51:16 -0600
Message-ID: <CAL_JsqJSMX7E2zQA2O8ofZQPDrm3S6PMCLG1iAQ95P10Pe2yFg@mail.gmail.com>
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
 <20181215151802.18592-2-jagan@amarulasolutions.com> <20190107225810.ggmkkbrnkoy2ykx5@penguin>
 <CAL_JsqKTnPVM7Qahy9ejQbPfENpLCdzf5K5uUTcPh8j3EiqWRA@mail.gmail.com>
 <CAMty3ZCyq=tZMt6RC1aYJuEWgYp2zv1LBh+ZUwucE+g4RCoUaQ@mail.gmail.com>
 <CAL_JsqKCw3EV+0_DuMiHh7GRGxv7YogQf-xwp71n9gpc2GzSSQ@mail.gmail.com> <CAMty3ZBtoocXBW5A0astyQPh2y7vG7NtbZ_M0BjSeex2etmGsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMty3ZBtoocXBW5A0astyQPh2y7vG7NtbZ_M0BjSeex2etmGsw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: devicetree <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michael Trimarchi <michael@amarulasolutions.com>, linux-amarula@amarulasolutions.com
List-Id: linux-input@vger.kernel.org

On Tue, Jan 22, 2019 at 7:39 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> On Mon, Jan 21, 2019 at 9:46 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Jan 18, 2019 at 10:01 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
> > >
> > > On Wed, Jan 9, 2019 at 7:08 PM Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > Please CC DT list if you want bindings reviewed.
> > >
> > > Sorry I forgot.
> > >
> > > >
> > > > On Wed, Jan 9, 2019 at 1:40 AM Dmitry Torokhov
> > > > <dmitry.torokhov@gmail.com> wrote:
> > > > >
> > > > > On Sat, Dec 15, 2018 at 08:47:59PM +0530, Jagan Teki wrote:
> > > > > > Most of the Goodix CTP controllers are supply with AVDD28 pin.
> > > > > > which need to supply for controllers like GT5663 on some boards
> > > > > > to trigger the power.
> > > > > >
> > > > > > So, document the supply property so-that the require boards
> > > > > > that used on GT5663 can enable it via device tree.
> > > > > >
> > > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > > ---
> > > > > >  Documentation/devicetree/bindings/input/touchscreen/goodix.txt | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > index f7e95c52f3c7..c4622c983e08 100644
> > > > > > --- a/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > +++ b/Documentation/devicetree/bindings/input/touchscreen/goodix.txt
> > > > > > @@ -23,6 +23,7 @@ Optional properties:
> > > > > >   - touchscreen-inverted-y  : Y axis is inverted (boolean)
> > > > > >   - touchscreen-swapped-x-y : X and Y axis are swapped (boolean)
> > > > > >                               (swapping is done after inverting the axis)
> > > > > > + - AVDD28-supply     : Analog power supply regulator on AVDD28 pin
> > > > >
> > > > > I think we normally use lower case in DT bindings and rarely encode
> > > > > voltage in the supply name unless we are dealing with several supplies
> > > > > of the same kind, but I'll let Ron comment on this.
> > > >
> > > > Yes on lowercase though there are some exceptions.
> > > >
> > > > There's also a AVDD22 supply as well as DVDD12 and VDDIO. So we
> > > > probably need to keep the voltage, but the binding is incomplete.
> > >
> > > What is incomplete here? can you please elaborate.
> >
> > You are missing the 3 other supplies the chip has: AVDD22, DVDD12 and VDDIO.
>
> Though it has other supplies, only AVDD28 is connected in the Host
> interface design similar like 9. Reference Schematic on Page, 23 in
> attached manual.

That is for a particular board design. It still has other supplies.
Just make the binding complete please. You can make them optional. I
don't care if the driver supports controlling all the supplies or not
(though Dmitry might).
