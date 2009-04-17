From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.30-rc2
Date: Thu, 16 Apr 2009 19:29:15 -0700
Message-ID: <20090417022915.GA7594@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:12971 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225AbZDQC3X (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Apr 2009 22:29:23 -0400
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

Alexander Beregalov (1):
      Input: hp_sdc_rtc should depend on serio

Arjan van de Ven (3):
      Input: i8042 - introduce a tougher reset
      Input: i8042 - add a DMI table for the i8042.reset option
      Input: remove unnecessary synchronize_rcu() call

Barry Carroll (1):
      Input: atkbd - add forced release keys quirk for Samsung NC20

Ben Nizette (1):
      Input: ads7846 - fix unsafe disable_irq

Dmitry Torokhov (2):
      Input: gameport - fix attach driver code
      Input: atkbd - add forced release keys quirk for Samsung Q45

Eric Miao (3):
      Input: ads7846 - introduce platform specific way to synchronize s=
ampling
      Input: da9034-ts - add Bin Yang as co-author of the driver
      Input: da9034-ts - make pen {down,up} events more reliable

Ilpo J=E4rvinen (1):
      Input: pc110pad - remove unused variable dev

Jiri Slaby (1):
      Input: mainstone-wm97xx - fix condition in pen_up

Mark Brown (1):
      Input: wm97xx - don't specify IRQF_SAMPLE_RANDOM

Michael Hennerich (2):
      Input: ad7877, ad7879 - remove depreciated IRQF_SAMPLE_RANDOM fla=
g
      Input: bf54x-keys - remove depreciated IRQF_SAMPLE_RANDOM flag


Diffstat:
--------

 drivers/input/gameport/gameport.c            |   14 ++++-----
 drivers/input/input.c                        |    1 -
 drivers/input/keyboard/atkbd.c               |   20 +++++++++++++-
 drivers/input/keyboard/bf54x-keys.c          |    2 +-
 drivers/input/misc/Kconfig                   |    2 +-
 drivers/input/mouse/pc110pad.c               |    1 -
 drivers/input/serio/i8042-x86ia64io.h        |   28 ++++++++++++++++++=
+
 drivers/input/serio/i8042.c                  |   37 ++++++++++++++++++=
++-----
 drivers/input/touchscreen/ad7877.c           |    4 +-
 drivers/input/touchscreen/ad7879.c           |    3 +-
 drivers/input/touchscreen/ads7846.c          |   12 +++++++-
 drivers/input/touchscreen/da9034-ts.c        |   29 ++++++++++++------=
-
 drivers/input/touchscreen/mainstone-wm97xx.c |    7 ++---
 drivers/input/touchscreen/wm97xx-core.c      |    3 +-
 include/linux/spi/ads7846.h                  |    1 +
 15 files changed, 121 insertions(+), 43 deletions(-)

--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
