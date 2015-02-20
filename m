From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 3.20-rc0 (part 2)
Date: Fri, 20 Feb 2015 12:18:29 -0800
Message-ID: <20150220201829.GC22546@dtor-glaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:40836 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613AbbBTUSd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2015 15:18:33 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive second round of updates for the input subsystem. You will ge=
t updates to
ALPS an bfin_roraty drivers and a couple oother fixups.

Changelog:
---------

Bastien Nocera (1):
      Input: soc_button_array - use "Windows" key for "Home"

Dan Carpenter (1):
      Input: pxa27x_keypad - remove an unneeded NULL check

Dmitry Torokhov (10):
      Input: ALPS - renumber protocol numbers
      Input: ALPS - make Rushmore a separate protocol
      Input: ALPS - split protocol data from model info
      Input: ALPS - consolidate setting protocol parameters
      Input: ALPS - fix trackstick detection on some Dell Latitudes
      Input: ALPS - fix confusing comment in protocol data
      Input: bfin_rotary - fix potential oops in interrupt handler
      Input: bfin_rotary - mark suspend and resume code as __maybe_unus=
ed
      Input: bfin_rotary - introduce open and close methods
      Input: psmouse - use IS_ENABLED instead of homegrown code

Markus Elfring (1):
      Input: adi - remove an unnecessary check

Pali Roh=E1r (2):
      Input: ALPS - do not mix trackstick and external PS/2 mouse data
      Input: ALPS - move v7 packet info to Documentation and v6 packet =
info

Sonic Zhang (4):
      Input: bfin_rotary - move platform header to linux/platform_data
      Input: bfin_rotary - move pin lists into into platform data
      Input: bfin_rotary - use generic IO functions
      Input: bfin_rotary - convert to use managed resources


Diffstat:
--------

 Documentation/input/alps.txt                       |  68 ++-
 arch/blackfin/mach-bf527/boards/ad7160eval.c       |  15 +-
 arch/blackfin/mach-bf527/boards/ezkit.c            |  15 +-
 arch/blackfin/mach-bf548/boards/ezkit.c            |   7 +-
 arch/blackfin/mach-bf609/boards/ezkit.c            |   7 +-
 drivers/input/joystick/adi.c                       |   3 +-
 drivers/input/keyboard/pxa27x_keypad.c             |   4 +-
 drivers/input/misc/bfin_rotary.c                   | 208 +++++----
 drivers/input/misc/soc_button_array.c              |   2 +-
 drivers/input/mouse/alps.c                         | 516 ++++++++++++-=
--------
 drivers/input/mouse/alps.h                         |  65 ++-
 drivers/input/mouse/cypress_ps2.c                  |   5 -
 drivers/input/mouse/cypress_ps2.h                  |   5 -
 drivers/input/mouse/focaltech.c                    |  10 -
 drivers/input/mouse/focaltech.h                    |   1 -
 drivers/input/mouse/psmouse-base.c                 |   6 +-
 drivers/input/mouse/synaptics.c                    |  10 -
 drivers/input/mouse/synaptics.h                    |   1 -
 .../linux/platform_data}/bfin_rotary.h             |   1 +
 19 files changed, 577 insertions(+), 372 deletions(-)
 rename {arch/blackfin/include/asm =3D> include/linux/platform_data}/bf=
in_rotary.h (99%)


--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
