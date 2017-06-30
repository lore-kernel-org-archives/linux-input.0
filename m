From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v3 00/12] AC97 device/driver model revamp
Date: Fri, 30 Jun 2017 21:43:56 +0200
Message-ID: <20170630194408.24978-1-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Lars, Mark, Charles, Lee,

This is a resend of the v2, with patch 1 added (forgotten in v2). Patch 12 was
slightly modified after module unloading tests, and Dmitry acks were added.

This serie has been stalled for almost one year, as I wasn't feeling that
well lately. I'm quite better now, so let's get back to it.

The following sentences is a what was already said in v2.

As it's been so long since the last review, I basically withdrew all my former
objections and took into account all remarks regardless of my own
judgement. This is especially the case with Lars's review on the bus code, where
I tried to address all his comments.

For this next round, let's sum up what happened :
 - I rebased against latest Linus's tree
   => as Lars had made ports to regmap of several impacted wm97xx drivers, all
   the better for me.
   
 - ALSA: ac97: add an ac97 bus
   => this addresses Lars's comments
   => history : https://patchwork.kernel.org/patch/9398229/
   => there is one remark which was left out, the drop of the table
      ac97_controller->codecs. The reason is that there are traversals required
      in the bus scan and controller removal, and the code is way simpler with a
      table, and the data structure very compact.
   
 - Input: wm97xx: split out touchscreen registering
   => Charles's comment taken into account
   => history: http://https://patchwork.kernel.org/patch/9398223/

Have a happy review.

--
Robert

Robert Jarzmik (12):
  ALSA: ac97: split out the generic ac97 registers
  ALSA: ac97: add an ac97 bus
  ASoC: add new ac97 bus support
  ASoC: arm: make pxa2xx-ac97-lib ac97 codec agnostic
  Input: wm97xx: split out touchscreen registering
  mfd: wm97xx-core: core support for wm97xx Codec
  Input: wm97xx: add new AC97 bus support
  ASoC: wm9713: add ac97 new bus support
  ASoC: wm9712: add ac97 new bus support
  ASoC: wm9705: add private structure
  ASoC: wm9705: add ac97 new bus support
  ASoC: pxa: switch to new ac97 bus support

 drivers/input/touchscreen/Kconfig       |   2 +-
 drivers/input/touchscreen/wm97xx-core.c | 252 ++++++++++-----
 drivers/mfd/Kconfig                     |  14 +
 drivers/mfd/Makefile                    |   1 +
 drivers/mfd/wm97xx-core.c               | 282 +++++++++++++++++
 include/linux/mfd/wm97xx.h              |  31 ++
 include/sound/ac97/codec.h              | 118 +++++++
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
 sound/ac97/bus.c                        | 526 ++++++++++++++++++++++++++++++++
 sound/ac97/codec.c                      |  15 +
 sound/ac97/snd_ac97_compat.c            | 105 +++++++
 sound/arm/Kconfig                       |   1 -
 sound/arm/pxa2xx-ac97-lib.c             |  37 ++-
 sound/arm/pxa2xx-ac97.c                 |  35 ++-
 sound/soc/Kconfig                       |   4 +
 sound/soc/codecs/Kconfig                |   9 +-
 sound/soc/codecs/wm9705.c               |  59 ++--
 sound/soc/codecs/wm9712.c               |  37 ++-
 sound/soc/codecs/wm9713.c               |  39 ++-
 sound/soc/pxa/Kconfig                   |   5 +-
 sound/soc/pxa/pxa2xx-ac97.c             |  46 ++-
 30 files changed, 1866 insertions(+), 414 deletions(-)
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
2.11.0
