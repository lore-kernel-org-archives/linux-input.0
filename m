From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: 3.18.rc1: compile failure in tsc2005.c
Date: Thu, 23 Oct 2014 08:47:51 -0700
Message-ID: <20141023154751.GB18714@dtor-ws>
References: <20141023125325.GB30572@amd>
 <201410231501.04540@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:36889 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbaJWPr4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Oct 2014 11:47:56 -0400
Content-Disposition: inline
In-Reply-To: <201410231501.04540@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, B38611@freescale.com, aaro.koskinen@iki.fi, jg1.han@samsung.com, linux-input@vger.kernel.org, Daniel Walter <dwalter@google.com>

On Thu, Oct 23, 2014 at 03:01:04PM +0200, Pali Roh=E1r wrote:
> On Thursday 23 October 2014 14:53:25 Pavel Machek wrote:
> > Hi!
> >=20
> > I get this. Before I start patching it, perhaps someone has
> > fixed it already?
> >=20
> > 								Pavel
> >=20
> >   CC      drivers/input/touchscreen/tsc2005.o
> > drivers/input/touchscreen/tsc2005.c: In function
> > 'tsc2005_disable_store':
> > drivers/input/touchscreen/tsc2005.c:406:2: error: implicit
> > declaration of function 'strict_strtoul'
> > [-Werror=3Dimplicit-function-declaration] cc1: some warnings
> > being treated as errors
> > scripts/Makefile.build:257: recipe for target
> > 'drivers/input/touchscreen/tsc2005.o' failed
> > make[3]: *** [drivers/input/touchscreen/tsc2005.o] Error 1
> > scripts/Makefile.build:402: recipe for target
> > 'drivers/input/touchscreen' failed
> > make[2]: *** [drivers/input/touchscreen] Error 2
> > scripts/Makefile.build:402: recipe for target 'drivers/input'
> > failed make[1]: *** [drivers/input] Error 2
> > make[1]: *** Waiting for unfinished jobs....
> >   CC      net/core/request_sock.o
>=20
> Hi, I read somewhere that strict_strtoul function was replaced by=20
> some kstrtol function... So maybe somebody forgot to fix tsc2005=20
> driver?

Yeah, I see patch from Daniel removing these but forgettign tsc2005.

Pavel, if you have hardware then a patch connverting to kstro* would be
very welcome.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
