From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [0/3]power management for usbtouchscreens
Date: Fri, 16 Jul 2010 00:07:22 -0700
Message-ID: <20100716070721.GA3712@core.coreip.homeip.net>
References: <201007151556.27284.oneukum@suse.de>
 <20100715162400.GA17622@core.coreip.homeip.net>
 <201007160856.04636.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41258 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935698Ab0GPHH0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Jul 2010 03:07:26 -0400
Content-Disposition: inline
In-Reply-To: <201007160856.04636.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>

On Fri, Jul 16, 2010 at 08:56:04AM +0200, Oliver Neukum wrote:
> Am Donnerstag, 15. Juli 2010, 18:24:00 schrieb Dmitry Torokhov:
> > On Thu, Jul 15, 2010 at 03:56:27PM +0200, Oliver Neukum wrote:
> > > Hi,
> > >=20
> > > this series implements power management in form of suspend/resume
> > > and reset_resume() for USB touchscreens. For devices that can liv=
e without
> > > constant communication runtime power management is also implement=
ed.
> > > Support for reset_resume() required splitting up device initializ=
ation in two
> > > parts. Allocations are not repeated upon reset_resume(); initiali=
zing the
> > > hardware is repeated.
> > >=20
> > > Many thanks to Petr =C5=A0tetiar for testing.
> > >=20
> >=20
> > Will apply, thanks Oliver.
> >=20
> > BTW, your editor adds a bit of whitespace garbage to the files, ple=
ase
> > beat it into submission.
>=20
> That is not good. What did it do?
>=20

Extra tabs on empty lines between variable declaration block and the
real code.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
