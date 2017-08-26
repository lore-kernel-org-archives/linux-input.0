From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.13-rc6
Date: Sat, 26 Aug 2017 12:14:11 -0700
Message-ID: <20170826191411.GA7101@dtor-ws>
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

to receive updates for the input subsystem. You will get:

- a tweak to IBM Trackpoint driver that helps recognizing trackpoints on
  never Lenovo Carbons;

- a fix to ALPS driver solving scroll issues on some Dells;

- yet another ACPI ID has been added to Elan I2C toucpad driver;

- quieted diagnostic message in soc_button_array driver.

Thanks!


Changelog:
---------

Aaron Ma (1):
      Input: trackpoint - add new trackpoint firmware ID

Hans de Goede (1):
      Input: soc_button_array - silence -ENOENT error on Dell XPS13 9365

KT Liao (1):
      Input: elan_i2c - add ELAN0602 ACPI ID to support Lenovo Yoga310

Masaki Ota (1):
      Input: ALPS - fix two-finger scroll breakage in right side on ALPS touchpad

Diffstat:
--------

 drivers/input/misc/soc_button_array.c |  2 +-
 drivers/input/mouse/alps.c            | 41 ++++++++++++++++++++++++++---------
 drivers/input/mouse/alps.h            |  8 +++++++
 drivers/input/mouse/elan_i2c_core.c   |  1 +
 drivers/input/mouse/trackpoint.c      |  3 ++-
 drivers/input/mouse/trackpoint.h      |  3 ++-
 6 files changed, 45 insertions(+), 13 deletions(-)

-- 
Dmitry
