From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] HID: fix data access in implement()
Date: Tue, 9 Jul 2013 20:44:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1307092042190.26857@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54703 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751945Ab3GISoe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Jul 2013 14:44:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Gustavo Padovan <gustavo@padovan.org>, Adam Kropelin <akropel1@rochester.rr.com>, Grant Grundler <grundler@parisc-linux.org>
Cc: linux-input@vger.kernel.org

implement() is setting bytes in LE data stream. In case the data
is not aligned to 64bits, it reads past the allocated buffer. It
doesn't really change any value there (it's properly bitmasked), but
in case that this read past the boundary hits a page boundary, pagefault
happens when accessing 64bits of 'x' in implement(), and kernel oopses.

This happens much more often when numbered reports are in use, as the
initial 8bit skip in the buffer makes the whole process work on values
which are not aligned to 64bits.

This problem dates back to attempts in 2005 and 2006 to make implement()
and extract() as generic as possible, and even back then the problem
was realized by Adam Kroperlin, but falsely assumed to be impossible
to cause any harm:

  http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg47690.html

I have made several attempts at fixing it "on the spot" directly in
implement(), but the results were horrible; the special casing for processing
last 64bit chunk and switching to different math makes it unreadable mess.

I therefore took a path to allocate a few bytes more which will never make
it into final report, but are there as a cushion for all the 64bit math
operations happening in implement() and extract().

All callers of hid_output_report() are converted at the same time to allocate
the buffer by newly introduced hid_alloc_report_buf() helper.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-core.c            |   19 ++++++++++++++++++-
 drivers/hid/hid-logitech-dj.c     |   12 ++++++++++--
 drivers/hid/hid-picolcd_debugfs.c |   10 +++++++++-
 drivers/hid/usbhid/hid-core.c     |    4 ++--
 include/linux/hid.h               |    1 +
 net/bluetooth/hidp/core.c         |   14 +++++++++-----
 6 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 264f550..987279b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1128,7 +1128,8 @@ static void hid_output_field(const struct hid_device *hid,
 }
 
 /*
- * Create a report.
+ * Create a report. 'data' has to be allocated using
+ * hid_alloc_report_buf() so that it has proper size.
  */
 
 void hid_output_report(struct hid_report *report, __u8 *data)
@@ -1145,6 +1146,22 @@ void hid_output_report(struct hid_report *report, __u8 *data)
 EXPORT_SYMBOL_GPL(hid_output_report);
 
 /*
+ * Allocator for buffer that is going to be passed to hid_output_report()
+ */
+u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags)
+{
+	/*
+	 * 7 extra bytes are necessary to achieve proper functionality
+	 * of implement() working on 8 byte chunks
+	 */
+
+	int len = ((report->size - 1) >> 3) + 1 + (report->id > 0) + 7;
+
+	return kmalloc(len, flags);
+}
+EXPORT_SYMBOL_GPL(hid_alloc_report_buf);
+
+/*
  * Set a field value. The report this field belongs to has to be
  * created and transferred to the device, to set this value in the
  * device.
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 5207591a..4d79273 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -574,7 +574,7 @@ static int logi_dj_ll_input_event(struct input_dev *dev, unsigned int type,
 
 	struct hid_field *field;
 	struct hid_report *report;
-	unsigned char data[8];
+	unsigned char *data;
 	int offset;
 
 	dbg_hid("%s: %s, type:%d | code:%d | value:%d\n",
@@ -590,6 +590,13 @@ static int logi_dj_ll_input_event(struct input_dev *dev, unsigned int type,
 		return -1;
 	}
 	hid_set_field(field, offset, value);
+
+	data = hid_alloc_report_buf(field->report, GFP_KERNEL);
+	if (!data) {
+		dev_warn(&dev->dev, "failed to allocate report buf memory\n");
+		return -1;
+	}
+
 	hid_output_report(field->report, &data[0]);
 
 	output_report_enum = &dj_rcv_hiddev->report_enum[HID_OUTPUT_REPORT];
@@ -600,8 +607,9 @@ static int logi_dj_ll_input_event(struct input_dev *dev, unsigned int type,
 
 	hid_hw_request(dj_rcv_hiddev, report, HID_REQ_SET_REPORT);
 
-	return 0;
+	kfree(data);
 
+	return 0;
 }
 
 static int logi_dj_ll_start(struct hid_device *hid)
diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
index 59ab8e1..784a17c 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -394,7 +394,7 @@ static void dump_buff_as_hex(char *dst, size_t dst_sz, const u8 *data,
 void picolcd_debug_out_report(struct picolcd_data *data,
 		struct hid_device *hdev, struct hid_report *report)
 {
-	u8 raw_data[70];
+	u8 *raw_data;
 	int raw_size = (report->size >> 3) + 1;
 	char *buff;
 #define BUFF_SZ 256
@@ -407,11 +407,18 @@ void picolcd_debug_out_report(struct picolcd_data *data,
 	if (!buff)
 		return;
 
+	raw_data = hid_alloc_report_buf(report, GFP_ATOMIC);
+	if (!raw_data) {
+		kfree(buff);
+		return;
+	}
+
 	snprintf(buff, BUFF_SZ, "\nout report %d (size %d) =  ",
 			report->id, raw_size);
 	hid_debug_event(hdev, buff);
 	if (raw_size + 5 > sizeof(raw_data)) {
 		kfree(buff);
+		kfree(raw_data);
 		hid_debug_event(hdev, " TOO BIG\n");
 		return;
 	} else {
@@ -644,6 +651,7 @@ void picolcd_debug_out_report(struct picolcd_data *data,
 		break;
 	}
 	wake_up_interruptible(&hdev->debug_wait);
+	kfree(raw_data);
 	kfree(buff);
 }
 
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 9941828..2b0b96daf 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -546,7 +546,7 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
 			return;
 		}
 
-		usbhid->out[usbhid->outhead].raw_report = kmalloc(len, GFP_ATOMIC);
+		usbhid->out[usbhid->outhead].raw_report = hid_alloc_report_buf(report, GFP_ATOMIC);
 		if (!usbhid->out[usbhid->outhead].raw_report) {
 			hid_warn(hid, "output queueing failed\n");
 			return;
@@ -595,7 +595,7 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
 	}
 
 	if (dir == USB_DIR_OUT) {
-		usbhid->ctrl[usbhid->ctrlhead].raw_report = kmalloc(len, GFP_ATOMIC);
+		usbhid->ctrl[usbhid->ctrlhead].raw_report = hid_alloc_report_buf(report, GFP_ATOMIC);
 		if (!usbhid->ctrl[usbhid->ctrlhead].raw_report) {
 			hid_warn(hid, "control queueing failed\n");
 			return;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 0c48991..acccdf4 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -744,6 +744,7 @@ struct hid_field *hidinput_get_led_field(struct hid_device *hid);
 unsigned int hidinput_count_leds(struct hid_device *hid);
 __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code);
 void hid_output_report(struct hid_report *report, __u8 *data);
+u8 *hid_alloc_report_buf(struct hid_report *report, gfp_t flags);
 struct hid_device *hid_allocate_device(void);
 struct hid_report *hid_register_report(struct hid_device *device, unsigned type, unsigned id);
 int hid_parse_report(struct hid_device *hid, __u8 *start, unsigned size);
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 940f5ac..41f154d 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -231,17 +231,21 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 
 static int hidp_send_report(struct hidp_session *session, struct hid_report *report)
 {
-	unsigned char buf[32], hdr;
-	int rsize;
+	unsigned char hdr;
+	u8 *buf;
+	int rsize, ret;
 
-	rsize = ((report->size - 1) >> 3) + 1 + (report->id > 0);
-	if (rsize > sizeof(buf))
+	buf = hid_alloc_report_buf(report, GFP_ATOMIC);
+	if (!buf)
 		return -EIO;
 
 	hid_output_report(report, buf);
 	hdr = HIDP_TRANS_DATA | HIDP_DATA_RTYPE_OUPUT;
 
-	return hidp_send_intr_message(session, hdr, buf, rsize);
+	ret = hidp_send_intr_message(session, hdr, buf, rsize);
+
+	kfree(buf);
+	return ret;
 }
 
 static int hidp_get_raw_report(struct hid_device *hid,
-- 
1.7.3.1
