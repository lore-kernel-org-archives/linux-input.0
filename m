From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: Sleeping inside spinlock in force feedback input event code
Date: Sat, 04 Oct 2008 15:41:00 +0300
Message-ID: <48E7645C.7080100@gmail.com>
References: <4868e2410806150157o5b290bf7kaccdeb2faf5057d6@mail.gmail.com> <485540A6.1050306@gmail.com> <4868e2410806151023j67ceea16pe1c5ad8ab9a8e122@mail.gmail.com> <4855507E.4030201@gmail.com> <4868e2410806151036o1a1652d8y8bf8432e3c6c0d06@mail.gmail.com> <4868e2410806151036r6d96a840v41b8ee745041db35@mail.gmail.com> <4868e2410806151105v3fec88a1qa439e2cc1423bc6a@mail.gmail.com> <48556723.2090204@gmail.com> <20080616143112.ZZRA012@mailhub.coreip.homeip.net> <485807F4.3010903@gmail.com> <20080617153423.ZZRA012@mailhub.coreip.homeip.net> <48581857.2080906@gmail.com> <4866E804.3000603@gmail.com> <4883474D.6080602@gmail.com> <alpine.LNX.1.10.0807251122210.16387@jikos.suse.cz> <48D55D8B.4070904@gmail.com> <alpine.LNX.1.10.0810031123000.26779@jikos.suse.cz> <48E7546F.3010307@gmail.com> <alpine.LNX
 .1.10.0810041358370.26779@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:59411 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752709AbYJDMlT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 4 Oct 2008 08:41:19 -0400
In-Reply-To: <alpine.LNX.1.10.0810041358370.26779@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, James Carthew <jcarthew@gmail.com>

Jiri Kosina wrote:
> On Sat, 4 Oct 2008, Anssi Hannula wrote:
>
>   
>>> There were some changes in the code due to hidbus getting finally 
>>> merged, but it should be rather trivial to solve.
>>>       
>> AFAICS no changes are needed, it applies to hid.git#mm fine.
>>     
>
> You are right.
>
> Could you please send me the patch with the changelog? I will then merge 
> it for 2.6.28.
>
> Thanks,
>
>   


From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: HID: fix a lockup regression when using force feedback on a PID device

Commit 8006479c9b75fb6594a7b746af3d7f1fbb68f18f introduced a spinlock in
input_dev->event_lock, which is locked when handling input events.
However, the hid-pidff driver sleeps when handling events as it waits for
reports being sent to the device before changing the report contents
again.
This causes a system lockup when trying to use force feedback with a PID
device, a regression introduced in 2.6.24 and 2.6.23.15.

Fix it by extracting the raw report data from struct hid_report
immediately when hid_submit_report() is called, therefore allowing
drivers to change the contents of struct hid_report immediately without
affecting the already-queued transfer.

In hid-pidff, re-add the removed usbhid_wait_io() to
pidff_erase_effect() instead, to prevent a full report queue from causing
the submission to fail, thus not freeing up device memory.
pidff_erase_effect() is not called while dev->event_lock is held.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 07840df..1ae047c 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -232,13 +232,16 @@ static void hid_irq_in(struct urb *urb)
 static int hid_submit_out(struct hid_device *hid)
 {
 	struct hid_report *report;
+	char *raw_report;
 	struct usbhid_device *usbhid = hid->driver_data;
 
-	report = usbhid->out[usbhid->outtail];
+	report = usbhid->out[usbhid->outtail].report;
+	raw_report = usbhid->out[usbhid->outtail].raw_report;
 
-	hid_output_report(report, usbhid->outbuf);
 	usbhid->urbout->transfer_buffer_length = ((report->size - 1) >> 3) + 1 + (report->id > 0);
 	usbhid->urbout->dev = hid_to_usb_dev(hid);
+	memcpy(usbhid->outbuf, raw_report, usbhid->urbout->transfer_buffer_length);
+	kfree(raw_report);
 
 	dbg_hid("submitting out urb\n");
 
@@ -254,17 +257,20 @@ static int hid_submit_ctrl(struct hid_device *hid)
 {
 	struct hid_report *report;
 	unsigned char dir;
+	char *raw_report;
 	int len;
 	struct usbhid_device *usbhid = hid->driver_data;
 
 	report = usbhid->ctrl[usbhid->ctrltail].report;
+	raw_report = usbhid->ctrl[usbhid->ctrltail].raw_report;
 	dir = usbhid->ctrl[usbhid->ctrltail].dir;
 
 	len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
 	if (dir == USB_DIR_OUT) {
-		hid_output_report(report, usbhid->ctrlbuf);
 		usbhid->urbctrl->pipe = usb_sndctrlpipe(hid_to_usb_dev(hid), 0);
 		usbhid->urbctrl->transfer_buffer_length = len;
+		memcpy(usbhid->ctrlbuf, raw_report, len);
+		kfree(raw_report);
 	} else {
 		int maxpacket, padlen;
 
@@ -401,6 +407,7 @@ void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, uns
 	int head;
 	unsigned long flags;
 	struct usbhid_device *usbhid = hid->driver_data;
+	int len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
 
 	if ((hid->quirks & HID_QUIRK_NOGET) && dir == USB_DIR_IN)
 		return;
@@ -415,7 +422,14 @@ void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, uns
 			return;
 		}
 
-		usbhid->out[usbhid->outhead] = report;
+		usbhid->out[usbhid->outhead].raw_report = kmalloc(len, GFP_ATOMIC);
+		if (!usbhid->out[usbhid->outhead].raw_report) {
+			spin_unlock_irqrestore(&usbhid->outlock, flags);
+			warn("output queueing failed");
+			return;
+		}
+		hid_output_report(report, usbhid->out[usbhid->outhead].raw_report);
+		usbhid->out[usbhid->outhead].report = report;
 		usbhid->outhead = head;
 
 		if (!test_and_set_bit(HID_OUT_RUNNING, &usbhid->iofl))
@@ -434,6 +448,15 @@ void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, uns
 		return;
 	}
 
+	if (dir == USB_DIR_OUT) {
+		usbhid->ctrl[usbhid->ctrlhead].raw_report = kmalloc(len, GFP_ATOMIC);
+		if (!usbhid->ctrl[usbhid->ctrlhead].raw_report) {
+			spin_unlock_irqrestore(&usbhid->ctrllock, flags);
+			warn("control queueing failed");
+			return;
+		}
+		hid_output_report(report, usbhid->ctrl[usbhid->ctrlhead].raw_report);
+	}
 	usbhid->ctrl[usbhid->ctrlhead].report = report;
 	usbhid->ctrl[usbhid->ctrlhead].dir = dir;
 	usbhid->ctrlhead = head;
diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 0113261..484e3ee 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -397,7 +397,6 @@ static void pidff_set_condition_report(struct pidff_device *pidff,
 			  effect->u.condition[i].left_saturation);
 		pidff_set(&pidff->set_condition[PID_DEAD_BAND],
 			  effect->u.condition[i].deadband);
-		usbhid_wait_io(pidff->hid);
 		usbhid_submit_report(pidff->hid, pidff->reports[PID_SET_CONDITION],
 				  USB_DIR_OUT);
 	}
@@ -512,7 +511,6 @@ static void pidff_playback_pid(struct pidff_device *pidff, int pid_id, int n)
 		pidff->effect_operation[PID_LOOP_COUNT].value[0] = n;
 	}
 
-	usbhid_wait_io(pidff->hid);
 	usbhid_submit_report(pidff->hid, pidff->reports[PID_EFFECT_OPERATION],
 			  USB_DIR_OUT);
 }
@@ -548,6 +546,9 @@ static int pidff_erase_effect(struct input_dev *dev, int effect_id)
 	int pid_id = pidff->pid_id[effect_id];
 
 	debug("starting to erase %d/%d", effect_id, pidff->pid_id[effect_id]);
+	/* Wait for the queue to clear. We do not want a full fifo to
+	   prevent the effect removal. */
+	usbhid_wait_io(pidff->hid);
 	pidff_playback_pid(pidff, pid_id, 0);
 	pidff_erase_pid(pidff, pid_id);
 
diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index b47f991..abedb13 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -67,7 +67,7 @@ struct usbhid_device {
 	spinlock_t ctrllock;                                            /* Control fifo spinlock */
 
 	struct urb *urbout;                                             /* Output URB */
-	struct hid_report *out[HID_CONTROL_FIFO_SIZE];                  /* Output pipe fifo */
+	struct hid_output_fifo out[HID_CONTROL_FIFO_SIZE];              /* Output pipe fifo */
 	unsigned char outhead, outtail;                                 /* Output pipe fifo head & tail */
 	char *outbuf;                                                   /* Output buffer */
 	dma_addr_t outbuf_dma;                                          /* Output buffer dma */
diff --git a/include/linux/hid.h b/include/linux/hid.h
index eb1844c..3e2726a 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -388,6 +388,12 @@ struct hid_report_enum {
 struct hid_control_fifo {
 	unsigned char dir;
 	struct hid_report *report;
+	char *raw_report;
+};
+
+struct hid_output_fifo {
+	struct hid_report *report;
+	char *raw_report;
 };
 
 #define HID_CLAIMED_INPUT	1



-- 
Anssi Hannula

