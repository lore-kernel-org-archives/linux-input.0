From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: Sleeping inside spinlock in force feedback input event code
Date: Sun, 20 Jul 2008 17:10:21 +0300
Message-ID: <4883474D.6080602@gmail.com>
References: <4868e2410806150157o5b290bf7kaccdeb2faf5057d6@mail.gmail.com> <485540A6.1050306@gmail.com> <4868e2410806151023j67ceea16pe1c5ad8ab9a8e122@mail.gmail.com> <4855507E.4030201@gmail.com> <4868e2410806151036o1a1652d8y8bf8432e3c6c0d06@mail.gmail.com> <4868e2410806151036r6d96a840v41b8ee745041db35@mail.gmail.com> <4868e2410806151105v3fec88a1qa439e2cc1423bc6a@mail.gmail.com> <48556723.2090204@gmail.com> <20080616143112.ZZRA012@mailhub.coreip.homeip.net> <485807F4.3010903@gmail.com> <20080617153423.ZZRA012@mailhub.coreip.homeip.net> <48581857.2080906@gmail.com> <4866E804.3000603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:51896 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757061AbYGTOKX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jul 2008 10:10:23 -0400
In-Reply-To: <4866E804.3000603@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, James Carthew <jcarthew@gmail.com>

Anssi Hannula wrote:
> Anssi Hannula wrote:
>   
>> Dmitry Torokhov wrote:
>>   
>>     
>>> On Tue, Jun 17, 2008 at 09:52:36PM +0300, Anssi Hannula wrote:
>>>     
>>>       
>>>> (Added Jiri Kosina due to the hid problem I describe near the end)
>>>>
>>>> Dmitry Torokhov wrote:
>>>>       
>>>>         
>>>>> Hi Anssi,
>>>>>
>>>>> On Sun, Jun 15, 2008 at 10:01:55PM +0300, Anssi Hannula wrote:
>>>>>         
>>>>>           
>>>>>> Hi all!
>>>>>>
>>>>>> It seems a new spinlock input_dev->event_lock has been added [1] to the
>>>>>> input subsystem since the force feedback support was reworked.
>>>>>>
>>>>>> However, the force feedback subsystem sleeps on events in multiple
>>>>>> places, e.g. ff-core.c uses a mutex, and hid-pidff driver waits for hid
>>>>>> io (otherwise commands were lost, IIRC; if necessary I'll test again).
>>>>>>
>>>>>> ff_device->mutex is used to shield effects[], so it is locked when
>>>>>> handling EV_FF events, on flushes, and on effect upload and erase ioctls.
>>>>>>
>>>>>> Maybe we should make EV_FF handling atomic? For effect uploading we
>>>>>> could either make it completely atomic, or lock only for reserving the
>>>>>> effect slot, then release the lock, and mark it as ready after upload is
>>>>>> complete.
>>>>>> Making even the upload completely atomic would mean that no force
>>>>>> feedback events/ioctl() would sleep, which AFAIK would be a plus for
>>>>>> userspace ff applications. On the other hand, hid-pidff (device managed
>>>>>> mode) driver doesn't know whether effect upload was successful until it
>>>>>> has received a report from the device, so it wouldn't be able to report
>>>>>> failure immediately. Other drivers would, though.
>>>>>>
>>>>>> What do you think?
>>>>>>
>>>>>>           
>>>>>>             
>>>>> I think something the patch below is what is needed. EV_FF handling is
>>>>> already atomic because of event_lock (and it is here to stay), but
>>>>> uploading does not need to be atomic, only installing into effect
>>>>> table needs the lock. Any change you could test the patch? I dont have
>>>>> any FF devices.
>>>>>         
>>>>>           
>>>> It seems to be ok, but not enough. The hid-pidff.c driver also waits on
>>>> pidff_playback_pid(). However, I now see that the wait is probably only
>>>> necessary because just the report pointer is passed to
>>>> usbhid_submit_report(). But fixing it properly seems non-trivial (to me).
>>>>
>>>> E.g. the problem sequence is:
>>>>
>>>> - playback_pid() gets called to stop effect 1.
>>>> - it sets control_report->field[X]->value[X] = 1;
>>>> - it submits control_report
>>>> - thus usbhid_submit_report() stores a pointer to the report
>>>> - playback_pid() gets immediately called again for effect 2.
>>>> - it sets control_report->field[X]->value[X] = 2;
>>>> - thus the previous report hasn't yet been submitted, but the report
>>>> content has already changed, thus effect 1 is never stopped.
>>>>
>>>> Any idea how this should be solved properly?
>>>>
>>>>       
>>>>         
>>> It looks like there is a common issue with HID FF devices. Pid driver
>>> tries to handle it by inserting waits till the control queue is
>>> cleared, other drivers are completely ignorant of this problem...
>>> I guess we need to implement a queue of events to be played and put it
>>> in hid-ff.c so it is available for all hid ff drivers.
>>>     
>>>       
>> With other HID FF drivers than hid-pidff we actually want to skip to the
>> last one, though (the report contains complete device state, so skipping
>> old ones does not matter). But indeed of course we still shouldn't be
>> modifying the just-submitted reports since hid_output_report() could be
>> reading them at the same time.
>>
>>   
>>     
> I tried to come up with something today.
>
> Since the only place where the integrity of all reports (i.e. not just
> the last one) is critical is hid-pidff, I implemented report submission
> in workqueue for that. It seems to work.
>
> As was said, though, there are conditions in other places which could
> cause corrupted reports to be sent to devices. However, AFAICS it
> doesn't seem to be a common issue with just HID FF devices, but all code
> using usbhid_submit_report() with USB_DIR_OUT. Therefore I'm not sure
> if any queue implementation in hid-ff.c would be the correct fix, but
> instead it should be fixed so that non-FF users (leds) would be fixed
> too. To achieve that, I modified usbhid_submit_report() to copy the
> report contents before returning. This seems to work as well. I added
> usbhid_wait_io() to effect removal in hid-pidff to prevent an event
> flood from preventing the removal.
>
> Note that even without a fix, any invalid reports would immediately
> be resent with correct content (as any code modifying a report calls
> usbhid_submit_report() again).
>
> That said, I do prefer the usbhid_submit_report() change instead of
> the workqueue one.
> WDYT? Or do you have a better way in mind?
>
> Below is the queue-raw-reports solution. I can post the alternative
> hid-pidff-workqueue solution as well if you want me to.
>   
Ping? Please comment :) I'd really much like the hid-pidff driver
to not panic when used.

For the record, here is a workqueue solution. It is much less
intrusive than the previous patch, but IMO less correct.

Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>

---

--- linux-2.6.26-0.rc5.1mnb-fftest/drivers/hid/usbhid/hid-pidff.c.orig	2008-04-17 05:49:44.000000000 +0300
+++ linux-2.6.26-0.rc5.1mnb-fftest/drivers/hid/usbhid/hid-pidff.c	2008-06-29 01:45:32.000000000 +0300
@@ -20,6 +20,7 @@
 
 #include <linux/input.h>
 #include <linux/usb.h>
+#include <linux/workqueue.h>
 
 #include <linux/hid.h>
 
@@ -155,6 +156,7 @@
 struct pidff_device {
 	struct hid_device *hid;
 
+	struct workqueue_struct *report_queue;
 	struct hid_report *reports[sizeof(pidff_reports)];
 
 	struct pidff_usage set_effect[sizeof(pidff_set_effect)];
@@ -197,6 +199,62 @@
 	int pid_id[PID_EFFECTS_MAX];
 };
 
+struct pidff_queued_report {
+	struct work_struct work;
+	struct hid_report report;
+};
+
+static void pidff_submit_queued_report(struct work_struct *work)
+{
+	unsigned i;
+	struct pidff_queued_report *qreport = (struct pidff_queued_report *) work;
+	struct hid_report report = qreport->report;
+	usbhid_submit_report(report.device, &report, USB_DIR_OUT);
+	usbhid_wait_io(report.device);
+	for (i = 0; i < report.maxfield; i++)
+		kfree(report.field[i]);
+	kfree(qreport);
+}
+
+static void pidff_queue_report(struct pidff_device *pidff,
+			       struct hid_report *report)
+{
+	struct pidff_queued_report *qreport;
+	unsigned i;
+	
+	qreport = kzalloc(sizeof(*qreport), GFP_ATOMIC);
+	if (!qreport) {
+		printk(KERN_ERR "hid-piff: "
+			"not enough free pages for atomic report copy");
+		return;
+	}
+	qreport->report = *report;
+	for (i = 0; i < report->maxfield; i++) {
+		struct hid_field *field;
+		/* See hid_register_field() in hid-core.c */
+		size_t field_alloc_size = sizeof(struct hid_field)
+			+ report->field[i]->maxusage * sizeof(struct hid_usage)
+			+ report->field[i]->report_count * sizeof(unsigned);
+		field = kzalloc(field_alloc_size, GFP_ATOMIC);
+		if (!field) {
+			printk(KERN_ERR "hid-pidff: "
+				"not enough free pages for atomic field copies");
+			goto fail;
+		}
+		memcpy(field, report->field[i], field_alloc_size);
+		qreport->report.field[i] = field;
+	}
+
+	INIT_WORK(&qreport->work, pidff_submit_queued_report);
+	queue_work(pidff->report_queue, &qreport->work);
+	return;
+
+ fail:
+	while (i-- > 0)
+		 kfree(qreport->report.field[i]);
+	kfree(qreport);
+}
+
 /*
  * Scale an unsigned value with range 0..max for the given field
  */
@@ -261,8 +319,7 @@
 	debug("attack %u => %d", envelope->attack_level,
 	      pidff->set_envelope[PID_ATTACK_LEVEL].value[0]);
 
-	usbhid_submit_report(pidff->hid, pidff->reports[PID_SET_ENVELOPE],
-			  USB_DIR_OUT);
+	pidff_queue_report(pidff, pidff->reports[PID_SET_ENVELOPE]);
 }
 
 /*
@@ -288,8 +345,7 @@
 	pidff_set_signed(&pidff->set_constant[PID_MAGNITUDE],
 			 effect->u.constant.level);
 
-	usbhid_submit_report(pidff->hid, pidff->reports[PID_SET_CONSTANT],
-			  USB_DIR_OUT);
+	pidff_queue_report(pidff, pidff->reports[PID_SET_CONSTANT]);
 }
 
 /*
@@ -323,8 +379,7 @@
 				pidff->effect_direction);
 	pidff->set_effect[PID_START_DELAY].value[0] = effect->replay.delay;
 
-	usbhid_submit_report(pidff->hid, pidff->reports[PID_SET_EFFECT],
-			  USB_DIR_OUT);
+	pidff_queue_report(pidff, pidff->reports[PID_SET_EFFECT]);
 }
 
 /*
@@ -355,9 +410,7 @@
 	pidff_set(&pidff->set_periodic[PID_PHASE], effect->u.periodic.phase);
 	pidff->set_periodic[PID_PERIOD].value[0] = effect->u.periodic.period;
 
-	usbhid_submit_report(pidff->hid, pidff->reports[PID_SET_PERIODIC],
-			  USB_DIR_OUT);
-
+	pidff_queue_report(pidff, pidff->reports[PID_SET_PERIODIC]);
 }
 
 /*
@@ -397,9 +450,7 @@
 			  effect->u.condition[i].left_saturation);
 		pidff_set(&pidff->set_condition[PID_DEAD_BAND],
 			  effect->u.condition[i].deadband);
-		usbhid_wait_io(pidff->hid);
-		usbhid_submit_report(pidff->hid, pidff->reports[PID_SET_CONDITION],
-				  USB_DIR_OUT);
+		pidff_queue_report(pidff, pidff->reports[PID_SET_CONDITION]);
 	}
 }
 
@@ -439,8 +490,7 @@
 			 effect->u.ramp.start_level);
 	pidff_set_signed(&pidff->set_ramp[PID_RAMP_END],
 			 effect->u.ramp.end_level);
-	usbhid_submit_report(pidff->hid, pidff->reports[PID_SET_RAMP],
-			  USB_DIR_OUT);
+	pidff_queue_report(pidff, pidff->reports[PID_SET_RAMP]);
 }
 
 /*
@@ -512,9 +562,7 @@
 		pidff->effect_operation[PID_LOOP_COUNT].value[0] = n;
 	}
 
-	usbhid_wait_io(pidff->hid);
-	usbhid_submit_report(pidff->hid, pidff->reports[PID_EFFECT_OPERATION],
-			  USB_DIR_OUT);
+	pidff_queue_report(pidff, pidff->reports[PID_EFFECT_OPERATION]);
 }
 
 /**
@@ -535,8 +583,7 @@
 static void pidff_erase_pid(struct pidff_device *pidff, int pid_id)
 {
 	pidff->block_free[PID_EFFECT_BLOCK_INDEX].value[0] = pid_id;
-	usbhid_submit_report(pidff->hid, pidff->reports[PID_BLOCK_FREE],
-			  USB_DIR_OUT);
+	pidff_queue_report(pidff, pidff->reports[PID_BLOCK_FREE]);
 }
 
 /*
@@ -550,6 +597,9 @@
 	debug("starting to erase %d/%d", effect_id, pidff->pid_id[effect_id]);
 	pidff_playback_pid(pidff, pid_id, 0);
 	pidff_erase_pid(pidff, pid_id);
+	/* wait until the effect has been erased to make sure the freed device
+	   memory is available for a possible immediate effect upload */
+	flush_workqueue(pidff->report_queue);
 
 	return 0;
 }
@@ -1234,6 +1284,12 @@
 
 }
 
+static void pidff_destroy(struct ff_device *ff)
+{
+	struct pidff_device *pidff = ff->private;
+	destroy_workqueue(pidff->report_queue);
+}
+
 /*
  * Check if the device is PID and initialize it
  */
@@ -1266,12 +1322,18 @@
 	if (!pidff_reports_ok(pidff)) {
 		debug("reports not ok, aborting");
 		error = -ENODEV;
-		goto fail;
+		goto fail1;
 	}
 
 	error = pidff_init_fields(pidff, dev);
 	if (error)
-		goto fail;
+		goto fail1;
+
+	pidff->report_queue = create_singlethread_workqueue("hid-pidff");
+	if (!pidff->report_queue) {
+		error = -ENOMEM;
+		goto fail1;
+	}
 
 	pidff_reset(pidff);
 
@@ -1283,7 +1345,7 @@
 
 	error = pidff_check_autocenter(pidff, dev);
 	if (error)
-		goto fail;
+		goto fail2;
 
 	max_effects =
 	    pidff->block_load[PID_EFFECT_BLOCK_INDEX].field->logical_maximum -
@@ -1306,12 +1368,12 @@
 	    pidff->pool[PID_DEVICE_MANAGED_POOL].value[0] == 0) {
 		printk(KERN_NOTICE "hid-pidff: "
 		       "device does not support device managed pool\n");
-		goto fail;
+		goto fail2;
 	}
 
 	error = input_ff_create(dev, max_effects);
 	if (error)
-		goto fail;
+		goto fail2;
 
 	ff = dev->ff;
 	ff->private = pidff;
@@ -1320,13 +1382,16 @@
 	ff->set_gain = pidff_set_gain;
 	ff->set_autocenter = pidff_set_autocenter;
 	ff->playback = pidff_playback;
+	ff->destroy = pidff_destroy;
 
 	printk(KERN_INFO "Force feedback for USB HID PID devices by "
 	       "Anssi Hannula <anssi.hannula@gmail.com>\n");
 
 	return 0;
 
- fail:
+ fail2:
+	destroy_workqueue(pidff->report_queue);
+ fail1:
 	kfree(pidff);
 	return error;
 }



-- 
Anssi Hannula

