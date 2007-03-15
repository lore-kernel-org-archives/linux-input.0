From: Helge Deller <deller@gmx.de>
Subject: [INPUT] HIL: fix rwlock recursion bug in hp_sdc_mlc driver
Date: Thu, 15 Mar 2007 21:31:26 +0100
Message-ID: <200703152131.26568.deller@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

the following patch fixes a rwlock recursion bug which happens when insmoding hp_sdc_mlc.ko:

    HP SDC MLC: Registering the System Domain Controller's HIL MLC.
    BUG: rwlock recursion on CPU#0, hotplug/1814, 00854734
    Backtrace:
     [<10267560>] _raw_write_lock+0x50/0x88
     [<10104008>] _write_lock_irqsave+0x14/0x24
     [<008537d4>] hp_sdc_mlc_out+0x38/0x25c [hp_sdc_mlc]
     [<0084ebd8>] hilse_donode+0x308/0x470 [hil_mlc]
     [<0084ed80>] hil_mlcs_process+0x40/0x6c [hil_mlc]
     [<10130f80>] tasklet_action+0x78/0xb8
     [<10130cec>] __do_softirq+0x60/0xcc
     [<1010428c>] __lock_text_end+0x38/0x48
     [<10108348>] do_cpu_irq_mask+0xf0/0x11c
     [<1010b068>] intr_return+0x0/0xc

Please apply,

Helge

-----------------
[INPUT] HIL: fix rwlock recursion bug in hp_sdc_mlc driver

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/input/serio/hil_mlc.c b/drivers/input/serio/hil_mlc.c
index 485b074..93a1a6b 100644
--- a/drivers/input/serio/hil_mlc.c
+++ b/drivers/input/serio/hil_mlc.c
@@ -716,7 +716,9 @@ static int hilse_donode(hil_mlc *mlc)
 		break;
 
 	case HILSE_CTS:
+		write_lock_irqsave(&mlc->lock, flags);
 		nextidx = mlc->cts(mlc) ? node->bad : node->good;
+		write_unlock_irqrestore(&mlc->lock, flags);
 		break;
 
 	default:
diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index 31826e6..6af1998 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -100,6 +100,7 @@ EXPORT_SYMBOL(hp_sdc_release_timer_irq);
 EXPORT_SYMBOL(hp_sdc_release_hil_irq);
 EXPORT_SYMBOL(hp_sdc_release_cooked_irq);
 
+EXPORT_SYMBOL(__hp_sdc_enqueue_transaction);
 EXPORT_SYMBOL(hp_sdc_enqueue_transaction);
 EXPORT_SYMBOL(hp_sdc_dequeue_transaction);
 
@@ -593,18 +594,15 @@ unsigned long hp_sdc_put(void)
 }
 
 /******* Functions called in either user or kernel context ****/
-int hp_sdc_enqueue_transaction(hp_sdc_transaction *this)
+int __hp_sdc_enqueue_transaction(hp_sdc_transaction *this)
 {
-	unsigned long flags;
 	int i;
 
 	if (this == NULL) {
-		tasklet_schedule(&hp_sdc.task);
+		BUG();
 		return -EINVAL;
 	}
 
-	write_lock_irqsave(&hp_sdc.lock, flags);
-
 	/* Can't have same transaction on queue twice */
 	for (i = 0; i < HP_SDC_QUEUE_LEN; i++)
 		if (hp_sdc.tq[i] == this)
@@ -617,21 +615,29 @@ int hp_sdc_enqueue_transaction(hp_sdc_tr
 	for (i = 0; i < HP_SDC_QUEUE_LEN; i++)
 		if (hp_sdc.tq[i] == NULL) {
 			hp_sdc.tq[i] = this;
-			write_unlock_irqrestore(&hp_sdc.lock, flags);
 			tasklet_schedule(&hp_sdc.task);
 			return 0;
 		}
 
-	write_unlock_irqrestore(&hp_sdc.lock, flags);
 	printk(KERN_WARNING PREFIX "No free slot to add transaction.\n");
 	return -EBUSY;
 
  fail:
-	write_unlock_irqrestore(&hp_sdc.lock,flags);
 	printk(KERN_WARNING PREFIX "Transaction add failed: transaction already queued?\n");
 	return -EINVAL;
 }
 
+int hp_sdc_enqueue_transaction(hp_sdc_transaction *this) {
+	unsigned long flags;
+	int ret;
+
+	write_lock_irqsave(&hp_sdc.lock, flags);
+	ret = __hp_sdc_enqueue_transaction(this);
+	write_unlock_irqrestore(&hp_sdc.lock,flags);
+
+	return ret;
+}
+
 int hp_sdc_dequeue_transaction(hp_sdc_transaction *this)
 {
 	unsigned long flags;
diff --git a/drivers/input/serio/hp_sdc_mlc.c b/drivers/input/serio/hp_sdc_mlc.c
index cb0b288..c45ea74 100644
--- a/drivers/input/serio/hp_sdc_mlc.c
+++ b/drivers/input/serio/hp_sdc_mlc.c
@@ -142,14 +142,11 @@ static void hp_sdc_mlc_isr (int irq, voi
 
 static int hp_sdc_mlc_in(hil_mlc *mlc, suseconds_t timeout)
 {
-	unsigned long flags;
 	struct hp_sdc_mlc_priv_s *priv;
 	int rc = 2;
 
 	priv = mlc->priv;
 
-	write_lock_irqsave(&mlc->lock, flags);
-
 	/* Try to down the semaphore */
 	if (down_trylock(&mlc->isem)) {
 		struct timeval tv;
@@ -178,21 +175,16 @@ static int hp_sdc_mlc_in(hil_mlc *mlc, s
  wasup:
 	up(&mlc->isem);
 	rc = 0;
-	goto done;
  done:
-	write_unlock_irqrestore(&mlc->lock, flags);
 	return rc;
 }
 
 static int hp_sdc_mlc_cts(hil_mlc *mlc)
 {
 	struct hp_sdc_mlc_priv_s *priv;
-	unsigned long flags;
 
 	priv = mlc->priv;
 
-	write_lock_irqsave(&mlc->lock, flags);
-
 	/* Try to down the semaphores -- they should be up. */
 	BUG_ON(down_trylock(&mlc->isem));
 	BUG_ON(down_trylock(&mlc->osem));
@@ -221,26 +213,21 @@ static int hp_sdc_mlc_cts(hil_mlc *mlc)
 	priv->tseq[2] = 1;
 	priv->tseq[3] = 0;
 	priv->tseq[4] = 0;
-	hp_sdc_enqueue_transaction(&priv->trans);
+	__hp_sdc_enqueue_transaction(&priv->trans);
  busy:
-	write_unlock_irqrestore(&mlc->lock, flags);
 	return 1;
  done:
 	priv->trans.act.semaphore = &mlc->osem;
 	up(&mlc->csem);
-	write_unlock_irqrestore(&mlc->lock, flags);
 	return 0;
 }
 
 static void hp_sdc_mlc_out(hil_mlc *mlc)
 {
 	struct hp_sdc_mlc_priv_s *priv;
-	unsigned long flags;
 
 	priv = mlc->priv;
 
-	write_lock_irqsave(&mlc->lock, flags);
-
 	/* Try to down the semaphore -- it should be up. */
 	BUG_ON(down_trylock(&mlc->osem));
 
@@ -250,7 +237,7 @@ static void hp_sdc_mlc_out(hil_mlc *mlc)
  do_data:
 	if (priv->emtestmode) {
 		up(&mlc->osem);
-		goto done;
+		return;
 	}
 	/* Shouldn't be sending commands when loop may be busy */
 	BUG_ON(down_trylock(&mlc->csem));
@@ -313,8 +300,6 @@ static void hp_sdc_mlc_out(hil_mlc *mlc)
 	}
  enqueue:
 	hp_sdc_enqueue_transaction(&priv->trans);
- done:
-	write_unlock_irqrestore(&mlc->lock, flags);
 }
 
 static int __init hp_sdc_mlc_init(void)
diff --git a/include/linux/hp_sdc.h b/include/linux/hp_sdc.h
index debd715..9db3d45 100644
--- a/include/linux/hp_sdc.h
+++ b/include/linux/hp_sdc.h
@@ -71,6 +71,7 @@ typedef struct {
 	  struct semaphore *semaphore;	/* Semaphore to sleep on. */
 	} act;
 } hp_sdc_transaction;
+int __hp_sdc_enqueue_transaction(hp_sdc_transaction *this);
 int hp_sdc_enqueue_transaction(hp_sdc_transaction *this);
 int hp_sdc_dequeue_transaction(hp_sdc_transaction *this);
 
