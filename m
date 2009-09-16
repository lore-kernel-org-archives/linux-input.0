From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Uclinux-dist-devel] [PATCH v2] input/keyboard: add ADP5588
	QWERTY I2C Keyboard Input device driver
Date: Wed, 16 Sep 2009 09:33:46 -0700
Message-ID: <20090916163345.GC4970@core.coreip.homeip.net>
References: <20090915062050.GB10232@core.coreip.homeip.net> <1253062178-18196-1-git-send-email-vapier@gentoo.org> <20090916050236.GF2756@core.coreip.homeip.net> <8bd0f97a0909160555n390ad48dhf19c7eac5c3783fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:55005 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbZIPQdt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Sep 2009 12:33:49 -0400
Content-Disposition: inline
In-Reply-To: <8bd0f97a0909160555n390ad48dhf19c7eac5c3783fe@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org

On Wed, Sep 16, 2009 at 08:55:13AM -0400, Mike Frysinger wrote:
> On Wed, Sep 16, 2009 at 01:02, Dmitry Torokhov wrote:
> > On Tue, Sep 15, 2009 at 08:49:38PM -0400, Mike Frysinger wrote:
> >> From: Michael Hennerich <michael.hennerich@analog.com>
> >>
> >> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> >> Signed-off-by: Bryan Wu <cooloney@kernel.org>
> >> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> >> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> >> ---
> >> v2
> >> =A0 =A0 =A0 - merge my and Dmitry's clean up fixes
> >>
> >
> > Looks good, I'd also like to add this instead of recalcularing dela=
y
> > every time:
>=20
> makes sense to me.  you going to merge that, or should i merge & repo=
st as v3 ?

If you could merge and test this would be great - I obviously don't hav=
e
the hardware.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
