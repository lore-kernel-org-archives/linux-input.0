From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: rotary encoder: implement quarter period mode
Date: Sun, 18 May 2014 20:45:23 -0700
Message-ID: <20140519034523.GA28435@core.coreip.homeip.net>
References: <1387377798-22344-1-git-send-email-s.hauer@pengutronix.de>
 <20140507144543.GE27177@e106331-lin.cambridge.arm.com>
 <20140507185932.GA22973@core.coreip.homeip.net>
 <20140508170133.GA1199@arch.cereza>
 <20140519032659.GA1062@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:45058 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbaESDp0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 May 2014 23:45:26 -0400
Content-Disposition: inline
In-Reply-To: <20140519032659.GA1062@arch.cereza>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ezequiel =?iso-8859-1?Q?Garc=EDa?= <ezequiel@vanguardiasur.com.ar>
Cc: Mark Rutland <mark.rutland@arm.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Daniel Mack <daniel@zonque.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Mon, May 19, 2014 at 12:26:59AM -0300, Ezequiel Garc=EDa wrote:
> On 08 May 02:01 PM, Ezequiel Garc=EDa wrote:
> > On 07 May 11:59 AM, Dmitry Torokhov wrote:
> > > On Wed, May 07, 2014 at 03:45:43PM +0100, Mark Rutland wrote:
> > > > On Wed, Dec 18, 2013 at 02:43:18PM +0000, Sascha Hauer wrote:
> > > > > Some rotary encoders have a stable state in all output state
> > > > > combinations. Add support for this type of encoder.
> > > > >=20
> > > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > > Cc: Daniel Mack <daniel@zonque.org>
> > > > > Cc: linux-input@vger.kernel.org
> > > > > Cc: devicetree@vger.kernel.org
> > > > > ---
> > > > >  .../devicetree/bindings/input/rotary-encoder.txt   |  1 +
> > > > >  Documentation/input/rotary-encoder.txt             |  9 ++++=
+--
> > > > >  drivers/input/misc/rotary_encoder.c                | 30 ++++=
++++++++++++++++--
> > > > >  include/linux/rotary_encoder.h                     |  1 +
> > > > >  4 files changed, 37 insertions(+), 4 deletions(-)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/input/rotary-e=
ncoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> > > > > index 3315495..cbdb29b 100644
> > > > > --- a/Documentation/devicetree/bindings/input/rotary-encoder.=
txt
> > > > > +++ b/Documentation/devicetree/bindings/input/rotary-encoder.=
txt
> > > > > @@ -15,6 +15,7 @@ Optional properties:
> > > > >  - rotary-encoder,rollover: Automatic rollove when the rotary=
 value becomes
> > > > >    greater than the specified steps or smaller than 0. For ab=
solute axis only.
> > > > >  - rotary-encoder,half-period: Makes the driver work on half-=
period mode.
> > > > > +- rotary-encoder,quarter-period: Makes the driver work on qu=
arter-period mode.
> > > >=20
> > > > The new property looks as sane to me as the half-period propert=
y, so for
> > > > the binding addition:
> > >=20
> > > Actually, maybe we should deprecate rotary-encoder,half-period an=
d
> > > instead add rotary-encoder,type property?
> > >=20
> >=20
> > Mark: what do you say?
> >=20
> > I can fix a few patches if everyone agrees...
>=20
> After some thought, it seemed to me we can define a more specific pro=
perty
> to describe this, instead of a generic "type".
>=20
> The difference among these three "modes" is the number of turns neede=
d to make
> a step.
>=20
> In the current driver, the default is 4 turns per step, where for the=
 half-period
> mode it's 2 turns per step. Now, we need to support 1 turn per step a=
nd hence
> Sascha proposes a new quarter-period mode.
>=20
> Given we only need to describe the number of turns per step, I'd say =
it's
> more accurate and less confusing to deprecate the bool half-period pr=
operty
> and instead introduce a "rotary-encoder,turns-per-step" integer prope=
rty.
>=20
> How does this sound?

We'd have to "filter out" invalid step settings, but that sounds fine b=
y
me.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
