From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.17-rc7
Date: Tue, 29 May 2018 16:38:34 -0700
Message-ID: <20180529233834.GA50727@dtor-ws>
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

to receive updates for the input subsystem. We are switching a bunch of
Lenovo devices with Synaptics touchpads from PS/2 emulation over to
native RMI/SMbus.

Given that all commits are marked for stable there is no point delaying
them till next release.

Thanks!

Changelog:
---------

Aaron Ma (1):
      Input: synaptics - add Intertouch support on X1 Carbon 6th and X280

Benjamin Tissoires (2):
      Input: synaptics - add Lenovo 80 series ids to SMBus
      Input: elan_i2c_smbus - fix corrupted stack

Dmitry Torokhov (1):
      Input: synaptics - Lenovo Carbon X1 Gen5 (2017) devices should use RMI

Edvard Holst (1):
      Input: synaptics - Lenovo Thinkpad X1 Carbon G5 (2017) with Elantech trackpoints should use RMI

Diffstat:
--------

 drivers/input/mouse/elan_i2c_smbus.c | 22 +++++++++++-----------
 drivers/input/mouse/synaptics.c      |  6 ++++++
 2 files changed, 17 insertions(+), 11 deletions(-)

Thanks.


-- 
Dmitry
