From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v7 0/4] i2c-smbus: add support for HOST NOTIFY
Date: Tue, 31 May 2016 12:03:01 +0200
Message-ID: <1464688985-19102-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>, Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>
Cc: linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

this is mostly a resubmission of the v6 with the acks, tested-by and few typos
here and there.

We really need this to be integrated in the kernel to be able to finally
support the touchpads found in many laptops (such as the Lenovo Thinkpad series,
some HPs, and probably many others). Currently those laptops are running the
fallback mechanism over PS/2 which is full of bugs as it has not been given
the same QA than the RMI4 over SMBus (Windows uses RMI4 over SMBus).

RMI4 is now in Linus' tree since v4.6, so it would be nice to see Host Notify
in the I2C tree as well.

Cheers,
Benjamin

Benjamin Tissoires (4):
  i2c: add a protocol parameter to the alert callback
  i2c-smbus: add SMBus Host Notify support
  i2c: i801: add support of Host Notify
  Input: synaptics-rmi4 - add SMBus support

 Documentation/i2c/smbus-protocol |   3 +
 drivers/char/ipmi/ipmi_ssif.c    |   6 +-
 drivers/hwmon/lm90.c             |   6 +-
 drivers/i2c/busses/Kconfig       |   1 +
 drivers/i2c/busses/i2c-i801.c    |  85 ++++++-
 drivers/i2c/i2c-smbus.c          | 112 +++++++++-
 drivers/input/rmi4/Kconfig       |  12 +
 drivers/input/rmi4/Makefile      |   1 +
 drivers/input/rmi4/rmi_bus.h     |  12 +
 drivers/input/rmi4/rmi_smbus.c   | 470 +++++++++++++++++++++++++++++++++++++++
 include/linux/i2c-smbus.h        |  44 ++++
 include/linux/i2c.h              |  10 +-
 include/uapi/linux/i2c.h         |   1 +
 13 files changed, 753 insertions(+), 10 deletions(-)
 create mode 100644 drivers/input/rmi4/rmi_smbus.c

-- 
2.5.0
