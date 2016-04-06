From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [LINUX PATCH v2] gpio_keys: Added support to read the IRQ_FLAGS
 from devicetree
Date: Wed, 6 Apr 2016 10:45:12 -0700
Message-ID: <20160406174512.GD38452@dtor-ws>
References: <1459763770-2296-1-git-send-email-navam@xilinx.com>
 <CACRpkdZ9pqgScTV_z9TLyBgB39vuj6SGCSpz2pYj89O6XDnFrA@mail.gmail.com>
 <C89496FEAE474D468F30D558A9468D9F26CCF95F@XAP-PVEXMBX01.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34652 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbcDFRpW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Apr 2016 13:45:22 -0400
Content-Disposition: inline
In-Reply-To: <C89496FEAE474D468F30D558A9468D9F26CCF95F@XAP-PVEXMBX01.xlnx.xilinx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?iso-8859-1?Q?Andersson=2C_Bj=F6rn?= <bjorn.andersson@sonymobile.com>, Peng Fan <van.freenix@gmail.com>, Linux Input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Apr 06, 2016 at 11:32:55AM +0000, Nava kishore Manne wrote:
> > -----Original Message-----
> > From: Linus Walleij [mailto:linus.walleij@linaro.org]
> > Sent: Monday, April 04, 2016 4:38 PM
> > To: Nava kishore Manne
> > Cc: Dmitry Torokhov; Andersson, Bj=F6rn; Nava kishore Manne; Peng F=
an;
> > Linux Input; linux-kernel@vger.kernel.org
> > Subject: Re: [LINUX PATCH v2] gpio_keys: Added support to read the
> > IRQ_FLAGS from devicetree
> >=20
> > On Mon, Apr 4, 2016 at 11:56 AM, Nava kishore Manne
> > <nava.manne@xilinx.com> wrote:
> >=20
> > > This patch adds the support to read the IRQ_FLAGS from the device
> > > instead of hard code the flags in gpio_keys_setup_key().
> >=20
> > NACK
> >=20
> > >                 sw14 {
> > >                         label =3D "sw14";
> > >                         gpios =3D <&gpio0 12 1>;
> > >                         /*
> > >                          * Triggering Type:
> > >                          *
> > >                          * 1 - edge rising
> > >                          * 2 - edge falling
> > >                          * 4 - level active high
> > >                          * 8 - level active low
> > >                          *
> > >                          */
> >=20
> > You are completely violating the existing GPIO flags from include/d=
t-
> > bindings/gpio/gpio.h
> >=20
> > As you will see, for a twocell GPIO flags are already clearly defin=
ed for 0,1,2
> > and 3. (Bit 0 & 1).
> >=20
> > Further, these IRQ edge/level flags already exist in include/dt-
> > bindings/interrupt-controller/irq.h
> > but you should not be using those either, because they do not mix w=
ith a
> > GPIO specifier, it's a bit like oil and water.
> >=20
> > The standard GPIO bindings already has
> > GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW
> > which makes it pretty clear that a GPIO line marked as GPIO_ACTIVE_=
HIGH
> > should trigger either on rising edge or level active high and vice =
versa.
> >=20
> > The only information you could *possibly* lack is whether the IRQ s=
hould be
> > edge or level triggered.
> >=20
> > But level triggered GPIO buttons *does* *not* *make*
> > *sense* *at* *all*.
> >=20
> > Think about it:
> >=20
> > The IRQ line goes level high or low because a user pressed a button=
 with
> > his/her thumb. Then that is wired in as a level IRQ. So what are we=
 going to
> > do? Wait in the interrupt handler until the user removes his/her th=
umb?
> >=20
> > Level IRQs on GPIOs only makes sense for devices off-chip where you=
 can
> > talk to the device and ACK the interrupt, and in this case "talk" d=
oes not
> > mean wire up a speaker telling the user to remove the thumb from th=
e
> > button because we have recieved the interrupt, albeit that would be=
 the
> > real-world analogy.
> >=20
> > Please tell us what you are actually trying to solve.
>=20
>=20
> One of Our gpio-controller was supporting only edge rising interrupts=
=2E
> For that reason I implementing the below logic to read the interrupt
> trigger level from the DT. If it is wrong could you please provide th=
e
> pointer to solve this issue?

How will you handle key releases if you can only signal key presses?
gpio-keys driver needs to be notified about both edges.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
