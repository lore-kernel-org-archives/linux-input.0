From: Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/5] IR: ene_ir: add support for carrier reports
Date: Fri, 15 Oct 2010 18:06:38 +0200
Message-ID: <1287158799-21486-5-git-send-email-maximlevitsky@gmail.com>
References: <1287158799-21486-1-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lirc-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1287158799-21486-1-git-send-email-maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/lirc-list>,
	<mailto:lirc-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=lirc-list>
List-Post: <mailto:lirc-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:lirc-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/lirc-list>,
	<mailto:lirc-list-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: lirc-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lirc-list-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: mchehab-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Signed-off-by: Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/media/IR/ene_ir.c |   37 +++++++++++++++++++++++++++++--------
 1 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/media/IR/ene_ir.c b/drivers/media/IR/ene_ir.c
index 8639621..1962652 100644
--- a/drivers/media/IR/ene_ir.c
+++ b/drivers/media/IR/ene_ir.c
@@ -193,10 +193,11 @@ static int ene_hw_detect(struct ene_device *dev)
 /* Sense current received carrier */
 void ene_rx_sense_carrier(struct ene_device *dev)
 {
+	DEFINE_IR_RAW_EVENT(ev);
+
+	int carrier, duty_cycle;
 	int period = ene_read_reg(dev, ENE_CIRCAR_PRD);
 	int hperiod = ene_read_reg(dev, ENE_CIRCAR_HPRD);
-	int carrier, duty_cycle;
-
 
 	if (!(period & ENE_CIRCAR_PRD_VALID))
 		return;
@@ -209,13 +210,16 @@ void ene_rx_sense_carrier(struct ene_device *dev)
 	dbg("RX: hardware carrier period = %02x", period);
 	dbg("RX: hardware carrier pulse period = %02x", hperiod);
 
-
 	carrier = 2000000 / period;
 	duty_cycle = (hperiod * 100) / period;
 	dbg("RX: sensed carrier = %d Hz, duty cycle %d%%",
-							carrier, duty_cycle);
-
-	/* TODO: Send carrier & duty cycle to IR layer */
+						carrier, duty_cycle);
+	if (dev->carrier_detect_enabled) {
+		ev.carrier_report = true;
+		ev.carrier = carrier;
+		ev.duty_cycle = duty_cycle;
+		ir_raw_event_store(dev->idev, &ev);
+	}
 }
 
 /* this enables/disables the CIR RX engine */
@@ -724,7 +728,7 @@ static irqreturn_t ene_isr(int irq, void *data)
 
 	dbg_verbose("RX interrupt");
 
-	if (dev->carrier_detect_enabled || debug)
+	if (dev->hw_learning_and_tx_capable)
 		ene_rx_sense_carrier(dev);
 
 	/* On hardware that don't support extra buffer we need to trust
@@ -897,6 +901,23 @@ static int ene_set_learning_mode(void *data, int enable)
 	return 0;
 }
 
+static int ene_set_carrier_report(void *data, int enable)
+{
+	struct ene_device *dev = (struct ene_device *)data;
+	unsigned long flags;
+
+	if (enable == dev->carrier_detect_enabled)
+		return 0;
+
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	dev->carrier_detect_enabled = enable;
+	ene_rx_disable(dev);
+	ene_rx_setup(dev);
+	ene_rx_enable(dev);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
+	return 0;
+}
+
 /* outside interface: enable or disable idle mode */
 static void ene_rx_set_idle(void *data, bool idle)
 {
@@ -1029,7 +1050,7 @@ static int ene_probe(struct pnp_dev *pnp_dev, const struct pnp_device_id *id)
 		ir_props->s_tx_mask = ene_set_tx_mask;
 		ir_props->s_tx_carrier = ene_set_tx_carrier;
 		ir_props->s_tx_duty_cycle = ene_set_tx_duty_cycle;
-		/* ir_props->s_carrier_report = ene_set_carrier_report; */
+		ir_props->s_carrier_report = ene_set_carrier_report;
 	}
 
 	ene_setup_hw_buffer(dev);
-- 
1.7.1


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
