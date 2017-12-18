From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v5 0/3] Make input drivers y2038 safe
Date: Sun, 17 Dec 2017 21:18:41 -0800
Message-ID: <20171218051844.10193-1-deepa.kernel@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pl0-f66.google.com ([209.85.160.66]:46331 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751929AbdLRFTR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 18 Dec 2017 00:19:17 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: peter.hutterer@who-t.net, arnd@arndb.de, y2038@lists.linaro.org

The series is aimed at making input events y2038 safe.
It extends the lifetime of the realtime timestamps in the
events to year 2106.
The series is also a necessary update as glibc is set to provide
64 bit time_t support for 32 bit binaries. glibc plan is detailed
at https://sourceware.org/glibc/wiki/Y2038ProofnessDesign .

The series is a result of discussions with Arnd Bergmann and
Dmitry Torokhov at last Plumbers.

The plan is to deprecate realtime timestamps anyway as they
are not appropriate for these timestamps as noted in the patch
a80b83b7b8 by John Stultz.

The design also updates the format of the input events read/ written
to the device nodes. This breaks 32 bit interface to the input
events at compile time as preferred by the maintainer.

The userspace library changes to libevdev, libuinput and mtdev
will be posted to the respective mailing groups for review.

Changes from v4:
* Dropped serio hil patch
Changes from v3:
* Updated uinput to support monotonic time only
* Addressed review comments
Changes from v2:
* Updated the design to break 32 bit interfaces at compile time.
Changes from v1:
* Updated changes according to review comments.
* Posted userspace library changes that go along with the series.

Deepa Dinamani (3):
  uinput: Use monotonic times for uinput timestamps.
  input: evdev: Replace timeval with timespec64
  input: Deprecate real timestamps beyond year 2106

 drivers/input/evdev.c        | 43 +++++++++++++++++++++++++++----------------
 drivers/input/input-compat.c | 11 ++++++-----
 drivers/input/input-compat.h |  3 ++-
 drivers/input/misc/uinput.c  |  5 ++++-
 include/uapi/linux/input.h   | 12 +++++++++++-
 5 files changed, 50 insertions(+), 24 deletions(-)


base-commit: 0c1f9d81ac360d8ad31cbfd2bdcf44de8204188e
-- 
2.14.1

