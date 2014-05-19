From: Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>
Subject: Re: [PATCH] input: rotary encoder: implement quarter period mode
Date: Mon, 19 May 2014 00:26:59 -0300
Message-ID: <20140519032659.GA1062@arch.cereza>
References: <1387377798-22344-1-git-send-email-s.hauer@pengutronix.de>
 <20140507144543.GE27177@e106331-lin.cambridge.arm.com>
 <20140507185932.GA22973@core.coreip.homeip.net>
 <20140508170133.GA1199@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:51633 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbaESD1f (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 May 2014 23:27:35 -0400
Received: by mail-yh0-f47.google.com with SMTP id z6so6311287yhz.6
        for <linux-input@vger.kernel.org>; Sun, 18 May 2014 20:27:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140508170133.GA1199@arch.cereza>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Daniel Mack <daniel@zonque.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 08 May 02:01 PM, Ezequiel Garc=EDa wrote:
> On 07 May 11:59 AM, Dmitry Torokhov wrote:
> > On Wed, May 07, 2014 at 03:45:43PM +0100, Mark Rutland wrote:
> > > On Wed, Dec 18, 2013 at 02:43:18PM +0000, Sascha Hauer wrote:
> > > > Some rotary encoders have a stable state in all output state
> > > > combinations. Add support for this type of encoder.
> > > >=20
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > Cc: Daniel Mack <daniel@zonque.org>
> > > > Cc: linux-input@vger.kernel.org
> > > > Cc: devicetree@vger.kernel.org
> > > > ---
> > > >  .../devicetree/bindings/input/rotary-encoder.txt   |  1 +
> > > >  Documentation/input/rotary-encoder.txt             |  9 +++++-=
-
> > > >  drivers/input/misc/rotary_encoder.c                | 30 ++++++=
++++++++++++++--
> > > >  include/linux/rotary_encoder.h                     |  1 +
> > > >  4 files changed, 37 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/input/rotary-enc=
oder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > > > index 3315495..cbdb29b 100644
> > > > --- a/Documentation/devicetree/bindings/input/rotary-encoder.tx=
t
> > > > +++ b/Documentation/devicetree/bindings/input/rotary-encoder.tx=
t
> > > > @@ -15,6 +15,7 @@ Optional properties:
> > > >  - rotary-encoder,rollover: Automatic rollove when the rotary v=
alue becomes
> > > >    greater than the specified steps or smaller than 0. For abso=
lute axis only.
> > > >  - rotary-encoder,half-period: Makes the driver work on half-pe=
riod mode.
> > > > +- rotary-encoder,quarter-period: Makes the driver work on quar=
ter-period mode.
> > >=20
> > > The new property looks as sane to me as the half-period property,=
 so for
> > > the binding addition:
> >=20
> > Actually, maybe we should deprecate rotary-encoder,half-period and
> > instead add rotary-encoder,type property?
> >=20
>=20
> Mark: what do you say?
>=20
> I can fix a few patches if everyone agrees...

After some thought, it seemed to me we can define a more specific prope=
rty
to describe this, instead of a generic "type".

The difference among these three "modes" is the number of turns needed =
to make
a step.

In the current driver, the default is 4 turns per step, where for the h=
alf-period
mode it's 2 turns per step. Now, we need to support 1 turn per step and=
 hence
Sascha proposes a new quarter-period mode.

Given we only need to describe the number of turns per step, I'd say it=
's
more accurate and less confusing to deprecate the bool half-period prop=
erty
and instead introduce a "rotary-encoder,turns-per-step" integer propert=
y.

How does this sound?
--=20
Ezequiel Garcia, VanguardiaSur
www.vanguardiasur.com.ar
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
