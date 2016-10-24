From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v5 0/7] Input: synaptics-rmi4 - F34 device reflash support
Date: Mon, 24 Oct 2016 22:51:50 +0100
Message-ID: <1477345917-25326-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout05.plus.net ([84.93.230.250]:57303 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940018AbcJXVwJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Oct 2016 17:52:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi-

Please find attached patches to add F34 firmware update to the RMI4
driver.

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

