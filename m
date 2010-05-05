From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.34-rc6
Date: Tue, 4 May 2010 23:41:34 -0700
Message-ID: <20100505064133.GA12329@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f204.google.com ([209.85.222.204]:38065 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352Ab0EEGli (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 02:41:38 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Nothing super exciting but
owners of newer touchpads will get a bit happier.

Changelog:
---------

Christoph Fritz (1):
      Input: joydev - allow binding to button-only devices

Daniel Mack (1):
      Input: eeti_ts - cancel pending work when going to suspend

Dmitry Torokhov (2):
      Input: psmouse - ignore parity error for basic protocols
      Revert "Input: ALPS - add signature for HP Pavilion dm3 laptops"

Florian Ragwitz (3):
      Input: elantech - fix firmware version check
      Input: elantech - allow forcing Elantech protocol
      Input: elantech - ignore high bits in the position coordinates

Jarod Wilson (1):
      Input: ati_remote - add some missing devices from lirc_atiusb

Takashi Iwai (1):
      Input: Add support of Synaptics Clickpad device


Diffstat:
--------

 Documentation/input/elantech.txt    |    8 ++--
 drivers/input/joydev.c              |   18 +++++++
 drivers/input/misc/ati_remote.c     |   14 ++++--
 drivers/input/mouse/alps.c          |    1 -
 drivers/input/mouse/elantech.c      |   84 +++++++++++++++++++++++------------
 drivers/input/mouse/psmouse-base.c  |   18 ++++++-
 drivers/input/mouse/psmouse.h       |    1 +
 drivers/input/mouse/synaptics.c     |   35 ++++++++++++--
 drivers/input/mouse/synaptics.h     |    4 ++
 drivers/input/touchscreen/eeti_ts.c |   56 +++++++++++++++++++----
 10 files changed, 183 insertions(+), 56 deletions(-)

-- 
Dmitry

