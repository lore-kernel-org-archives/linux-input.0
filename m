From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.15-rc6
Date: Fri, 5 Jan 2018 15:53:50 -0800
Message-ID: <20180105235350.e5qncxjju7djzo2d@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36829 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752561AbeAEXxy (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 5 Jan 2018 18:53:54 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just a few driver fixups,
nothing exciting.

Changelog:
---------

Aaron Ma (1):
      Input: elantech - add new icbody type 15

Anthony Kim (1):
      Input: hideep - fix compile error due to missing include file

Dmitry Torokhov (1):
      Input: elants_i2c - do not clobber interrupt trigger on x86

Oleksandr Andrushchenko (1):
      Input: xen-kbdfront - do not advertise multi-touch pressure support

Olof Johansson (1):
      Input: joystick/analog - riscv has get_cycles()

Zhen Lei (1):
      Input: ims-pcu - fix typo in the error message

Diffstat:
--------

 drivers/input/joystick/analog.c        |  2 +-
 drivers/input/misc/ims-pcu.c           |  2 +-
 drivers/input/misc/xen-kbdfront.c      |  2 --
 drivers/input/mouse/elantech.c         |  2 +-
 drivers/input/touchscreen/elants_i2c.c | 10 +++++++---
 drivers/input/touchscreen/hideep.c     |  3 +--
 6 files changed, 11 insertions(+), 10 deletions(-)

Thanks.


-- 
Dmitry
