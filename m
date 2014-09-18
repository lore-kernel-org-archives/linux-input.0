From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v4 0/5] Second batch of cleanups for cros_ec
Date: Thu, 18 Sep 2014 17:18:53 +0200
Message-ID: <1411053538-17237-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:40971 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756730AbaIRPTM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Sep 2014 11:19:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Gwendal Grignou <gwendal@google.com>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Hello,

This is a second batch of cleanups patches for the mfd cros_ec
driver and its subdevices drivers. The first batch of cleanups
was posted by Doug Anderson [0] and have already been merged.
The patches were picked from the ChromeOS 3.8 kernel and after
these no cleanups patches for cros_ec are left, only commits
that add cros ec support not yet available in mainline.

This is a fourth version of the patch series that addresses
issues pointed out by Lee Jones on v3 [1]. I dropped patch #6
from this version since that change will make more sense once
the cros_ec_dev driver is added and the cells array isn't empty.

There is almost no functionality added on this series but the
idea is to reduce the delta between the mainline drivers and
the ones in the downstream Chrome OS 3.8 kernel so the missing
functionality can be added on top once these cleanups patches
are merged. The missing functionality currently in mainline is:

- Chrome OS Embedded Controller userspace device interface
- Chrome OS Embedded Controller Low Pin Count (LPC) inteface
- Access to vboot context stored on a block device
- Access to vboot context stored on EC's nvram

The patches in this series are authored by different people
(all on cc) and consist of the following:

Andrew Bresticker (3):
  mfd: cros_ec: stop calling ->cmd_xfer() directly
  mfd: cros_ec: move locking into cros_ec_cmd_xfer
  mfd: cros_ec: wait for completion of commands that return IN_PROGRESS

Derek Basehore (1):
  i2c: i2c-cros-ec-tunnel: Set retries to 3

Doug Anderson (1):
  mfd: cros_ec: Delay for 50ms when we see EC_CMD_REBOOT_EC

 drivers/i2c/busses/i2c-cros-ec-tunnel.c |  5 +++-
 drivers/input/keyboard/cros_ec_keyb.c   |  2 +-
 drivers/mfd/cros_ec.c                   | 48 +++++++++++++++++++++++++++++++++
 drivers/mfd/cros_ec_spi.c               | 20 +++++++-------
 include/linux/mfd/cros_ec.h             | 24 ++++++++++++-----
 5 files changed, 80 insertions(+), 19 deletions(-)

Patches #1 and #2 can be applied independently but patches #3, #4 and #5
rely on the previous one so they should be applied together and in that order.

Best regards,
Javier

[0]: https://www.mail-archive.com/linux-input@vger.kernel.org/msg11385.html
[1]: https://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg36505.html

