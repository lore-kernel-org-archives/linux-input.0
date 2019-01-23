From: Nick Crews <ncrews@chromium.org>
Subject: [PATCH v4 0/9] platform/chrome: rtc: Add support for Wilco EC
Date: Wed, 23 Jan 2019 11:33:16 -0700
Message-ID: <20190123183325.92946-1-ncrews@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: sjg@chromium.org, dmitry.torokhov@gmail.com, sre@kernel.org, linux-input@vger.kernel.org, groeck@chromium.org, dlaurie@chromium.org, Nick Crews <ncrews@chromium.org>, linux-rtc@vger.kernel.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Alessandro Zummo <a.zummo@towertech.it>, Benson Leung <bleung@chromium.org>, Nick Crews <ncrews@google.com>, Duncan Laurie <dlaurie@google.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-input@vger.kernel.org


There is a new chromebook that contains a different Embedded Controller
(codename Wilco) than the rest of the chromebook series. Thus the kernel
requires a different driver than the already existing and generalized
cros_ec_* drivers. Specifically, this driver adds support for getting
and setting the RTC on the EC, adding a binary sysfs attribute
that receives ACPI events from the EC, adding a binary sysfs
attribute to request telemetry data from the EC (useful for enterprise
applications), adding a debugfs interface for sending/receiving raw byte
sequesnces to the EC, and adding normal sysfs attributes to get/set various
other properties on the EC. The core of the communication with the EC
is implemented in wilco_ec/mailbox.c, using a simple byte-level protocol
with a checksum, transmitted over an eSPI bus. For debugging purposes,
a raw attribute is also provided via debugfs which can write/read
arbitrary bytes to/from the eSPI bus.

The entry point of the driver is wilco_ec/core.c,
which is responsible for several tasks:
- Initialize the register interface that is used by wilco_ec_mailbox()
- Create a platform device which is picked up by the debugfs driver
- Create a platform device which is picked up by the RTC driver
- Initialize the sysfs entries
- Set up event handling

We attempted to adhere to the sysfs principles of "one piece of data per
attribute" as much as possible, and mostly succeded. However, with the
wilco_ec/adv_power.h attributes, which deal with scheduling power usage,
we found it most elegant to bundle setting event times for an entire day
into a single attribute, so at most you are using attributes formatted
as "%d %d %d %d %d %d". With the telemetry attribute, we had to use a
binary attribute, instead of the preferable human-readable ascii, in
order to keep secure the information which is proprietary to the
enterprise service provider. This opaque binary data will be read and
sent using a proprietary daemon running on the OS.

The RTC driver is exposed as a standard RTC driver with
read/write functionality.

For event notification, the Wilco EC can return extended events that
are not handled by standard ACPI objects. These events can
include hotkeys which map to standard functions like brightness
controls, or information about EC controlled features like the
charger or battery. These events are triggered with an
ACPI Notify(0x90) and the event data buffer is read through an ACPI
method provided by the BIOS which reads the event buffer from EC RAM.
These events are then processed, with hotkey events being sent
to the input subsystem and other events put into a queue which
can be read by a userspace daemon via a sysfs attribute.

The rest of the attributes are categorized as either "properties" or
"legacy". "legacy" implies that the attribute existed on the EC before it
was modified for ChromeOS, and "properties" implies that the attribute
exposes functionality that was added to the EC specifically for
ChromeOS. They are mostly boolean flags or percentages.

A full thread of the development of these patches can be found at
https://chromium-review.googlesource.com/c/1371034. This thread contains
comments and revisions that could be helpful in understanding how the
driver arrived at the state it is in now. The thread also contains some
ChromeOS specific patches that actually enable the driver. If you want
to test the patch yourself, you would have to install the ChromeOS SDK
and cherry pick in these patches.

I also wrote some integration tests using the Tast testing framework that
ChromeOS uses. It would require a full ChromeOS SDK to actually run the
tests, but the source of the tests, written in Go, are useful for
understanding what the desired behavior is. You can view the tests here:
https://chromium-review.googlesource.com/c/1372575

Thank you for your comments!

Changes in v4:
- add #define DRV_NAME
- remove redundant Kconfig nesting
- changed my email to @chromium.org
- Add better explanation of what core.c does
- Change debugfs driver to be a separate module
- Change me email to @chromium.org from @google.com
- Change CONFIG_WILCO_EC_SYSFS_RAW to
  CONFIG_WILCO_EC_DEBUGFS
- Change me email to @chromium.org from @google.com
- Move "Add RTC driver" before "Add sysfs attributes" so that
  it could get accepted earlier, since it is less contentious
- Move "Add RTC driver" before "Add sysfs attributes" so that
  it could get accepted earlier, since it is less contentious

Changes in v3:
- Change <= to >= in mec_in_range()
- Add " - EC_HOST_CMD_REGION0" to offset arg for io_bytes_mec()
- remove unused ret in probe()
- Add newline spacer in probe()
- rm unnecessary res in get_resource()
- s/8bit/8-bit
- rm first sleep when sending command to EC
- Move the attribute to the debugfs system
- Move the implementation to debugfs.c
- Improve the raw hex parsing
- Encapsulate global variables in one object
- Add safety check when passing less than 3 bytes
- Move documentation to debugfs-wilco-ec
- rm #define for driver name
- Don't compute weekday when reading from RTC.
  Still set weekday when writing, as RTC needs this
  to control advanced power scheduling
- rm check for invalid month data
- Set range_min and range_max on rtc_device
- explicitly define toplevel_groups from the start,
so adding telem later makes sense
- Break version attribute into individual attributes
- rm unused WILCO_EC_ATTR_RW macro
- Moved some #defines from legacy.h to legacy.c
- change err check from "if (ret < 0)" to "if (ret)"
- Now bubble up error codes from within sysfs_init()
- Add comment that PID means Property ID
- rm some useless references to internal docs from documentation
- add err check on returned data size
- add check on read request offset and size

Changes in v2:
- Fixed kernel-doc comments
- Fixed include of linux/mfd/cros_ec_lpc_mec.h
- cros_ec_lpc_mec_in_range() returns -EINVAL on error
- Added parens around macro variables
- Remove COMPILE_TEST from Kconfig because inb()/outb()
won't work on anything but X86
- Add myself as module author
- Tweak mailbox()
- Add sysfs documentation
- rm duplicate EC_MAILBOX_DATA_SIZE defs
- Make docstrings follow kernel style
- Fix tags in commit msg
- Move Kconfig to subdirectory
- Reading raw now includes ASCII translation
- rm license boiler plate
- rm "wilco_ec_rtc -" prefix in docstring
- Make rtc driver its own module within the drivers/rtc/ directory
- Register a rtc device from core.c that is picked up by this driver
- Remove license boiler plate
- Remove "wilco_ec_sysfs -" docstring prefix
- Fix accidental Makefile deletion
- Add documentation for sysfs entries
- Change "enable ? 0 : 1" to "!enable"
- No longer override error code from sysfs_init()
- Put attributes in the legacy file to begin with, don't move later
- Remove duplicate error messages when init()ing sysfs
- rm "wilco_ec_event -" prefix from docstring
- rm license boiler plate
- Add sysfs directory documentation
- Fix cosmetics
- events are init()ed before subdrivers now
- rm license boiler plate
- rm "wilco_ec_properties -" prefix from docstring
- Add documentation
- rm license boiler plate
- rm "wilco_ec_adv_power - " prefix from docstring
- Add documentation
- make format strings in read() and store() functions static

Duncan Laurie (6):
  cros_ec: Remove cros_ec dependency in lpc_mec
  platform/chrome: Add new driver for Wilco EC
  platform/chrome: Add support for raw commands in debugfs
  platform/chrome: rtc: Add RTC driver
  platform/chrome: Add sysfs attributes
  platform/chrome: Add event handling

Nick Crews (3):
  platform/chrome: Add EC properties
  platform/chrome: Add peakshift and adv_batt_charging
  platform/chrome: Add binary telemetry attributes

 Documentation/ABI/testing/debugfs-wilco-ec    |  23 +
 .../ABI/testing/sysfs-platform-wilco-ec       | 196 +++++++
 drivers/platform/chrome/Kconfig               |   4 +-
 drivers/platform/chrome/Makefile              |   2 +
 drivers/platform/chrome/cros_ec_lpc_mec.c     |  52 +-
 drivers/platform/chrome/cros_ec_lpc_mec.h     |  43 +-
 drivers/platform/chrome/cros_ec_lpc_reg.c     |  47 +-
 drivers/platform/chrome/wilco_ec/Kconfig      |  20 +
 drivers/platform/chrome/wilco_ec/Makefile     |   8 +
 drivers/platform/chrome/wilco_ec/adv_power.c  | 544 ++++++++++++++++++
 drivers/platform/chrome/wilco_ec/adv_power.h  | 183 ++++++
 drivers/platform/chrome/wilco_ec/core.c       | 164 ++++++
 drivers/platform/chrome/wilco_ec/debugfs.c    | 226 ++++++++
 drivers/platform/chrome/wilco_ec/event.c      | 347 +++++++++++
 drivers/platform/chrome/wilco_ec/legacy.c     | 103 ++++
 drivers/platform/chrome/wilco_ec/legacy.h     |  79 +++
 drivers/platform/chrome/wilco_ec/mailbox.c    | 236 ++++++++
 drivers/platform/chrome/wilco_ec/properties.c | 344 +++++++++++
 drivers/platform/chrome/wilco_ec/properties.h | 180 ++++++
 drivers/platform/chrome/wilco_ec/sysfs.c      | 245 ++++++++
 drivers/platform/chrome/wilco_ec/telemetry.c  |  73 +++
 drivers/platform/chrome/wilco_ec/telemetry.h  |  41 ++
 drivers/platform/chrome/wilco_ec/util.h       |  38 ++
 drivers/rtc/Kconfig                           |  11 +
 drivers/rtc/Makefile                          |   1 +
 drivers/rtc/rtc-wilco-ec.c                    | 177 ++++++
 include/linux/platform_data/wilco-ec.h        | 186 ++++++
 27 files changed, 3513 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-wilco-ec
 create mode 100644 Documentation/ABI/testing/sysfs-platform-wilco-ec
 create mode 100644 drivers/platform/chrome/wilco_ec/Kconfig
 create mode 100644 drivers/platform/chrome/wilco_ec/Makefile
 create mode 100644 drivers/platform/chrome/wilco_ec/adv_power.c
 create mode 100644 drivers/platform/chrome/wilco_ec/adv_power.h
 create mode 100644 drivers/platform/chrome/wilco_ec/core.c
 create mode 100644 drivers/platform/chrome/wilco_ec/debugfs.c
 create mode 100644 drivers/platform/chrome/wilco_ec/event.c
 create mode 100644 drivers/platform/chrome/wilco_ec/legacy.c
 create mode 100644 drivers/platform/chrome/wilco_ec/legacy.h
 create mode 100644 drivers/platform/chrome/wilco_ec/mailbox.c
 create mode 100644 drivers/platform/chrome/wilco_ec/properties.c
 create mode 100644 drivers/platform/chrome/wilco_ec/properties.h
 create mode 100644 drivers/platform/chrome/wilco_ec/sysfs.c
 create mode 100644 drivers/platform/chrome/wilco_ec/telemetry.c
 create mode 100644 drivers/platform/chrome/wilco_ec/telemetry.h
 create mode 100644 drivers/platform/chrome/wilco_ec/util.h
 create mode 100644 drivers/rtc/rtc-wilco-ec.c
 create mode 100644 include/linux/platform_data/wilco-ec.h

-- 
2.20.1.321.g9e740568ce-goog
