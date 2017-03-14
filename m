From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: Synaptics RMI4 touchpad regression in 4.11-rc1
Date: Mon, 13 Mar 2017 22:10:22 -0700
Message-ID: <03d8e6ac-1ba4-36a6-cc07-0c07e61f754f@gmail.com>
References: <375e67b5-2cb8-3491-1d71-d8650d6e9451@gmail.com>
 <7964888d-05dd-b109-973a-e0503884e2e2@leemhuis.info>
 <20170313131356.GH4378@mail.corp.redhat.com>
 <20170313131537.GI4378@mail.corp.redhat.com>
 <07543e67-efef-a764-02e6-d81d30b89a1c@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34223 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbdCNFKZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Mar 2017 01:10:25 -0400
In-Reply-To: <07543e67-efef-a764-02e6-d81d30b89a1c@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thorsten Leemhuis <linux@leemhuis.info>, Jiri Kosina <jikos@kernel.org>
Cc: nick@shmanahar.org, cheiny@synaptics.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org



On 03/13/2017 06:35 PM, Andrew Duggan wrote:
> 
> 
> On 03/13/2017 06:15 AM, Benjamin Tissoires wrote:
>> [Resending, forgot to add Jiri in CC]
>>
>> On Mar 13 2017 or thereabouts, Benjamin Tissoires wrote:
>>> On Mar 13 2017 or thereabouts, Thorsten Leemhuis wrote:
>>>> Lo! On 12.03.2017 02:55, Cameron Gutman wrote:
>>>>> Beginning in 4.11-rc1, it looks like RMI4 is binding to my XPS 13 9343's
>>>>> Synaptics touchpad and dropping some errors into dmesg. Here are the
>>>>> messages that seem RMI-related:
>>>>>
>>>>> rmi4_f34 rmi4-00.fn34: rmi_f34v7_probe: Unrecognized bootloader version
>>>>> rmi4_f34: probe of rmi4-00.fn34 failed with error -22
>>>>> rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3038-001, fw id: 1832324
>>>>> input: Synaptics TM3038-001 as /devices/pci0000:00/INT3433:00/i2c-7/i2c-DLL0665:01/0018:06CB:76AD.0001/input/input19
>>>>> hid-rmi 0018:06CB:76AD.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL0665:01 06CB:76AD] on i2c-DLL0665:01
>>>> FWIW, I get this on my XPS 13 DE (9360) with 4.11-rc1:
>>>>
>>>> input: SynPS/2 Synaptics TouchPad as
>>>> /devices/platform/i8042/serio1/input/input6
>>>> rmi4_f34 rmi4-00.fn34: rmi_f34v7_probe: Unrecognized bootloader version
>>>> rmi4_f34: probe of rmi4-00.fn34 failed with error -22
>>>> rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics,
>>>> product: TM3038-003, fw id: 2375007
>>>> input: Synaptics TM3038-003 as
>>>> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-8/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input20
>>>> hid-rmi 0018:06CB:76AF.0001: input,hidraw0: I2C HID v1.00 Mouse
>>>> [DLL075B:01 06CB:76AF] on i2c-DLL075B:01
>>>>
>>>>> […]
>>>>> Compared to hid-multitouch, the RMI stack seems to have completely broken
>>>>> palm rejection and introduced some random jumpiness during fine pointing
>>>>> motions. I don't know if these issues are caused by the above errors or
>>>>> are a separate issue.
> 
> The error about the bootloader version not being recognized just means that updating the firmware is not supported on this touchpad. It is only the F34 firmware update functionality which is failing to load. The palm rejection and jumps are not related to this error.
> 

Maybe that code path should be changed to not make as much noise when it runs
on known unsupported hardware. Something like the attached patch?

> Looking at how hid-multitouch handles palms it looks like palms should not be reported as active when calling input_mt_report_slot_state(). I'm setting the tool type to MT_TOOL_PALM when the firmware determines that a contact is a palm. But, that does not seem to be sufficient enough to have the palms filtered out. After some quick testing it looks like the change below will restore palm rejection similar to that provided by hid-multitouch.
> 

It looks like your email client ate the tabs, but if I apply the change
myself it seems to fix the palm rejection regression for me.

Tested-by: Cameron Gutman <aicommander@gmail.com>

>>>> Just to confirm: I noticed "jumpiness during fine pointing motions" as
>>>> well since switching to 4.11-rc.
> 
> One of my test systems is a XPS 13 9343 and I have not really seen any jumpiness. But, based on the data I am seeing that if I lift my finger and place it again in a short period of time the first event or so will be at the location of the previous contact. Then it will switch over to the current location. When switching over to hid-multitouch I was unable to reproduce this behavior. This definitely could be the source of the jumps.
> 

The jumpiness definitely happens without lifting my finger, but I'm willing
to test any patch you think would improve the situation. Moving one finger
slowly in a figure-8 across my touchpad shows the issue clearly for me. The
small variations in speed of my finger due to the friction on the trackpad
get magnified to relatively large jumpy pointer movements on screen. It
seems much more noticeable in diagonal movements than completely vertical
or horizontal movements.

Regards,
Cameron

---
diff --git a/drivers/input/rmi4/rmi_f34v7.c b/drivers/input/rmi4/rmi_f34v7.c
index 56c6c39..1291d9a 100644
--- a/drivers/input/rmi4/rmi_f34v7.c
+++ b/drivers/input/rmi4/rmi_f34v7.c
@@ -1369,9 +1369,9 @@ int rmi_f34v7_probe(struct f34_data *f34)
 	} else if (f34->bootloader_id[1] == 7) {
 		f34->bl_version = 7;
 	} else {
-		dev_err(&f34->fn->dev, "%s: Unrecognized bootloader version\n",
-				__func__);
-		return -EINVAL;
+		dev_info(&f34->fn->dev, "%s: Unsupported bootloader version: %u\n",
+				__func__, f34->bootloader_id[1]);
+		return -ENODEV;
 	}
 
 	memset(&f34->v7.blkcount, 0x00, sizeof(f34->v7.blkcount));
