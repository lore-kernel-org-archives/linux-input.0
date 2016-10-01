From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.8-rc8
Date: Fri, 30 Sep 2016 18:32:31 -0700
Message-ID: <20161001013231.GA16135@dtor-ws>
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

to receive updates for the input subsystem. One small change to make
joydev (which is used by older games) to bind to devices that export Z
axis but not X or Y (such as TRC rudder).

Changelog:
---------

Ville Ranki (1):
      Input: joydev - recognize devices with Z axis as joysticks


Diffstat:
--------

 drivers/input/joydev.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
Dmitry
