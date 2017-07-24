From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v4 00/12] AC97 device/driver model revamp
Date: Mon, 24 Jul 2017 22:49:16 +0200
Message-ID: <20170724204928.29505-1-robert.jarzmik@free.fr>
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

This is a minor revision after v3, mainly reviews from Takashi, Charles.

I did more extensive testing of load/unload of the whole serie, and apart from a
bug in wm97xx-core in touchscreen tree (for a which a patch will be sent apart),
it seems to work properly. I extracted the diff from the v3 of sound/ac97 which
is in [1] for easier spotting of what has globally changed.

I would still need a review from you, Lee, for the mfd patch (patch 6/12).

Happy review.

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
 drivers/mfd/Kconfig                     |  15 +
 drivers/mfd/Makefile                    |   1 +
 drivers/mfd/wm97xx-core.c               | 405 ++++++++++++++++++++++++
 include/linux/mfd/wm97xx.h              |  31 ++
 include/sound/ac97/codec.h              | 118 +++++++
 include/sound/ac97/compat.h             |  21 ++
 include/sound/ac97/controller.h         |  84 +++++
 include/sound/ac97/regs.h               | 262 +++++++++++++++
 include/sound/ac97_codec.h              | 239 +-------------
 include/sound/pxa2xx-lib.h              |  15 +-
 sound/Kconfig                           |   2 +
 sound/Makefile                          |   1 +
 sound/ac97/Kconfig                      |  19 ++
 sound/ac97/Makefile                     |   8 +
 sound/ac97/ac97_core.h                  |  10 +
 sound/ac97/bus.c                        | 542 ++++++++++++++++++++++++++++++++
 sound/ac97/codec.c                      |  15 +
 sound/ac97/snd_ac97_compat.c            | 105 +++++++
 sound/arm/Kconfig                       |   1 -
 sound/arm/pxa2xx-ac97-lib.c             |  37 ++-
 sound/arm/pxa2xx-ac97.c                 |  35 ++-
 sound/soc/codecs/Kconfig                |   9 +-
 sound/soc/codecs/wm9705.c               |  59 ++--
 sound/soc/codecs/wm9712.c               |  37 ++-
 sound/soc/codecs/wm9713.c               |  39 ++-
 sound/soc/pxa/Kconfig                   |   5 +-
 sound/soc/pxa/pxa2xx-ac97.c             |  46 ++-
 29 files changed, 2001 insertions(+), 414 deletions(-)
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

[1] sound diff from last revision
   (git diff submit/ac97-2..submit/ac97-3 sound/ac97 include/sound/ac97)
diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 7cda8175341e..af618a0e89cb 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -76,7 +76,6 @@ static void ac97_codec_release(struct device *dev)
 	adev = to_ac97_device(dev);
 	ac97_ctrl = adev->ac97_ctrl;
 	ac97_ctrl->codecs[adev->num] = NULL;
-	sysfs_remove_link(&dev->kobj, "ac97_controller");
 	kfree(adev);
 }
 
@@ -269,8 +268,29 @@ static const struct attribute_group *ac97_adapter_groups[] = {
 	NULL,
 };
 
+static void ac97_del_adapter(struct ac97_controller *ac97_ctrl)
+{
+	mutex_lock(&ac97_controllers_mutex);
+	ac97_ctrl_codecs_unregister(ac97_ctrl);
+	list_del(&ac97_ctrl->controllers);
+	mutex_unlock(&ac97_controllers_mutex);
+
+	device_unregister(&ac97_ctrl->adap);
+}
+
+static void ac97_adapter_release(struct device *dev)
+{
+	struct ac97_controller *ac97_ctrl;
+
+	ac97_ctrl = to_ac97_controller(dev);
+	idr_remove(&ac97_adapter_idr, ac97_ctrl->nr);
+	dev_dbg(&ac97_ctrl->adap, "adapter unregistered by %s\n",
+		dev_name(ac97_ctrl->parent));
+}
+
 static const struct device_type ac97_adapter_type = {
 	.groups		= ac97_adapter_groups,
+	.release	= ac97_adapter_release,
 };
 
 static int ac97_add_adapter(struct ac97_controller *ac97_ctrl)
@@ -298,16 +318,6 @@ static int ac97_add_adapter(struct ac97_controller *ac97_ctrl)
 	return ret;
 }
 
-static void ac97_del_adapter(struct ac97_controller *ac97_ctrl)
-{
-	mutex_lock(&ac97_controllers_mutex);
-	ac97_ctrl_codecs_unregister(ac97_ctrl);
-	list_del(&ac97_ctrl->controllers);
-	idr_remove(&ac97_adapter_idr, ac97_ctrl->nr);
-	mutex_unlock(&ac97_controllers_mutex);
-	put_device(&ac97_ctrl->adap);
-}
-
 /**
  * snd_ac97_controller_register - register an ac97 controller
  * @ops: the ac97 bus operations
@@ -508,7 +518,7 @@ static int ac97_bus_remove(struct device *dev)
 }
 
 static struct bus_type ac97_bus_type = {
-	.name		= "ac97",
+	.name		= "ac97bus",
 	.dev_groups	= ac97_dev_groups,
 	.match		= ac97_bus_match,
 	.pm		= &ac97_pm,
@@ -522,5 +532,11 @@ static int __init ac97_bus_init(void)
 }
 subsys_initcall(ac97_bus_init);
 
+static void __exit ac97_bus_exit(void)
+{
+	bus_unregister(&ac97_bus_type);
+}
+module_exit(ac97_bus_exit);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Robert Jarzmik <robert.jarzmik@free.fr>");
