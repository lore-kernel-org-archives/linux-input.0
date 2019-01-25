From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 0/4] input: misc: gp2a: Add device tree support
Date: Fri, 25 Jan 2019 18:50:41 +0100
Message-ID: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, mchehab+samsung@kernel.org, colyli@suse.de, ckeepax@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com, arnd@arndb.de, xiaotong.lu@spreadtrum.com, xc-racer2@live.ca, pawel.mikolaj.chmiel@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The main goal of this patchset is to add device tree support to driver.

First patch is doing little cleanup by using managed resource helpers.

Second patch adds support for light sensor part, which is supported by hw,
but was not supported by driver.

The last two patches adds device tree support to driver,
with documentation.

It was tested on s5pv210-galaxys and s5pv210-fascinate4g.

Jonathan Bakker (4):
  input: misc: gp2a: Use managed resource helpers
  input: misc: gp2a: Add support for light sensor
  input: misc: gp2a: Enable device tree
  dt-bindings: input: Add documentation for gp2a sensor

 .../bindings/input/sharp,gp2ap002a00f.txt     |  29 ++++
 drivers/input/misc/Kconfig                    |   2 +
 drivers/input/misc/gp2ap002a00f.c             | 154 +++++++++++++++---
 include/linux/input/gp2ap002a00f.h            |   4 +
 4 files changed, 163 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt

-- 
2.17.1
