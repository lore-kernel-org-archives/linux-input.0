From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: Sleeping inside spinlock in force feedback input event code
Date: Sun, 29 Jun 2008 04:40:20 +0300
Message-ID: <4866E804.3000603@gmail.com>
References: <4868e2410806150157o5b290bf7kaccdeb2faf5057d6@mail.gmail.com> <485540A6.1050306@gmail.com> <4868e2410806151023j67ceea16pe1c5ad8ab9a8e122@mail.gmail.com> <4855507E.4030201@gmail.com> <4868e2410806151036o1a1652d8y8bf8432e3c6c0d06@mail.gmail.com> <4868e2410806151036r6d96a840v41b8ee745041db35@mail.gmail.com> <4868e2410806151105v3fec88a1qa439e2cc1423bc6a@mail.gmail.com> <48556723.2090204@gmail.com> <20080616143112.ZZRA012@mailhub.coreip.homeip.net> <485807F4.3010903@gmail.com> <20080617153423.ZZRA012@mailhub.coreip.homeip.net> <48581857.2080906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:40141 "EHLO
	jenni2.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752921AbYF2Bk2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Jun 2008 21:40:28 -0400
In-Reply-To: <48581857.2080906@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, James Carthew <jcarthew@gmail.com>

Anssi Hannula wrote:
> Dmitry Torokhov wrote:
>   
>> On Tue, Jun 17, 2008 at 09:52:36PM +0300, Anssi Hannula wrote:
>>     
>>> (Added Jiri Kosina due to the hid problem I describe near the end)
>>>
>>> Dmitry Torokhov wrote:
>>>       
>>>> Hi Anssi,
>>>>
>>>> On Sun, Jun 15, 2008 at 10:01:55PM +0300, Anssi Hannula wrote:
>>>>         
>>>>> Hi all!
>>>>>
>>>>> It seems a new spinlock input_dev->event_lock has been added [1] to the
>>>>> input subsystem since the force feedback support was reworked.
>>>>>
>>>>> However, the force feedback subsystem sleeps on events in multiple
>>>>> places, e.g. ff-core.c uses a mutex, and hid-pidff driver waits for hid
>>>>> io (otherwise commands were lost, IIRC; if necessary I'll test again).
>>>>>
>>>>> ff_device->mutex is used to shield effects[], so it is locked when
>>>>> handling EV_FF events, on flushes, and on effect upload and erase ioctls.
>>>>>
>>>>> Maybe we should make EV_FF handling atomic? For effect uploading we
>>>>> could either make it completely atomic, or lock only for reserving the
>>>>> effect slot, then release the lock, and mark it as ready after upload is
>>>>> complete.
>>>>> Making even the upload completely atomic would mean that no force
>>>>> feedback events/ioctl() would sleep, which AFAIK would be a plus for
>>>>> userspace ff applications. On the other hand, hid-pidff (device managed
>>>>> mode) driver doesn't know whether effect upload was successful until it
>>>>> has received a report from the device, so it wouldn't be able to report
>>>>> failure immediately. Other drivers would, though.
>>>>>
>>>>> What do you think?
>>>>>
>>>>>           
>>>> I think something the patch below is what is needed. EV_FF handling is
>>>> already atomic because of event_lock (and it is here to stay), but
>>>> uploading does not need to be atomic, only installing into effect
>>>> table needs the lock. Any change you could test the patch? I dont have
>>>> any FF devices.
>>>>         
>>> It seems to be ok, but not enough. The hid-pidff.c driver also waits on
>>> pidff_playback_pid(). However, I now see that the wait is probably only
>>> necessary because just the report pointer is passed to
>>> usbhid_submit_report(). But fixing it properly seems non-trivial (to me).
>>>
>>> E.g. the problem sequence is:
>>>
>>> - playback_pid() gets called to stop effect 1.
>>> - it sets control_report->field[X]->value[X] = 1;
>>> - it submits control_report
>>> - thus usbhid_submit_report() stores a pointer to the report
>>> - playback_pid() gets immediately called again for effect 2.
>>> - it sets control_report->field[X]->value[X] = 2;
>>> - thus the previous report hasn't yet been submitted, but the report
>>> content has already changed, thus effect 1 is never stopped.
>>>
>>> Any idea how this should be solved properly?
>>>
>>>       
>> It looks like there is a common issue with HID FF devices. Pid driver
>> tries to handle it by inserting waits till the control queue is
>> cleared, other drivers are completely ignorant of this problem...
>> I guess we need to implement a queue of events to be played and put it
>> in hid-ff.c so it is available for all hid ff drivers.
>>     
>
> With other HID FF drivers than hid-pidff we actually want to skip to the
> last one, though (the report contains complete device state, so skipping
> old ones does not matter). But indeed of course we still shouldn't be
> modifying the just-submitted reports since hid_output_report() could be
> reading them at the same time.
>
>   
I tried to come up with something today.

Since the only place where the integrity of all reports (i.e. not just
the last one) is critical is hid-pidff, I implemented report submission
in workqueue for that. It seems to work.

As was said, though, there are conditions in other places which could
cause corrupted reports to be sent to devices. However, AFAICS it
doesn't seem to be a common issue with just HID FF devices, but all code
using usbhid_submit_report() with USB_DIR_OUT. Therefore I'm not sure
if any queue implementation in hid-ff.c would be the correct fix, but
instead it should be fixed so that non-FF users (leds) would be fixed
too. To achieve that, I modified usbhid_submit_report() to copy the
report contents before returning. This seems to work as well. I added
usbhid_wait_io() to effect removal in hid-pidff to prevent an event
flood from preventing the removal.

Note that even without a fix, any invalid reports would immediately
be resent with correct content (as any code modifying a report calls
usbhid_submit_report() again).

That said, I do prefer the usbhid_submit_report() change instead of
the workqueue one.
WDYT? Or do you have a better way in mind?

Below is the queue-raw-reports solution. I can post the alternative
hid-pidff-workqueue solution as well if you want me to.


Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
---
Not tested extensively yet, just gathering comments.

--- linux-2.6.26-0.rc5.1mnb-fftest/include/linux/hid.h.orig	2008-06-12 15:39:31.000000000 +0300
+++ linux-2.6.26-0.rc5.1mnb-fftest/include/linux/hid.h	2008-06-29 03:02:30.000000000 +0300
@@ -411,6 +411,12 @@
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
--- linux-2.6.26-0.rc5.1mnb-fftest/drivers/hid/usbhid/usbhid.h.orig	2008-06-12 15:38:11.000000000 +0300
+++ linux-2.6.26-0.rc5.1mnb-fftest/drivers/hid/usbhid/usbhid.h	2008-06-29 02:47:22.000000000 +0300
@@ -67,7 +67,7 @@
 	spinlock_t ctrllock;                                            /* Control fifo spinlock */
 
 	struct urb *urbout;                                             /* Output URB */
-	struct hid_report *out[HID_CONTROL_FIFO_SIZE];                  /* Output pipe fifo */
+	struct hid_output_fifo out[HID_CONTROL_FIFO_SIZE];              /* Output pipe fifo */
 	unsigned char outhead, outtail;                                 /* Output pipe fifo head & tail */
 	char *outbuf;                                                   /* Output buffer */
 	dma_addr_t outbuf_dma;                                          /* Output buffer dma */
--- linux-2.6.26-0.rc5.1mnb-fftest/drivers/hid/usbhid/hid-core.c.orig	2008-06-12 15:38:11.000000000 +0300
+++ linux-2.6.26-0.rc5.1mnb-fftest/drivers/hid/usbhid/hid-core.c	2008-06-29 03:01:42.000000000 +0300
@@ -240,13 +240,16 @@
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
 
@@ -262,17 +265,20 @@
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
 
@@ -408,6 +414,7 @@
 	int head;
 	unsigned long flags;
 	struct usbhid_device *usbhid = hid->driver_data;
+	int len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
 
 	if ((hid->quirks & HID_QUIRK_NOGET) && dir == USB_DIR_IN)
 		return;
@@ -422,7 +429,14 @@
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
@@ -441,6 +455,15 @@
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
--- linux-2.6.26-0.rc5.1mnb-fftest/drivers/hid/usbhid/hid-pidff.c.orig	2008-04-17 05:49:44.000000000 +0300
+++ linux-2.6.26-0.rc5.1mnb-fftest/drivers/hid/usbhid/hid-pidff.c	2008-06-29 04:06:50.000000000 +0300
@@ -397,7 +397,6 @@
 			  effect->u.condition[i].left_saturation);
 		pidff_set(&pidff->set_condition[PID_DEAD_BAND],
 			  effect->u.condition[i].deadband);
-		usbhid_wait_io(pidff->hid);
 		usbhid_submit_report(pidff->hid, pidff->reports[PID_SET_CONDITION],
 				  USB_DIR_OUT);
 	}
@@ -512,7 +511,6 @@
 		pidff->effect_operation[PID_LOOP_COUNT].value[0] = n;
 	}
 
-	usbhid_wait_io(pidff->hid);
 	usbhid_submit_report(pidff->hid, pidff->reports[PID_EFFECT_OPERATION],
 			  USB_DIR_OUT);
 }
@@ -548,6 +546,9 @@
 	int pid_id = pidff->pid_id[effect_id];
 
 	debug("starting to erase %d/%d", effect_id, pidff->pid_id[effect_id]);
+	/* Wait for the queue to clear. We do not want a full fifo to
+	   prevent the effect removal. */
+	usbhid_wait_io(pidff->hid);
 	pidff_playback_pid(pidff, pid_id, 0);
 	pidff_erase_pid(pidff, pid_id);
 



-- 
Anssi Hannula

