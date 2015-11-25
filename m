From: Todd Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH] serio: delay resume error handling til PM complete
Date: Tue, 24 Nov 2015 16:58:13 -0800
Message-ID: <d2cc800492b6d0f800d87d73a6be738e42b2023d.1448068686.git.todd.e.brandt@linux.intel.com>
References: <cover.1448068686.git.todd.e.brandt@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:2389 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932671AbbKYA6W (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Nov 2015 19:58:22 -0500
In-Reply-To: <cover.1448068686.git.todd.e.brandt@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: stern@rowland.harvard.edu, todd.e.brandt@intel.com, todd.e.brandt@linux.intel.com

 Delay the error rescan for serio devices until the PM
 complete phase. PM complete requires locking each device 
 before checking for and executing the complete callbacks.
 Serio rescan also locks the device in order to reinit on
 error, so this can cause a conflict which will result in
 unnecessary delay.

 History: 

 The issue was discovered on an ivy bridge platform with
 i8042 keyboard/mouse. The mouse resume fails and the serio
 driver begins a full driver rescan in the resume phase. Since
 the device is locked during re-initialization it conflicts
 with the PM subsystem's attempt to lock the device to check
 for a complete callback. Thus dpm_complete is delayed for
 almost a second.

 I've tried to fix this by altering the PM subsystem code 
 itself so that it doesn't have to lock a device in order to
 check if it has a callback, but this was too much for an 
 isolated case. This approach attempts to fix the problem in 
 the serio driver itself. 

 The analyze_suspend timeline highlighting the underlying 
 calls before and after the patch is applied is here:

 http://01.org/suspendresume/blogs/tebrandt/2015/fixing-delay-when-errors-occur-serio-resume

Signed-off-by: Todd Brandt <todd.e.brandt@linux.intel.com>
---
 drivers/input/serio/serio.c | 40 ++++++++++++++++++++++++++++++++++------
 include/linux/serio.h       |  1 +
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
index 8f82897..98def59 100644
--- a/drivers/input/serio/serio.c
+++ b/drivers/input/serio/serio.c
@@ -50,7 +50,7 @@ static DEFINE_MUTEX(serio_mutex);
 static LIST_HEAD(serio_list);
 
 static void serio_add_port(struct serio *serio);
-static int serio_reconnect_port(struct serio *serio);
+static int serio_reconnect_port(struct serio *serio, bool in_resume);
 static void serio_disconnect_port(struct serio *serio);
 static void serio_reconnect_subtree(struct serio *serio);
 static void serio_attach_driver(struct serio_driver *drv);
@@ -148,6 +148,7 @@ static void serio_find_driver(struct serio *serio)
 enum serio_event_type {
 	SERIO_RESCAN_PORT,
 	SERIO_RECONNECT_PORT,
+	SERIO_RECONNECT_PORT_RESUME,
 	SERIO_RECONNECT_SUBTREE,
 	SERIO_REGISTER_PORT,
 	SERIO_ATTACH_DRIVER,
@@ -227,7 +228,11 @@ static void serio_handle_event(struct work_struct *work)
 			break;
 
 		case SERIO_RECONNECT_PORT:
-			serio_reconnect_port(event->object);
+			serio_reconnect_port(event->object, false);
+			break;
+
+		case SERIO_RECONNECT_PORT_RESUME:
+			serio_reconnect_port(event->object, true);
 			break;
 
 		case SERIO_RESCAN_PORT:
@@ -599,11 +604,18 @@ static void serio_destroy_port(struct serio *serio)
  * there was no device to begin with) we do full rescan in
  * hope of finding a driver for the port.
  */
-static int serio_reconnect_port(struct serio *serio)
+static int serio_reconnect_port(struct serio *serio, bool in_resume)
 {
 	int error = serio_reconnect_driver(serio);
 
-	if (error) {
+	if (error && in_resume) {
+		/*
+		 * Delay the rescan until the complete phase, since PM
+		 * has to lock the device to check for a complete call.
+		 * serio_find_driver locks the device for a long time.
+		 */
+		serio->resume_error = true;
+	} else if (error) {
 		serio_disconnect_port(serio);
 		serio_find_driver(serio);
 	}
@@ -621,7 +633,7 @@ static void serio_reconnect_subtree(struct serio *root)
 	int error;
 
 	do {
-		error = serio_reconnect_port(s);
+		error = serio_reconnect_port(s, false);
 		if (!error) {
 			/*
 			 * Reconnect was successful, move on to do the
@@ -958,14 +970,30 @@ static int serio_resume(struct device *dev)
 	 * Driver reconnect can take a while, so better let kseriod
 	 * deal with it.
 	 */
-	serio_queue_event(serio, NULL, SERIO_RECONNECT_PORT);
+	serio_queue_event(serio, NULL, SERIO_RECONNECT_PORT_RESUME);
 
 	return 0;
 }
 
+static void serio_complete(struct device *dev)
+{
+	struct serio *serio = to_serio_port(dev);
+
+	if (!serio->resume_error)
+		return;
+
+	/*
+	 * If an error happened in resume, issue the rescan in the
+	 * complete phase so that it doesn't hold up the queue
+	 */
+	serio->resume_error = false;
+	serio_queue_event(serio, NULL, SERIO_RESCAN_PORT);
+}
+
 static const struct dev_pm_ops serio_pm_ops = {
 	.suspend	= serio_suspend,
 	.resume		= serio_resume,
+	.complete	= serio_complete,
 	.poweroff	= serio_suspend,
 	.restore	= serio_resume,
 };
diff --git a/include/linux/serio.h b/include/linux/serio.h
index df4ab5d..df8a8eaf 100644
--- a/include/linux/serio.h
+++ b/include/linux/serio.h
@@ -50,6 +50,7 @@ struct serio {
 	struct device dev;
 
 	struct list_head node;
+	bool resume_error:1;  /* an error occurred in resume */
 };
 #define to_serio_port(d)	container_of(d, struct serio, dev)
 
-- 
2.1.4

