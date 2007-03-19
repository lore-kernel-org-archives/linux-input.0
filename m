From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 6/7] usbhid: add /proc/usbhid/device_quirks handler
Date: Sun, 18 Mar 2007 22:22:11 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0703182043570.21893@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org


From: Paul Walmsley <paul@booyaka.com>

Add a procfs file, /proc/usbhid/device_quirks.  Reading this file returns
a list of all currently active USB HID quirks.  Writing a specially-formatted
string (documented in the Kconfig option USBHID_PROC_FS text) will add, 
replace, or remove existing quirks.

Signed-off-by: Paul Walmsley <paul@booyaka.com>

---
  dev/drivers/usb/input/hid-core.c |  188 ++++++++++++++++++++++++++++++++++++++-
  1 file changed, 185 insertions(+), 3 deletions(-)

Index: linux/dev/drivers/usb/input/hid-core.c
===================================================================
--- linux.orig/dev/drivers/usb/input/hid-core.c
+++ linux/dev/drivers/usb/input/hid-core.c
@@ -5,6 +5,7 @@
   *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
   *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
   *  Copyright (c) 2006-2007 Jiri Kosina
+ *  Copyright (c) 2007 Paul Walmsley
   */

  /*
@@ -27,6 +28,9 @@
  #include <linux/input.h>
  #include <linux/wait.h>
  #include <linux/rwsem.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/uaccess.h>

  #include <linux/usb.h>

@@ -1167,20 +1171,192 @@ static int modify_quirk_list(const char
  	/* If we didn't edit the list, we mustn't have found an existing
  	 * entry, so add the new quirk to the end of the list
  	 */
-	if (!list_edited)
+	if (!list_edited) {
  		if (q_new->hid_bl_item.quirks != 0) {
  			list_add_tail(&q_new->node, &quirks_list);
  		} else {
-			/* Cannot add a quirk of 0x0 */
+			/* Adding a quirk of 0x0 is a no-op */
  			kfree(q_new);
-			return -EINVAL;
  		}
+	}

  	up_write(&quirks_list_rwsem);

  	return 0;
  }

+#ifdef CONFIG_USBHID_PROC_FS
+
+/* seq_file-related functions */
+
+static void *seq_device_quirks_start(struct seq_file *m,
+                                     loff_t *pos)
+{
+	struct quirks_list_struct *q;
+	loff_t off = 0;
+
+	down_read(&quirks_list_rwsem);
+
+	if (*pos == 0)
+		return SEQ_START_TOKEN;
+
+	/* Fast-forward through the list, looking for entry *pos */
+	list_for_each_entry(q, &quirks_list, node) {
+		if ((*pos - 1) == off++)
+			return q;
+	}
+
+	/* pos was larger than the length of the list */
+	return NULL;
+}
+
+static void *seq_device_quirks_next(struct seq_file *m,
+                                    void *v,
+                                    loff_t *pos)
+{
+	struct list_head *q;
+
+	if (v == SEQ_START_TOKEN)
+		q = &quirks_list;
+	else
+		q = &((struct quirks_list_struct *)v)->node;
+
+	if (list_is_last(q, &quirks_list))
+		return NULL;
+
+	++*pos;
+
+	return list_entry(q->next, struct quirks_list_struct, node);
+}
+
+static void seq_device_quirks_stop(struct seq_file *m,
+				   void *v)
+{
+	up_read(&quirks_list_rwsem);
+}
+
+static int seq_device_quirks_show(struct seq_file *m,
+                                  void *v)
+{
+	struct quirks_list_struct *q;
+
+	if (v == SEQ_START_TOKEN)
+		seq_printf(m, "vendor\tprod\tpmask\tquirks\n");
+	else {
+		q = v;
+		seq_printf(m, "0x%04hx\t0x%04hx\t0x%04hx\t0x%08x\n",
+			   q->hid_bl_item.idVendor,
+			   q->hid_bl_item.idProduct,
+			   q->hid_bl_item.idProductMask,
+			   q->hid_bl_item.quirks);
+	}
+
+	return 0;
+}
+
+static const struct seq_operations device_quirks_seqops = {
+	.start         = seq_device_quirks_start,
+	.next          = seq_device_quirks_next,
+	.stop          = seq_device_quirks_stop,
+	.show          = seq_device_quirks_show,
+};
+
+
+/* procfs-related functions */
+
+static int proc_open_device_quirks(struct inode *inode,
+                                   struct file *file)
+{
+	return seq_open(file, &device_quirks_seqops);
+}
+
+static ssize_t proc_write_device_quirks(struct file *file,
+                                        const char *buffer,
+                                        size_t count,
+                                        loff_t *ppos)
+{
+	char in_buf[MAX_USBHID_QUIRK_LEN + 1];
+	ssize_t len;
+
+	/* Copy the command string in from userspace, ensure that it is
+	 * null-terminated
+	 */
+	len = (count > MAX_USBHID_QUIRK_LEN) ? MAX_USBHID_QUIRK_LEN : count;
+
+	if (copy_from_user(in_buf, buffer, len))
+		return -EFAULT;
+
+	in_buf[len] = '\0';
+
+	modify_quirk_list(in_buf);
+
+	return len;
+}
+
+
+static const struct file_operations proc_device_quirks_fops = {
+	.open		= proc_open_device_quirks,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+	.write		= proc_write_device_quirks,
+};
+
+/**
+ * usbhid_procfs_init: set up the usbhid/, usbhid/device_quirks procfs entries
+ *
+ * Description:
+ *     Creates the procfs directory usbhid/ and the device_quirks
+ *     file inside it.
+ *
+ * Returns: 0 OK, -error on failure.
+ */
+static int usbhid_procfs_init(void)
+{
+	struct proc_dir_entry *qf, *usbhid_dir;
+
+	/* Create usbhid/ directory */
+	usbhid_dir = proc_mkdir("usbhid", NULL);
+	if (usbhid_dir == NULL) {
+		dbg("Could not create procfs directory");
+		return -ENOMEM;
+	}
+	usbhid_dir->owner = THIS_MODULE;
+
+	/* Create usbhid/device_quirks file */
+	qf = create_proc_entry("device_quirks", 0644, usbhid_dir);
+	if (qf == NULL) {
+		dbg("Could not create procfs usbhid/device_quirks file");
+		return -ENOMEM;
+	}
+	qf->owner = THIS_MODULE;
+	qf->proc_fops = &proc_device_quirks_fops;
+
+	return 0;
+}
+
+/**
+ * usbhid_procfs_exit: remove the usbhid/, usbhid/device_quirks procfs entries
+ *
+ * Description:
+ *     Removes the procfs directory usbhid/ and the device_quirks
+ *     file inside it.
+ *
+ * Returns: nothing
+ */
+static void usbhid_procfs_exit(void)
+{
+	remove_proc_entry("usbhid/device_quirks", NULL);
+	remove_proc_entry("usbhid", NULL);
+}
+
+#else /* CONFIG_USBHID_PROC_FS */
+
+static inline int usbhid_procfs_init(void) { return 0; }
+static inline void usbhid_procfs_exit(void) {}
+
+#endif /* CONFIG_USBHID_PROC_FS */
+

  /**
   * usbhid_quirks_init: copy the hid_blacklist[] into the quirks_list
@@ -1682,6 +1858,9 @@ static int __init hid_init(void)
  	retval = usbhid_quirks_init();
  	if (retval)
                  goto usbhid_quirks_init_fail;
+	retval = usbhid_procfs_init();
+	if (retval)
+                goto usbhid_procfs_init_fail;
  	retval = hiddev_init();
  	if (retval)
  		goto hiddev_init_fail;
@@ -1695,6 +1874,8 @@ usb_register_fail:
  	hiddev_exit();
  hiddev_init_fail:
          usbhid_quirks_exit();
+usbhid_procfs_init_fail:
+	usbhid_procfs_exit();
  usbhid_quirks_init_fail:
  	return retval;
  }
@@ -1703,6 +1884,7 @@ static void __exit hid_exit(void)
  {
  	usb_deregister(&hid_driver);
  	hiddev_exit();
+	usbhid_procfs_exit();
  	usbhid_quirks_exit();
  }
