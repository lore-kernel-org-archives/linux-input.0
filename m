From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] Input: Make ADS7846 independent on regulator
Date: Sat, 31 Jul 2010 09:03:52 +0200
Message-ID: <201007310903.52921.marek.vasut@gmail.com>
References: <1280555108-27994-1-git-send-email-marek.vasut@gmail.com> <20100731063329.GA23620@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53738 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab0GaHEM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jul 2010 03:04:12 -0400
In-Reply-To: <20100731063329.GA23620@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, vapier@gentoo.org, pavel@ucw.cz, akpm@linux-foundation.org, khilman@deeprootsystems.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, eric.y.miao@gmail.com

Dne So 31. =C4=8Dervence 2010 08:33:29 Dmitry Torokhov napsal(a):
> Hi Marek,
>=20
> On Sat, Jul 31, 2010 at 07:45:08AM +0200, Marek Vasut wrote:
> > In case regulator was not found, ADS7846 failed to probe.
> >=20
> > This fixes a problem on some Sharp Zaurus devices, where there is n=
o
> > regulator present and yet the touchscreen is used.
>=20
> Too many ifdefs to my taste... Can we have ads7846_regulator_enable()
> and friends stubbed out in case !CONFIG_REGULATOR?

Hi,

I believe you should ask the regulator guys about these. We can certain=
ly just=20
remove the ifdefs (I was thinking about it, because it poluted the code=
 quality=20
quite a bit). Just removing the ifdefs shouldn't cause any harm.

Cheers
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
