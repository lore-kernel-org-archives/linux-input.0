From: =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
Subject: [PATCH v2 0/3] Apple iBridge support
Date: Wed, 12 Jun 2019 01:33:57 -0700
Message-ID: <20190612083400.1015-1-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

2016 and 2017 MacBook Pro's have a T1 chip that drives the Touch Bar,
ambient light sensor, webcam, and fingerprint sensor; this shows up
as an iBridge USB device in the system. These patches provide initial
support for the Touch Bar and ALS - the webcam is already handled by
existing drivers, and no information is currently known on how to access
the fingerprint sensor (other than it's apparently via one of the extra
interfaces available in the OS X USB configuration).

One thing of note here is that both the ALS and (some of) the Touch Bar
functionality are exposed via the same USB interface (and hence same
hid_device), so both drivers need to share this device. This is solved
by having the iBridge driver create multiple virtual HID devices for
each real HID device to which the Touch Bar and ALS drivers attach, and 
then forwarding the calls between the real and virtual HID devices, so
we end up with a structure like this:

    iBridge (HID) driver    Sub drivers

           --  vhdev0  --   (unbound)
          /
   hdev1  ---  vhdev1  ---  tb-drv
                         /
           --  vhdev2  --
          /
   hdev2  ---  vhdev3  ---  als-drv


Changes in v2:
  - Changed iBridge driver from an MFD driver to a HID driver. Instead
    of creating virtual HID drivers and (de)multiplexing their calls,
    this now create virtual HID devices and (de)multiplexing the
    operations on them. This is from the feedback by Benjamin Tissoires.
  - Applied all feedback on ALS driver from Jonathan Cameron
  - Applied all feedback on Touch Bar driver from Jonathan Cameron
    and Peter Meerwald-Stadler
  - various smaller cleanups

Ronald Tschalär (3):
  HID: apple-ibridge: Add Apple iBridge HID driver.
  HID: apple-ib-tb: Add driver for the Touch Bar on MacBook Pro's.
  iio: light: apple-ib-als: Add driver for ALS on iBridge chip.

 drivers/hid/Kconfig              |   24 +
 drivers/hid/Makefile             |    2 +
 drivers/hid/apple-ib-tb.c        | 1389 ++++++++++++++++++++++++++++++
 drivers/hid/apple-ibridge.c      |  588 +++++++++++++
 drivers/hid/hid-ids.h            |    1 +
 drivers/iio/light/Kconfig        |   12 +
 drivers/iio/light/Makefile       |    1 +
 drivers/iio/light/apple-ib-als.c |  607 +++++++++++++
 include/linux/apple-ibridge.h    |   23 +
 9 files changed, 2647 insertions(+)
 create mode 100644 drivers/hid/apple-ib-tb.c
 create mode 100644 drivers/hid/apple-ibridge.c
 create mode 100644 drivers/iio/light/apple-ib-als.c
 create mode 100644 include/linux/apple-ibridge.h

-- 
2.21.0
