From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.0-rc3
Date: Mon, 9 Mar 2015 17:08:09 -0700
Message-ID: <20150310000809.GD22993@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:43810 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbbCJAIN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Mar 2015 20:08:13 -0400
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

to receive updates for the input subsystem: miscellaneous driver fixes.

Changelog:
---------

Arnd Bergmann (1):
      Input: sun4i-ts - add thermal driver dependency

Dmitry Torokhov (1):
      Input: ALPS - fix memory leak when detection fails

Dudley Du (1):
      Input: cyapa - fix unaligned functions redefinition error

Geert Uytterhoeven (1):
      Input: cyapa - remove superfluous type check in cyapa_gen5_read_idac_data()

Mathias Gottschlag (4):
      Input: psmouse - remove hardcoded touchpad size from the focaltech driver
      Input: psmouse - ensure that focaltech reports consistent coordinates
      Input: psmouse - disable changing resolution/rate/scale for FocalTech
      Input: psmouse - disable "palm detection" in the focaltech driver

Stefan Sauer (1):
      Input: mma8450 - add parent device

Valentin Rothberg (1):
      Input: tc3589x-keypad - set IRQF_ONESHOT flag to ensure IRQ request


Diffstat:
--------

 drivers/input/keyboard/tc3589x-keypad.c |  6 ++--
 drivers/input/misc/mma8450.c            |  1 +
 drivers/input/mouse/alps.c              |  4 ++-
 drivers/input/mouse/cyapa_gen3.c        |  2 +-
 drivers/input/mouse/cyapa_gen5.c        |  4 +--
 drivers/input/mouse/focaltech.c         | 50 +++++++++++++++++++++++----------
 drivers/input/mouse/psmouse-base.c      | 14 ++++++++-
 drivers/input/mouse/psmouse.h           |  6 ++++
 drivers/input/touchscreen/Kconfig       |  1 +
 9 files changed, 65 insertions(+), 23 deletions(-)

-- 
Dmitry

