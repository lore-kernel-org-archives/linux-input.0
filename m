From: Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: USB interrupt times
Date: Tue, 14 Aug 2012 13:18:04 +0100
Message-ID: <20120814121804.GC7105@flint.arm.linux.org.uk>
References: <20120814103936.GA7105@flint.arm.linux.org.uk> <alpine.LNX.2.00.1208141250020.12490@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1208141250020.12490-ztGlSCb7Y1iN3ZZ/Hiejyg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Henrik Rydberg <rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, Aug 14, 2012 at 12:54:00PM +0200, Jiri Kosina wrote:
> Actually, Henrik (added to CC) has been doing some latency improvements 
> both for input core in general, and for HID devices as well lately. I 
> still have his patchset in my to-review queue, as I have just came back 
> from offline vacation, but the patch below definitely can't hurt and 
> should significantly lower the time spent in handling the irq for hid 
> device in common situation (i.e. noone listening for debugfs events).
> 
> Could you please measure how much it helps on your system?

Ok, it looks like it's changed the maximum USB interrupt execution
time from around 364us to 255us.

If I also do a similar trick with the debug code in hid_input_report()
then I get down to 212us - iow, something like the patch below.

Given that debugfs is fairly ubiquitous in the kernel, and that this is
fairly invasive in terms of interrupt execution impact, wouldn't having
this debug code enabled by a separate Kconfig symbol be reasonable too?

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 6ac0286..8daf4d1 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1220,8 +1220,6 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int i
 	struct hid_report_enum *report_enum;
 	struct hid_driver *hdrv;
 	struct hid_report *report;
-	char *buf;
-	unsigned int i;
 	int ret = 0;
 
 	if (!hid)
@@ -1243,23 +1241,27 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int i
 		goto unlock;
 	}
 
-	buf = kmalloc(sizeof(char) * HID_DEBUG_BUFSIZE, GFP_ATOMIC);
+	if (!list_empty(&hid->debug_list)) {
+		unsigned int i;
+		char *buf;
 
-	if (!buf)
-		goto nomem;
+		buf = kmalloc(sizeof(char) * HID_DEBUG_BUFSIZE, GFP_ATOMIC);
+		if (!buf)
+			goto nomem;
 
-	/* dump the report */
-	snprintf(buf, HID_DEBUG_BUFSIZE - 1,
+		/* dump the report */
+		snprintf(buf, HID_DEBUG_BUFSIZE - 1,
 			"\nreport (size %u) (%snumbered) = ", size, report_enum->numbered ? "" : "un");
-	hid_debug_event(hid, buf);
+		hid_debug_event(hid, buf);
 
-	for (i = 0; i < size; i++) {
-		snprintf(buf, HID_DEBUG_BUFSIZE - 1,
+		for (i = 0; i < size; i++) {
+			snprintf(buf, HID_DEBUG_BUFSIZE - 1,
 				" %02x", data[i]);
-		hid_debug_event(hid, buf);
+			hid_debug_event(hid, buf);
+		}
+		hid_debug_event(hid, "\n");
+		kfree(buf);
 	}
-	hid_debug_event(hid, "\n");
-	kfree(buf);
 
 nomem:
 	report = hid_get_report(report_enum, data);

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
