From: Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v4 0/3] Add PAT9125 optical tracker driver
Date: Fri, 12 Jul 2019 11:40:47 +0200
Message-ID: <20190712094050.17432-1-amergnat@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
List-Id: linux-input@vger.kernel.org

PixArt Imaging PAT9125 is a miniature low power optical navigation chip
using LASER light source enabling digital surface tracking.

This device driver use IIO API to provide punctual and/or buffered data.
The data is a relative position from where start the device on X and Y
axis, depend on CPI (Counts Per Inch) resolution setting chosen.

The device support CPI configuration through IIO interface.

This patchset :
- Update vendor prefix
- Add the bindings for this device
- Add the device driver
- Add directory for optical tracker devices

Change since v3:
- Replace delta value by relative position
- Improve write protected reg function by removing print log and obvious
  returns
- Handle error in postenable buffer function

Change since v2:
- Fix typo
- Add constructor webpage and datasheet in commit message
- Use BIT() macro for define bit mask
- Remove shift from IIO channel spec structure
- Replace IIO_LE by IIO_CPU from IIO channel spec structure
- Replace memcpy() by cast (s32)
- Rename "pat9125_trig_try_reen" to "pat9125_trig_try_reenable"
- Add carriage return (\n) at the end of each "dev_err" function
- Remove "iio_trigger_unregister" in case of "iio_trigger_register" fail,
  register function already manage it
- Remove log which print device name in case of successful initialization
- Fix enabled IRQ flag warning during nested IRQ thread
- Improve retry algo now based on status register
- Remove "ts", "motion_detected" and "buffer_mode" from pat9125_data
  structure
- Rename all "ot" directories to "position"
- Polling sample through IIO_CHAN_INFO_RAW now return position value
  (relative to the position at initialization time) instead of delta
  position
- Clean iio_buffer_setup_ops structure by removing NULL pointer.
- Use devm_iio_ function for all init functions and then delete
  "pat9125_remove"
- Move device_register at the end of probe function
- Replace MODULE_PARM_DESC by IIO_SCALE to set axis resolution (CPI)

Change since v1:
- Fix typo
- Rename some defines / variables
- Remove I2C client from driver structure
- Change type of delta_x and delta_y from s16 to s32 to simplify signed
  operations
- Add module parameter for axis resolution
- Replace "IIO_MOD_X_AND_Y" by "IIO_MOD_X" and "IIO_MOD_Y"
- Add sign extension macro
- Improve read value algorithm to avoid data loss
- Implement a trigger handler function which can work with any IIO
  trigger, independently of it own GPIO IRQ, to match with IIO
  requirement/behaviour
- Replace iio push event function by iio trigger poll in GPIO IRQ handler
- Use triggered_buffer helpers to replace kfifo use, setup buffer,
  implement enable/disable setup buffer operations, IIO trigger
  allocation and re-enable operations
- Remove useless "goto"
- Change GPIO IRQ handler from planified thread to IRQ thread
- Change GPIO IRQ trigger from low level and one shot to falling edge
- Add device unregister and buffer cleanup to driver remove function

Alexandre Mergnat (3):
  dt-bindings: Add pixart vendor
  dt-bindings: iio: position: Add docs pat9125
  iio: Add PAT9125 optical tracker sensor

 .../bindings/iio/position/pat9125.txt         |  18 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/position/Kconfig                  |  18 +
 drivers/iio/position/Makefile                 |   6 +
 drivers/iio/position/pat9125.c                | 506 ++++++++++++++++++
 7 files changed, 552 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/position/pat9125.txt
 create mode 100644 drivers/iio/position/Kconfig
 create mode 100644 drivers/iio/position/Makefile
 create mode 100644 drivers/iio/position/pat9125.c

-- 
2.17.1
