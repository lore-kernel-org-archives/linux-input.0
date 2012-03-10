From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [git pull] Input updates for 3.3-rc6
Date: Sat, 10 Mar 2012 23:11:17 +0100
Message-ID: <CAMuHMdUyCEVr+fFmUnUABSG33juYTWdyy6-6a1uNW0+oePJR6g@mail.gmail.com>
References: <20120307091816.GA28160@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:59651 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565Ab2CJWLS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Mar 2012 17:11:18 -0500
In-Reply-To: <20120307091816.GA28160@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Wed, Mar 7, 2012 at 10:18, Dmitry Torokhov <dmitry.torokhov@gmail.co=
m> wrote:
> Dmitry Torokhov (1):
> =C2=A0 =C2=A0 =C2=A0Input: twl4030-vibra - use proper guard for PM me=
thods

That's commit f3761c0779b62276b5bf84532a81d5dc49bd721f?

| drivers/input/misc/twl4030-vibra.c:175:5: warning: "CONFIG_PM" is not
| defined
|
| We should use #ifdef instead of #if and also check CONFIG_PM_SLEEP
| instead of CONFIG_PM.

It still uses "#if CONFIG_PM_SLEEP", i.e. no #ifdef.

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
