From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v8 0/4] i2c-smbus: add support for HOST NOTIFY
Date: Thu,  9 Jun 2016 16:53:46 +0200
Message-ID: <1465484030-28838-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50787 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152AbcFIOx4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 Jun 2016 10:53:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi,

and here comes the v8 of Host Notify.

To minimize the merge conflicts, I first applied the following 2 patches:
http://patchwork.ozlabs.org/patch/632768/
http://patchwork.ozlabs.org/patch/626051/

The series Corey sent (http://patchwork.ozlabs.org/patch/627567/ and the 9
after) does not conflict with the i2c-i801 patch (3/4).

I haven't seen any other pending i801 patches in the recent history, but please
tell me if you need extra eyes on some others.

I guess you won't take 4/4 in the I2C tree (unless Dmitry gives his ACK), but
I felt it was important to have one driver submitted with the use of this "new"
feature.

Cheers,
Benjamin

Benjamin Tissoires (4):
  i2c: add a protocol parameter to the alert callback
  i2c-smbus: add SMBus Host Notify support
  i2c: i801: add support of Host Notify
  Input: synaptics-rmi4 - add SMBus support

 Documentation/i2c/smbus-protocol |   6 +
 drivers/char/ipmi/ipmi_ssif.c    |   6 +-
 drivers/hwmon/lm90.c             |   6 +-
 drivers/i2c/busses/Kconfig       |   1 +
 drivers/i2c/busses/i2c-i801.c    |  79 ++++++-
 drivers/i2c/i2c-smbus.c          | 112 +++++++++-
 drivers/input/rmi4/Kconfig       |  12 +
 drivers/input/rmi4/Makefile      |   1 +
 drivers/input/rmi4/rmi_bus.h     |  12 +
 drivers/input/rmi4/rmi_smbus.c   | 470 +++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-smbus.h        |  44 ++++
 include/linux/i2c.h              |  10 +-
 include/uapi/linux/i2c.h         |   1 +
 13 files changed, 750 insertions(+), 10 deletions(-)
 create mode 100644 drivers/input/rmi4/rmi_smbus.c

-- 
2.5.0

