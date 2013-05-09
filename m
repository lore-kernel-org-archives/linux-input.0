From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Possible regression 3.8.7 -> 3.9 with Dell touchpad
Date: Thu, 9 May 2013 15:54:21 -0700
Message-ID: <20130509225421.GA18220@core.coreip.homeip.net>
References: <20130509205958.89890@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:43757 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932431Ab3EIWyZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 May 2013 18:54:25 -0400
Received: by mail-pd0-f174.google.com with SMTP id u10so2333454pdi.33
        for <linux-input@vger.kernel.org>; Thu, 09 May 2013 15:54:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130509205958.89890@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tibor Billes <tbilles@gmx.com>
Cc: linux-input@vger.kernel.org, Dave Turvene <dturvene@dahetral.com>, Kevin Cernekee <cernekee@gmail.com>

On Thu, May 09, 2013 at 10:59:58PM +0200, Tibor Billes wrote:
> Hi,
>=20
> I found that after upgrading my kernel from 3.8.7 to 3.9 my touchpad =
only
> works partly. By that I mean I can use the touchpad to move the curso=
r
> around, but I cannot click with it by tapping.

Is the touchpad recognized as ALPS or PS/2 mouse in 3.8.7? Also, can yo=
u
check that touchpad tapping is enabled in your desktop environment?

Thanks.

> My machine is a Dell
> Latitude E5530. Since it is 100% reproducible on my machine, I bisect=
ed it,
> and found this commit:
>=20
> commit 1302bac33d9e88cd43e482191a806998f3ed43cc
> Author: Kevin Cernekee <cernekee@gmail.com>
> Date: =A0 Wed Feb 13 22:27:08 2013 -0800
>=20
>  =A0 =A0Input: ALPS - add support for "Rushmore" touchpads
>  =A0 =A0
>  =A0 =A0Rushmore touchpads are found on Dell E6230/E6430/E6530. =A0Th=
ey use the V3
>  =A0 =A0protocol with slightly tweaked init sequences and report form=
ats.
>  =A0 =A0
>  =A0 =A0The E7 report is 73 03 0a, and the EC report is 88 08 1d
>  =A0 =A0
>  =A0 =A0Credits: Emmanuel Thome reported the MT bitmap changes.
>  =A0 =A0
>  =A0 =A0Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>  =A0 =A0Tested-by: Dave Turvene <dturvene@dahetral.com>
>  =A0 =A0Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> I did the bisection between 3.8.7 and 3.9, but also tried 3.9.1, it i=
s bad
> too. I also tried reverting that commit to make sure that it really i=
s
> what made my touchpad not working. The revert did fix my problem.
>=20
> That's all I gathered so far, but I'd be happy to help further in any=
 way
> I can, just let me know.
>=20
> Thanks,
> Tibor
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
