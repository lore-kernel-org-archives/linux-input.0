From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD and HWMON due for the v4.14
 merge window
Date: Tue, 22 Aug 2017 08:47:41 +0100
Message-ID: <20170822074741.jjynyudbfgzsl7ju@dell>
References: <20170821145404.18902-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170821145404.18902-1-sebastian.reichel@collabora.co.uk>
Sender: linux-hwmon-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Enjoy!

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-hwmon-v4.14

for you to fetch changes up to 4f16cab19a3d57638dd5d962ff6e87c154a6cab2:

  hwmon: da9052: Add support for TSI channel (2017-08-22 08:45:02 +0100)

----------------------------------------------------------------
Immutable branch between MFD and HWMON due for the v4.14 merge window

----------------------------------------------------------------
Sebastian Reichel (4):
      mfd: da9052: Add register details for TSI
      hwmon: da9052: Replace S_IRUGO with 0444
      mfd: da9052: Make touchscreen registration optional
      hwmon: da9052: Add support for TSI channel

 drivers/hwmon/da9052-hwmon.c      | 285 +++++++++++++++++++++++++++++++++++---
 drivers/mfd/da9052-core.c         |  26 +++-
 include/linux/mfd/da9052/da9052.h |   6 +
 include/linux/mfd/da9052/reg.h    |  11 +-
 4 files changed, 302 insertions(+), 26 deletions(-)
 
-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
