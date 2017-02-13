From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] Subsequent immutable branch between MFD and Input due for
 the v4.11 merge window
Date: Mon, 13 Feb 2017 09:28:24 +0000
Message-ID: <20170213092824.szf7x6nsvbu2ehmw@dell>
References: <20170127105235.4727-1-enric.balletbo@collabora.com>
 <20170201175417.GA40720@dtor-ws>
 <20170208113910.bgwmoyttmddvihqj@dell>
 <7bb05b51-4cc2-9b19-0eca-7a318b9d9433@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7bb05b51-4cc2-9b19-0eca-7a318b9d9433@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
List-Id: linux-input@vger.kernel.org

Dmitry,

Enjoy!

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-v4.11-1

for you to fetch changes up to 6ccc3a33810e8ec09936fa990c13370d9f61606f:

  input: cros_ec_keyb: Add Tablet Mode switch (2017-02-13 09:25:19 +0000)

----------------------------------------------------------------
Subsequent immutable branch between MFD and Input due for the v4.11 merge window

----------------------------------------------------------------
Douglas Anderson (2):
      mfd: cros-ec: Update cros_ec_commands.h for buttons and switches
      input: cros_ec_keyb: Add non-matrix buttons and switches

Gwendal Grignou (1):
      input: cros_ec_keyb: Add Tablet Mode switch

 drivers/input/keyboard/cros_ec_keyb.c | 452 ++++++++++++++++++++++++++++++----
 include/linux/mfd/cros_ec_commands.h  |  74 +++++-
 2 files changed, 479 insertions(+), 47 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
