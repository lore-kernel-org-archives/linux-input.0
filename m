From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH 0/4] HID: Improve handling of multimode Logitech handling wheels
Date: Fri,  6 Feb 2015 17:34:42 +0100
Message-ID: <1423240486-6714-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: simon@mungewell.org, elias.vds@gmail.com, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
List-Id: linux-input@vger.kernel.org

This patch series improves handling of various Logitech gaming wheels a=
nd
allows switching between various compatibility modes which might be use=
ful
to improve compatibility with very old games and testing purposes.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>=20

Michal Mal=C3=BD (4):
  Identify Logitech gaming wheels in compatibility modes accordingly to=
=20
       Logitech specifications
  Display the real wheel model and supported alternate modes through   =
=20
    sysfs. This applies only to multimode wheels.
  Introduce a module parameter to disable automatic switch of Logitech =
=20
      gaming wheels from compatibility to native mode. This only applie=
s
    to     multimode wheels.
  Allow switching of Logitech gaming wheels between available
    compatibility modes through sysfs. This only applies to multimode
    wheels.

 .../ABI/testing/sysfs-driver-hid-logitech-lg4ff    |  45 ++
 drivers/hid/hid-lg.c                               |   6 +
 drivers/hid/hid-lg4ff.c                            | 608 +++++++++++++=
+++++---
 3 files changed, 583 insertions(+), 76 deletions(-)

--=20
2.2.2
