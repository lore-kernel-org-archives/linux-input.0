From: "Patil, Rachna" <rachna@ti.com>
Subject: [PATCH RESEND 0/7] MFD: ti_am335x_tscadc: DT support and TSC features addition
Date: Wed, 7 Nov 2012 12:21:57 +0530
Message-ID: <1352271124-5513-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Rob Landley <rob@landley.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Jonathan Cameron <jic23@cam.ac.uk>, "Patil, Rachna" <rachna@ti.com>
List-Id: linux-input@vger.kernel.org

This patch set is a cumulative set of [1] and [2] sent earlier.

Note that there are no code changes in either of the patch set,
only rebased on top of MFD-next to make sure that all the patches
apply without any conflicts.

This patch set has been tested on AM335x EVM and is based on top of [3].

[1] http://www.spinics.net/lists/linux-input/msg23060.html
[2] http://www.spinics.net/lists/linux-input/msg23090.html
[3] https://lkml.org/lkml/2012/11/6/67

Patil, Rachna (7):
  input: ti_am335x_tsc: Step enable bits made configurable
  input: ti_am335x_tsc: Order of TSC wires, made configurable
  input: ti_am335x_tsc: Add variance filter
  MFD: ti_am335x_tscadc: add device tree binding information
  MFD: ti_am335x_tscadc: Add DT support
  input: ti_am335x_tsc: Add DT support
  IIO: ti_am335x_adc: Add DT support

 .../devicetree/bindings/mfd/ti_am335x_tscadc.txt   |   35 +++
 drivers/iio/adc/ti_am335x_adc.c                    |   24 ++-
 drivers/input/touchscreen/ti_am335x_tsc.c          |  239 +++++++++++++++++---
 drivers/mfd/ti_am335x_tscadc.c                     |   28 ++-
 include/linux/input/ti_am335x_tsc.h                |   12 +
 include/linux/mfd/ti_am335x_tscadc.h               |   11 +-
 6 files changed, 308 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ti_am335x_tscadc.txt

