From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] Input: i8042 - signal wakeup from atkbd/psmouse
Date: Tue, 26 Mar 2019 17:28:00 -0700
Message-ID: <20190327002800.GA187083@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ravi Chandra Sadineni <ravisadineni@chromium.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shaunak Saha <shaunak.saha@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of signalling wakeup directly from i8042, let psmouse and atkbd
drivers execute basic protocol handling and only then signal wakeup
condition. This solves the issue where we increment wakeup counter
simply because we are getting responses from keyboard/mouse to the
commands we ourselves send to them as part of suspend transition.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/atkbd.c     | 2 ++
 drivers/input/mouse/psmouse-base.c | 2 ++
 drivers/input/serio/i8042.c        | 3 ---
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 850bb259c20e..3ad93e3e2f4c 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -401,6 +401,8 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 		if  (ps2_handle_response(&atkbd->ps2dev, data))
 			goto out;
 
+	pm_wakeup_event(&serio->dev, 0);
+
 	if (!atkbd->enabled)
 		goto out;
 
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index d3ff1fc09af7..94f7ca5ad077 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -373,6 +373,8 @@ static irqreturn_t psmouse_interrupt(struct serio *serio,
 		if  (ps2_handle_response(&psmouse->ps2dev, data))
 			goto out;
 
+	pm_wakeup_event(&serio->dev, 0);
+
 	if (psmouse->state <= PSMOUSE_RESYNCING)
 		goto out;
 
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 95a78ccbd847..6462f1798fbb 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -573,9 +573,6 @@ static irqreturn_t i8042_interrupt(int irq, void *dev_id)
 	port = &i8042_ports[port_no];
 	serio = port->exists ? port->serio : NULL;
 
-	if (irq && serio)
-		pm_wakeup_event(&serio->dev, 0);
-
 	filter_dbg(port->driver_bound, data, "<- i8042 (interrupt, %d, %d%s%s)\n",
 		   port_no, irq,
 		   dfl & SERIO_PARITY ? ", bad parity" : "",
-- 
2.21.0.392.gf8f6787159e-goog


-- 
Dmitry
