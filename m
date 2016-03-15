From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v5 0/4] i2c-smbus: add support for HOST NOTIFY
Date: Tue, 15 Mar 2016 15:53:40 +0100
Message-ID: <1458053624-14818-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi all,

This is a resent of my series sent back in September[1].
The i801 driver has been updated to also match on the skylake chip, which
makes the new Lenovo working with RMI4 too.

The trigger for this series has been that RMI4 (the Synaptics protocol for
their devices) is on its way to v4.6. It would be good if we could have a
review for the smbus part so we can finally switch the Synaptics devices
into a better reporting mode where they report 5 true fingers.

Cheers,
Benjamin


[1] http://thread.gmane.org/gmane.linux.drivers.i2c/23899/focus=2044469

Benjamin Tissoires (4):
  i2c: add a protocol parameter to the alert callback
  i2c-smbus: add SMBus Host Notify support
  i2c: i801: add support of Host Notify
  Input: synaptics-rmi4 - add SMBus support

 Documentation/i2c/smbus-protocol |   3 +
 drivers/char/ipmi/ipmi_ssif.c    |   6 +-
 drivers/hwmon/lm90.c             |   3 +-
 drivers/i2c/busses/i2c-i801.c    |  85 +++++++-
 drivers/i2c/i2c-smbus.c          | 112 ++++++++++-
 drivers/input/rmi4/Kconfig       |  12 ++
 drivers/input/rmi4/Makefile      |   1 +
 drivers/input/rmi4/rmi_bus.h     |  12 ++
 drivers/input/rmi4/rmi_smbus.c   | 416 +++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-smbus.h        |  43 ++++
 include/linux/i2c.h              |  10 +-
 include/uapi/linux/i2c.h         |   1 +
 12 files changed, 694 insertions(+), 10 deletions(-)
 create mode 100644 drivers/input/rmi4/rmi_smbus.c

-- 
2.5.0
