From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.20-rc7
Date: Fri, 21 Dec 2018 01:12:58 -0800
Message-ID: <20181221091258.GA63423@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Switching a few devices with
Synaptics over to SMbus and disabling SMbus on a couple devices with
Elan touchpads as they need more plumbing on PS/2 side.

Changelog:
---------

Benjamin Tissoires (1):
      Input: elantech - disable elan-i2c for P52 and P72

Mantas Mikulėnas (1):
      Input: synaptics - enable SMBus for HP EliteBook 840 G4

Tony Lindgren (1):
      Input: omap-keypad - fix idle configuration to not block SoC idle states

Yussuf Khalil (1):
      Input: synaptics - enable RMI on ThinkPad T560

Diffstat:
--------

 drivers/input/keyboard/omap4-keypad.c | 16 ++++------------
 drivers/input/mouse/elantech.c        | 18 ++++++++++++++++--
 drivers/input/mouse/synaptics.c       |  2 ++
 3 files changed, 22 insertions(+), 14 deletions(-)

Thanks.


-- 
Dmitry
