From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 0/9] AC97 device/driver model revamp
Date: Wed, 26 Oct 2016 21:41:38 +0200
Message-ID: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:45297 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755448AbcJZTmH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Oct 2016 15:42:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org

It all started in the pxa device-tree submission here :
   https://lkml.org/lkml/2016/2/25/965

Last submission was a RFC in here:
  http://www.gossamer-threads.com/lists/linux/kernel/2446863
   
It will be maintained in :
   git fetch https://github.com/rjarzmik/linux.git work/ac97

The driving ideas are still the same, and I put them in [1] for memory. This is
the first post RFC submission. In order to make a full demonstration of the
framework, wm97xx was converted to an MFD, see [2] for the "why".

As this serie is a complete wm9713 change towards the new AC97 bus, here is the
patch organization :
 - 1/9, 2/9, 3/9 and 5/9: the new AC97 bus, for Mark and Takashi to review
 - 4/9: wm9713 conversion, this one has ugly #ifdefs, should be reviewed more
   carefully
 - 6/9: prerequisite for final 9/9, for Marek and Sebastian to approve
        => this one is independent and can flow through Sebastian's tree in this
        next-cycle if accepted
 - 7/9: prerequisite for final 9/9, for Mark/Dmitry
        => this one is also independent and can flow in this cycle if accepted
 - 8/9: prerequisite for final 9/9, for Lee to review
        => this one has a dependency on 2/9, so it probably can't fit in this
	next-cycle
 - 9/9: this last one depends on all the patches before, so it can't fit in this
        next-cycle

As a sum-up, I'd like to push for review for this -next cycle at least the
patches 1, 2, 3, 5, 6 and 9.

Happy review.

Robert Jarzmik (9):
  ALSA: ac97: split out the generic ac97 registers
  ALSA: ac97: add an ac97 bus
  ASoC: add new ac97 bus support
  ASoC: wm9713: add ac97 new bus support
  ASoC: pxa: switch to new ac97 bus support
  power_supply: wm97xx_battery: use power_supply_get_drvdata
  Input: wm97xx: split out touchscreen registering
  mfd: wm97xx-core: core support for wm97xx Codec
  Input: wm97xx: add new AC97 bus support

 drivers/input/touchscreen/Kconfig       |   2 +-
 drivers/input/touchscreen/wm97xx-core.c | 247 +++++++++++-----
 drivers/mfd/Kconfig                     |  14 +
 drivers/mfd/Makefile                    |   1 +
 drivers/mfd/wm97xx-core.c               | 282 ++++++++++++++++++
 drivers/power/supply/wm97xx_battery.c   |  25 +-
 include/linux/mfd/wm97xx.h              |  31 ++
 include/sound/ac97/codec.h              | 115 +++++++
 include/sound/ac97/compat.h             |  21 ++
 include/sound/ac97/controller.h         |  85 ++++++
 include/sound/ac97/regs.h               | 262 ++++++++++++++++
 include/sound/ac97_codec.h              | 239 +--------------
 include/sound/pxa2xx-lib.h              |  15 +-
 sound/Kconfig                           |   2 +
 sound/Makefile                          |   1 +
 sound/ac97/Kconfig                      |  19 ++
 sound/ac97/Makefile                     |   8 +
 sound/ac97/ac97_core.h                  |  10 +
 sound/ac97/bus.c                        | 510 ++++++++++++++++++++++++++++++++
 sound/ac97/codec.c                      |  15 +
 sound/ac97/snd_ac97_compat.c            | 105 +++++++
 sound/arm/Kconfig                       |   1 -
 sound/arm/pxa2xx-ac97-lib.c             |  39 ++-
 sound/soc/Kconfig                       |   4 +
 sound/soc/codecs/Kconfig                |   3 +-
 sound/soc/codecs/wm9713.c               |  37 ++-
 sound/soc/pxa/Kconfig                   |   5 +-
 sound/soc/pxa/pxa2xx-ac97.c             |  22 +-
 28 files changed, 1738 insertions(+), 382 deletions(-)
 create mode 100644 drivers/mfd/wm97xx-core.c
 create mode 100644 include/linux/mfd/wm97xx.h
 create mode 100644 include/sound/ac97/codec.h
 create mode 100644 include/sound/ac97/compat.h
 create mode 100644 include/sound/ac97/controller.h
 create mode 100644 include/sound/ac97/regs.h
 create mode 100644 sound/ac97/Kconfig
 create mode 100644 sound/ac97/Makefile
 create mode 100644 sound/ac97/ac97_core.h
 create mode 100644 sound/ac97/bus.c
 create mode 100644 sound/ac97/codec.c
 create mode 100644 sound/ac97/snd_ac97_compat.c

-- 
2.1.4

[1] RFC PATCH reminder:

Amongst the driving ideas behind this RFC :
 - use device/driver model for AC'97
   device/driver binding is based on vendor_id{1,2}
 - use auto-probe of the AC'97 bus to enumerate codecs and create devices
 - be compatible with previous platform_data model for codecs
   => this enables a smooth transition, where a codec (here wm9713) can
      be used either through platform_device or automatic discovery
 - struct snd_ac97 is not used
   This structure is really heavy, and doesn't represent an AC97 device, but
   rather an AC'97 codec internals IIUC.
   I think it's right place would be in include/sound/ac97/codec.h.
   This is also a problem for regmap adherence, hence the
   include/sound/ac97/compat.h.
 - a new AC'97 bus Kconfig is created
   This was done for a smooth transition ... let's see if it's a good idea.
 - split the AC'97 into :
   - the codec
   - the digital controller
   - the bus

Amongst the things that are not all touched yet :
 - ac97_codec.c
   The generic AC'97 codec in sound/pci/ac97/ac97_codec.c has really a lot
   features, which are not at all PCI related. They could be transfered to
   sound/ac97, without the pci specific field.
   => this deserves a deep ahead thinking, which I'll do if the current approach
   is accepted by the communauty.

The most important patch is 2/7 "ALSA: ac97: add an ac97 bus". This is the main
evaluation point for the serie, the others are here so that I can test it all.

Well, this is a long term effort, which might need a complete rewrite according
to the comments it'll get. Let's expose it for comments and see how I can
progress with it.

[2] As a corollary, wm97xx is changed into a MFD device, which at least spawns:
 - the touchscreen device
 - the ac97 codec
 - the problem to solve was stated in
   http://www.gossamer-threads.com/lists/linux/kernel/2510113#2510113
