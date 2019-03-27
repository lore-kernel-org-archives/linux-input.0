From: =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
Subject: [PATCH v3 0/4] Add Apple SPI keyboard and trackpad driver
Date: Tue, 26 Mar 2019 18:48:03 -0700
Message-ID: <20190327014807.7472-1-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This changeset adds a driver for the SPI keyboard and trackpad on recent
MacBook's and MacBook Pro's. The driver has seen a fair amount of use
over the last 2 years (basically anybody running linux on these
machines), with only relatively small changes in the last year or so.
For those interested, the driver development has been hosted at
https://github.com/cb22/macbook12-spi-driver/ (as well as my clone at
https://github.com/roadrunner2/macbook12-spi-driver/).

The first patch is just a placeholder for now and is provided in case
somebody wants to compile the driver while it's being reviewed here; the
real patch has been submitted to dri-devel and is being discussed there,
with the intent/hope that I can get an Ack and permission to merge it
through the input subsystem tree here as part of this patch series.

The second and third patches add a new dev_print_hex_dump() helper as
the dev_xxx() analog of print_hex_dump().

The fourth patch finally contains the new applespi driver.

Changes in v3:
  Applied all feedback from review by Andy Shevchenko, including:
  - move dev_print_hex_dump() to driver core
  - clean up keyboard modifier bits testing/modifying
  - remove DEV() macro
  - minor style issues
  The full set of changes to applespi can be viewed at
  https://github.com/roadrunner2/macbook12-spi-driver/ as individual
  commits f832caa..3a6262e in the upstreaming-review branch.

Ronald Tschalär (4):
  drm/bridge: sil_sii8620: depend on INPUT instead of selecting it.
  lib/hexdump.c: factor out generic hexdump formatting for reuse.
  driver core: add dev_print_hex_dump() logging function.
  Input: add Apple SPI keyboard and trackpad driver.

 drivers/base/core.c               |   43 +
 drivers/gpu/drm/bridge/Kconfig    |    2 +-
 drivers/input/keyboard/Kconfig    |   15 +
 drivers/input/keyboard/Makefile   |    1 +
 drivers/input/keyboard/applespi.c | 1988 +++++++++++++++++++++++++++++
 include/linux/device.h            |   15 +
 include/linux/printk.h            |   12 +
 lib/hexdump.c                     |   95 +-
 8 files changed, 2146 insertions(+), 25 deletions(-)
 create mode 100644 drivers/input/keyboard/applespi.c

-- 
2.20.1
