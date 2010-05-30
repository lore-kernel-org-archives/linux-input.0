From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [NEEDS TEST][PATCH] elantech: discard the first 2 positions
 reports for some firmwares
Date: Sun, 30 May 2010 11:26:01 -0700
Message-ID: <20100530182600.GA32416@core.coreip.homeip.net>
References: <4C02B18D.3050003@tudelft.nl>
 <1275243114.6666.50.camel@mini>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:61654 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab0E3S0I (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 May 2010 14:26:08 -0400
Received: by pzk42 with SMTP id 42so1330121pzk.4
        for <linux-input@vger.kernel.org>; Sun, 30 May 2010 11:26:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275243114.6666.50.camel@mini>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>
Cc: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, May 30, 2010 at 02:11:54PM -0400, Chase Douglas wrote:
> On Sun, 2010-05-30 at 20:42 +0200, =C9ric Piel wrote:
> > According to the Dell/Ubuntu driver, what was previously observed a=
s "jumpy cursor"
> > corresponds to the hardware sending incorrect data for the first tw=
o reports of a=20
> > one touch finger. So let's use the same workaround as in the other =
driver. Also,
> > detect another firmware version with the same behaviour, as in the =
other driver.
>=20
> I can't find this code in any of the Ubuntu released kernels. Where d=
id
> you find this patch?

http://zinc.ubuntu.com/git?p=3Dmid-team/hardy-netbook.git;a=3Dcommitdif=
f;h=3Ddfc02dc860ccef79e7bce095c872548f914d96bf

Woudl be nice if we did not have to hunt through random repos to find
it...

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
