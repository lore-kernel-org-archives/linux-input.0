From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/3] AM335x: tsc: Fix suspended while touchscreen in use
Date: Mon, 16 May 2016 16:56:21 +0530
Message-ID: <1463397984-15766-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: Vignesh R <vigneshr@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On am335x-evm, its observed that touchscreen fails to wake system from
suspend if user had finger on touch screen while entering system.
This series addresses the above issue.


Grygorii Strashko (2):
  Input: ti_am335x_tsc - Prevent system suspend when TSC is in use
  Input: ti_am335x_tsc - Ack pending IRQs at probe and before suspend

Vignesh R (1):
  Input: ti_am335x_tsc - Mark IRQ as wakeup capable

 drivers/input/touchscreen/ti_am335x_tsc.c | 14 ++++++++++++++
 include/linux/mfd/ti_am335x_tscadc.h      |  1 +
 2 files changed, 15 insertions(+)

-- 
2.8.2
