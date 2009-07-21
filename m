From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.31-rc3
Date: Mon, 20 Jul 2009 22:54:02 -0700
Message-ID: <20090721055401.GC4671@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754831AbZGUFyJ@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem.

Changelog:
---------

Daniel Mack (1):
      Input: fix EVIOCGNAME/JSIOCGNAME regression

Frans Pop (1):
      Input: pcspkr - switch driver to dev_pm_ops

Giuseppe Mazzotta (1):
      Input: wistron_btns - recognize Maxdata Pro 7000 notebooks

Jerone Young (1):
      Input: atkbd - add force relese key quirk for Soltech TA12

Michael Gruber (1):
      Input: xpad - don't resend successfully sent outgoing requests

Simon Davie (1):
      Input: atkbd - add forced release keys quirk for FSC Amilo Pi 3525


Diffstat:
--------

 drivers/input/evdev.c             |    3 +--
 drivers/input/joydev.c            |    2 +-
 drivers/input/joystick/xpad.c     |   26 +++++++++++++-------------
 drivers/input/keyboard/atkbd.c    |   32 ++++++++++++++++++++++++++++++++
 drivers/input/misc/pcspkr.c       |    8 ++++++--
 drivers/input/misc/wistron_btns.c |    9 +++++++++
 6 files changed, 62 insertions(+), 18 deletions(-)

-- 
Dmitry
