From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.17-rc3
Date: Wed, 2 May 2018 11:09:14 -0700
Message-ID: <20180502180914.GA67132@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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

to receive updates for the input subsystem: just a few driver fixes.

Changelog:
---------

Christophe JAILLET (1):
      Input: synaptics-rmi4 - fix an unchecked out of memory error path

Dmitry Torokhov (1):
      Input: leds - fix out of bound access

Javier Martinez Canillas (1):
      Input: atmel_mxt_ts - add missing compatible strings to OF device table

Masanari Iida (1):
      Input: hideep_ts - fix a typo in Kconfig

Nick Dyer (1):
      Input: atmel_mxt_ts - fix the firmware update

Pali Rohár (1):
      Input: alps - fix reporting pressure of v3 trackstick

Vittorio Gambaletta (VittGam) (1):
      Input: atmel_mxt_ts - add touchpad button mapping for Samsung Chromebook Pro

Wolfram Sang (1):
      MAINTAINERS: Rakesh Iyer can't be reached anymore

Diffstat:
--------

 .../devicetree/bindings/input/atmel,maxtouch.txt   |   7 +
 MAINTAINERS                                        |   1 -
 drivers/input/input-leds.c                         |   8 +-
 drivers/input/mouse/alps.c                         |   2 +-
 drivers/input/rmi4/rmi_spi.c                       |   7 +-
 drivers/input/touchscreen/Kconfig                  |   2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           | 200 +++++++++++++--------
 7 files changed, 142 insertions(+), 85 deletions(-)

Thanks.


-- 
Dmitry
