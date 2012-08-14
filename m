From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: USB interrupt times
Date: Tue, 14 Aug 2012 12:54:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1208141250020.12490@pobox.suse.cz>
References: <20120814103936.GA7105@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:55517 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756010Ab2HNKyH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Aug 2012 06:54:07 -0400
In-Reply-To: <20120814103936.GA7105@flint.arm.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Henrik Rydberg <rydberg@euromail.se>

On Tue, 14 Aug 2012, Russell King wrote:

> I've been trying to track down where all the CPU time goes while
> processing USB interrupts for HID devices.  At the moment, out of
> everything on the cubox, moving the mouse or even pressing a key
> on the keyboard just once is far more expensive than processing an
> interrupt for the network interface or handling the SDHCI port.
> Handing HID actions weigh in at around 300-400us per USB interrupt.
> 
> Around two-thirds of the time for a USB HID device interrupt is
> spent in the HID layer, currently tracked down to:
> 
> 	for (a = 0; a < report->maxfield; a++)
> 		hid_input_field(hid, report->field[a], cdata, interrupt);
> 
> in hid_report_raw_event().
> 
> However, looking at hid_input_report() and its use of down_trylock(),
> I'm wondering why we're trying to run this chunk of code in IRQ
> context anyway?  Why not a tasklet or workqueue?
> 
> Any suggestions on why processing a key press or mouse movement is soo
> expensive?

Actually, Henrik (added to CC) has been doing some latency improvements 
both for input core in general, and for HID devices as well lately. I 
still have his patchset in my to-review queue, as I have just came back 
from offline vacation, but the patch below definitely can't hurt and 
should significantly lower the time spent in handling the irq for hid 
device in common situation (i.e. noone listening for debugfs events).

Could you please measure how much it helps on your system?

Offloading the processing to workqueue might actually work and make sense, 
but I will have to think a little bit more about all the consequences it'd 
have throughout the rest of the code.



From: Henrik Rydberg <rydberg@euromail.se>
Subject: HID: Only dump input if someone is listening

Going through the motions of printing the debug message information
takes a long time; using the keyboard can lead to a 160 us irqsoff
latency. This patch skips hid_dump_input() when there are no open
handles, which brings latency down to 100 us.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 60ea284..5b74e78 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -996,7 +996,8 @@ static void hid_process_event(struct hid_device *hid, struct hid_field *field,
 	struct hid_driver *hdrv = hid->driver;
 	int ret;
 
-	hid_dump_input(hid, usage, value);
+	if (!list_empty(&hid->debug_list))
+		hid_dump_input(hid, usage, value);
 
 	if (hdrv && hdrv->event && hid_match_usage(hid, usage)) {
 		ret = hdrv->event(hid, field, usage, value);
-- 
Jiri Kosina
SUSE Labs
