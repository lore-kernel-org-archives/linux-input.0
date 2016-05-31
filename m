From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 0/8] TI AM335x TSC/ADC cleanup
Date: Tue, 31 May 2016 12:00:05 -0500
Message-ID: <20160531170013.2649-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60081 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755252AbcEaRAe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 31 May 2016 13:00:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Dave Gerlach <d-gerlach@ti.com>
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>

Hello all,

This series is a group of non-functional changes I would
like to get in this cycle to prepare some regmap based
changes I would like to make next cycle. Hopefully the
churn can be seen as more useful in that case.

Thanks,
Andrew

Andrew F. Davis (8):
  mfd: ti_am335x_tscadc: Use SIMPLE_DEV_PM_OPS helper macro
  iio: adc: ti_am335x_adc: use SIMPLE_DEV_PM_OPS helper macro
  mfd: ti_am335x_tscadc: Remove use of single line functions
  mfd: ti_am335x_tscadc: Unify variable naming when refrencing
    ti_tscadc_dev
  mfd: ti_am335x_tscadc: Rename regmap_tscadc to regmap
  mfd: ti_am335x_tscadc: use variable name for sizeof() operator
  iio: adc: ti_am335x_adc: use variable names for sizeof() operator
  Input: ti_am335x_tsc - use variable name for sizeof() operator

 drivers/iio/adc/ti_am335x_adc.c           |  22 ++---
 drivers/input/touchscreen/ti_am335x_tsc.c |   2 +-
 drivers/mfd/ti_am335x_tscadc.c            | 135 +++++++++++++-----------------
 include/linux/mfd/ti_am335x_tscadc.h      |   2 +-
 4 files changed, 64 insertions(+), 97 deletions(-)

-- 
2.8.3

