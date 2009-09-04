From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.31-rc8
Date: Thu, 3 Sep 2009 22:05:24 -0700
Message-ID: <20090904053822.CCA13526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752375AbZIDFF2@vger.kernel.org>
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

Dave Andrews (1):
      Input: atkbd - add Compaq Presario R4000-series repeat quirk

Dmitry Torokhov (1):
      Input: i8042 - add Acer Aspire 5536 to the nomux list


Diffstat:
--------

 drivers/input/keyboard/atkbd.c        |   35 +++++++++++++++++++++++++++++++++
 drivers/input/serio/i8042-x86ia64io.h |    8 +++++++
 2 files changed, 43 insertions(+), 0 deletions(-)

-- 
Dmitry
