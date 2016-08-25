From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.8-rc3
Date: Thu, 25 Aug 2016 09:31:28 -0700
Message-ID: <20160825163128.GA11206@dtor-ws>
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

to receive updates for the input subsystem (simply small driver fixups).

Changelog:
---------

Andrew Duggan (1):
      Input: synaptics-rmi4 - fix register descriptor subpacket map construction

Dmitry Torokhov (1):
      Input: i8042 - set up shared ps2_cmd_mutex for AUX ports

Hans de Goede (1):
      Input: silead - use devm_gpiod_get

Masahiro Yamada (1):
      Input: tegra-kbc - fix inverted reset logic

Petr Cvek (1):
      Input: ads7846 - remove redundant regulator_disable call


Diffstat:
--------

 drivers/input/keyboard/tegra-kbc.c  | 2 +-
 drivers/input/rmi4/rmi_driver.c     | 3 ++-
 drivers/input/serio/i8042.c         | 1 +
 drivers/input/touchscreen/ads7846.c | 1 -
 drivers/input/touchscreen/silead.c  | 2 +-
 5 files changed, 5 insertions(+), 4 deletions(-)

-- 
Dmitry
