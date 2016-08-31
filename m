From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD and Input due for the v4.9
 merge window
Date: Wed, 31 Aug 2016 12:05:53 +0100
Message-ID: <20160831110553.GE27357@dell>
References: <1470848725-32405-1-git-send-email-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35078 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932622AbcHaLEM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 31 Aug 2016 07:04:12 -0400
Received: by mail-wm0-f43.google.com with SMTP id w2so25674072wmd.0
        for <linux-input@vger.kernel.org>; Wed, 31 Aug 2016 04:04:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1470848725-32405-1-git-send-email-enric.balletbo@collabora.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Vic Yang <victoryang@google.com>, Olof Johansson <olof@lixom.net>, Gwendal Grignou <gwendal@chromium.org>, Brian Norris <briannorris@chromium.org>

Enjoy!

The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d:

  Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-input-v4.9

for you to fetch changes up to 44051a6825d58c02820c07ded54a010479460308:

  Input: cros_ec_keyb: Stop handling interrupts directly (2016-08-31 10:51:09 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Input due for the v4.9 merge window

----------------------------------------------------------------
Vic Yang (2):
      mfd: cros_ec: Add MKBP event support
      Input: cros_ec_keyb: Stop handling interrupts directly

 drivers/input/keyboard/cros_ec_keyb.c   | 135 ++++++++------------------------
 drivers/mfd/cros_ec.c                   |  58 +++++++++++++-
 drivers/platform/chrome/cros_ec_proto.c |  92 ++++++++++++++++++++++
 include/linux/mfd/cros_ec.h             |  18 +++++
 include/linux/mfd/cros_ec_commands.h    |  34 ++++++++
 5 files changed, 230 insertions(+), 107 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
