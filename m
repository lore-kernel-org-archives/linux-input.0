From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] add ad714x
	input driver for button/scrollwhell/slider/touchpad
Date: Tue, 1 Sep 2009 19:04:59 -0700
Message-ID: <200909011905.00270.david-b@pacbell.net>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com>
	<1251777330-16994-3-git-send-email-21cnbao@gmail.com>
	<8bd0f97a0909011230r50cb532ep46db64d65cbb49e5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <8bd0f97a0909011230r50cb532ep46db64d65cbb49e5-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dtor-JGs/UdohzUI@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tuesday 01 September 2009, Mike Frysinger wrote:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_threaded_irq(ad714x->bus-=
>irq, ad714x_interrupt,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ad714x_in=
terrupt_thread, IRQF_TRIGGER_FALLING,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "ad714x_c=
aptouch", ad714x);

IRQF_SHARED is worth including; and TRIGGER_FALLING is not good
to hard-wire, maybe it gets inverted or hooked up to an IRQ
controller which only supports level triggers.  Best to have
the trigger mode come from the platform data.

Of course, if it's a level triggered IRQ then it clearly can't
be IRQF_SHARED since someone will need to mask it off at the IRQ
controller before exiting the hardirq handler, and unmask it
before exiting the threaded handler.


---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
