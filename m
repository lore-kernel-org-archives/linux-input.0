From: Lee Jones <lee.jones@linaro.org>
Subject: [GIT PULL] Immutable branch between MFD and Input due for the v4.12
 merge window
Date: Tue, 11 Apr 2017 15:21:21 +0100
Message-ID: <20170411142121.pfblj2oxhymzi2po@dell>
References: <20170321225042.28057-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36591 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753263AbdDKOVZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 11 Apr 2017 10:21:25 -0400
Received: by mail-wm0-f54.google.com with SMTP id o81so64821676wmb.1
        for <linux-input@vger.kernel.org>; Tue, 11 Apr 2017 07:21:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170321225042.28057-1-sre@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Dmitry,

Enjoy!

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-input-v4.12

for you to fetch changes up to 6d99971842f6b0779738d8c168d9ed92ef1ff5fc:

  input: cpcap-pwrbutton: New driver (2017-04-11 15:18:09 +0100)

----------------------------------------------------------------
Immutable branch between MFD and Input due for the v4.12 merge window

----------------------------------------------------------------
Sebastian Reichel (2):
      mfd: cpcap: Implement IRQ sense helper
      input: cpcap-pwrbutton: New driver

 .../devicetree/bindings/input/cpcap-pwrbutton.txt  |  20 ++++
 drivers/input/misc/Kconfig                         |  10 ++
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/cpcap-pwrbutton.c               | 117 +++++++++++++++++++++
 drivers/mfd/motorola-cpcap.c                       |  28 +++++
 include/linux/mfd/motorola-cpcap.h                 |   2 +
 6 files changed, 178 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/cpcap-pwrbutton.txt
 create mode 100644 drivers/input/misc/cpcap-pwrbutton.c

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
