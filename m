From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v6 0/2] Input: synaptics-rmi4 - F34 device reflash support
Date: Sun, 20 Nov 2016 19:04:00 +0000
Message-ID: <1479668642-376-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Dmitry-

Please find an updated set of patches to add F34 firmware update to the RMI4
driver.

Changes in v6:
- Properly free irq_memory in rmi_free_function_list()
- Split out the sysfs changes for now
- Various coding style improvements to the V7 patch (now checkpatch clean)

Changes in v5:
- Improve split between for different versions (req. Bjorn Andersson)
- Address a couple of kbuild test robot issues
- Fix a bug with configuration ID on V7

Changes in v4:
- Add support for v7 bootloaders and fix numerous issues
- Add sysfs attributes for retrieving various hardware IDs
- Add a couple of debug lines to core

Changes in v3:
- Only attempt to flash on F34 V0 (later versions have different
  register map)

Changes in v2:
- Resolved reliability issues with locking and teardown/re-probe
- Add #ifdefs for CONFIG_RMI4_F34 in rmi_driver.c
- Slightly improve debug
- Tested by Chris Healy

cheers

Nick
