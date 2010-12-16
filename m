From: Henrik Rydberg <rydberg@euromail.se>
Subject: [GIT PULL] input: mt updates for 2.6.38
Date: Thu, 16 Dec 2010 12:37:06 +0100
Message-ID: <4D09F9E2.6060900@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:40476 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754691Ab0LPLiH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Dec 2010 06:38:07 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Dmitry,

Please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/rydberg/input-mt.git next

to re-receive input-mt updates for 2.6.38.

As a one-time measure, the tree has been rewound all the way to 2.6.37-rc1, to
keep our trees at a common checkpoint. Hereafter, the branch will be kept stable
and synchronized at a common checkpoint.

Content-wise, the filename change has been folded into the first commit. The
finger-count report and the trkid documentation have been folded into the commit
where they are introduced. Furthermore, MT_TOOL_ENVELOPE has been dropped
completely, and is going to be replaced by an input device quirk. The overall
documentation changes have been held back for another respin. Lastly, another
device patch has been added to hid-egalax.

Thanks,
Henrik

Dmitry Torokhov (1):
      Input: include MT library as source for kerneldoc

Henrik Rydberg (12):
      input: mt: Break out slots handling
      input: mt: Collect slots initialization code
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

Richard Nauber (1):
      hid: egalax: Add support for Samsung NB30 netbook

 Documentation/DocBook/device-drivers.tmpl    |    4 +
 Documentation/input/multi-touch-protocol.txt |    9 ++-
 MAINTAINERS                                  |    2 +
 drivers/hid/Kconfig                          |    3 +-
 drivers/hid/hid-3m-pct.c                     |   36 +-----
 drivers/hid/hid-core.c                       |    2 +
 drivers/hid/hid-egalax.c                     |  129 ++++++++-----------
 drivers/hid/hid-ids.h                        |    2 +
 drivers/input/Makefile                       |    2 +-
 drivers/input/input-mt.c                     |  170 ++++++++++++++++++++++++++
 drivers/input/input.c                        |   48 +-------
 drivers/input/misc/uinput.c                  |    4 +-
 drivers/input/tablet/wacom_wac.c             |   26 +---
 drivers/input/tablet/wacom_wac.h             |    4 -
 drivers/input/touchscreen/wacom_w8001.c      |   25 +---
 include/linux/input.h                        |   22 +---
 include/linux/input/mt.h                     |   57 +++++++++
 17 files changed, 329 insertions(+), 216 deletions(-)
 create mode 100644 drivers/input/input-mt.c
 create mode 100644 include/linux/input/mt.h
