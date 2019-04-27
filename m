From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v5.1-rc6
Date: Sat, 27 Apr 2019 15:38:54 -0700
Message-ID: <20190427223854.GA97206@dtor-ws>
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

to receive updates for the input subsystem. Just a couple of fixups for
Synaptics RMI4 driver and allowing snvs_pwrkey to be selected on more
boards.

Changelog:
---------

Jacky Bai (1):
      Input: snvs_pwrkey - make it depend on ARCH_MXC

Lucas Stach (1):
      Input: synaptics-rmi4 - write config register values to the right offset

Pan Bian (1):
      Input: synaptics-rmi4 - fix possible double free

Diffstat:
--------

 drivers/input/keyboard/Kconfig  | 2 +-
 drivers/input/rmi4/rmi_driver.c | 6 +-----
 drivers/input/rmi4/rmi_f11.c    | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

Thanks.


-- 
Dmitry
