From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v3 0/4] HID: hid-lg4ff: Improve handling of Logitech multimode wheels
Date: Wed, 18 Feb 2015 17:59:19 +0100
Message-ID: <1424278763-29072-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, simon@mungewell.org, elias.vds@gmail.com, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

This patch series improves handling of various Logitech gaming wheels a=
nd
allows switching between various compatibility modes which might be use=
ful
to improve compatibility with very old games and testing purposes.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>

v3: - Marked all internal functions static
    - Moved function and external variable declarations to hid-lg4ff.h

v2: - Rebased against latest linux-next
    - Document the newly introduced sysfs interfaces in appropriate com=
mits
    - Assume that we are targeting kernel version 4.1
    - Fix a misleading error message regarding unsupported wheel mode

Michal Mal=C3=BD (4):
  Identify Logitech gaming wheels in compatibility modes accordingly to
    Logitech specifications
  Display the real wheel model and supported alternate modes through
    sysfs. This applies only to multimode wheels.
  Introduce a module parameter to disable automatic switch of Logitech
    gaming wheels from compatibility to native mode. This only applies
    to multimode wheels.
  Allow switching of Logitech gaming wheels between available
    compatibility modes through sysfs. This only applies to multimode
    wheels.

 .../ABI/testing/sysfs-driver-hid-logitech-lg4ff    |  45 ++
 drivers/hid/hid-lg.c                               |   7 +
 drivers/hid/hid-lg.h                               |  12 -
 drivers/hid/hid-lg4ff.c                            | 605 +++++++++++++=
+++++---
 drivers/hid/hid-lg4ff.h                            |  18 +
 5 files changed, 599 insertions(+), 88 deletions(-)
 create mode 100644 drivers/hid/hid-lg4ff.h

--=20
2.3.0
