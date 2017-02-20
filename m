From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 0/3] Fix tsc2007 to report ABS_PRESSURE correctly
Date: Mon, 20 Feb 2017 17:56:33 +0100
Message-ID: <cover.1487609795.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Jonathan Cameron <jic23@kernel.org>, sre@kernel.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
List-Id: linux-input@vger.kernel.org

tsc2007 reports the touch resistance as ABS_PRESSURE, which jumps
to its maximum for light touch and goes down for increasing pressure.
This is not consistent with other touch drivers and not what one would
expect.

Additionally the name of the function tsc2007_calculate_pressure()
is misleading since the formula calculates an estimate for the touch
screen resistance. So it is renamed without changing the function.

While this patch changes the values reported to userspace,
ABS_PRESSURE is used rarely by userspace. Most software only
relies on BTN_TOUCH (boolean), which is not affected by this
patch. Some graphics software makes use of the interface and
does not work correctly with the currently used inverted
behaviour.

Note: this patch series assumes to be merged after

	"Input: tsc2007 - add iio interface to read external ADC input and temperature"

because that one renames tsc2007.c to tsc2007_core.c

H. Nikolaus Schaller (3):
  Input: tsc2007 - rename function tsc2007_calculate_pressure to
    tsc2007_calculate_resistance     because that is what it does
  Input: tsc2007 - correctly report pressure and not resistance to user
    space
  Input: tsc2007 - add a property "ti,report-resistance" to restore the
    old pressure reporting state     if needed.

 .../devicetree/bindings/input/touchscreen/tsc2007.txt      |  2 ++
 drivers/input/touchscreen/tsc2007.h                        |  1 +
 drivers/input/touchscreen/tsc2007_core.c                   | 14 ++++++++++----
 3 files changed, 13 insertions(+), 4 deletions(-)

-- 
2.7.3
