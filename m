From: Adrian Bunk <bunk@kernel.org>
Subject: [RFC: 2.6 patch] drivers/hid/: make 2 functions static
Date: Mon, 31 Mar 2008 02:22:21 +0300
Message-ID: <20080330232221.GQ28445@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6.pp.htv.fi ([213.243.153.40]:58962 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753581AbYC3XWd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 30 Mar 2008 19:22:33 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org

This patch makes the following needlessly global functions static:
- hid-core.c:hid_input_field()
- usbhid/hid-quirks.c:usbhid_modify_dquirk()

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 drivers/hid/hid-core.c          |    4 ++--
 drivers/hid/usbhid/hid-quirks.c |    4 ++--
 include/linux/hid.h             |    2 --
 3 files changed, 4 insertions(+), 6 deletions(-)

373e9a0f9aea0995b5475cfaabd9d9f1db4445a6 diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index f0b00ec..cf2557b 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -830,7 +830,8 @@ static void hid_process_event(struct hid_device *hid, struct hid_field *field, s
  * reporting to the layer).
  */
 
-void hid_input_field(struct hid_device *hid, struct hid_field *field, __u8 *data, int interrupt)
+static void hid_input_field(struct hid_device *hid, struct hid_field *field,
+			    __u8 *data, int interrupt)
 {
 	unsigned n;
 	unsigned count = field->report_count;
@@ -876,7 +877,6 @@ void hid_input_field(struct hid_device *hid, struct hid_field *field, __u8 *data
 exit:
 	kfree(value);
 }
-EXPORT_SYMBOL_GPL(hid_input_field);
 
 /*
  * Output the field into the report.
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index e29a057..2dd4273 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -793,8 +793,8 @@ static struct hid_blacklist *usbhid_exists_dquirk(const u16 idVendor,
  *
  * Returns: 0 OK, -error on failure.
  */
-int usbhid_modify_dquirk(const u16 idVendor, const u16 idProduct,
-		const u32 quirks)
+static int usbhid_modify_dquirk(const u16 idVendor, const u16 idProduct,
+				const u32 quirks)
 {
 	struct quirks_list_struct *q_new, *q;
 	int list_edited = 0;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 74ff575..86fa869 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -530,14 +530,12 @@ int hidinput_find_field(struct hid_device *hid, unsigned int type, unsigned int
 int hidinput_mapping_quirks(struct hid_usage *, struct input_dev *, unsigned long **, int *);
 int hidinput_event_quirks(struct hid_device *, struct hid_field *, struct hid_usage *, __s32);
 int hidinput_apple_event(struct hid_device *, struct input_dev *, struct hid_usage *, __s32);
-void hid_input_field(struct hid_device *hid, struct hid_field *field, __u8 *data, int interrupt);
 void hid_output_report(struct hid_report *report, __u8 *data);
 void hid_free_device(struct hid_device *device);
 struct hid_device *hid_parse_report(__u8 *start, unsigned size);
 
 /* HID quirks API */
 u32 usbhid_lookup_quirk(const u16 idVendor, const u16 idProduct);
-int usbhid_modify_dquirk(const u16 idVendor, const u16 idProduct, const u32 quirks);
 int usbhid_quirks_init(char **quirks_param);
 void usbhid_quirks_exit(void);
 void usbhid_fixup_report_descriptor(const u16, const u16, char *, unsigned, char **);

