From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/4] da9063: convert to SPDX
Date: Mon, 18 Mar 2019 16:57:23 +0100
Message-ID: <20190318155728.28365-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-input@vger.kernel.org, linux-rtc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When working with this driver while debugging something else, I noticed a typo
in one of the file headers and decided that it could be converted to SPDX while
I am at it anyhow.

These patches were "tested" on a Renesas Lager board (R-Car H2). No regressions
encountered. buildbot was happy, too.

The patches are based on v5.1-rc1. I'd think they can be picked up per
subsystem but am also fine with everything going via MFD. There is no
dependency or merge conflict with my platform_data removal series which I sent
a few minutes ago.

Looking forward to comments!

   Wolfram




Wolfram Sang (4):
  mfd: da9063: convert headers to SPDX
  regulator: da9063: convert header to SPDX
  input: da9063_onkey: convert header to SPDX
  rtc: da9063: convert header to SPDX

 drivers/input/misc/da9063_onkey.c    | 11 +----------
 drivers/mfd/da9063-core.c            |  8 ++------
 drivers/mfd/da9063-i2c.c             |  9 ++-------
 drivers/mfd/da9063-irq.c             |  9 ++-------
 drivers/regulator/da9063-regulator.c |  8 +-------
 drivers/rtc/rtc-da9063.c             | 14 +++-----------
 include/linux/mfd/da9063/core.h      |  7 +------
 include/linux/mfd/da9063/registers.h |  7 +------
 8 files changed, 13 insertions(+), 60 deletions(-)

-- 
2.11.0
