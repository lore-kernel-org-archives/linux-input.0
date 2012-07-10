From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [PATCH V7 0/4] add 88pm80x mfd driver
Date: Tue, 10 Jul 2012 17:17:34 +0800
Message-ID: <1341911858-10851-1-git-send-email-zhouqiao@marvell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:60369 "HELO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753274Ab2GJJRu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jul 2012 05:17:50 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-input@vger.kernel.org
Cc: Qiao Zhou <zhouqiao@marvell.com>

Hi Dmitry, could you please help review the input patch? sorry that I
didn't cc you in the beginning. the first 3 patches are merged on
mfd-2.6 for-next branch.

change log [v7->v6]:
1, add the ack by Arnd for the first two patches.
2, add NULL terminater for id_table in 88pm800.c & 88pm805.c.

change log [v6->v5]:
export_symbol_gpl for pm80x_regmap_config to fix build issue for module.

change log [v5->v4]:
1, change the file name, from 88pm800-core.c, 88pm805-core.c, 88pm80x-i2c.c
to 88pm800.c, 88pm805.c, 88pm80x.c, and modified Makefile accordingly.
2, replace the spinlock used to protect wakeup flag, with using set_bit/
clear_bit, which is suitable adn enough in SMP env.
3, add the version number in each patch.

change log [v4->v3]:
1, provide unified suspend/resume api for all sub-devices, and add
protection for 800 & 805 wakeup flag in SMP case.
2, clean register definition in 88pm80x.h, and thanks Arnd's help.
3, some minor changes in mfd Kconfig/Makefile.

change log [v3->v2]:
1, dynamically get the irq_base, for both regmap_add_irq_chip and
mfd_add_devices. add pm80x_request_irq & pm80x_free_irq for sub-driver
facility, and modify related irq thread operation. remove irq_base member
from 80x_chip & platform data.
2, split 88pm80x.o into 3 separate modules.
3, remove the 88pm80x r/w API, and directly use open-coded regmap api.
4, minor change: move pm80x_id_table from 80x-i2c.c to 800/805-core.c,
exported pm80x_init, pm80x_deinit, and pm80x_bulk_read, add callback in
pdata.

change log [v2->v1]:
1, split 88pm80x-core.c into 88pm800-core.c and 88pm805.c, per Arnd's
suggestion. after the re-arch, 88pm80x-i2c handles the 800 & 805 common
parts, while 800-core.c & 805-core.c handle the specific parts in each
chip.
2, add details about the workaround adding a i2c companion between 800 &
805, and make a separate patch for it, per Arnd's suggestion.
3, remove callback in pdata. but still keep the pdata currently.
4, only keep necessary register in 88pm80x.h, including registers for
regulator/rtc/onkey/power/codec etc, and remove other registers from global
visibility.
5, exported r/w API which requires regmap handle. as currently the pm800
chip has 3 i2c device, only passing a pm80x_chip info can't ensure r/w the
register in correct i2c device.

change log [v1]:
1, pm800 and pm805 are decoupled and probed separately;
2, re-used the most of API for pm800 and pm805 per Arnd's comments;
3, use regmap_irq, instead of previous 88pm80x_irq_data per Mark's comments.
use regmap_add_irq_chip, and remove previous 88pm80x irq handling.
4, remove callback function in rtc pdata per Arnd's comments.
5, updated some coding style issue.

Qiao Zhou (4):
  mfd: support 88pm80x in 80x driver
  mfd: workaround: add companion chip in 88pm80x
  rtc: add rtc support to 88PM80X PMIC
  input: add onkey support to 88PM80X PMIC

 drivers/input/misc/88pm80x_onkey.c |  176 +++++++++++
 drivers/input/misc/Kconfig         |   10 +
 drivers/input/misc/Makefile        |    1 +
 drivers/mfd/88pm800.c              |  594 ++++++++++++++++++++++++++++++++++++
 drivers/mfd/88pm805.c              |  300 ++++++++++++++++++
 drivers/mfd/88pm80x.c              |  145 +++++++++
 drivers/mfd/Kconfig                |   24 ++
 drivers/mfd/Makefile               |    2 +
 drivers/rtc/Kconfig                |   10 +
 drivers/rtc/Makefile               |    1 +
 drivers/rtc/rtc-88pm80x.c          |  371 ++++++++++++++++++++++
 include/linux/mfd/88pm80x.h        |  369 ++++++++++++++++++++++
 12 files changed, 2003 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/88pm80x_onkey.c
 create mode 100644 drivers/mfd/88pm800.c
 create mode 100644 drivers/mfd/88pm805.c
 create mode 100644 drivers/mfd/88pm80x.c
 create mode 100644 drivers/rtc/rtc-88pm80x.c
 create mode 100644 include/linux/mfd/88pm80x.h

