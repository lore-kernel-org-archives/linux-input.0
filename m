From: =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
Subject: [PATCH v5 0/2] Add Apple SPI keyboard and trackpad driver
Date: Mon, 15 Apr 2019 01:12:58 -0700
Message-ID: <20190415081300.24831-1-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrzej Hajda <a.hajda@samsung.com>, Inki Dae <inki.dae@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-input@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This changeset adds a driver for the SPI keyboard and trackpad on recent
MacBook's and MacBook Pro's. The driver has seen a fair amount of use
over the last 2 years (basically anybody running linux on these
machines), with only relatively small changes in the last year or so.
For those interested, the driver development has been hosted at
https://github.com/cb22/macbook12-spi-driver/ (as well as my clone at
https://github.com/roadrunner2/macbook12-spi-driver/).

The first patch fixes a problem during config.

The second patch contains the new applespi driver.

Changes in v5:
  Applied all feedback from review by Andy Shevchenko (applespi) and
  Andrzej Hajda (sil-sii8620), including:
  - (sil_sii8620) use 'if (IS_DEFINED(...))' instead of conditional
    compilation to handle RC_CORE being undefined
  - (applespi) a number of cleanups of leftovers from changes to earlier
    versions
  - (applespi) replace some bool flags with loop-end detection
  - (applespi) improve error reporting in a couple places
  The full set of changes to applespi can be viewed at
  https://github.com/roadrunner2/macbook12-spi-driver/ as individual
  commits daf60f8..36afd70 in the upstreaming-review branch.

Ronald Tschalär (2):
  drm/bridge: sil_sii8620: make remote control optional.
  Input: add Apple SPI keyboard and trackpad driver.

 drivers/gpu/drm/bridge/Kconfig          |    3 +-
 drivers/gpu/drm/bridge/sil-sii8620.c    |   10 +-
 drivers/input/keyboard/Kconfig          |   15 +
 drivers/input/keyboard/Makefile         |    1 +
 drivers/input/keyboard/applespi.c       | 1985 +++++++++++++++++++++++
 drivers/input/keyboard/applespi.h       |   29 +
 drivers/input/keyboard/applespi_trace.h |   94 ++
 7 files changed, 2132 insertions(+), 5 deletions(-)
 create mode 100644 drivers/input/keyboard/applespi.c
 create mode 100644 drivers/input/keyboard/applespi.h
 create mode 100644 drivers/input/keyboard/applespi_trace.h

-- 
2.20.1
