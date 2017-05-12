From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: Missing release event for Synaptics touchscreen
Date: Fri, 12 May 2017 16:23:10 +0200
Message-ID: <c2492242-71c3-1bd5-8e1e-0f282e9ab0d1@gmail.com>
References: <708339c2-2b70-81ae-a939-ac122e5fd6f2@gmail.com>
 <1f16ba27-99cd-d16d-f09f-97dcda1bd358@gmail.com>
 <dee48656-1993-b52d-5451-7a0cb186f18a@synaptics.com>
 <03d13b14-1f97-eee7-4131-60ef014cbf50@gmail.com>
 <8c492623-d37c-e8e1-2445-cf86109dad44@ginzinger.com>
 <aa5cb000-7e8a-2f9b-30de-a35b0c44db96@gmail.com>
 <9e370d9b-a2d4-9fcd-9b0d-2d97e225188a@ginzinger.com>
 <CAN+gG=EchYSE4=iZU9NPOvQy6PHZVSZcA2YkoH01nhg81E+Xsw@mail.gmail.com>
 <8566ae03-faad-a1ee-2156-db49d36cea71@ginzinger.com>
 <CAN+gG=Frvd0bJ62xBp+sGFgqB5=mdYwJGo7L+MZiscNbPb4K_w@mail.gmail.com>
 <540cd246-d72f-a9eb-9618-ff2449384a21@ginzinger.com>
 <a4766146-3edb-31c6-16dd-99eee28bdd63@gmail.com>
 <CAN+gG=F8kaWaS81L9uxON-ZDQoHe6eS2puauAofJxGKkhEeCcg@mail.gmail.com>
 <8d690a3d-88f6-cef9-b271-da5dcc87741b@gmail.com>
 <12ac2e90-ba7b-8a29-bb35-40d50841a63b@ginzinger.com>
 <27a556e7-2045-2d6a-3b13-287d314375d5@gmail.com>
 <CAN+gG=G3KbhTFcXZEmiYuOmFsjADvHuwXRxz=FOKf6F9ctB8gg@mail.gmail.com>
 <e87c0744-ff24-d6f5-090b-ab96a478f674@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35103 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751323AbdELOXO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 12 May 2017 10:23:14 -0400
Received: by mail-wr0-f194.google.com with SMTP id g12so7821945wrg.2
        for <linux-input@vger.kernel.org>; Fri, 12 May 2017 07:23:13 -0700 (PDT)
In-Reply-To: <e87c0744-ff24-d6f5-090b-ab96a478f674@gmail.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arek Burdach <arek.burdach@gmail.com>
Cc: Martin Kepplinger <martin.kepplinger@ginzinger.com>, Andrew Duggan <aduggan@synaptics.com>, =?UTF-8?Q?St=c3=a9phane_Chatty?= <chatty@enac.fr>, linux-input <linux-input@vger.kernel.org>



On 05/12/2017 09:57 AM, Arek Burdach wrote:
> 
> 
> On 12.05.2017 09:39, Benjamin Tissoires wrote:
>> On Fri, May 12, 2017 at 9:25 AM, Arek Burdach <arek.burdach@gmail.com>
>> wrote:
>>>
>>> On 12.05.2017 08:56, Martin Kepplinger wrote:
>>>>>>>>> No, you won't have "move after hold>5s" broken. Because at the HID
>>>>>>>>> level, the device is supposed to send an update on every touch
>>>>>>>>> when
>>>>>>>>> reporting a touch (for Windows 8 devices). So if there are tiny
>>>>>>>>> movements filtered at the input level in the kernel, we will get
>>>>>>>>> those
>>>>>>>>> and I suspect the timeout will only appear when the finger actual
>>>>>>>>> leaves the surface.
>>>>>>>> ok. sounds a little more like a solution in the kernel would be
>>>>>>>> justified. Isn't it? It still feels dangerously ugly.
>>>>>>>>
>>>>>>>> Mainly I wanted to point out that if you somehow have to stay with
>>>>>>>> "no"
>>>>>>>> for such broken devices, tslib would be a garbage can for userspace
>>>>>>>> workarounds. (in this case, most probably a new device-specific
>>>>>>>> hidraw
>>>>>>>> based module).
>>>> (...)
>>>>
>>>>> Thank you for clarification. So do someone have an idea how it is
>>>>> possible that Windows manages this? From my point of view, they can't
>>>>> rely on timeouts because effect is visible immediately after releasing
>>>>> finger. Is it possible that they use other protocol for communication
>>>>> with device then we do? Because beside that, I don't see any other
>>>>> option - there is too few information from device to correctly handle
>>>>> this situation.
>>>> hey, Benjamin explained what most probably is going on, see above, so:
>>>>
>>>> 1. convice yourself that microsoft isn't using out-of-band data by
>>>> sniffing the connection.
>>> Touchscreen is communicating via i2c - am i right? Can you recommend
>>> some
>>> i2c sniffer for windows?
>> I wrote something few months ago:
>> https://github.com/bentiss/SimplePeripheralBusProbe
>> But it requires you to have confidence in not breaking your EFI :)
>>
>> I can help you setting the bits up if you want.
>>
>>>> 2. if not, and Benjamin is right, come up with a timer- and hidraw
>>>> based
>>>> solution (I guess) and convince him and Dmitry to take it.
>>>>
>>>> 3. if they don't see any chance to support such broken behaviour in the
>>>> kernel, which could as well be and also has it's benefits in some way,
>>>> you write the thing in userspace (a tslib raw module is only one
>>>> example
>>>> that would make it easy for you).
>>>>
>>>> Even *if* Synaptics would come up with a firmware update:
>>>> 1. the current firmware is already out there in the wild;
>>>> 2. it takes time and work to get people to update
>>>>
>>>> so, if I had the device, I'd write a workaround.
>>> It is reasonable what you've wrote. The only blocker for me is that I
>>> have
>>> almost zero-experience in low level programming. I'm from java world
>>> :-) It
>>> is why I was looking for some low entry level solution. I'll do my
>>> best but
>>> every helping hand will be appreciated.
>> I am currently checking the requirements for the devices to be
>> validated by Microsoft:
>> https://msdn.microsoft.com/en-us/windows/hardware/commercialize/design/compatibility/1703/device-input-digitizer
>>
>>
>> I would believe that the Latency and ReportRate requirements mean that
>> as long as a finger is there, it should be reported at at least 60Hz,
>> meaning that if there are no input reports for more than 16 ms, all
>> fingers should be lifted. I think we can work something like that
>> (taking an arbitrary multiple of 60 Hz would prevent any system lag),
>> and release the touches if nothing comes in for, lets say, 250ms.
> 
> Thank you Benjamin, it is significant brick for building knowledge how
> this devices are handled in Windows. I will take a look in our drivers
> and will try to understand the code and find the way how to handle it.
> 
>>
>> I should be able to work on that for Win8 devices. Win7 devices are a
>> different beast, but hopefully they are nearly extinct or at least
>> quirked in the kernel for them to be working.
>>

I have something which seems to compile, but for various reasons I haven't tested it (yet):

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 24d5b6d..2ce0e96 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -44,6 +44,7 @@
 #include <linux/slab.h>
 #include <linux/input/mt.h>
 #include <linux/string.h>
+#include <linux/timer.h>
 
 
 MODULE_AUTHOR("Stephane Chatty <chatty@enac.fr>");
@@ -54,22 +55,23 @@ MODULE_LICENSE("GPL");
 #include "hid-ids.h"
 
 /* quirks to control the device */
-#define MT_QUIRK_NOT_SEEN_MEANS_UP	(1 << 0)
-#define MT_QUIRK_SLOT_IS_CONTACTID	(1 << 1)
-#define MT_QUIRK_CYPRESS		(1 << 2)
-#define MT_QUIRK_SLOT_IS_CONTACTNUMBER	(1 << 3)
-#define MT_QUIRK_ALWAYS_VALID		(1 << 4)
-#define MT_QUIRK_VALID_IS_INRANGE	(1 << 5)
-#define MT_QUIRK_VALID_IS_CONFIDENCE	(1 << 6)
-#define MT_QUIRK_CONFIDENCE		(1 << 7)
-#define MT_QUIRK_SLOT_IS_CONTACTID_MINUS_ONE	(1 << 8)
-#define MT_QUIRK_NO_AREA		(1 << 9)
-#define MT_QUIRK_IGNORE_DUPLICATES	(1 << 10)
-#define MT_QUIRK_HOVERING		(1 << 11)
-#define MT_QUIRK_CONTACT_CNT_ACCURATE	(1 << 12)
-#define MT_QUIRK_FORCE_GET_FEATURE	(1 << 13)
-#define MT_QUIRK_FIX_CONST_CONTACT_ID	(1 << 14)
-#define MT_QUIRK_TOUCH_SIZE_SCALING	(1 << 15)
+#define MT_QUIRK_NOT_SEEN_MEANS_UP	BIT(0)
+#define MT_QUIRK_SLOT_IS_CONTACTID	BIT(1)
+#define MT_QUIRK_CYPRESS		BIT(2)
+#define MT_QUIRK_SLOT_IS_CONTACTNUMBER	BIT(3)
+#define MT_QUIRK_ALWAYS_VALID		BIT(4)
+#define MT_QUIRK_VALID_IS_INRANGE	BIT(5)
+#define MT_QUIRK_VALID_IS_CONFIDENCE	BIT(6)
+#define MT_QUIRK_CONFIDENCE		BIT(7)
+#define MT_QUIRK_SLOT_IS_CONTACTID_MINUS_ONE	BIT(8)
+#define MT_QUIRK_NO_AREA		BIT(9)
+#define MT_QUIRK_IGNORE_DUPLICATES	BIT(10)
+#define MT_QUIRK_HOVERING		BIT(11)
+#define MT_QUIRK_CONTACT_CNT_ACCURATE	BIT(12)
+#define MT_QUIRK_FORCE_GET_FEATURE	BIT(13)
+#define MT_QUIRK_FIX_CONST_CONTACT_ID	BIT(14)
+#define MT_QUIRK_TOUCH_SIZE_SCALING	BIT(15)
+#define MT_QUIRK_STICKY_FINGERS		BIT(16)
 
 #define MT_INPUTMODE_TOUCHSCREEN	0x02
 #define MT_INPUTMODE_TOUCHPAD		0x03
@@ -104,6 +106,7 @@ struct mt_fields {
 struct mt_device {
 	struct mt_slot curdata;	/* placeholder of incoming data */
 	struct mt_class mtclass;	/* our mt device class */
+	struct timer_list release_timer;	/* to release sticky fingers */
 	struct mt_fields *fields;	/* temporary placeholder for storing the
 					   multitouch fields */
 	int cc_index;	/* contact count field index in the report */
@@ -212,7 +215,8 @@ static struct mt_class mt_classes[] = {
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_IGNORE_DUPLICATES |
 			MT_QUIRK_HOVERING |
-			MT_QUIRK_CONTACT_CNT_ACCURATE },
+			MT_QUIRK_CONTACT_CNT_ACCURATE |
+			MT_QUIRK_STICKY_FINGERS },
 	{ .name = MT_CLS_EXPORT_ALL_INPUTS,
 		.quirks = MT_QUIRK_ALWAYS_VALID |
 			MT_QUIRK_CONTACT_CNT_ACCURATE,
@@ -813,6 +817,9 @@ static void mt_touch_report(struct hid_device *hid, struct hid_report *report)
 
 	if (td->num_received >= td->num_expected)
 		mt_sync_frame(td, report->field[0]->hidinput->input);
+
+	if (td->mtclass.quirks & MT_QUIRK_STICKY_FINGERS)
+		mod_timer(&td->release_timer, msecs_to_jiffies(250));
 }
 
 static int mt_touch_input_configured(struct hid_device *hdev,
@@ -1124,6 +1131,35 @@ static void mt_fix_const_fields(struct hid_device *hdev, unsigned int usage)
 	}
 }
 
+static void mt_release_contacts(struct hid_device *hid)
+{
+	struct hid_input *hidinput;
+
+	list_for_each_entry(hidinput, &hid->inputs, list) {
+		struct input_dev *input_dev = hidinput->input;
+		struct input_mt *mt = input_dev->mt;
+		int i;
+
+		if (mt) {
+			for (i = 0; i < mt->num_slots; i++) {
+				input_mt_slot(input_dev, i);
+				input_mt_report_slot_state(input_dev,
+							   MT_TOOL_FINGER,
+							   false);
+			}
+			input_mt_sync_frame(input_dev);
+			input_sync(input_dev);
+		}
+	}
+}
+
+static void mt_expired_timeout(unsigned long arg)
+{
+	struct hid_device *hdev = (void*)arg;
+
+	mt_release_contacts(hdev);
+}
+
 static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret, i;
@@ -1193,6 +1229,8 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	 */
 	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
 
+	setup_timer(&td->release_timer, mt_expired_timeout, (long)hdev);
+
 	ret = hid_parse(hdev);
 	if (ret != 0)
 		return ret;
@@ -1220,28 +1258,6 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 }
 
 #ifdef CONFIG_PM
-static void mt_release_contacts(struct hid_device *hid)
-{
-	struct hid_input *hidinput;
-
-	list_for_each_entry(hidinput, &hid->inputs, list) {
-		struct input_dev *input_dev = hidinput->input;
-		struct input_mt *mt = input_dev->mt;
-		int i;
-
-		if (mt) {
-			for (i = 0; i < mt->num_slots; i++) {
-				input_mt_slot(input_dev, i);
-				input_mt_report_slot_state(input_dev,
-							   MT_TOOL_FINGER,
-							   false);
-			}
-			input_mt_sync_frame(input_dev);
-			input_sync(input_dev);
-		}
-	}
-}
-
 static int mt_reset_resume(struct hid_device *hdev)
 {
 	mt_release_contacts(hdev);
@@ -1266,6 +1282,8 @@ static void mt_remove(struct hid_device *hdev)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
 
+	del_timer_sync(&mt->release_timer);
+
 	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
 	hid_hw_stop(hdev);
 	hdev->quirks = td->initial_quirks;

---

(the (1 << X) -> BIT(X) conversion needs to be done in a separate patch).

>From what I can read in the documentation, this might be enough. However,
I wouldn't be surprised if this segfaults for whatever reasons.
Also note that there is no guards between the execution of the release and
the incoming events. So if you wait around 250 ms between 2 touches, nothing
prevents a race between the timeout previously started and the actual true
touches.

But it might be enough to have a good test case and see if this works well in
your case and in most Win8 devices.

Cheers,
Benjamin
