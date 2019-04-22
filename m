From: =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
Subject: [PATCH 0/3] Apple iBridge support
Date: Sun, 21 Apr 2019 20:12:48 -0700
Message-ID: <20190422031251.11968-1-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>
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
hid_device), so both drivers need to share this device. This
necessitated creating a demux hid driver in the mfd driver to which
multiple hid devices can be attached, and implied not being able to make
use of the existing hid-sensor-als driver.

Ronald Tschalär (3):
  mfd: apple-ibridge: Add Apple iBridge MFD driver.
  HID: apple-ib-tb: Add driver for the Touch Bar on MacBook Pro's.
  iio: light: apple-ib-als: Add driver for ALS on iBridge chip.

 drivers/hid/Kconfig               |   10 +
 drivers/hid/Makefile              |    1 +
 drivers/hid/apple-ib-tb.c         | 1288 +++++++++++++++++++++++++++++
 drivers/iio/light/Kconfig         |   12 +
 drivers/iio/light/Makefile        |    1 +
 drivers/iio/light/apple-ib-als.c  |  694 ++++++++++++++++
 drivers/mfd/Kconfig               |   15 +
 drivers/mfd/Makefile              |    1 +
 drivers/mfd/apple-ibridge.c       |  883 ++++++++++++++++++++
 include/linux/mfd/apple-ibridge.h |   39 +
 10 files changed, 2944 insertions(+)
 create mode 100644 drivers/hid/apple-ib-tb.c
 create mode 100644 drivers/iio/light/apple-ib-als.c
 create mode 100644 drivers/mfd/apple-ibridge.c
 create mode 100644 include/linux/mfd/apple-ibridge.h

-- 
2.20.1
