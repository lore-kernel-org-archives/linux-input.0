From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/6] mfd: da9063: remove platform_data
Date: Mon, 18 Mar 2019 16:47:52 +0100
Message-ID: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When working with this driver while debugging something else, I noticed that
there are no in-kernel users of platform_data anymore. Removing the support
simplifies the code and gets rid of quite some lines. The biggest refactoring
went to the regulator driver which could maybe benefit from more
refactorization. However, there is no in-kernel user of that driver, so no
testing. I left it at this stage. I think the changes are still at a level
where review and build-testing will give enough confidence.

Besides the regulator thing, it was tested on a Renesas Lager board (R-Car H2).
No regressions encountered. buildbot was happy, too.

The patches are based on v5.1-rc1. I'd vote for all of them going through the
MFD tree. Looking forward to comments!

   Wolfram


Wolfram Sang (6):
  regulator: da9063: remove platform_data support
  input: da9063_onkey: remove platform_data support
  mfd: da9063: remove platform_data support
  regulator: da9063: move definitions out of a header into the driver
  mfd: da9063: remove leftover platform_data definitions
  regulator: da9063: platform_data is gone, depend on OF

 drivers/input/misc/da9063_onkey.c    |  11 +---
 drivers/mfd/da9063-core.c            |  20 +-----
 drivers/mfd/da9063-i2c.c             |   1 -
 drivers/mfd/da9063-irq.c             |   1 -
 drivers/regulator/Kconfig            |   2 +-
 drivers/regulator/da9063-regulator.c |  61 +++++++++++++------
 include/linux/mfd/da9063/pdata.h     | 114 -----------------------------------
 7 files changed, 49 insertions(+), 161 deletions(-)
 delete mode 100644 include/linux/mfd/da9063/pdata.h

-- 
2.11.0
