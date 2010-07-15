From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [0/3]power management for usbtouchscreens
Date: Thu, 15 Jul 2010 09:24:00 -0700
Message-ID: <20100715162400.GA17622@core.coreip.homeip.net>
References: <201007151556.27284.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201007151556.27284.oneukum-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz-knWk7/PSn+s@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jul 15, 2010 at 03:56:27PM +0200, Oliver Neukum wrote:
> Hi,
>=20
> this series implements power management in form of suspend/resume
> and reset_resume() for USB touchscreens. For devices that can live wi=
thout
> constant communication runtime power management is also implemented.
> Support for reset_resume() required splitting up device initializatio=
n in two
> parts. Allocations are not repeated upon reset_resume(); initializing=
 the
> hardware is repeated.
>=20
> Many thanks to Petr =C5=A0tetiar for testing.
>=20

Will apply, thanks Oliver.

BTW, your editor adds a bit of whitespace garbage to the files, please
beat it into submission.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
