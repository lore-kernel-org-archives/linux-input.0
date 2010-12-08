From: Henrik Rydberg <rydberg@euromail.se>
Subject: [GIT PULL] input: mt updates for 2.6.38
Date: Wed, 08 Dec 2010 10:02:52 +0100
Message-ID: <4CFF49BC.8030202@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Dmitry,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/rydberg/input-mt.git next

to receive input-mt updates for 2.6.38.

The tree contains core changes as well as dependent changes to hid drivers. You
also find the new hid-egalax driver in there, signed off by Jiri.

Thanks,
Henrik

Henrik Rydberg (13):
      input: mt: Break out slots handling
      input: mt: Collect slots initialization code
      input: mt: Add an envelope tool type
      input: mt: Move tracking and pointer emulation to input-mt
      input: mt: Add hovering distance axis
      hid: egalax: Setup input device manually
      hid: egalax: Correct for device resolution report error
      hid: egalax: Report zero as minimum pressure
      hid: egalax: Add event filtering
      hid: egalax: Convert to MT slots
      hid: egalax: Add support for Wetab
      hid: egalax: Document the new devices in Kconfig
      MAINTAINERS: Update input-mt entry

 Documentation/input/multi-touch-protocol.txt |   14 ++-
 MAINTAINERS                                  |    2 +
 drivers/hid/Kconfig                          |    3 +-
 drivers/hid/hid-3m-pct.c                     |   36 +------
 drivers/hid/hid-core.c                       |    1 +
 drivers/hid/hid-egalax.c                     |  127 +++++++++-------------
 drivers/hid/hid-ids.h                        |    1 +
 drivers/input/Makefile                       |    2 +-
 drivers/input/input-mt.c                     |  153 ++++++++++++++++++++++++++
 drivers/input/input.c                        |   48 +--------
 drivers/input/misc/uinput.c                  |    4 +-
 drivers/input/tablet/wacom_wac.c             |   26 +---
 drivers/input/tablet/wacom_wac.h             |    4 -
 drivers/input/touchscreen/wacom_w8001.c      |   25 +---
 include/linux/input-mt.h                     |   56 ++++++++++
 include/linux/input.h                        |   22 +---
 16 files changed, 306 insertions(+), 218 deletions(-)
 create mode 100644 drivers/input/input-mt.c
 create mode 100644 include/linux/input-mt.h
