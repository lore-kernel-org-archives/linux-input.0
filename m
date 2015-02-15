From: =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>
Subject: [PATCH v2 0/4] HID: hid-lg4ff: Improve handling of Logitech multimode gaming wheels
Date: Sun, 15 Feb 2015 03:03:01 +0100
Message-ID: <1423965785-22930-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gitweb.devoid-pointer.net ([31.31.77.140]:40500 "EHLO
	smtp.devoid-pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754380AbbBOCEF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Feb 2015 21:04:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, simon@mungewell.org, elias.vds@gmail.com, =?UTF-8?q?Michal=20Mal=C3=BD?= <madcatxster@devoid-pointer.net>

This patch series improves handling of various Logitech gaming wheels a=
nd
allows switching between various compatibility modes which might be use=
ful
to improve compatibility with very old games and testing purposes.

Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>

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
 drivers/hid/hid-lg.c                               |   6 +
 drivers/hid/hid-lg4ff.c                            | 605 +++++++++++++=
+++++---
 3 files changed, 580 insertions(+), 76 deletions(-)

--=20
2.3.0

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
