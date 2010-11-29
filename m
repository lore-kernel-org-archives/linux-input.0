From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [PATCH 0/4] input: mt: Driver interface simplifications
Date: Mon, 29 Nov 2010 08:13:18 +0100
Message-ID: <1291014802-17061-1-git-send-email-rydberg@euromail.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>
List-Id: linux-input@vger.kernel.org

Hi Dmitry, Jiri,

This is the first patchset in a series, aiming to simplify the MT
slots driver interface, provide common emulation code, a software
tracking module, and of course updates to drivers.

The first patch moves the slots initialization over to a new file, and
the second patch collects common code. The third patch moves handling
of ABS_MT_TRACKIND_ID to the input core, and aligns the current
drivers. Please note the subsystem overlap here. The fourth patch
prepares for the next patchset, which is against the hid-egalax
driver.

The patches are against 2.6.37-rc3.

Cheers,
Henrik

Henrik Rydberg (4):
  input: mt: Break out slots handling
  input: mt: Collect slots initialization code
  input: mt: Move tracking and pointer emulation to input-mt
  input: mt: Add pressure to pointer emulation code

 drivers/hid/hid-3m-pct.c                |   36 +-------
 drivers/input/Makefile                  |    2 +-
 drivers/input/input-mt.c                |  137 +++++++++++++++++++++++++++++++
 drivers/input/input.c                   |   48 +-----------
 drivers/input/misc/uinput.c             |    4 +-
 drivers/input/tablet/wacom_wac.c        |   11 +--
 drivers/input/tablet/wacom_wac.h        |    4 -
 drivers/input/touchscreen/wacom_w8001.c |   17 +---
 include/linux/input-mt.h                |   55 ++++++++++++
 include/linux/input.h                   |   17 +----
 10 files changed, 209 insertions(+), 122 deletions(-)
 create mode 100644 drivers/input/input-mt.c
 create mode 100644 include/linux/input-mt.h
