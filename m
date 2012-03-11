From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [git pull] Input updates for 3.3-rc6
Date: Sat, 10 Mar 2012 23:35:56 -0800
Message-ID: <20120311073556.GA15408@core.coreip.homeip.net>
References: <20120307091816.GA28160@core.coreip.homeip.net>
 <CAMuHMdUyCEVr+fFmUnUABSG33juYTWdyy6-6a1uNW0+oePJR6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54220 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab2CKHgE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Mar 2012 03:36:04 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdUyCEVr+fFmUnUABSG33juYTWdyy6-6a1uNW0+oePJR6g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sat, Mar 10, 2012 at 11:11:17PM +0100, Geert Uytterhoeven wrote:
> On Wed, Mar 7, 2012 at 10:18, Dmitry Torokhov <dmitry.torokhov@gmail.=
com> wrote:
> > Dmitry Torokhov (1):
> > =A0 =A0 =A0Input: twl4030-vibra - use proper guard for PM methods
>=20
> That's commit f3761c0779b62276b5bf84532a81d5dc49bd721f?
>=20
> | drivers/input/misc/twl4030-vibra.c:175:5: warning: "CONFIG_PM" is n=
ot
> | defined
> |
> | We should use #ifdef instead of #if and also check CONFIG_PM_SLEEP
> | instead of CONFIG_PM.
>=20
> It still uses "#if CONFIG_PM_SLEEP", i.e. no #ifdef.
>=20

Doh! I'll fix it up...

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
