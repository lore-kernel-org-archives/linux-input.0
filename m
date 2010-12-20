From: <aaro.koskinen@nokia.com>
Subject: RE: [PATCH v2] Keyboard: omap-keypad: use matrix_keypad.h
Date: Mon, 20 Dec 2010 19:03:58 +0000
Message-ID: <BC214410FD04D84F9079A624236597070C1680@008-AM1MPN1-003.mgdnok.nokia.com>
References: <201012172332.06480.jkrzyszt@tis.icnet.pl>
 <201012181639.29820.jkrzyszt@tis.icnet.pl>
 <alpine.DEB.1.10.1012201720470.13087@esdhcp041196.research.nokia.com>,<201012201832.24243.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:55199 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932694Ab0LTTFA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Dec 2010 14:05:00 -0500
In-Reply-To: <201012201832.24243.jkrzyszt@tis.icnet.pl>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkrzyszt@tis.icnet.pl
Cc: dmitry.torokhov@gmail.com, linux-omap@vger.kernel.org, linux-input@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Hi,

From: Janusz Krzysztofik [jkrzyszt@tis.icnet.pl]
> Monday 20 December 2010 16:29:32 Aaro Koskinen wrote:
> > You should update the ams_delta_keymap type as well, otherwise this
> > patch will introduce the following sparse warning:
> >
> >    CHECK   arch/arm/mach-omap1/board-ams-delta.c
> > arch/arm/mach-omap1/board-ams-delta.c:191:27: warning: incorrect type in initializer (different signedness)
> > arch/arm/mach-omap1/board-ams-delta.c:191:27:    expected unsigned int const [usertype] *keymap
> > arch/arm/mach-omap1/board-ams-delta.c:191:27:    got int static [toplevel] *<noident>
>
> Hi Aaro,
> How did you get this output? I'm using OpenEmbedded as my development
> environment. Running make with "C=1" (EXTRA_OEMAKE=" C=1 ") displays a
> lot but the above. Running sparse by hand breaks with "unable to
> open 'linux/init.h'". Any advice?

I'm using the latest sparse from:

   git://git.kernel.org/pub/scm/devel/sparse/sparse.git

I don't know about OpenEmbedded, but I've noticed that at least Debian
ships with some old version that is missing many checks...

A.
