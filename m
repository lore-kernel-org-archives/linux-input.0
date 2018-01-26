From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.15-rc9
Date: Thu, 25 Jan 2018 17:17:33 -0800
Message-ID: <20180126011733.ocuj5gsrelcd2n7x@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40277 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbeAZBRh (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 Jan 2018 20:17:37 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. The main item is that we try
to handle better newer trackpoints on Lenovo devices that now being
produced by Elan/ALPS/NXP and only implement a small subset of the
original IBM trackpoint controls.

Changelog:
---------

Aaron Ma (1):
      Input: trackpoint - force 3 buttons if 0 button is reported

Andi Shyti (1):
      Input: stmfts,s6sy671 - add SPDX identifier

Dmitry Torokhov (1):
      Input: trackpoint - only expose supported controls for Elan, ALPS and NXP

Mark Furneaux (1):
      Input: xpad - add support for PDP Xbox One controllers

Nick Dyer (1):
      Revert "Input: synaptics_rmi4 - use devm_device_add_group() for attributes in F01"

Diffstat:
--------

 drivers/input/joystick/xpad.c       |  19 +++
 drivers/input/mouse/trackpoint.c    | 245 ++++++++++++++++++++++--------------
 drivers/input/mouse/trackpoint.h    |  34 +++--
 drivers/input/rmi4/rmi_f01.c        |  12 +-
 drivers/input/touchscreen/s6sy761.c |  15 +--
 drivers/input/touchscreen/stmfts.c  |  15 +--
 6 files changed, 210 insertions(+), 130 deletions(-)

Thanks.


-- 
Dmitry
