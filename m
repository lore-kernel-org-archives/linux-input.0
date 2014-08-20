From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [RESEND PATCH 0/7] Second batch of cleanups for cros_ec
Date: Wed, 20 Aug 2014 14:13:25 +0200
Message-ID: <1408536812-7836-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bill Richardson <wfrichar-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Derek Basehore <dbasehore-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Todd Broch <tbroch-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber-l3A5Bk7waGM@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hello Lee,

This is a resend of a patch series originally sent [0] almost a
month ago (July, 28). The series add a batch of cleanups patches
for the mfd cros_ec driver and its subdevices drivers. The first
batch of cleanups was posted by Doug Anderson [1] and have already
been merged. The patches were taken from the ChromeOS 3.8 kernel
and after this series, no cleanups patches for cros_ec are left.
The remaining commits add support not yet available in mainline.

There is almost no functionality added on this series but the
idea is to reduce the delta between the mainline drivers and
the ones in the downstream Chrome OS 3.8 kernel so the missing
functionality can be added on top once these cleanups patches
are merged. The missing functionlity currently in mainline is:

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

Todd Broch (2):
  mfd: cros_ec: Instantiate sub-devices from device tree
  Input: cros_ec_keyb: Optimize ghosting algorithm.

 drivers/i2c/busses/i2c-cros-ec-tunnel.c |  5 +-
 drivers/input/keyboard/cros_ec_keyb.c   | 89 +++++++++++++++++--------=
--------
 drivers/mfd/cros_ec.c                   | 88 +++++++++++++++++++++++++=
+++----
 drivers/mfd/cros_ec_spi.c               | 20 ++++----
 include/linux/mfd/cros_ec.h             | 24 ++++++---
 5 files changed, 154 insertions(+), 72 deletions(-)

There were no changes on this resend, just picked Acked-by and
Tested-by tags and also added my own Signed-off-by tag to all
the patches as suggested by Andreas F=C3=A4rber even when I just
picked them from downstream and rebased on top of linux-next.

The patches should be merged together which means that they
should go through your mfd tree once the relevant acks are
obtained.

Best regards,
Javier

[0]: https://www.mail-archive.com/linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg11385.=
html
[1]: https://lkml.org/lkml/2014/6/16/681
