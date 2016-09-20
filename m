From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v3 0/2] Input: synaptics-rmi4 - F34 device reflash support
Date: Tue, 20 Sep 2016 21:42:40 +0100
Message-ID: <1474404162-29357-1-git-send-email-nick@shmanahar.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:56011 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbcITUmu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Sep 2016 16:42:50 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi-

Please find attached patches to add F34 firmware update to the RMI4 driver.

Git tree here:
https://github.com/ndyer/linux/commits/synaptics-fw-update-v3-2016-09-20

Changes in v3:
- Only attempt to flash on F34 V0 (later versions have different register map)

Changes in v2:
- Resolved reliability issues with locking and teardown/re-probe
- Add #ifdefs for CONFIG_RMI4_F34 in rmi_driver.c
- Slightly improve debug
- Tested by Chris Healy

cheers

Nick

