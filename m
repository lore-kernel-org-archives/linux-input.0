From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/4] Current ad7879 patches
Date: Fri, 25 Jun 2010 01:22:13 -0700
Message-ID: <20100625081847.8617.31150.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:49588 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab0FYIWR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Jun 2010 04:22:17 -0400
Received: by pwj8 with SMTP id 8so2238436pwj.19
        for <linux-input@vger.kernel.org>; Fri, 25 Jun 2010 01:22:16 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>, Michael Hennerich <michael.hennerich@analog.com>
Cc: linux-input@vger.kernel.org

Mike, Michael,

I was looking through outstanding patches to ad7879 and here they are.
Since I made some changes to the patches you wrote and there also some
new code and I do not have the hardware I'd appreciate if you could try
them out so they can be applied.

Thank you.

-- 
Dmitry

Dmitry Torokhov (2):
      Input: ad7879 - add open and close methods
      Input: ad7879 - use threaded IRQ

Michael Hennerich (1):
      Input: ad7879 - use i2c_smbus_read_i2c_block_data() to lower overhead

Mike Frysinger (1):
      Input: ad7879 - split bus logic out


 drivers/input/touchscreen/ad7879-i2c.c |  143 ++++++++
 drivers/input/touchscreen/ad7879-spi.c |  190 ++++++++++
 drivers/input/touchscreen/ad7879.c     |  606 +++++++++-----------------------
 drivers/input/touchscreen/ad7879.h     |   30 ++
 4 files changed, 533 insertions(+), 436 deletions(-)
 create mode 100644 drivers/input/touchscreen/ad7879-i2c.c
 create mode 100644 drivers/input/touchscreen/ad7879-spi.c
 create mode 100644 drivers/input/touchscreen/ad7879.h
