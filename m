From: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: [PATCH V3] i8042: Increment wakeup_count for the respective port.
Date: Tue,  5 Jun 2018 12:01:24 -0700
Message-ID: <20180605190124.191827-1-ravisadineni@chromium.org>
References: <CAJZ5v0iu23LqdKUJA5OQGF3Yqq3=k+nfNUVn-LFpYgkDrgokCg@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iu23LqdKUJA5OQGF3Yqq3=k+nfNUVn-LFpYgkDrgokCg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, rafael@kernel.org, chenhong3@huawei.com, ravisadineni@google.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, rajatja@google.com, bleung@google.com, furquan@chromium.org, Ravi Chandra Sadineni <ravisadineni@chromium.org>
List-Id: linux-input@vger.kernel.org

Call pm_wakeup_event on every irq. This should help us in identifying if
keyboard was a potential wake reason for the last resume.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
V3: Remove the unnecessary device_may_wakeup check.
V2: Increment the wakeup count only when there is a irq and not when the
method is called internally.

 drivers/input/serio/i8042.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 824f4c1c1f310..b8bc71569349d 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -573,6 +573,9 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 	port = &i8042_ports[port_no];
 	serio = port->exists ? port->serio : NULL;
 
+	if (irq && serio)
+		pm_wakeup_event(&serio->dev, 0);
+
 	filter_dbg(port->driver_bound, data, "<- i8042 (interrupt, %d, %d%s%s)\n",
 		   port_no, irq,
 		   dfl & SERIO_PARITY ? ", bad parity" : "",
-- 
2.17.1.1185.g55be947832-goog
