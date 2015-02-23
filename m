From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 0/3] HID: Support for Lenovo Thinkpad 10 digitizer
Date: Mon, 23 Feb 2015 15:52:42 +0200
Message-ID: <1424699565-138045-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mark Rutland <mark.rutland@arm.com>, sb@m-labs.hk, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

Previously I sent a patch that enables GPIO interrupts for i2c-hid. This
was not accepted by the community:

	https://lkml.org/lkml/2015/1/26/398

However, it turned out that there are actually device(s) out there that
need this support. One of them is Lenovo Thinkpad 10. It has touch screen
connected to IO-APIC but in addition it includes Wacom digitizer
that uses GPIO as an interrupt.

In this version of the patch, I limited the GPIO retrieving code path to be
taken only when the device is enumerated from ACPI. This allows DT to use
whatever is the appropriate mechanism to represent GPIO/interrupt
configuration and still makes current ACPI based devices to work.

The first two patches are needed to get the Wacom digitizer work properly
with i2c-hid.

Mika Westerberg (3):
  HID: wacom: Add support for I2C connected devices
  HID: i2c-hid: Read wMaxInputLength of input report instead of bufsize
  HID: i2c-hid: Add support for ACPI GPIO interrupts

 drivers/hid/i2c-hid/i2c-hid.c | 76 +++++++++++++++++++++++++++++++++----------
 drivers/hid/wacom_wac.c       |  5 +++
 2 files changed, 63 insertions(+), 18 deletions(-)

-- 
2.1.4
