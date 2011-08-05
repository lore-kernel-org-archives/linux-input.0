From: Michael Thayer <michael.thayer@oracle.com>
Subject: Re: Getting notification of PS/2 mouse packages
Date: Fri, 05 Aug 2011 16:10:07 +0200
Message-ID: <1312553407.2426.62.camel@michael-latitude-e6410>
References: <1312544155.2426.49.camel@michael-latitude-e6410>
	 <20110805123605.GA5464@nautilus.holoscopio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:40360 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754958Ab1HEOKU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Aug 2011 10:10:20 -0400
In-Reply-To: <20110805123605.GA5464@nautilus.holoscopio.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2011-08-05 at 09:36 -0300, Thadeu Lima de Souza Cascardo wrote:
> On Fri, Aug 05, 2011 at 01:35:55PM +0200, Michael Thayer wrote:
> > I am looking at writing a driver (it is to be open source, but not =
for
> > mainstream kernel inclusion) for a virtual machine-specific input
> > device.  Unfortunately one of the versions of the device I have to
> > support signals that it has new data available by sending a fake pa=
ckage
> > to the PS/2 mouse, so I need to be able to get notification of that
> > somehow.  Looking at the kernel source, I see that the i8042 driver
> > requests IRQ 12 as IRQF_SHARED, and that the kernel always notifies=
 all
> > registered interrupt handlers of an interrupt, even if one of them
> > returns IRQ_HANDLED.  So it looks like I can just request my own sh=
ared
> > handler for IRQ 12 and always return IRQ_NONE, but still update my =
data.
> > However I am not sure whether this is something I can count on to k=
eep
> > working in future kernel releases.  Does anyone on this list know m=
ore
> > about this, or can someone suggest a cleaner way to get the
> > notifications I need?
> [...]
> My advice is: send it for mainline inclusion!
>=20
> You more likely get your code reviewed, and it what you do is
> acceptable, it will get included and that's a "OK" for your solution.
> Then, if it turns out it's not OK anymore, it's much more likely peop=
le
> will go and fix it for you. At least, that's certainly not going to
> happen if it's not published somehow, but out-of-tree drivers or patc=
hes
> do not usually have the attention of Linux developers.
>=20
> So, what is it that you consider your work not worth of mainline
> inclusion?

Hello Thadeu,

I suppose that the main reason is that the usual upgrade cycle of new
hardware, new kernel doesn't quite fit to virtual machines, given that
one of their main purposes is to run legacy software.  My driver should
ideally work with any 2.6.x (and now 3.x) kernel, and obviously I can n=
o
longer get it into mainline for say the 2.6.9 kernel shipped with Fedor=
a
Core 3.  Having it in mainline also complicates matters slightly if we
wanted to add new features to the hardware and the driver (we might wan=
t
multi-touch sometime) but the kernel in question already ships with an
older version.  I realise that that is not a show-stopper, but it bring=
s
additional complications for relatively little gain.

Obviously we are used to the trade-off of having to put in more
maintenance work, though it isn't as bad as you might think,
particularly compared to the effort of ensuring that new features work
on any random 2.6 kernel (until recently 2.4 as well), including variou=
s
hacked distribution kernels.  And these days we often get patches from
users to support new kernel (pre-)releases before we even notice that
something is broken.

Regards,

Michael
--=20
ORACLE Deutschland B.V. & Co. KG   Michael Thayer
Werkstrasse 24                     VirtualBox engineering
71384 Weinstadt, Germany           mailto:michael.thayer@oracle.com

Hauptverwaltung: Riesstr. 25, D-80992 M=C3=BCnchen
Registergericht: Amtsgericht M=C3=BCnchen, HRA 95603

Komplement=C3=A4rin: ORACLE Deutschland Verwaltung B.V.
Hertogswetering 163/167, 3543 AS Utrecht, Niederlande
Handelsregister der Handelskammer Midden-Niederlande, Nr. 30143697
Gesch=C3=A4ftsf=C3=BChrer: J=C3=BCrgen Kunz, Marcel van de Molen, Alexa=
nder van der Ven

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
