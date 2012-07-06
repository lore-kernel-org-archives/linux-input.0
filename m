From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: [GIT PULL] input: mt updates for 3.5-rc0
Date: Fri, 6 Jul 2012 08:30:05 +0200
Message-ID: <20120706063005.GA506@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:60610 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604Ab2GFG3d (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Jul 2012 02:29:33 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

Here are the input-mt updates for 3.5-rc0. It includes the large
atmel_mxt update from Daniel, and an MT protocol addition for win8
devices.

Thanks,
Henrik

The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:

  Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)

are available in the git repository at:

  git://github.com/rydberg/linux.git for-next

for you to fetch changes up to c45361a1287a74d327d72d4d2b96f4ac170653d9:

  Revert "Input: atmel_mxt_ts - warn if sysfs could not be created" (2012-07-05 20:59:37 +0200)

----------------------------------------------------------------
Daniel Kurtz (23):
      Input: atmel_mxt_ts - derive phys from i2c client adapter
      Input: atmel_mxt_ts - use client name for irq
      Input: atmel_mxt_ts - detect OOM when creating mt slots
      Input: atmel_mxt_ts - warn if sysfs could not be created
      Input: atmel_mxt_ts - don't read T5 when dumping objects
      Input: atmel_mxt_ts - use scnprintf for object sysfs entry
      Input: atmel_mxt_ts - optimize reading objects in object sysfs entry
      Input: atmel_mxt_ts - print less overhead when dumping objects
      Input: atmel_mxt_ts - print all instances when dumping objects
      Input: atmel_mxt_ts - return errors from i2c layer
      Input: atmel_mxt_ts - add variable length __mxt_write_reg
      Input: atmel_mxt_ts - optimize writing of object table entries
      Input: atmel_mxt_ts - read ID information block in one i2c transaction
      Input: atmel_mxt_ts - update driver ID info logging
      Input: atmel_mxt_ts - add sysfs entries to read fw and hw version
      Input: atmel_mxt_ts - simplify event reporting
      Input: atmel_mxt_ts - add detail to touchevent debug message
      Input: atmel_mxt_ts - refactor when and how object table is freed
      Input: atmel_mxt_ts - cache T9 reportid range when reading object table
      Input: atmel_mxt_ts - refactor reportid checking in mxt_interrupt
      Input: atmel_mxt_ts - use T9 reportid range to init number of mt slots
      Input: atmel_mxt_ts - send all MT-B slots in one input report
      Input: atmel_mxt_ts - parse T6 reports

Henrik Rydberg (2):
      Input: MT - Include win8 support
      Revert "Input: atmel_mxt_ts - warn if sysfs could not be created"

Sachin Kamat (1):
      Input: MT - fix null pointer warning

 Documentation/input/multi-touch-protocol.txt | 118 +++++--
 drivers/input/input-mt.c                     |   2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c     | 463 ++++++++++++++-------------
 include/linux/input.h                        |   8 +-
 4 files changed, 339 insertions(+), 252 deletions(-)
