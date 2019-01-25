From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 0/3] input: misc: bma150: Add support for device tree
Date: Fri, 25 Jan 2019 19:43:57 +0100
Message-ID: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
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

Jonathan Bakker (3):
  input: misc: bma150: Use managed resources helpers
  input: misc: bma150: Add support for device tree
  input: dt-bindings: Add binding for bma150 sensor

 .../bindings/input/bosch,bma150.txt           | 20 ++++++++
 drivers/input/misc/bma150.c                   | 50 +++++++++----------
 2 files changed, 44 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/bosch,bma150.txt

-- 
2.17.1
