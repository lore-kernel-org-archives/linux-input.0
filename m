From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/2] add ad714x
	input driver forbutton/scrollwhell/slider/touchpad
Date: Tue, 1 Sep 2009 21:31:26 -0700
Message-ID: <200909012131.27471.david-b@pacbell.net>
References: <1251777330-16994-1-git-send-email-21cnbao@gmail.com>
	<8bd0f97a0909011230r50cb532ep46db64d65cbb49e5@mail.gmail.com>
	<0F1B54C89D5F954D8535DB252AF412FA04A5CADA@chinexm1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <0F1B54C89D5F954D8535DB252AF412FA04A5CADA-SGdA1W8gREmuVPpjEGsWsTcYPEmu4y7e@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Song, Barry" <Barry.Song-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dtor-JGs/UdohzUI@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tuesday 01 September 2009, Song, Barry wrote:
> >> + =A0 =A0 =A0 spi_message_add_tail(&t, &m);
> >> + =A0 =A0 =A0 ret =3D spi_sync(spi, &m);
> >
> >cant you use spi_write_then_read() ? =A0dont let the u8* prototype scare
> >you, it should work with writing 16bits and then reading 16bits.
> =

> I have never been scared by any u8* or something else. I only prefer
> to use raw spi API, which can show the bottom level timing and SPI =

> bus feature better.   =


In this case spi_write_then_read() is required, since
your tx and rx buffers are on the stack and hence not
DMA-safe.

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
