From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] input/keyboard: add
	ADP5588	QWERTY I2C Keyboard Input device driver
Date: Mon, 21 Sep 2009 09:55:18 -0700
Message-ID: <20090921165517.GA5260@core.coreip.homeip.net>
References: <20090915062050.GB10232@core.coreip.homeip.net>
	<1253062178-18196-1-git-send-email-vapier@gentoo.org>
	<20090916050236.GF2756@core.coreip.homeip.net>
	<8bd0f97a0909210945s5e3d9613pa7a72271ec6b47bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8bd0f97a0909210945s5e3d9613pa7a72271ec6b47bc-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Sep 21, 2009 at 12:45:02PM -0400, Mike Frysinger wrote:
> On Wed, Sep 16, 2009 at 01:02, Dmitry Torokhov wrote:
> > On Tue, Sep 15, 2009 at 08:49:38PM -0400, Mike Frysinger wrote:
> >> From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> >>
> >> Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> >> Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
> >> Signed-off-by: Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>
> >> ---
> >> v2
> >> =A0 =A0 =A0 - merge my and Dmitry's clean up fixes
> >>
> >
> > Looks good, I'd also like to add this instead of recalcularing delay
> > every time:
> =

> this should continue to work fine with cpu scaling right ?

Jiffy value depends only on HZ, not on current cpu frequency so should
be OK I think.

-- =

Dmitry
