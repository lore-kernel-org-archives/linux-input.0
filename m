From: =?UTF-8?q?Ronald=20Tschal=C3=A4r?= <ronald@innovation.ch>
Subject: [PATCH v2 0/2] Add Apple SPI keyboard and trackpad driver
Date: Thu, 21 Feb 2019 02:56:07 -0800
Message-ID: <20190221105609.5710-1-ronald@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>
Cc: Lukas Wunner <lukas@wunner.de>, Federico Lorenzi <federico@travelground.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
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

Changes in v2:
  Applied all feedback from review by Andy Shevchenko, including:
  - reworked logging to use dev_xxx() everywhere
  - split 16-bit model_id field into 2 8-bit fields
  - factored out several pieces of code into separate functions
  - many code style improvements and cleanups
  - Kconfig dependency fixes
  The full set of changes (except for the Kconfig) can be viewed at
  https://github.com/roadrunner2/macbook12-spi-driver/ as individual
  commits a651bb9..f832caa in the upstreaming-review branch.

Ronald Tschalär (2):
  drm/bridge: sil_sii8620: depend on INPUT instead of selecting it.
  Input: add Apple SPI keyboard and trackpad driver.

 drivers/gpu/drm/bridge/Kconfig    |    2 +-
 drivers/input/keyboard/Kconfig    |   14 +
 drivers/input/keyboard/Makefile   |    1 +
 drivers/input/keyboard/applespi.c | 2003 +++++++++++++++++++++++++++++
 4 files changed, 2019 insertions(+), 1 deletion(-)
 create mode 100644 drivers/input/keyboard/applespi.c

-- 
2.20.1
