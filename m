From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.14-rc1
Date: Fri, 22 Sep 2017 15:40:58 -0700
Message-ID: <20170922224058.GA37337@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:56679 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbdIVWlB (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Sep 2017 18:41:01 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- fixes for two long standing issues (lock up and a crash) in force
  feedback handling in uinput driver

- tweak to firmware update timing in Elan I2C touchpad driver.

Changelog:
---------

Dmitry Torokhov (2):
      Input: uinput - avoid FF flush when destroying device
      Input: uinput - avoid crash when sending FF request to device going away

KT Liao (1):
      Input: elan_i2c - extend Flash-Write delay

Diffstat:
--------

 drivers/input/ff-core.c            | 13 +++++++--
 drivers/input/misc/uinput.c        | 57 ++++++++++++++++++++++++++------------
 drivers/input/mouse/elan_i2c_i2c.c |  2 +-
 include/linux/input.h              |  1 +
 4 files changed, 51 insertions(+), 22 deletions(-)

Thanks.


-- 
Dmitry
