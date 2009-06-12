From: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Subject: [PATCH 2/2] HID: use debugfs for events/reports dumping
Date: Fri, 12 Jun 2009 15:27:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906121526250.7457@wotan.suse.de>
References: <1244384236.30768.5690.camel@cookie.hadess.net>  <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz>  <1244589738.5973.1954.camel@cookie.hadess.net> <1244617386.3068.22.camel@localhost.localdomain>
 <alpine.LNX.2.00.0906121521490.7457@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LNX.2.00.0906121521490.7457-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This is a followup patch to the one implemeting rdesc representation in debugfs
rather than being dependent on compile-time CONFIG_HID_DEBUG setting.

The API of the appropriate formatting functions is slightly modified -- if
they are passed seq_file pointer, the one-shot output for 'rdesc' file mode
is used, and therefore the message is formatted into the corresponding seq_file
immediately.

Otherwise the called function allocated a new buffer, formats the text into the
buffer and returns the pointer to it, so that it can be queued into the ring-buffer
of the processess blocked waiting on input on 'events' file in debugfs.

'debug' parameter to the 'hid' module is now used solely for the prupose of inetrnal
driver state debugging (parser, transport, etc).

Signed-off-by: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
---
 drivers/hid/hid-core.c    |   42 ++++++--
 drivers/hid/hid-debug.c   |  239 +++++++++++++++++++++++++++++++++++++++++----
 include/linux/hid-debug.h |   18 +++-
 include/linux/hid.h       |   26 ++----
 4 files changed, 276 insertions(+), 49 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index d4317db..449bd74 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -46,7 +46,7 @@
 
 int hid_debug = 0;
 module_param_named(debug, hid_debug, int, 0600);
-MODULE_PARM_DESC(debug, "HID debugging (0=off, 1=probing info, 2=continuous data dumping)");
+MODULE_PARM_DESC(debug, "toggle HID debugging messages");
 EXPORT_SYMBOL_GPL(hid_debug);
 
 /*
@@ -859,7 +859,7 @@ static void hid_process_event(struct hid_device *hid, struct hid_field *field,
 	struct hid_driver *hdrv = hid->driver;
 	int ret;
 
-	hid_dump_input(usage, value);
+	hid_dump_input(hid, usage, value);
 
 	if (hdrv && hdrv->event && hid_match_usage(hid, usage)) {
 		ret = hdrv->event(hid, field, usage, value);
@@ -981,7 +981,7 @@ int hid_set_field(struct hid_field *field, unsigned offset, __s32 value)
 {
 	unsigned size = field->report_size;
 
-	hid_dump_input(field->usage + offset, value);
+	hid_dump_input(field->report->device, field->usage + offset, value);
 
 	if (offset >= field->report_count) {
 		dbg_hid("offset (%d) exceeds report_count (%d)\n", offset, field->report_count);
@@ -1075,6 +1075,7 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int i
 	struct hid_report_enum *report_enum = hid->report_enum + type;
 	struct hid_driver *hdrv = hid->driver;
 	struct hid_report *report;
+	char *buf;
 	unsigned int i;
 	int ret;
 
@@ -1086,18 +1087,36 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int i
 		return -1;
 	}
 
-	dbg_hid("report (size %u) (%snumbered)\n", size, report_enum->numbered ? "" : "un");
+	buf = kmalloc(sizeof(char) * HID_DEBUG_BUFSIZE,
+			interrupt ? GFP_ATOMIC : GFP_KERNEL);
+
+	if (!buf) {
+		report = hid_get_report(report_enum, data);
+		goto nomem;
+	}
+
+	snprintf(buf, HID_DEBUG_BUFSIZE - 1,
+			"\nreport (size %u) (%snumbered)\n", size, report_enum->numbered ? "" : "un");
+	hid_debug_event(hid, buf);
 
 	report = hid_get_report(report_enum, data);
 	if (!report)
 		return -1;
 
 	/* dump the report */
-	dbg_hid("report %d (size %u) = ", report->id, size);
-	for (i = 0; i < size; i++)
-		dbg_hid_line(" %02x", data[i]);
-	dbg_hid_line("\n");
+	snprintf(buf, HID_DEBUG_BUFSIZE - 1,
+			"report %d (size %u) = ", report->id, size);
+	hid_debug_event(hid, buf);
+	for (i = 0; i < size; i++) {
+		snprintf(buf, HID_DEBUG_BUFSIZE - 1,
+				" %02x", data[i]);
+		hid_debug_event(hid, buf);
+	}
+	hid_debug_event(hid, "\n");
+
+	kfree(buf);
 
+nomem:
 	if (hdrv && hdrv->raw_event && hid_match_report(hid, report)) {
 		ret = hdrv->raw_event(hid, report, data, size);
 		if (ret != 0)
@@ -1756,6 +1775,9 @@ struct hid_device *hid_allocate_device(void)
 	for (i = 0; i < HID_REPORT_TYPES; i++)
 		INIT_LIST_HEAD(&hdev->report_enum[i].report_list);
 
+	init_waitqueue_head(&hdev->debug_wait);
+	INIT_LIST_HEAD(&hdev->debug_list);
+
 	return hdev;
 err:
 	put_device(&hdev->dev);
@@ -1844,8 +1866,8 @@ static int __init hid_init(void)
 	int ret;
 
 	if (hid_debug)
-		printk(KERN_WARNING "HID: hid_debug parameter has been deprecated. "
-				"Debugging data are now provided via debugfs\n");
+		printk(KERN_WARNING "HID: hid_debug is now used solely for parser and driver debugging.\n"
+				"HID: debugfs is now used for inspecting the device (report descriptor, reports)\n");
 
 	ret = bus_register(&hid_bus_type);
 	if (ret) {
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 067e173..a331a18 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -28,6 +28,10 @@
 
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+#include <linux/poll.h>
+
 #include <linux/hid.h>
 #include <linux/hid-debug.h>
 
@@ -335,49 +339,86 @@ static const struct hid_usage_entry hid_usage_table[] = {
   { 0, 0, NULL }
 };
 
-static void resolv_usage_page(unsigned page, struct seq_file *f) {
+/* Either output directly into simple seq_file, or (if f == NULL)
+ * allocate a separate buffer that will then be passed to the 'events'
+ * ringbuffer.
+ *
+ * This is because these functions can be called both for "one-shot"
+ * "rdesc" while resolving, or for blocking "events".
+ *
+ * This holds both for resolv_usage_page() and hid_resolv_usage().
+ */
+static char *resolv_usage_page(unsigned page, struct seq_file *f) {
 	const struct hid_usage_entry *p;
+	char *buf = NULL;
+
+	if (!f) {
+		buf = kzalloc(sizeof(char) * HID_DEBUG_BUFSIZE, GFP_ATOMIC);
+		if (!buf)
+			return ERR_PTR(-ENOMEM);
+	}
 
 	for (p = hid_usage_table; p->description; p++)
 		if (p->page == page) {
-			if (!f)
-				printk("%s", p->description);
-			else
+			if (!f) {
+				snprintf(buf, HID_DEBUG_BUFSIZE, "%s",
+						p->description);
+				return buf;
+			}
+			else {
 				seq_printf(f, "%s", p->description);
-			return;
+				return NULL;
+			}
 		}
 	if (!f)
-		printk("%04x", page);
+		snprintf(buf, HID_DEBUG_BUFSIZE, "%04x", page);
 	else
 		seq_printf(f, "%04x", page);
+	return buf;
 }
 
-void hid_resolv_usage(unsigned usage, struct seq_file *f) {
+char *hid_resolv_usage(unsigned usage, struct seq_file *f) {
 	const struct hid_usage_entry *p;
+	char *buf = NULL;
+	int len = 0;
 
-	resolv_usage_page(usage >> 16, f);
-	if (!f)
-		printk(".");
-	else
+	buf = resolv_usage_page(usage >> 16, f);
+	if (IS_ERR(buf)) {
+		printk(KERN_ERR "error allocating HID debug buffer\n");
+		return NULL;
+	}
+
+
+	if (!f) {
+		len = strlen(buf);
+		snprintf(buf+len, max(0, HID_DEBUG_BUFSIZE - len), ".");
+		len++;
+	}
+	else {
 		seq_printf(f, ".");
+	}
 	for (p = hid_usage_table; p->description; p++)
 		if (p->page == (usage >> 16)) {
 			for(++p; p->description && p->usage != 0; p++)
 				if (p->usage == (usage & 0xffff)) {
 					if (!f)
-						printk("%s", p->description);
+						snprintf(buf + len,
+							max(0,HID_DEBUG_BUFSIZE - len - 1),
+							"%s", p->description);
 					else
 						seq_printf(f,
 							"%s",
 							p->description);
-					return;
+					return buf;
 				}
 			break;
 		}
 	if (!f)
-		printk("%04x", usage & 0xffff);
+		snprintf(buf + len, max(0, HID_DEBUG_BUFSIZE - len - 1),
+				"%04x", usage & 0xffff);
 	else
 		seq_printf(f, "%04x", usage & 0xffff);
+	return buf;
 }
 EXPORT_SYMBOL_GPL(hid_resolv_usage);
 
@@ -508,13 +549,37 @@ void hid_dump_device(struct hid_device *device, struct seq_file *f)
 }
 EXPORT_SYMBOL_GPL(hid_dump_device);
 
-void hid_dump_input(struct hid_usage *usage, __s32 value) {
-	if (hid_debug < 2)
+/* enqueue string to 'events' ring buffer */
+void hid_debug_event(struct hid_device *hdev, char *buf)
+{
+	int i;
+	struct hid_debug_list *list;
+
+	list_for_each_entry(list, &hdev->debug_list, node) {
+		for (i = 0; i <= strlen(buf); i++)
+			list->hid_debug_buf[(list->tail + i) % (HID_DEBUG_BUFSIZE - 1)] =
+				buf[i];
+		list->tail = (list->tail + i) % (HID_DEBUG_BUFSIZE - 1);
+        }
+}
+EXPORT_SYMBOL_GPL(hid_debug_event);
+
+void hid_dump_input(struct hid_device *hdev, struct hid_usage *usage, __s32 value)
+{
+	char *buf;
+	int len;
+
+	buf = hid_resolv_usage(usage->hid, NULL);
+	if (!buf)
 		return;
+	len = strlen(buf);
+	snprintf(buf + len, HID_DEBUG_BUFSIZE - len - 1, " = %d\n", value);
+
+	hid_debug_event(hdev, buf);
+
+	kfree(buf);
+        wake_up_interruptible(&hdev->debug_wait);
 
-	printk(KERN_DEBUG "hid-debug: input ");
-	hid_resolv_usage(usage->hid, NULL);
-	printk(" = %d\n", value);
 }
 EXPORT_SYMBOL_GPL(hid_dump_input);
 
@@ -808,6 +873,7 @@ void hid_dump_input_mapping(struct hid_device *hid, struct seq_file *f)
 
 }
 
+
 static int hid_debug_rdesc_show(struct seq_file *f, void *p)
 {
 	struct hid_device *hdev = f->private;
@@ -831,6 +897,126 @@ static int hid_debug_rdesc_open(struct inode *inode, struct file *file)
 	return single_open(file, hid_debug_rdesc_show, inode->i_private);
 }
 
+static int hid_debug_events_open(struct inode *inode, struct file *file)
+{
+	int err = 0;
+	struct hid_debug_list *list;
+
+	if (!(list = kzalloc(sizeof(struct hid_debug_list), GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	if (!(list->hid_debug_buf = kzalloc(sizeof(char) * HID_DEBUG_BUFSIZE, GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto out;
+	}
+	list->hdev = (struct hid_device *) inode->i_private;
+	file->private_data = list;
+	mutex_init(&list->read_mutex);
+
+	list_add_tail(&list->node, &list->hdev->debug_list);
+
+out:
+	return err;
+}
+
+static ssize_t hid_debug_events_read(struct file *file, char __user *buffer,
+		size_t count, loff_t *ppos)
+{
+	struct hid_debug_list *list = file->private_data;
+	int ret = 0, len;
+	DECLARE_WAITQUEUE(wait, current);
+
+	while (ret == 0) {
+		mutex_lock(&list->read_mutex);
+		if (list->head == list->tail) {
+			add_wait_queue(&list->hdev->debug_wait, &wait);
+			set_current_state(TASK_INTERRUPTIBLE);
+
+			while (list->head == list->tail) {
+				if (file->f_flags & O_NONBLOCK) {
+					ret = -EAGAIN;
+					break;
+				}
+				if (signal_pending(current)) {
+					ret = -ERESTARTSYS;
+					break;
+				}
+
+				if (!list->hdev || !list->hdev->debug) {
+					ret = -EIO;
+					break;
+				}
+
+				/* allow O_NONBLOCK from other threads */
+				mutex_unlock(&list->read_mutex);
+				schedule();
+				mutex_lock(&list->read_mutex);
+				set_current_state(TASK_INTERRUPTIBLE);
+			}
+
+			set_current_state(TASK_RUNNING);
+			remove_wait_queue(&list->hdev->debug_wait, &wait);
+		}
+
+		if (ret)
+			goto out;
+
+		/* pass the ringbuffer contents to userspace */
+copy_rest:
+		if (list->tail == list->head)
+			goto out;
+		if (list->tail > list->head) {
+			len = list->tail - list->head;
+
+			if (copy_to_user(buffer + ret, &list->hid_debug_buf[list->head], len)) {
+				ret = -EFAULT;
+				goto out;
+			}
+			ret += len;
+			list->head += len;
+		} else {
+			len = HID_DEBUG_BUFSIZE - list->head;
+
+			if (copy_to_user(buffer, &list->hid_debug_buf[list->head], len)) {
+				ret = -EFAULT;
+				goto out;
+			}
+			list->head = 0;
+			ret += len;
+			goto copy_rest;
+		}
+
+	}
+out:
+	mutex_unlock(&list->read_mutex);
+	return ret;
+}
+
+static unsigned int hid_debug_events_poll(struct file *file, poll_table *wait)
+{
+	struct hid_debug_list *list = file->private_data;
+
+	poll_wait(file, &list->hdev->debug_wait, wait);
+	if (list->head != list->tail)
+		return POLLIN | POLLRDNORM;
+	if (!list->hdev->debug)
+		return POLLERR | POLLHUP;
+	return 0;
+}
+
+static int hid_debug_events_release(struct inode *inode, struct file *file)
+{
+	struct hid_debug_list *list = file->private_data;
+
+	list_del(&list->node);
+	kfree(list->hid_debug_buf);
+	kfree(list);
+
+	return 0;
+}
+
 static const struct file_operations hid_debug_rdesc_fops = {
 	.open           = hid_debug_rdesc_open,
 	.read           = seq_read,
@@ -838,16 +1024,31 @@ static const struct file_operations hid_debug_rdesc_fops = {
 	.release        = single_release,
 };
 
+static const struct file_operations hid_debug_events_fops = {
+	.owner =        THIS_MODULE,
+	.open           = hid_debug_events_open,
+	.read           = hid_debug_events_read,
+	.poll		= hid_debug_events_poll,
+	.release        = hid_debug_events_release,
+};
+
+
 void hid_debug_register(struct hid_device *hdev, const char *name)
 {
 	hdev->debug_dir = debugfs_create_dir(name, hid_debug_root);
 	hdev->debug_rdesc = debugfs_create_file("rdesc", 0400,
 			hdev->debug_dir, hdev, &hid_debug_rdesc_fops);
+	hdev->debug_events = debugfs_create_file("events", 0400,
+			hdev->debug_dir, hdev, &hid_debug_events_fops);
+	hdev->debug = 1;
 }
 
 void hid_debug_unregister(struct hid_device *hdev)
 {
+	hdev->debug = 0;
+	wake_up_interruptible(&hdev->debug_wait);
 	debugfs_remove(hdev->debug_rdesc);
+	debugfs_remove(hdev->debug_events);
 	debugfs_remove(hdev->debug_dir);
 }
 
diff --git a/include/linux/hid-debug.h b/include/linux/hid-debug.h
index 516e12c..ec08ac1 100644
--- a/include/linux/hid-debug.h
+++ b/include/linux/hid-debug.h
@@ -24,14 +24,27 @@
 
 #ifdef CONFIG_DEBUG_FS
 
-void hid_dump_input(struct hid_usage *, __s32);
+void hid_dump_input(struct hid_device *, struct hid_usage *, __s32);
 void hid_dump_device(struct hid_device *, struct seq_file *);
 void hid_dump_field(struct hid_field *, int, struct seq_file *);
-void hid_resolv_usage(unsigned, struct seq_file *);
+char *hid_resolv_usage(unsigned, struct seq_file *);
 void hid_debug_register(struct hid_device *, const char *);
 void hid_debug_unregister(struct hid_device *);
 void hid_debug_init(void);
 void hid_debug_exit(void);
+void hid_debug_event(struct hid_device *, char *);
+
+#define HID_DEBUG_BUFSIZE 512
+
+struct hid_debug_list {
+	char *hid_debug_buf;
+	int head;
+	int tail;
+	struct fasync_struct *fasync;
+	struct hid_device *hdev;
+	struct list_head node;
+	struct mutex read_mutex;
+};
 
 #else
 
@@ -44,6 +57,7 @@ void hid_debug_exit(void);
 #define hid_debug_unregister(a)		do { } while (0)
 #define hid_debug_init()		do { } while (0)
 #define hid_debug_exit()		do { } while (0)
+#define hid_debug_event(a,b)		do { } while (0)
 
 #endif
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index da09ab1..60fa529 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -451,10 +451,6 @@ struct hid_device {							/* device report descriptor */
 	char phys[64];							/* Device physical location */
 	char uniq[64];							/* Device unique identifier (serial #) */
 
-	/* debugfs */
-	struct dentry *debug_dir;
-	struct dentry *debug_rdesc;
-
 	void *driver_data;
 
 	/* temporary hid_ff handling (until moved to the drivers) */
@@ -468,6 +464,14 @@ struct hid_device {							/* device report descriptor */
 
 	/* handler for raw output data, used by hidraw */
 	int (*hid_output_raw_report) (struct hid_device *, __u8 *, size_t);
+
+	/* debugging support via debugfs */
+	unsigned short debug;
+	struct dentry *debug_dir;
+	struct dentry *debug_rdesc;
+	struct dentry *debug_events;
+	struct list_head debug_list;
+	wait_queue_head_t debug_wait;
 };
 
 static inline void *hid_get_drvdata(struct hid_device *hdev)
@@ -625,9 +629,7 @@ struct hid_ll_driver {
 
 /* HID core API */
 
-#ifdef CONFIG_HID_DEBUG
 extern int hid_debug;
-#endif
 
 extern int hid_add_device(struct hid_device *);
 extern void hid_destroy_device(struct hid_device *);
@@ -783,21 +785,9 @@ int hid_pidff_init(struct hid_device *hid);
 #define hid_pidff_init NULL
 #endif
 
-#ifdef CONFIG_HID_DEBUG
 #define dbg_hid(format, arg...) if (hid_debug) \
 				printk(KERN_DEBUG "%s: " format ,\
 				__FILE__ , ## arg)
-#define dbg_hid_line(format, arg...) if (hid_debug) \
-				printk(format, ## arg)
-#else
-static inline int __attribute__((format(printf, 1, 2)))
-dbg_hid(const char *fmt, ...)
-{
-	return 0;
-}
-#define dbg_hid_line dbg_hid
-#endif /* HID_DEBUG */
-
 #define err_hid(format, arg...) printk(KERN_ERR "%s: " format "\n" , \
 		__FILE__ , ## arg)
 #endif /* HID_FF */
-- 
1.5.6
