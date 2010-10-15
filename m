From: Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/7] IR: plug races in IR raw thread.
Date: Fri, 15 Oct 2010 17:07:47 +0200
Message-ID: <1287155273-16171-2-git-send-email-maximlevitsky@gmail.com>
References: <1287155273-16171-1-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lirc-list-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1287155273-16171-1-git-send-email-maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

Unfortunelly (my fault) the kernel thread that now handles IR processing
has classical races in regard to wakeup and stop.
This patch hopefully closes them all.
Tested with module reload running in a loop, while receiver is blasted
with IR data for 10 minutes.

Signed-off-by: Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Acked-by: Jarod Wilson <jarod-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/media/IR/ir-core-priv.h |    2 ++
 drivers/media/IR/ir-raw-event.c |   34 +++++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/media/IR/ir-core-priv.h b/drivers/media/IR/ir-core-priv.h
index a85a8c7..761e7f4 100644
--- a/drivers/media/IR/ir-core-priv.h
+++ b/drivers/media/IR/ir-core-priv.h
@@ -17,6 +17,7 @@
 #define _IR_RAW_EVENT
 
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <media/ir-core.h>
 
 struct ir_raw_handler {
@@ -33,6 +34,7 @@ struct ir_raw_handler {
 struct ir_raw_event_ctrl {
 	struct list_head		list;		/* to keep track of raw clients */
 	struct task_struct		*thread;
+	spinlock_t			lock;
 	struct kfifo			kfifo;		/* fifo for the pulse/space durations */
 	ktime_t				last_event;	/* when last event occurred */
 	enum raw_event_type		last_type;	/* last event type */
diff --git a/drivers/media/IR/ir-raw-event.c b/drivers/media/IR/ir-raw-event.c
index 8e0e1b1..119b567 100644
--- a/drivers/media/IR/ir-raw-event.c
+++ b/drivers/media/IR/ir-raw-event.c
@@ -39,22 +39,34 @@ static int ir_raw_event_thread(void *data)
 	struct ir_raw_event ev;
 	struct ir_raw_handler *handler;
 	struct ir_raw_event_ctrl *raw = (struct ir_raw_event_ctrl *)data;
+	int retval;
 
 	while (!kthread_should_stop()) {
-		try_to_freeze();
 
-		mutex_lock(&ir_raw_handler_lock);
+		spin_lock_irq(&raw->lock);
+		retval = kfifo_out(&raw->kfifo, &ev, sizeof(ev));
+
+		if (!retval) {
+			set_current_state(TASK_INTERRUPTIBLE);
 
-		while (kfifo_out(&raw->kfifo, &ev, sizeof(ev)) == sizeof(ev)) {
-			list_for_each_entry(handler, &ir_raw_handler_list, list)
-				handler->decode(raw->input_dev, ev);
-			raw->prev_ev = ev;
+			if (kthread_should_stop())
+				set_current_state(TASK_RUNNING);
+
+			spin_unlock_irq(&raw->lock);
+			schedule();
+			continue;
 		}
 
-		mutex_unlock(&ir_raw_handler_lock);
+		spin_unlock_irq(&raw->lock);
 
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule();
+
+		BUG_ON(retval != sizeof(ev));
+
+		mutex_lock(&ir_raw_handler_lock);
+		list_for_each_entry(handler, &ir_raw_handler_list, list)
+			handler->decode(raw->input_dev, ev);
+		raw->prev_ev = ev;
+		mutex_unlock(&ir_raw_handler_lock);
 	}
 
 	return 0;
@@ -232,11 +244,14 @@ EXPORT_SYMBOL_GPL(ir_raw_event_set_idle);
 void ir_raw_event_handle(struct input_dev *input_dev)
 {
 	struct ir_input_dev *ir = input_get_drvdata(input_dev);
+	unsigned long flags;
 
 	if (!ir->raw)
 		return;
 
+	spin_lock_irqsave(&ir->raw->lock, flags);
 	wake_up_process(ir->raw->thread);
+	spin_unlock_irqrestore(&ir->raw->lock, flags);
 }
 EXPORT_SYMBOL_GPL(ir_raw_event_handle);
 
@@ -275,6 +290,7 @@ int ir_raw_event_register(struct input_dev *input_dev)
 		return rc;
 	}
 
+	spin_lock_init(&ir->raw->lock);
 	ir->raw->thread = kthread_run(ir_raw_event_thread, ir->raw,
 			"rc%u",  (unsigned int)ir->devno);
 
-- 
1.7.1


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
