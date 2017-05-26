From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.12-rc2
Date: Fri, 26 May 2017 16:20:49 -0700
Message-ID: <20170526232049.GA29003@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35294 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1948835AbdEZXUw (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 May 2017 19:20:52 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Just a few fixups to a
couple of drivers.

Changelog:
---------

KT Liao (2):
      Input: elan_i2c - clear INT before resetting controller
      Input: elan_i2c - ignore signals when finishing updating firmware

Martin Kepplinger (1):
      Input: edt-ft5x06 - increase allowed data range for threshold parameter

Maxime Roussin-Bélanger (1):
      Input: atmel_mxt_ts - add T100 as a readable object

Diffstat:
--------

 .../bindings/input/touchscreen/edt-ft5x06.txt      |  2 +-
 Documentation/input/devices/edt-ft5x06.rst         |  2 +-
 drivers/input/mouse/elan_i2c_i2c.c                 | 30 ++++++++++++----------
 drivers/input/touchscreen/atmel_mxt_ts.c           |  1 +
 drivers/input/touchscreen/edt-ft5x06.c             |  2 +-
 5 files changed, 20 insertions(+), 17 deletions(-)

Thanks.


-- 
Dmitry
