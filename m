From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input/keyboard: new OpenCores Keyboard Controller
	driver
Date: Tue, 15 Sep 2009 09:23:50 -0700
Message-ID: <20090915162349.GA29241@core.coreip.homeip.net>
References: <1252911864-19233-1-git-send-email-vapier@gentoo.org> <1252950003-9451-1-git-send-email-vapier@gentoo.org> <200909141049.50705.dmitry.torokhov@gmail.com> <8bd0f97a0909141102l5fa309f4ua1bedd0f1ac99295@mail.gmail.com> <4AAE8908.1000104@hvsistemas.es> <20090915055224.GD1132@core.coreip.homeip.net> <8bd0f97a0909150416j444999e4sfcb6ad77146a97d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:64774 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754988AbZIOQYC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Sep 2009 12:24:02 -0400
Content-Disposition: inline
In-Reply-To: <8bd0f97a0909150416j444999e4sfcb6ad77146a97d7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Javier Herrero <jherrero@hvsistemas.es>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@kernel.org>

On Tue, Sep 15, 2009 at 07:16:25AM -0400, Mike Frysinger wrote:
> On Tue, Sep 15, 2009 at 01:52, Dmitry Torokhov wrote:
> > On Mon, Sep 14, 2009 at 08:18:48PM +0200, Javier Herrero wrote:
> >> It has a bit long since last time I touched the driver, so I shoul=
d also
> >> try to refresh my memory about it :). I suppose that you're right =
in the
> >> double allocation issue (I took another keyboard driver as a start=
ing
> >> point and probably the double allocation was already there...), so=
 feel
> >> free to introduce the change and I will test it as soon as I can.
> >>
> >> About the exact scancode - key mapping, the reason is that since t=
he
> >> FPGA opencores device already implements a translation table, I fo=
und
> >> that another translation table sounded a bit redundant.
> >
> > OK, below is what I have now... One concern though - don't we need =
to do
> > request_mem_region/ioremap for the addr_res?
>=20
> i think so ... these operations are nops on a Blackfin CPU which is
> probably why it "just works".
>=20

Surely request_mem_region is not a nop? I think even if uoremap is a no=
p
we need to convert the driver since it does not have to be on a
Blackfin, does it?

> > +struct opencores_kbd {
> > + =A0 =A0 =A0 struct input_dev *input;
> > + =A0 =A0 =A0 void __iomem *addr;
> > + =A0 =A0 =A0 int irq;
> > + =A0 =A0 =A0 struct resource *irq_res;
>=20
> the irq_res member is no longer needed
>=20
> +#define NUM_KEYS 128
> > + =A0 =A0 =A0 unsigned short keycodes[NUM_KEYS];
>=20
> since this is the only usage of NUM_KEYS, could just inline it now ..=
=2E
>=20
> > + =A0 =A0 =A0 error =3D request_irq(irq, &opencores_kbd_isr,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_TRIGGER_=
RISING, pdev->name, opencores_kbd);
> > + =A0 =A0 =A0 if (error) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "unable to claim =
irq %d\n", irq);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_mem;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 error =3D input_register_device(input);
> > + =A0 =A0 =A0 if (error) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "unable to regist=
er input device\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_irq;
> > + =A0 =A0 =A0 }
>=20
> the input layer can handle input even if it's not registered ?

The device can survive input events as soon as it was allocated with
input_allocate_device() but of course the event will not get anywhere.
This is a property that I intend to keep since it is very convenient.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
