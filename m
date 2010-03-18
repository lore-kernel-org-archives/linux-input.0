From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: driver for BTC "Emprex 3009URF III Vista MCE Remote"
  quirky remote
Date: Thu, 18 Mar 2010 12:00:58 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1003181200220.18642@pobox.suse.cz>
References: <4B8902C5.5000508@gmail.com>  <alpine.LNX.2.00.1003151701380.18642@pobox.suse.cz> <3711715e1003171218n2e15438fy6bf5d2615a4cb4ae@mail.gmail.com> <alpine.LNX.2.00.1003181150401.18642@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48981 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752594Ab0CRLA7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Mar 2010 07:00:59 -0400
In-Reply-To: <alpine.LNX.2.00.1003181150401.18642@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wayne Thomas <waynethomas69@gmail.com>
Cc: Ben Hardill <b.hardill@gmail.com>, linux-input@vger.kernel.org

On Thu, 18 Mar 2010, Jiri Kosina wrote:

> > I have compiled kernel 2.6.33.1 with hid_debug set to 2.
> > Below is the output of the appropriate device (the remote presents
> > itself as two separate event devices) when pressing some of the
> > buttons in question.
> > 
> > I have attached the output of
> > /sys/kernel/debug/hid/0003:046E:5578.0004/rdesc as a text file since
> > it is so long, but here is the output of
> > /sys/kernel/debug/hid/0003:046E:5578.0004/events (one report for each
> > button pressed).
> > 
> > report (size 7) (numbered)
> > 
> > 
> > 
> > report (size 7) (numbered)
> > 
> > 
> > 
> > report (size 7) (numbered)
> > 
> > 
> > 
> 
> Hmm, this is very odd output. Do you by any chance have messages such as
> 
>         undefined report_id <NUMBER> received
> 
> appearing in your 'dmesg' output when you are pressing the keys?

Does applying the patch below give reasonable output in 'events' debugfs 
file please?



diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 368fbb0..c49aaa2 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1096,20 +1096,11 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int i
 		goto nomem;
 	}
 
-	snprintf(buf, HID_DEBUG_BUFSIZE - 1,
-			"\nreport (size %u) (%snumbered)\n", size, report_enum->numbered ? "" : "un");
-	hid_debug_event(hid, buf);
-
-	report = hid_get_report(report_enum, data);
-	if (!report) {
-		kfree(buf);
-		return -1;
-	}
-
 	/* dump the report */
 	snprintf(buf, HID_DEBUG_BUFSIZE - 1,
-			"report %d (size %u) = ", report->id, size);
+			"\nreport (size %u) (%snumbered) = ", size, report_enum->numbered ? "" : "un");
 	hid_debug_event(hid, buf);
+
 	for (i = 0; i < size; i++) {
 		snprintf(buf, HID_DEBUG_BUFSIZE - 1,
 				" %02x", data[i]);
@@ -1117,6 +1108,13 @@ int hid_input_report(struct hid_device *hid, int type, u8 *data, int size, int i
 	}
 	hid_debug_event(hid, "\n");
 
+	report = hid_get_report(report_enum, data);
+
+	if (!report) {
+		kfree(buf);
+		return -1;
+	}
+
 	kfree(buf);
 
 nomem:
