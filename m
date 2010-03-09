From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [git pull] Input updates for 2.6.34-rc0
Date: Tue, 9 Mar 2010 09:51:07 -0800
Message-ID: <20100309175107.GB23378@core.coreip.homeip.net>
References: <20100301080342.GH765@core.coreip.homeip.net>
 <8bd0f97a1003090644p19fb7dacqe1f2fb3adee3fa7a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:34343 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab0CIRvT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 12:51:19 -0500
Content-Disposition: inline
In-Reply-To: <8bd0f97a1003090644p19fb7dacqe1f2fb3adee3fa7a@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Robin Getz <rgetz@blackfin.uclinux.org>

On Tue, Mar 09, 2010 at 09:44:08AM -0500, Mike Frysinger wrote:
> On Mon, Mar 1, 2010 at 03:03, Dmitry Torokhov wrote:
> > Hi Linus,
> >
> > Please pull from:
> >
> > =A0 =A0 =A0 =A0git://git.kernel.org/pub/scm/linux/kernel/git/dtor/i=
nput.git for-linus
> > or
> > =A0 =A0 =A0 =A0master.kernel.org:/pub/scm/linux/kernel/git/dtor/inp=
ut.git for-linus
> >
> > to receive first round of updates for the input subsystem.
>=20
> i'm trying to figure out what the problem is with the ADXL34x and
> AD714x drivers you seem to have accepted (at least, you didnt say
> there was anything left for us to do).  i would have expected them to
> be in 2.6.33/2.6.34 already, but it seems they arent moving now.  so
> what's up ?

I am still spooked by the fact that this is an accelerometer and does
not have to be an input device but maybe used for different purposes as
well.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
