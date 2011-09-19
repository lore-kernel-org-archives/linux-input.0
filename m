From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v3 0/2] Add device tree support for Samsung's keypad controller
 driver
Date: Mon, 19 Sep 2011 15:49:11 +0530
Message-ID: <1316427553-5033-1-git-send-email-thomas.abraham@linaro.org>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, dmitry.torokhov@gmail.com
Cc: grant.likely@secretlab.ca, linux-input@vger.kernel.org, kgene.kim@samsung.com, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jy0922.shim@samsung.com, dh09.lee@samsung.com
List-Id: linux-input@vger.kernel.org

Changes since v2:
- Addressed comments from Grant Likely.
  - Renamed 'keypad,key-code' property name to 'linux,code'.
  - Fixed incorrect data types for all instances of of_property+read_u32.
  - linux,input-type binding was not added as suggested since the driver
    supports only EV_KEY event type.

Changes since v1:
- Addressed comments from Dmitry Torokhov.
  - Type of controller is cached in driver's private data and the function
    that determines the type of the controller for each keypad scan is
    removed.
  - pdata allocated during probe is explicitly freed after probe completes
    without any error. In case of exit from probe due a error, no explicit
    deallocation of pdata memory is performed and it is left to devres to
    handle that.
  - The generic code to translate KEY(x,y,code) is retained in the driver
    itself. I am unsure of a right common place for it.
  - Driver continues with the probe even if one or more gpio configuration
    fails.
  - Patch 1 that adds a new config option is still retained in this patchset.


This patchset adds device tree support for samsung's keypad controller driver.
First patch adds a new config option to be used by device tree enabled platforms
for selecting the samsung's keypad controller driver. The second patch adds device
tree support for the keypad driver.

Thomas Abraham (2):
  input: samsung-keypad: Add HAVE_SAMSUNG_KEYPAD config option
  input: samsung-keypad: Add device tree support

 .../devicetree/bindings/input/samsung-keypad.txt   |   88 ++++++++++
 drivers/input/keyboard/Kconfig                     |    9 +-
 drivers/input/keyboard/samsung-keypad.c            |  179 ++++++++++++++++++--
 3 files changed, 263 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/samsung-keypad.txt
