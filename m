From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.6-rc0 (round 2)
Date: Fri, 25 Mar 2016 14:02:31 -0700
Message-ID: <20160325210231.GA20759@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33315 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbcCYVCf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2016 17:02:35 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive 2nd round of updates for the input subsystem. The BYD PS/2
protocol driver now uses absolute reporting mode and should behave more
like other touchpads; Synaptics driver needed to extend one of its
quirks to a newer firmware version, and a few USB drivers got tightened
up checks for the contents of their descriptors.

Changelog:
---------

Andrew Duggan (1):
      Input: synaptics-rmi4 - remove check of Non-NULL array

Benjamin Tissoires (1):
      Input: synaptics - handle spurious release of trackstick buttons, again

Oliver Neukum (2):
      Input: ims-pcu - sanity check against missing interfaces
      Input: sur40 - fix DMA on stack

Richard Pospesel (1):
      Input: byd - enable absolute mode

Sangwon Jee (1):
      Input: melfas_mip4 - add hw_version sysfs attribute

Vladis Dronov (1):
      Input: ati_remote2 - fix crashes on detecting device with invalid descriptor


Diffstat:
--------

 drivers/input/misc/ati_remote2.c        |  36 +-
 drivers/input/misc/ims-pcu.c            |   4 +
 drivers/input/mouse/byd.c               | 565 +++++++++++++++++++++-----------
 drivers/input/mouse/psmouse-base.c      |   2 +-
 drivers/input/mouse/synaptics.c         |   5 +-
 drivers/input/rmi4/rmi_driver.c         |   5 +-
 drivers/input/touchscreen/melfas_mip4.c |  28 +-
 drivers/input/touchscreen/sur40.c       |  21 +-
 8 files changed, 449 insertions(+), 217 deletions(-)


-- 
Dmitry

