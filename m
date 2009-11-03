From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.32-rc5
Date: Mon, 2 Nov 2009 22:40:54 -0800
Message-ID: <20091103064054.GD3212@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:60291 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbZKCGky (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Nov 2009 01:40:54 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem.

Changelog:
---------

David H=E4rdeman (1):
      Input: winbond-cir - select LEDS_TRIGGERS

Dmitry Eremin-Solenikov (1):
      Input: gpio-keys - use IRQF_SHARED

Dmitry Torokhov (1):
      Input: i8042 - try to get stable CTR value when initializing

Jamie Lentin (1):
      Input: atkbd - add a quirk for OQO 01+ multimedia keys


Diffstat:
--------

 drivers/input/keyboard/atkbd.c     |   36 ++++++++++++++++++++++++++++=
++++++++
 drivers/input/keyboard/gpio_keys.c |    1 +
 drivers/input/misc/Kconfig         |    1 +
 drivers/input/serio/i8042.c        |   35 ++++++++++++++++++++++++++++=
-------
 4 files changed, 66 insertions(+), 7 deletions(-)

--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
