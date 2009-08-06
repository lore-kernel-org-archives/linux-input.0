From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.31-rc5
Date: Wed, 5 Aug 2009 22:24:42 -0700
Message-ID: <20090806052443.E4B24526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753715AbZHFFYs@vger.kernel.org>
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

Eric Miao (1):
      Input: matrix_keypad - make matrix keymap size dynamic

Jory A. Pratt (1):
      Input: i8042 - add Asus G1S to noloop exception list

TJ (1):
      Input: wistron_btns - support Prestigio Wifi RF kill button


Diffstat:
--------

 drivers/input/keyboard/matrix_keypad.c |   18 +++++++++---------
 drivers/input/misc/wistron_btns.c      |   16 ++++++++++++++++
 drivers/input/serio/i8042-x86ia64io.h  |    8 ++++++++
 include/linux/input/matrix_keypad.h    |   13 +++++++------
 4 files changed, 40 insertions(+), 15 deletions(-)

-- 
Dmitry
