From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD and Input due for the v4.11
 merge window
Date: Wed, 8 Feb 2017 11:39:10 +0000
Message-ID: <20170208113910.bgwmoyttmddvihqj@dell>
References: <20170127105235.4727-1-enric.balletbo@collabora.com>
 <20170201175417.GA40720@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36535 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753313AbdBHLrq (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 8 Feb 2017 06:47:46 -0500
Received: by mail-wm0-f46.google.com with SMTP id c85so193979426wmi.1
        for <linux-input@vger.kernel.org>; Wed, 08 Feb 2017 03:47:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170201175417.GA40720@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>

Dmitry,

> Lee, can you please take it as well?

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-v4.11

for you to fetch changes up to cdd7950e7aa4a4d0d8ba71e3967aae6d25d09b03:

  input: cros_ec_keyb: Add non-matrix buttons and switches (2017-02-08 11:36:23 +0000)

----------------------------------------------------------------
Immutable branch between MFD and Input due for the v4.11 merge window

----------------------------------------------------------------
Douglas Anderson (2):
      mfd: cros-ec: Update cros_ec_commands.h for buttons and switches
      input: cros_ec_keyb: Add non-matrix buttons and switches

 drivers/input/keyboard/cros_ec_keyb.c | 447 ++++++++++++++++++++++++++++++----
 include/linux/mfd/cros_ec_commands.h  |  73 +++++-
 2 files changed, 473 insertions(+), 47 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
