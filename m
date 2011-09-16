From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 3.1-rc6
Date: Thu, 15 Sep 2011 23:22:00 -0700
Message-ID: <20110916062200.GA6731@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://github.com/dtor/input.git for-linus

to receive updates for the input subsystem.

Changelog:
---------

Axel Lin (2):
      Input: cm109 - fix checking return value of usb_control_msg
      Input: adp5588-keys - remove incorrect modalias

Chris Bagwell (1):
      Input: wacom - fix touch parsing on newer Bamboos

Jason Gerecke (2):
      Input: wacom - advertise BTN_TOOL_PEN and BTN_STYLUS for PenPartner
      Input: wacom - add POINTER and DIRECT device properties

Pieter-Augustijn Van Malleghem (1):
      Input: bcm5974 - add MacBookAir4,1 trackpad support

Ping Cheng (1):
      Input: wacom - remove pressure for touch devices


Diffstat:
--------

 drivers/hid/hid-wacom.c                 |    2 +
 drivers/input/keyboard/adp5588-keys.c   |    1 -
 drivers/input/misc/cm109.c              |    2 +-
 drivers/input/mouse/bcm5974.c           |   20 +++++++++++++
 drivers/input/tablet/wacom_sys.c        |   14 ---------
 drivers/input/tablet/wacom_wac.c        |   45 ++++++++++++++++++++++++-------
 drivers/input/touchscreen/wacom_w8001.c |    2 +
 7 files changed, 60 insertions(+), 26 deletions(-)

-- 
Dmitry
