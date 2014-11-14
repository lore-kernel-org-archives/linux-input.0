From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 3.18-rc4
Date: Fri, 14 Nov 2014 14:26:40 -0800
Message-ID: <20141114222640.GA39748@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:63148 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161920AbaKNW0p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Nov 2014 17:26:45 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Mostly small fixups to PS/2
tochpad drivers (ALPS, Elantech, Synaptics) to better deal with specifi=
c
hardware.

Changelog:
---------

NeilBrown (1):
      Input: twl4030-pwrbutton - ensure a wakeup event is recorded.

Pali Roh=E1r (3):
      Input: alps - ignore potential bare packets when device is out of=
 sync
      Input: alps - allow up to 2 invalid packets without resetting dev=
ice
      Input: alps - ignore bad data on Dell Latitudes E6440 and E7440

Takashi Iwai (1):
      Input: synaptics - add min/max quirk for Lenovo T440s

Ulrik De Bie (5):
      Input: elantech - use elantech_report_trackpoint for hardware v4 =
too
      Input: elantech - fix crc_enabled for Fujitsu H730
      Input: elantech - report the middle button of the touchpad
      Input: elantech - provide a sysfs knob for crc_enabled
      Input: elantech - update the documentation


Diffstat:
--------

 Documentation/input/elantech.txt       | 81 ++++++++++++++++++++++++++=
+++++---
 drivers/input/misc/twl4030-pwrbutton.c |  1 +
 drivers/input/mouse/alps.c             | 28 +++++++++++-
 drivers/input/mouse/elantech.c         | 56 +++++++++++++++++++++--
 drivers/input/mouse/synaptics.c        |  5 ++-
 5 files changed, 158 insertions(+), 13 deletions(-)

--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
