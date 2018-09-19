From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: egalax-ts: add support for wakeup event action
Date: Tue, 18 Sep 2018 18:01:42 -0700
Message-ID: <CAL_JsqKTm7Rc5a0Y4UMwpsTZm5amRRC8H6y0yWsOd4StmAWqJQ@mail.gmail.com>
References: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
 <1536139607-16848-2-git-send-email-Anson.Huang@nxp.com> <5b9f3f5d.1c69fb81.bca6d.cdee@mx.google.com>
 <20180917180744.GB104770@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917180744.GB104770@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Anson Huang <Anson.Huang@nxp.com>, Mark Rutland <mark.rutland@arm.com>, Marco Franchi <marco.franchi@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, NXP Linux Team <Linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 17, 2018 at 11:07 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Sun, Sep 16, 2018 at 05:54:33PM -0500, Rob Herring wrote:
> > On Wed, Sep 05, 2018 at 05:26:47PM +0800, Anson Huang wrote:
> > > Add support for wakeup event action, this would allow the device
> > > to configure whether to be a wakeup source of system suspend.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
> > > index 92fb262..296a9cd 100644
> > > --- a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
> > > +++ b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
> > > @@ -6,6 +6,7 @@ Required properties:
> > >  - interrupts: touch controller interrupt
> > >  - wakeup-gpios: the gpio pin to be used for waking up the controller
> > >    and also used as irq pin
> >
> > If the wakeup gpio is the same as the irq, then this should be removed
> > since wakeup-source replaces it.
>
> No, it does not: it is GPIO that we need to toggle to wake up the
> controller, not host, and we do not have generic API to map from IRQ to
> GPIO.

Ah, okay.

> This is also existing binding...

Right, I meant removed as in moved to deprecated. Sometimes we just
remove the documentation when deprecating.

Rob
