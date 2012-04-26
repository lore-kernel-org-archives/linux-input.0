From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: possible missing error handling in hidraw
Date: Fri, 27 Apr 2012 00:56:08 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204270055310.1856@pobox.suse.cz>
References: <201204251512.16482.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43491 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077Ab2DZW4K (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Apr 2012 18:56:10 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 7A9AD9C818
	for <linux-input@vger.kernel.org>; Fri, 27 Apr 2012 00:56:09 +0200 (CEST)
In-Reply-To: <201204251512.16482.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org

On Wed, 25 Apr 2012, Oliver Neukum wrote:

> Hi,
> 
> what happens if kmemdup here cannot allocate memory?
> 
> 	Regards
> 		Oliver
> 
> void hidraw_report_event(struct hid_device *hid, u8 *data, int len)
> {
>         struct hidraw *dev = hid->hidraw;
>         struct hidraw_list *list;
> 
>         list_for_each_entry(list, &dev->list, node) {
>                 list->buffer[list->head].value = kmemdup(data, len, GFP_ATOMIC);
>                 list->buffer[list->head].len = len;
>                 list->head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
>                 kill_fasync(&list->fasync, SIGIO, POLL_IN);
>         }
> 
>         wake_up_interruptible(&dev->wait);
> }
> EXPORT_SYMBOL_GPL(hidraw_report_event);

Good catch. I believe the fix below is sufficient.




From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: hidraw: add proper error handling to raw event reporting

If kmemdup() in hidraw_report_event() fails, we are not propagating
this fact properly.

Let hidraw_report_event() and hid_report_raw_event() return an error
value to the caller.

Reported-by: Oliver Neukum <oneukum@suse.de>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-core.c |   16 +++++++++++-----
 drivers/hid/hidraw.c   |    9 +++++++--
 include/linux/hid.h    |    2 +-
 include/linux/hidraw.h |    4 ++--
 4 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 4da66b4..2a337f9 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1032,7 +1032,7 @@ static struct hid_report *hid_get_report(struct hid_report_enum *report_enum,
 	return report;
 }
 
-void hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
+int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
 		int interrupt)
 {
 	struct hid_report_enum *report_enum = hid->report_enum + type;
@@ -1040,10 +1040,11 @@ void hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
 	unsigned int a;
 	int rsize, csize = size;
 	u8 *cdata = data;
+	int ret = 0;
 
 	report = hid_get_report(report_enum, data);
 	if (!report)
-		return;
+		goto out;
 
 	if (report_enum->numbered) {
 		cdata++;
@@ -1063,14 +1064,19 @@ void hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
 
 	if ((hid->claimed & HID_CLAIMED_HIDDEV) && hid->hiddev_report_event)
 		hid->hiddev_report_event(hid, report);
-	if (hid->claimed & HID_CLAIMED_HIDRAW)
-		hidraw_report_event(hid, data, size);
+	if (hid->claimed & HID_CLAIMED_HIDRAW) {
+		ret = hidraw_report_event(hid, data, size);
+		if (ret)
+			goto out;
+	}
 
 	for (a = 0; a < report->maxfield; a++)
 		hid_input_field(hid, report->field[a], cdata, interrupt);
 
 	if (hid->claimed & HID_CLAIMED_INPUT)
 		hidinput_report_event(hid, report);
+out:
+	return ret;
 }
 EXPORT_SYMBOL_GPL(hid_report_raw_event);
 
@@ -1147,7 +1153,7 @@ nomem:
 		}
 	}
 
-	hid_report_raw_event(hid, type, data, size, interrupt);
+	ret = hid_report_raw_event(hid, type, data, size, interrupt);
 
 unlock:
 	up(&hid->driver_lock);
diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index cf7d6d5..7c1a92ff9 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -437,19 +437,24 @@ static const struct file_operations hidraw_ops = {
 	.llseek =	noop_llseek,
 };
 
-void hidraw_report_event(struct hid_device *hid, u8 *data, int len)
+int hidraw_report_event(struct hid_device *hid, u8 *data, int len)
 {
 	struct hidraw *dev = hid->hidraw;
 	struct hidraw_list *list;
+	int ret = 0;
 
 	list_for_each_entry(list, &dev->list, node) {
-		list->buffer[list->head].value = kmemdup(data, len, GFP_ATOMIC);
+		if (!(list->buffer[list->head].value = kmemdup(data, len, GFP_ATOMIC))) {
+			ret = -ENOMEM;
+			break;
+		}
 		list->buffer[list->head].len = len;
 		list->head = (list->head + 1) & (HIDRAW_BUFFER_SIZE - 1);
 		kill_fasync(&list->fasync, SIGIO, POLL_IN);
 	}
 
 	wake_up_interruptible(&dev->wait);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(hidraw_report_event);
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 3a95da6..58b3857 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -896,7 +896,7 @@ static inline int hid_hw_power(struct hid_device *hdev, int level)
 	return hdev->ll_driver->power ? hdev->ll_driver->power(hdev, level) : 0;
 }
 
-void hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
+int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, int size,
 		int interrupt);
 
 extern int hid_generic_init(void);
diff --git a/include/linux/hidraw.h b/include/linux/hidraw.h
index 4b88e69..9cdc9b6 100644
--- a/include/linux/hidraw.h
+++ b/include/linux/hidraw.h
@@ -76,13 +76,13 @@ struct hidraw_list {
 #ifdef CONFIG_HIDRAW
 int hidraw_init(void);
 void hidraw_exit(void);
-void hidraw_report_event(struct hid_device *, u8 *, int);
+int hidraw_report_event(struct hid_device *, u8 *, int);
 int hidraw_connect(struct hid_device *);
 void hidraw_disconnect(struct hid_device *);
 #else
 static inline int hidraw_init(void) { return 0; }
 static inline void hidraw_exit(void) { }
-static inline void hidraw_report_event(struct hid_device *hid, u8 *data, int len) { }
+static inline int hidraw_report_event(struct hid_device *hid, u8 *data, int len) { }
 static inline int hidraw_connect(struct hid_device *hid) { return -1; }
 static inline void hidraw_disconnect(struct hid_device *hid) { }
 #endif


-- 
Jiri Kosina
SUSE Labs
