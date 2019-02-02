From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 0/5] input: misc: bma150: Add support for device tree
Date: Sat,  2 Feb 2019 16:18:01 +0100
Message-ID: <20190202151806.9064-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This small patchset adds support for device tree to Bosch BMA150 Accelerometer
Sensor driver.

It was tested on s5pv210-galaxys and s5pv210-fascinate4g.

Changes from v1:
  - Correct devm input unregistering
  - Correct IRQ type in DT documentation
  - Add DT properties for bma150_cfg and document
  - Add patch removing pdata
  - Fix race condition in input device registering

Jonathan Bakker (5):
  dt-bindings: input: Add binding for bma150 sensor
  input: misc: bma150: Use managed resources helpers
  input: misc: bma150: Add support for device tree
  input: misc: bma150: Drop platform data
  input: misc: bma150: Register input device after setting private data

 .../bindings/input/bosch,bma150.txt           |  38 ++++++
 drivers/input/misc/bma150.c                   | 128 ++++++++++--------
 include/dt-bindings/input/bma150.h            |  22 +++
 include/linux/bma150.h                        |  38 ++----
 4 files changed, 144 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/bosch,bma150.txt
 create mode 100644 include/dt-bindings/input/bma150.h

-- 
2.17.1
