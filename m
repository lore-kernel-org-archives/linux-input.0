From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 0/4] Make input drivers y2038 safe
Date: Tue, 13 Sep 2016 07:10:01 -0700
Message-ID: <1473775805-2242-1-git-send-email-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, y2038@lists.linaro.org
List-Id: linux-input@vger.kernel.org

The series is aimed at making input events y2038 safe.
It extends the lifetime of the realtime timestamps in the
events to year 2106.
The plan is to deprecate realtime timestamps anyway as they
are not appropriate for these timestamps as noted in the patch
a80b83b7b8 by John Stultz.

The series is a result of many discussions with Arnd Bergmann.

Deepa Dinamani (4):
  uinput: Add ioctl for using monotonic/ boot times
  input: evdev: Replace timeval with timespec64
  input: Deprecate real timestamps beyond year 2106
  input: serio: Replace timeval by timespec64

 drivers/input/evdev.c            | 30 +++++++++++--------
 drivers/input/input-compat.c     | 25 ++++++++--------
 drivers/input/input-compat.h     | 19 +++++++-----
 drivers/input/misc/uinput.c      | 64 +++++++++++++++++++++++++++++++++++++---
 drivers/input/serio/hil_mlc.c    | 37 +++++++++++------------
 drivers/input/serio/hp_sdc.c     | 17 ++++++-----
 drivers/input/serio/hp_sdc_mlc.c | 10 +++----
 include/linux/hil_mlc.h          |  6 ++--
 include/linux/hp_sdc.h           |  6 ++--
 include/linux/uinput.h           |  3 +-
 include/uapi/linux/input.h       | 37 +++++++++++++++++++++++
 include/uapi/linux/uinput.h      |  3 ++
 12 files changed, 183 insertions(+), 74 deletions(-)

-- 
2.7.4
