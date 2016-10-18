From: Nick Dyer <nick@shmanahar.org>
Subject: [PATCH v4 0/7]
Date: Wed, 19 Oct 2016 00:34:30 +0100
Message-ID: <20161018233430.GA13162@lava.h.shmanahar.org>
References: <1474404162-29357-1-git-send-email-nick@shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474404162-29357-1-git-send-email-nick@shmanahar.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>
Cc: Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi-

Apologies, I think I hit send too soon on the previous email.

Please find attached patches to add F34 firmware update to the RMI4
driver.

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
