From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: [PATCH V2] i8042: Increment wakeup_count for the respective port.
Date: Fri,  1 Jun 2018 18:07:08 -0700
Message-ID: <20180602010708.152025-1-ravisadineni@chromium.org>
References: <20180601180053.120202-1-ravisadineni@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180601180053.120202-1-ravisadineni@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, chenhong3@huawei.com, ravisadineni@chromium.org, ravisadineni@google.com, dtor@google.com
Cc: tbroch@google.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, rajatja@google.com, bleung@google.com
List-Id: linux-input@vger.kernel.org

Call pm_wakeup_event on every irq. This should help us in identifying if
keyboard was a potential wake reason for the last resume.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
V2: Increment the wakeup count only when there is a irq and not when the
method is called internally.

drivers/input/serio/i8042.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 824f4c1c1f310..2bd6f2633e29a 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -573,6 +573,9 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 	port = &i8042_ports[port_no];
 	serio = port->exists ? port->serio : NULL;
 
+	if (irq && serio && device_may_wakeup(&serio->dev))
+		pm_wakeup_event(&serio->dev, 0);
+
 	filter_dbg(port->driver_bound, data, "<- i8042 (interrupt, %d, %d%s%s)\n",
 		   port_no, irq,
 		   dfl & SERIO_PARITY ? ", bad parity" : "",
-- 
2.17.1.1185.g55be947832-goog
