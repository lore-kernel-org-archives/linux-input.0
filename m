From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/5] Input: Enable STMPE keypad driver for Device Tree
Date: Tue, 8 Jan 2013 09:53:26 +0000
Message-ID: <20130108095326.GC21994@gmail.com>
References: <1352900837-20759-1-git-send-email-lee.jones@linaro.org>
 <1352900837-20759-5-git-send-email-lee.jones@linaro.org>
 <20130108083803.GY21994@gmail.com>
 <20130108092653.GA29695@core.coreip.homeip.net>
 <20130108093013.GB29695@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:33048 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754532Ab3AHJxc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Jan 2013 04:53:32 -0500
Received: by mail-bk0-f50.google.com with SMTP id jf3so108401bkc.23
        for <linux-input@vger.kernel.org>; Tue, 08 Jan 2013 01:53:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130108093013.GB29695@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linus.walleij@linaro.org, arnd@arndb.de

On Tue, 08 Jan 2013, Dmitry Torokhov wrote:

> On Tue, Jan 08, 2013 at 01:26:54AM -0800, Dmitry Torokhov wrote:
> > Hi Lee,
> >=20
> > On Tue, Jan 08, 2013 at 08:38:03AM +0000, Lee Jones wrote:
> > >=20
> > > I'm less than pleased that you _stole_ authorship of this patch!
> > >=20
> > > Especially, as I've been asking you to review it for some time.
> >=20
> > My sincere apologies, it was never my intention to claim anyones wo=
rk as
> > my own.
> >=20
> > It appears that "stg squash" command (I use stacked git to manage m=
y WIP
> > queue) produces result with authorship changed to the committer and=
 if
> > you check the thread you will see that I explicitly mentioned that =
I
> > folded the device tree binding documentation (that was also authore=
d by
> > you) into this patch.
> >=20
> > Now that I am looking it appears that sysrq keyreset patch by Mathi=
eu
> > Poirier was also committed as authored by me, and on that patch I a=
slo
> > used "stg squash".
> >=20
> > OK, I'll now be aware of this behavior and I will rewind my 'next'
> > branch and correct the authorship on the commits.
>=20
> *sigh* It looks like the stmpe patch is already in mainline, so I wil=
l
> not be able to correct it.
>=20
> I am very sorry.

Okay, as long as it was a genuine mistake, I will bear no grudges.

Apology graciously accepted. :)

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
