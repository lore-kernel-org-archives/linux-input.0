From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.13-rc7
Date: Fri, 1 Sep 2017 10:25:50 -0700
Message-ID: <20170901172550.GA15089@dtor-ws>
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

to receive updates for the input subsystem. Just a couple drivers fixes
(Synaptics PS/2, Xpad).

Changelog:
---------

Anthony Martin (1):
      Input: synaptics - fix device info appearing different on reconnect

Cameron Gutman (1):
      Input: xpad - fix PowerA init quirk for some gamepad models

Diffstat:
--------

 drivers/input/joystick/xpad.c   | 24 +++++++++++++++++++-----
 drivers/input/mouse/synaptics.c | 35 ++++++++++++++++++++---------------
 2 files changed, 39 insertions(+), 20 deletions(-)

Thanks.

-- 
Dmitry
