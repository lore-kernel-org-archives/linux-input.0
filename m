From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 1/2] HID: use debugfs for report dumping descriptor
Date: Fri, 12 Jun 2009 15:27:06 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906121525491.7457@wotan.suse.de>
References: <1244384236.30768.5690.camel@cookie.hadess.net>  <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz>  <1244589738.5973.1954.camel@cookie.hadess.net> <1244617386.3068.22.camel@localhost.localdomain>
 <alpine.LNX.2.00.0906121521490.7457@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47992 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764691AbZFLN1G (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Jun 2009 09:27:06 -0400
In-Reply-To: <alpine.LNX.2.00.0906121521490.7457@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org, linux-input <linux-input@vger.kernel.org>

It is a little bit inconvenient for people who have some non-standard
HID hardware (usually violating the HID specification) to have to
recompile kernel with CONFIG_HID_DEBUG to be able to see kernel's perspective
of the HID report descriptor and observe the parsed events. Plus the messages
are then mixed up inconveniently with the rest of the dmesg stuff.

This patch implements /sys/kernel/debug/hid/<device>/rdesc file, which
represents the kernel's view of report descriptor (both the raw report
descriptor data and parsed contents).

With all the device-specific debug data being available through debugfs, there
is no need for keeping CONFIG_HID_DEBUG, as the 'debug' parameter to the
hid module will now only output only driver-specific debugging options, which has
absolutely minimal memory footprint, just a few error messages and one global
flag (hid_debug).

We use the current set of output formatting functions. The ones that need to be
used both for one-shot rdesc seq_file and also for continuous flow of data
(individual reports, as being sent by the device) distinguish according to the
passed seq_file parameter, and if it is NULL, it still output to kernel ringbuffer,
otherwise the corresponding seq_file is used for output.

The format of the output is preserved.

Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/Kconfig           |   15 ---
 drivers/hid/Makefile          |    5 +-
 drivers/hid/hid-core.c        |   13 ++-
 drivers/hid/hid-debug.c       |  227 ++++++++++++++++++++++++++++-------------
 drivers/hid/hid-input.c       |   13 +--
 drivers/hid/usbhid/hid-core.c |    8 +--
 include/linux/hid-debug.h     |   32 ++++---
 include/linux/hid.h           |    4 +
 8 files changed, 195 insertions(+), 122 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 7e67dcb..05950a7 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -31,21 +31,6 @@ config HID
 
 	  If unsure, say Y.
 
-config HID_DEBUG
-	bool "HID debugging support"
-	default y
-	depends on HID
-	---help---
-	This option lets the HID layer output diagnostics about its internal
-	state, resolve HID usages, dump HID fields, etc. Individual HID drivers
-	use this debugging facility to output information about individual HID
-	devices, etc.
-
-	This feature is useful for those who are either debugging the HID parser
-	or any HID hardware device.
-
-	If unsure, say Y.
-
 config HIDRAW
 	bool "/dev/hidraw raw HID device support"
 	depends on HID
diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 1f7cb0f..cf3687d 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -3,9 +3,12 @@
 #
 hid-objs			:= hid-core.o hid-input.o
 
+ifdef CONFIG_DEBUG_FS
+	hid-objs		+= hid-debug.o
+endif
+
 obj-$(CONFIG_HID)		+= hid.o
 
-hid-$(CONFIG_HID_DEBUG)		+= hid-debug.o
 hid-$(CONFIG_HIDRAW)		+= hidraw.o
 
 hid-logitech-objs		:= hid-lg.o
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8551693..d4317db 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -44,12 +44,10 @@
 #define DRIVER_DESC "HID core driver"
 #define DRIVER_LICENSE "GPL"
 
-#ifdef CONFIG_HID_DEBUG
 int hid_debug = 0;
 module_param_named(debug, hid_debug, int, 0600);
 MODULE_PARM_DESC(debug, "HID debugging (0=off, 1=probing info, 2=continuous data dumping)");
 EXPORT_SYMBOL_GPL(hid_debug);
-#endif
 
 /*
  * Register a new report for a device.
@@ -987,7 +985,6 @@ int hid_set_field(struct hid_field *field, unsigned offset, __s32 value)
 
 	if (offset >= field->report_count) {
 		dbg_hid("offset (%d) exceeds report_count (%d)\n", offset, field->report_count);
-		hid_dump_field(field, 8);
 		return -1;
 	}
 	if (field->logical_minimum < 0) {
@@ -1721,6 +1718,8 @@ int hid_add_device(struct hid_device *hdev)
 	if (!ret)
 		hdev->status |= HID_STAT_ADDED;
 
+	hid_debug_register(hdev, dev_name(&hdev->dev));
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(hid_add_device);
@@ -1768,6 +1767,7 @@ static void hid_remove_device(struct hid_device *hdev)
 {
 	if (hdev->status & HID_STAT_ADDED) {
 		device_del(&hdev->dev);
+		hid_debug_unregister(hdev);
 		hdev->status &= ~HID_STAT_ADDED;
 	}
 }
@@ -1843,6 +1843,10 @@ static int __init hid_init(void)
 {
 	int ret;
 
+	if (hid_debug)
+		printk(KERN_WARNING "HID: hid_debug parameter has been deprecated. "
+				"Debugging data are now provided via debugfs\n");
+
 	ret = bus_register(&hid_bus_type);
 	if (ret) {
 		printk(KERN_ERR "HID: can't register hid bus\n");
@@ -1853,6 +1857,8 @@ static int __init hid_init(void)
 	if (ret)
 		goto err_bus;
 
+	hid_debug_init();
+
 	return 0;
 err_bus:
 	bus_unregister(&hid_bus_type);
@@ -1862,6 +1868,7 @@ err:
 
 static void __exit hid_exit(void)
 {
+	hid_debug_exit();
 	hidraw_exit();
 	bus_unregister(&hid_bus_type);
 }
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 47ac1a7..067e173 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1,9 +1,9 @@
 /*
  *  (c) 1999 Andreas Gal		<gal@cs.uni-magdeburg.de>
  *  (c) 2000-2001 Vojtech Pavlik	<vojtech@ucw.cz>
- *  (c) 2007 Jiri Kosina
+ *  (c) 2007-2009 Jiri Kosina
  *
- *  Some debug stuff for the HID parser.
+ *  HID debugging support
  */
 
 /*
@@ -26,9 +26,13 @@
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
  */
 
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
 #include <linux/hid.h>
 #include <linux/hid-debug.h>
 
+static struct dentry *hid_debug_root;
+
 struct hid_usage_entry {
 	unsigned  page;
 	unsigned  usage;
@@ -331,72 +335,83 @@ static const struct hid_usage_entry hid_usage_table[] = {
   { 0, 0, NULL }
 };
 
-static void resolv_usage_page(unsigned page) {
+static void resolv_usage_page(unsigned page, struct seq_file *f) {
 	const struct hid_usage_entry *p;
 
 	for (p = hid_usage_table; p->description; p++)
 		if (p->page == page) {
-			printk("%s", p->description);
+			if (!f)
+				printk("%s", p->description);
+			else
+				seq_printf(f, "%s", p->description);
 			return;
 		}
-	printk("%04x", page);
+	if (!f)
+		printk("%04x", page);
+	else
+		seq_printf(f, "%04x", page);
 }
 
-void hid_resolv_usage(unsigned usage) {
+void hid_resolv_usage(unsigned usage, struct seq_file *f) {
 	const struct hid_usage_entry *p;
 
-	if (!hid_debug)
-		return;
-
-	resolv_usage_page(usage >> 16);
-	printk(".");
+	resolv_usage_page(usage >> 16, f);
+	if (!f)
+		printk(".");
+	else
+		seq_printf(f, ".");
 	for (p = hid_usage_table; p->description; p++)
 		if (p->page == (usage >> 16)) {
 			for(++p; p->description && p->usage != 0; p++)
 				if (p->usage == (usage & 0xffff)) {
-					printk("%s", p->description);
+					if (!f)
+						printk("%s", p->description);
+					else
+						seq_printf(f,
+							"%s",
+							p->description);
 					return;
 				}
 			break;
 		}
-	printk("%04x", usage & 0xffff);
+	if (!f)
+		printk("%04x", usage & 0xffff);
+	else
+		seq_printf(f, "%04x", usage & 0xffff);
 }
 EXPORT_SYMBOL_GPL(hid_resolv_usage);
 
-static void tab(int n) {
-	printk(KERN_DEBUG "%*s", n, "");
+static void tab(int n, struct seq_file *f) {
+	seq_printf(f, "%*s", n, "");
 }
 
-void hid_dump_field(struct hid_field *field, int n) {
+void hid_dump_field(struct hid_field *field, int n, struct seq_file *f) {
 	int j;
 
-	if (!hid_debug)
-		return;
-
 	if (field->physical) {
-		tab(n);
-		printk("Physical(");
-		hid_resolv_usage(field->physical); printk(")\n");
+		tab(n, f);
+		seq_printf(f, "Physical(");
+		hid_resolv_usage(field->physical, f); seq_printf(f, ")\n");
 	}
 	if (field->logical) {
-		tab(n);
-		printk("Logical(");
-		hid_resolv_usage(field->logical); printk(")\n");
+		tab(n, f);
+		seq_printf(f, "Logical(");
+		hid_resolv_usage(field->logical, f); seq_printf(f, ")\n");
 	}
-	tab(n); printk("Usage(%d)\n", field->maxusage);
+	tab(n, f); seq_printf(f, "Usage(%d)\n", field->maxusage);
 	for (j = 0; j < field->maxusage; j++) {
-		tab(n+2); hid_resolv_usage(field->usage[j].hid); printk("\n");
+		tab(n+2, f); hid_resolv_usage(field->usage[j].hid, f); seq_printf(f, "\n");
 	}
 	if (field->logical_minimum != field->logical_maximum) {
-		tab(n); printk("Logical Minimum(%d)\n", field->logical_minimum);
-		tab(n); printk("Logical Maximum(%d)\n", field->logical_maximum);
+		tab(n, f); seq_printf(f, "Logical Minimum(%d)\n", field->logical_minimum);
+		tab(n, f); seq_printf(f, "Logical Maximum(%d)\n", field->logical_maximum);
 	}
 	if (field->physical_minimum != field->physical_maximum) {
-		tab(n); printk("Physical Minimum(%d)\n", field->physical_minimum);
-		tab(n); printk("Physical Maximum(%d)\n", field->physical_maximum);
+		tab(n, f); seq_printf(f, "Physical Minimum(%d)\n", field->physical_minimum);
+		tab(n, f); seq_printf(f, "Physical Maximum(%d)\n", field->physical_maximum);
 	}
 	if (field->unit_exponent) {
-		tab(n); printk("Unit Exponent(%d)\n", field->unit_exponent);
+		tab(n, f); seq_printf(f, "Unit Exponent(%d)\n", field->unit_exponent);
 	}
 	if (field->unit) {
 		static const char *systems[5] = { "None", "SI Linear", "SI Rotation", "English Linear", "English Rotation" };
@@ -417,77 +432,75 @@ void hid_dump_field(struct hid_field *field, int n) {
 		data >>= 4;
 
 		if(sys > 4) {
-			tab(n); printk("Unit(Invalid)\n");
+			tab(n, f); seq_printf(f, "Unit(Invalid)\n");
 		}
 		else {
 			int earlier_unit = 0;
 
-			tab(n); printk("Unit(%s : ", systems[sys]);
+			tab(n, f); seq_printf(f, "Unit(%s : ", systems[sys]);
 
 			for (i=1 ; i<sizeof(__u32)*2 ; i++) {
 				char nibble = data & 0xf;
 				data >>= 4;
 				if (nibble != 0) {
 					if(earlier_unit++ > 0)
-						printk("*");
-					printk("%s", units[sys][i]);
+						seq_printf(f, "*");
+					seq_printf(f, "%s", units[sys][i]);
 					if(nibble != 1) {
 						/* This is a _signed_ nibble(!) */
 
 						int val = nibble & 0x7;
 						if(nibble & 0x08)
 							val = -((0x7 & ~val) +1);
-						printk("^%d", val);
+						seq_printf(f, "^%d", val);
 					}
 				}
 			}
-			printk(")\n");
+			seq_printf(f, ")\n");
 		}
 	}
-	tab(n); printk("Report Size(%u)\n", field->report_size);
-	tab(n); printk("Report Count(%u)\n", field->report_count);
-	tab(n); printk("Report Offset(%u)\n", field->report_offset);
+	tab(n, f); seq_printf(f, "Report Size(%u)\n", field->report_size);
+	tab(n, f); seq_printf(f, "Report Count(%u)\n", field->report_count);
+	tab(n, f); seq_printf(f, "Report Offset(%u)\n", field->report_offset);
 
-	tab(n); printk("Flags( ");
+	tab(n, f); seq_printf(f, "Flags( ");
 	j = field->flags;
-	printk("%s", HID_MAIN_ITEM_CONSTANT & j ? "Constant " : "");
-	printk("%s", HID_MAIN_ITEM_VARIABLE & j ? "Variable " : "Array ");
-	printk("%s", HID_MAIN_ITEM_RELATIVE & j ? "Relative " : "Absolute ");
-	printk("%s", HID_MAIN_ITEM_WRAP & j ? "Wrap " : "");
-	printk("%s", HID_MAIN_ITEM_NONLINEAR & j ? "NonLinear " : "");
-	printk("%s", HID_MAIN_ITEM_NO_PREFERRED & j ? "NoPreferredState " : "");
-	printk("%s", HID_MAIN_ITEM_NULL_STATE & j ? "NullState " : "");
-	printk("%s", HID_MAIN_ITEM_VOLATILE & j ? "Volatile " : "");
-	printk("%s", HID_MAIN_ITEM_BUFFERED_BYTE & j ? "BufferedByte " : "");
-	printk(")\n");
+	seq_printf(f, "%s", HID_MAIN_ITEM_CONSTANT & j ? "Constant " : "");
+	seq_printf(f, "%s", HID_MAIN_ITEM_VARIABLE & j ? "Variable " : "Array ");
+	seq_printf(f, "%s", HID_MAIN_ITEM_RELATIVE & j ? "Relative " : "Absolute ");
+	seq_printf(f, "%s", HID_MAIN_ITEM_WRAP & j ? "Wrap " : "");
+	seq_printf(f, "%s", HID_MAIN_ITEM_NONLINEAR & j ? "NonLinear " : "");
+	seq_printf(f, "%s", HID_MAIN_ITEM_NO_PREFERRED & j ? "NoPreferredState " : "");
+	seq_printf(f, "%s", HID_MAIN_ITEM_NULL_STATE & j ? "NullState " : "");
+	seq_printf(f, "%s", HID_MAIN_ITEM_VOLATILE & j ? "Volatile " : "");
+	seq_printf(f, "%s", HID_MAIN_ITEM_BUFFERED_BYTE & j ? "BufferedByte " : "");
+	seq_printf(f, ")\n");
 }
 EXPORT_SYMBOL_GPL(hid_dump_field);
 
-void hid_dump_device(struct hid_device *device) {
+void hid_dump_device(struct hid_device *device, struct seq_file *f)
+{
 	struct hid_report_enum *report_enum;
 	struct hid_report *report;
 	struct list_head *list;
 	unsigned i,k;
 	static const char *table[] = {"INPUT", "OUTPUT", "FEATURE"};
 
-	if (!hid_debug)
-		return;
-
 	for (i = 0; i < HID_REPORT_TYPES; i++) {
 		report_enum = device->report_enum + i;
 		list = report_enum->report_list.next;
 		while (list != &report_enum->report_list) {
 			report = (struct hid_report *) list;
-			tab(2);
-			printk("%s", table[i]);
+			tab(2, f);
+			seq_printf(f, "%s", table[i]);
 			if (report->id)
-				printk("(%d)", report->id);
-			printk("[%s]", table[report->type]);
-			printk("\n");
+				seq_printf(f, "(%d)", report->id);
+			seq_printf(f, "[%s]", table[report->type]);
+			seq_printf(f, "\n");
 			for (k = 0; k < report->maxfield; k++) {
-				tab(4);
-				printk("Field(%d)\n", k);
-				hid_dump_field(report->field[k], 6);
+				tab(4, f);
+				seq_printf(f, "Field(%d)\n", k);
+				hid_dump_field(report->field[k], 6, f);
 			}
 			list = list->next;
 		}
@@ -500,7 +513,7 @@ void hid_dump_input(struct hid_usage *usage, __s32 value) {
 		return;
 
 	printk(KERN_DEBUG "hid-debug: input ");
-	hid_resolv_usage(usage->hid);
+	hid_resolv_usage(usage->hid, NULL);
 	printk(" = %d\n", value);
 }
 EXPORT_SYMBOL_GPL(hid_dump_input);
@@ -767,12 +780,84 @@ static const char **names[EV_MAX + 1] = {
 	[EV_SND] = sounds,			[EV_REP] = repeats,
 };
 
-void hid_resolv_event(__u8 type, __u16 code) {
-
-	if (!hid_debug)
-		return;
+void hid_resolv_event(__u8 type, __u16 code, struct seq_file *f) {
 
-	printk("%s.%s", events[type] ? events[type] : "?",
+	seq_printf(f, "%s.%s", events[type] ? events[type] : "?",
 		names[type] ? (names[type][code] ? names[type][code] : "?") : "?");
 }
-EXPORT_SYMBOL_GPL(hid_resolv_event);
+
+void hid_dump_input_mapping(struct hid_device *hid, struct seq_file *f)
+{
+	int i, j, k;
+	struct hid_report *report;
+	struct hid_usage *usage;
+
+	for (k = HID_INPUT_REPORT; k <= HID_OUTPUT_REPORT; k++) {
+		list_for_each_entry(report, &hid->report_enum[k].report_list, list) {
+			for (i = 0; i < report->maxfield; i++) {
+				for ( j = 0; j < report->field[i]->maxusage; j++) {
+					usage = report->field[i]->usage + j;
+					hid_resolv_usage(usage->hid, f);
+					seq_printf(f, " ---> ");
+					hid_resolv_event(usage->type, usage->code, f);
+					seq_printf(f, "\n");
+				}
+			}
+		}
+	}
+
+}
+
+static int hid_debug_rdesc_show(struct seq_file *f, void *p)
+{
+	struct hid_device *hdev = f->private;
+	int i;
+
+	/* dump HID report descriptor */
+	for (i = 0; i < hdev->rsize; i++)
+		seq_printf(f, "%02x ", hdev->rdesc[i]);
+	seq_printf(f, "\n\n");
+
+	/* dump parsed data and input mappings */
+	hid_dump_device(hdev, f);
+	seq_printf(f, "\n");
+	hid_dump_input_mapping(hdev, f);
+
+	return 0;
+}
+
+static int hid_debug_rdesc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, hid_debug_rdesc_show, inode->i_private);
+}
+
+static const struct file_operations hid_debug_rdesc_fops = {
+	.open           = hid_debug_rdesc_open,
+	.read           = seq_read,
+	.llseek         = seq_lseek,
+	.release        = single_release,
+};
+
+void hid_debug_register(struct hid_device *hdev, const char *name)
+{
+	hdev->debug_dir = debugfs_create_dir(name, hid_debug_root);
+	hdev->debug_rdesc = debugfs_create_file("rdesc", 0400,
+			hdev->debug_dir, hdev, &hid_debug_rdesc_fops);
+}
+
+void hid_debug_unregister(struct hid_device *hdev)
+{
+	debugfs_remove(hdev->debug_rdesc);
+	debugfs_remove(hdev->debug_dir);
+}
+
+void hid_debug_init(void)
+{
+	hid_debug_root = debugfs_create_dir("hid", NULL);
+}
+
+void hid_debug_exit(void)
+{
+	debugfs_remove_recursive(hid_debug_root);
+}
+
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 7f183b7..5862b0f 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -159,17 +159,12 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 	field->hidinput = hidinput;
 
-	dbg_hid("Mapping: ");
-	hid_resolv_usage(usage->hid);
-	dbg_hid_line(" ---> ");
-
 	if (field->flags & HID_MAIN_ITEM_CONSTANT)
 		goto ignore;
 
 	/* only LED usages are supported in output fields */
 	if (field->report_type == HID_OUTPUT_REPORT &&
 			(usage->hid & HID_USAGE_PAGE) != HID_UP_LED) {
-		dbg_hid_line(" [non-LED output field] ");
 		goto ignore;
 	}
 
@@ -561,15 +556,9 @@ mapped:
 		set_bit(MSC_SCAN, input->mscbit);
 	}
 
-	hid_resolv_event(usage->type, usage->code);
-
-	dbg_hid_line("\n");
-
-	return;
-
 ignore:
-	dbg_hid_line("IGNORED\n");
 	return;
+
 }
 
 void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct hid_usage *usage, __s32 value)
diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index ac8049b..708aa52 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -4,8 +4,8 @@
  *  Copyright (c) 1999 Andreas Gal
  *  Copyright (c) 2000-2005 Vojtech Pavlik <vojtech@suse.cz>
  *  Copyright (c) 2005 Michael Haboustak <mike-@cinci.rr.com> for Concept2, Inc
- *  Copyright (c) 2006-2008 Jiri Kosina
  *  Copyright (c) 2007-2008 Oliver Neukum
+ *  Copyright (c) 2006-2009 Jiri Kosina
  */
 
 /*
@@ -886,11 +886,6 @@ static int usbhid_parse(struct hid_device *hid)
 		goto err;
 	}
 
-	dbg_hid("report descriptor (size %u, read %d) = ", rsize, n);
-	for (n = 0; n < rsize; n++)
-		dbg_hid_line(" %02x", (unsigned char) rdesc[n]);
-	dbg_hid_line("\n");
-
 	ret = hid_parse_report(hid, rdesc, rsize);
 	kfree(rdesc);
 	if (ret) {
@@ -1005,7 +1000,6 @@ static int usbhid_start(struct hid_device *hid)
 	usbhid->urbctrl->transfer_flags |= (URB_NO_TRANSFER_DMA_MAP | URB_NO_SETUP_DMA_MAP);
 
 	usbhid_init_reports(hid);
-	hid_dump_device(hid);
 
 	set_bit(HID_STARTED, &usbhid->iofl);
 
diff --git a/include/linux/hid-debug.h b/include/linux/hid-debug.h
index 50d568e..516e12c 100644
--- a/include/linux/hid-debug.h
+++ b/include/linux/hid-debug.h
@@ -2,7 +2,7 @@
 #define __HID_DEBUG_H
 
 /*
- *  Copyright (c) 2007	Jiri Kosina
+ *  Copyright (c) 2007-2009	Jiri Kosina
  */
 
 /*
@@ -22,24 +22,30 @@
  *
  */
 
-#ifdef CONFIG_HID_DEBUG
+#ifdef CONFIG_DEBUG_FS
 
 void hid_dump_input(struct hid_usage *, __s32);
-void hid_dump_device(struct hid_device *);
-void hid_dump_field(struct hid_field *, int);
-void hid_resolv_usage(unsigned);
-void hid_resolv_event(__u8, __u16);
+void hid_dump_device(struct hid_device *, struct seq_file *);
+void hid_dump_field(struct hid_field *, int, struct seq_file *);
+void hid_resolv_usage(unsigned, struct seq_file *);
+void hid_debug_register(struct hid_device *, const char *);
+void hid_debug_unregister(struct hid_device *);
+void hid_debug_init(void);
+void hid_debug_exit(void);
 
 #else
 
-#define hid_dump_input(a,b)     do { } while (0)
-#define hid_dump_device(c)      do { } while (0)
-#define hid_dump_field(a,b)     do { } while (0)
-#define hid_resolv_usage(a)         do { } while (0)
-#define hid_resolv_event(a,b)       do { } while (0)
-
-#endif /* CONFIG_HID_DEBUG */
+#define hid_dump_input(a,b)		do { } while (0)
+#define hid_dump_device(c)		do { } while (0)
+#define hid_dump_field(a,b)		do { } while (0)
+#define hid_resolv_usage(a)		do { } while (0)
+#define hid_resolv_event(a,b)		do { } while (0)
+#define hid_debug_register(a, b)	do { } while (0)
+#define hid_debug_unregister(a)		do { } while (0)
+#define hid_debug_init()		do { } while (0)
+#define hid_debug_exit()		do { } while (0)
 
+#endif
 
 #endif
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index a72876e..da09ab1 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -451,6 +451,10 @@ struct hid_device {							/* device report descriptor */
 	char phys[64];							/* Device physical location */
 	char uniq[64];							/* Device unique identifier (serial #) */
 
+	/* debugfs */
+	struct dentry *debug_dir;
+	struct dentry *debug_rdesc;
+
 	void *driver_data;
 
 	/* temporary hid_ff handling (until moved to the drivers) */
-- 
1.5.6

