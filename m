From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v2 0/4] Make input drivers y2038 safe
Date: Mon, 17 Oct 2016 20:27:29 -0700
Message-ID: <1476761253-13450-1-git-send-email-deepa.kernel@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33322 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754832AbcJRD1r (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Oct 2016 23:27:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, y2038@lists.linaro.org

Reposting the series as I did not hear comments from the
maintainers.

The series is aimed at making input events y2038 safe.
It extends the lifetime of the realtime timestamps in the
events to year 2106.
The plan is to deprecate realtime timestamps anyway as they
are not appropriate for these timestamps as noted in the patch
a80b83b7b8 by John Stultz.

The series is a result of many discussions with Arnd Bergmann.

The design updates the format of the input events read/ written
to the device nodes. This structure and the uapi/input.h
header file are copied across many userspace libraries.
These libraries not only use this struct input_event locally,
but also expose interfaces that contain input_event. To maintain
backward compatibility with all these interfaces, kernel
updates the format of the input events at the dev node to
struct raw_input_event. Kernel also maintains the old struct
input_event and provides apis to convert between the old and new
input event types.

The userspace library changes to libevdev, libuinput and mtdev
will be posted to the respective mailing groups for review.
Once there is a consensus on the design, all the changes dependent
on the kernel change will be merged at the same time.

Changes from v1:
* Updated changes according to review comments.
* Posted userspace library changes that go along with the series.

Deepa Dinamani (4):
  uinput: Add ioctl for using monotonic/ boot times
  input: evdev: Replace timeval with timespec64
  input: Deprecate real timestamps beyond year 2106
  input: serio: Replace timeval by timespec64

 drivers/input/evdev.c            | 57 ++++++++++++++++++++----------------
 drivers/input/input-compat.c     | 29 ++++++++++---------
 drivers/input/input-compat.h     | 19 +++++++-----
 drivers/input/misc/uinput.c      | 62 +++++++++++++++++++++++++++++++++++++---
 drivers/input/serio/hil_mlc.c    | 37 ++++++++++++------------
 drivers/input/serio/hp_sdc.c     | 17 +++++------
 drivers/input/serio/hp_sdc_mlc.c | 10 +++----
 include/linux/hil_mlc.h          |  6 ++--
 include/linux/hp_sdc.h           |  6 ++--
 include/linux/uinput.h           |  3 +-
 include/uapi/linux/input.h       | 47 ++++++++++++++++++++++++++++++
 include/uapi/linux/uinput.h      |  3 ++
 12 files changed, 208 insertions(+), 88 deletions(-)

-- 
2.7.4

