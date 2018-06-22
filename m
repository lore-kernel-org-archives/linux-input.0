From: Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v3 0/2] Add another regulator to i2c-hid
Date: Thu, 21 Jun 2018 19:27:15 -0700
Message-ID: <20180622022717.134300-1-swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dtor@chromium.org>, Doug Anderson <dianders@chromium.org>
List-Id: linux-input@vger.kernel.org

The wacom w9013 device has two supplies that need to be turned
on and in some cases these come from two different power supplies.
This patch series supports that case.

Changes from v1:
 * Use the bulk regulator APIs instead of open coding it (Dmitry)

Changes from v2:
 * Split out devm for allocation into another patch (Dmitry)
 * Drop errant error print that snuck in across port

Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dtor@chromium.org>
Cc: Doug Anderson <dianders@chromium.org>

Stephen Boyd (2):
  HID: i2c-hid: Use devm to allocate i2c_hid struct
  HID: i2c-hid: Add vddl regulator control

 .../bindings/input/hid-over-i2c.txt           |  3 +-
 drivers/hid/i2c-hid/i2c-hid.c                 | 57 +++++++++----------
 include/linux/platform_data/i2c-hid.h         |  7 +--
 3 files changed, 32 insertions(+), 35 deletions(-)

-- 
Sent by a computer through tubes
