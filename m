From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.9-rc3
Date: Sat, 5 Nov 2016 11:09:38 -0700
Message-ID: <20161105180938.GA3574@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem.

Changelog:
---------

Dmitry Tunin (1):
      Input: psmouse - cleanup Focaltech code

Patrick Scheuring (1):
      Input: i8042 - add XMG C504 to keyboard reset table


Diffstat:
--------

 drivers/input/mouse/focaltech.c       | 6 +++---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
Dmitry
