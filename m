From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [0/3]power management for usbtouchscreens
Date: Fri, 16 Jul 2010 08:56:04 +0200
Message-ID: <201007160856.04636.oneukum@suse.de>
References: <201007151556.27284.oneukum@suse.de> <20100715162400.GA17622@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:52407 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935636Ab0GPG4u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Jul 2010 02:56:50 -0400
In-Reply-To: <20100715162400.GA17622@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Petr =?utf-8?q?=C5=A0tetiar?= <ynezz@true.cz>

Am Donnerstag, 15. Juli 2010, 18:24:00 schrieb Dmitry Torokhov:
> On Thu, Jul 15, 2010 at 03:56:27PM +0200, Oliver Neukum wrote:
> > Hi,
> >=20
> > this series implements power management in form of suspend/resume
> > and reset_resume() for USB touchscreens. For devices that can live =
without
> > constant communication runtime power management is also implemented=
=2E
> > Support for reset_resume() required splitting up device initializat=
ion in two
> > parts. Allocations are not repeated upon reset_resume(); initializi=
ng the
> > hardware is repeated.
> >=20
> > Many thanks to Petr =C5=A0tetiar for testing.
> >=20
>=20
> Will apply, thanks Oliver.
>=20
> BTW, your editor adds a bit of whitespace garbage to the files, pleas=
e
> beat it into submission.

That is not good. What did it do?

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
