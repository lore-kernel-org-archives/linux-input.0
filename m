From: =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
Subject: [PATCH v4 0/2] Add Apple SPI keyboard and trackpad driver
Date: Sat,  6 Apr 2019 22:03:56 -0700
Message-ID: <20190407050358.2976-1-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This changeset adds a driver for the SPI keyboard and trackpad on recent
MacBook's and MacBook Pro's. The driver has seen a fair amount of use
over the last 2 years (basically anybody running linux on these
machines), with only relatively small changes in the last year or so.
For those interested, the driver development has been hosted at
https://github.com/cb22/macbook12-spi-driver/ (as well as my clone at
https://github.com/roadrunner2/macbook12-spi-driver/).

The first patch fixes a problem during config and is provided for
anybody wanting to compile the driver while it's being reviewed here.
The patch is the latest version that has been submitted for review
at dri-devel; the intent is to get an Ack and permission to merge it
through the input subsystem tree here as part of this patch series.

The second patch contains the new applespi driver.

Changes in v4:
  Applied all feedback from review by Andy Shevchenko and Greg
  Kroah-Hartman, including:
  - minor include path fix
  - moved debug logging to debugfs and tracepoints
  The full set of changes to applespi can be viewed at
  https://github.com/roadrunner2/macbook12-spi-driver/ as individual
  commits 3a6262e..daf60f8 in the upstreaming-review branch.

Ronald Tschalär (2):
  drm/bridge: sil_sii8620: make remote control optional.
  Input: add Apple SPI keyboard and trackpad driver.

 drivers/gpu/drm/bridge/Kconfig          |    3 +-
 drivers/gpu/drm/bridge/sil-sii8620.c    |   21 +
 drivers/input/keyboard/Kconfig          |   15 +
 drivers/input/keyboard/Makefile         |    1 +
 drivers/input/keyboard/applespi.c       | 1999 +++++++++++++++++++++++
 drivers/input/keyboard/applespi.h       |   29 +
 drivers/input/keyboard/applespi_trace.h |   94 ++
 7 files changed, 2160 insertions(+), 2 deletions(-)
 create mode 100644 drivers/input/keyboard/applespi.c
 create mode 100644 drivers/input/keyboard/applespi.h
 create mode 100644 drivers/input/keyboard/applespi_trace.h

-- 
2.20.1
