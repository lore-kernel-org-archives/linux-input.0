From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 1/3] input: add dynamic-minor allocation helpers
Date: Thu, 13 Sep 2012 21:19:50 +0200
Message-ID: <1347563992-27980-2-git-send-email-dh.herrmann@googlemail.com>
References: <1347563992-27980-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:39075 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab2IMTST (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 13 Sep 2012 15:18:19 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi8so7313145wib.1
        for <linux-input@vger.kernel.org>; Thu, 13 Sep 2012 12:18:19 -0700 (PDT)
In-Reply-To: <1347563992-27980-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Herrmann <dh.herrmann@googlemail.com>

Every input-handler-backend like evdev and joydev were allocated 32 minor
numbers for historical reasons. This is a very low limit for modern linux
desktops and prevents new technologies like multi-seat from becoming more
useful.

This introduces four new global helpers that allow input-handler-backends
to allocate minors dynamically. New backends can even drop any
static-minor support and allocate all minors dynamically through this API.

All minors that are available beyond the minors-range used for static
allocations can be allocated by this API. The maximum number of devices is
still limited by INPUT_DEVICES+register_chrdev() but can now be extended
to increase the dynamic-minors range.

This patch is fully backwards-compatible and all handlers can be converted
to use this API without breaking backwards-compatiblity. However, new
devices using dynamically allocated minor numbers might not be visible to
old user-space programs that do not use libudev or similar.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/input/input.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/input.h |   5 ++
 2 files changed, 163 insertions(+), 1 deletion(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index 8921c61..34e315e 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -45,7 +45,14 @@ static LIST_HEAD(input_handler_list);
  */
 static DEFINE_MUTEX(input_mutex);
 
+/*
+ * Please note that everything beyond the size of this array is used for
+ * dynamic minor allocations. Please also avoid adding new users to this array.
+ * Instead of relying on static minor-allocations, you should use dynamic minors
+ * exlusively. See input_minor_alloc().
+ */
 static struct input_handler *input_table[8];
+#define INPUT_TABLE_SIZE (sizeof(input_table) / sizeof(*input_table))
 
 static inline int is_event_supported(unsigned int code,
 				     unsigned long *bm, unsigned int max)
@@ -2090,18 +2097,168 @@ void input_unregister_handle(struct input_handle *handle)
 }
 EXPORT_SYMBOL(input_unregister_handle);
 
+/*
+ * Dynamic Minors
+ * Historically, each handler-backend gets 32 minors allocated. This was enough
+ * in old times, but today we often want more input devices. Therefore, if you
+ * run out of minors, you can request new dynamic minors from the input core.
+ * These are above an upper limit so they do not collide with static minors.
+ * Furthermore, you can save an arbitrary data pointer with them so you don't
+ * have to keep a list of dynamic minors yourself.
+ *
+ * There can be up to INPUT_TABLE_SIZE static minor users with 32 minors for
+ * each. Therefore, we start allocating dynamic minors beyond
+ * INPUT_TABLE_SIZE << 5. But we still must make sure we are below INPUT_DEVICES
+ * which is the upper limit and maximum minor size that we allocate on startup.
+ */
+
+#define INPUT_MINOR_DYNAMIC_START (INPUT_TABLE_SIZE << 5)
+
+struct input_minor {
+	struct input_handler *handler;
+	void *data;
+};
+
+static DEFINE_MUTEX(dynamic_minors_lock);
+static size_t dynamic_minors_size;
+static struct input_minor *dynamic_minors;
+
+int input_minor_alloc(struct input_handler *handler, void *data)
+{
+	void *narray;
+	unsigned int i, nsize;
+	int minor = -1, ret;
+
+	mutex_lock(&dynamic_minors_lock);
+
+	for (i = 0; i < dynamic_minors_size; ++i) {
+		if (!dynamic_minors[i].handler) {
+			minor = i;
+			break;
+		}
+	}
+
+	if (minor < 0) {
+		nsize = dynamic_minors_size * 2;
+		if (!nsize)
+			nsize = 32;
+		narray = krealloc(dynamic_minors,
+				  nsize * sizeof(*dynamic_minors),
+				  GFP_KERNEL);
+		if (!narray) {
+			ret = -ENOMEM;
+			goto out_unlock;
+		}
+
+		memset(&dynamic_minors[dynamic_minors_size], 0,
+		       sizeof(*dynamic_minors) * (nsize - dynamic_minors_size));
+
+		minor = dynamic_minors_size;
+		dynamic_minors = narray;
+		dynamic_minors_size = nsize;
+	}
+
+	ret = minor + INPUT_MINOR_DYNAMIC_START;
+	if (ret >= INPUT_DEVICES) {
+		ret = -ENFILE;
+		goto out_unlock;
+	}
+
+	dynamic_minors[minor].handler = handler;
+	dynamic_minors[minor].data = data;
+
+out_unlock:
+	mutex_unlock(&dynamic_minors_lock);
+	return ret;
+}
+EXPORT_SYMBOL(input_minor_alloc);
+
+void input_minor_free(int minor)
+{
+	if (minor < INPUT_MINOR_DYNAMIC_START)
+		return;
+
+	mutex_lock(&dynamic_minors_lock);
+
+	minor -= INPUT_MINOR_DYNAMIC_START;
+	if (minor >= dynamic_minors_size)
+		goto out_unlock;
+
+	dynamic_minors[minor].handler = NULL;
+	dynamic_minors[minor].data = NULL;
+
+out_unlock:
+	mutex_unlock(&dynamic_minors_lock);
+}
+EXPORT_SYMBOL(input_minor_free);
+
+void *input_minor_get_data(int minor)
+{
+	void *res;
+
+	if (minor < INPUT_MINOR_DYNAMIC_START)
+		return NULL;
+
+	mutex_lock(&dynamic_minors_lock);
+
+	minor -= INPUT_MINOR_DYNAMIC_START;
+	if (minor >= dynamic_minors_size) {
+		res = NULL;
+		goto out_unlock;
+	}
+
+	res = dynamic_minors[minor].data;
+
+out_unlock:
+	mutex_unlock(&dynamic_minors_lock);
+	return res;
+}
+EXPORT_SYMBOL(input_minor_get_data);
+
+struct input_handler *input_minor_get_handler(int minor)
+{
+	void *res;
+
+	if (minor < INPUT_MINOR_DYNAMIC_START)
+		return NULL;
+
+	mutex_lock(&dynamic_minors_lock);
+
+	minor -= INPUT_MINOR_DYNAMIC_START;
+	if (minor >= dynamic_minors_size) {
+		res = NULL;
+		goto out_unlock;
+	}
+
+	res = dynamic_minors[minor].handler;
+
+out_unlock:
+	mutex_unlock(&dynamic_minors_lock);
+	return res;
+}
+EXPORT_SYMBOL(input_minor_get_handler);
+
 static int input_open_file(struct inode *inode, struct file *file)
 {
 	struct input_handler *handler;
 	const struct file_operations *old_fops, *new_fops = NULL;
 	int err;
+	unsigned int minor, minor_group;
 
 	err = mutex_lock_interruptible(&input_mutex);
 	if (err)
 		return err;
 
 	/* No load-on-demand here? */
-	handler = input_table[iminor(inode) >> 5];
+
+	minor = iminor(inode);
+	minor_group = minor >> 5;
+
+	if (minor_group < INPUT_TABLE_SIZE)
+		handler = input_table[minor_group];
+	else
+		handler = input_minor_get_handler(minor);
+
 	if (handler)
 		new_fops = fops_get(handler->fops);
 
diff --git a/include/linux/input.h b/include/linux/input.h
index 2740d08..3fa3d7b 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -1486,6 +1486,11 @@ void input_reset_device(struct input_dev *);
 int __must_check input_register_handler(struct input_handler *);
 void input_unregister_handler(struct input_handler *);
 
+int input_minor_alloc(struct input_handler *, void *);
+void input_minor_free(int);
+void *input_minor_get_data(int);
+struct input_handler *input_minor_get_handler(int);
+
 int input_handler_for_each_handle(struct input_handler *, void *data,
 				  int (*fn)(struct input_handle *, void *));
 
-- 
1.7.12

