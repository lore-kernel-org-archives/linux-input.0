From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: Synaptics RMI4 touchpad regression in 4.11-rc1
Date: Mon, 13 Mar 2017 18:35:01 -0700
Message-ID: <07543e67-efef-a764-02e6-d81d30b89a1c@synaptics.com>
References: <375e67b5-2cb8-3491-1d71-d8650d6e9451@gmail.com>
 <7964888d-05dd-b109-973a-e0503884e2e2@leemhuis.info>
 <20170313131356.GH4378@mail.corp.redhat.com>
 <20170313131537.GI4378@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-by2nam01on0074.outbound.protection.outlook.com ([104.47.34.74]:27853
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752235AbdCNBfe (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Mar 2017 21:35:34 -0400
In-Reply-To: <20170313131537.GI4378@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Thorsten Leemhuis <linux@leemhuis.info>, Jiri Kosina <jikos@kernel.org>
Cc: Cameron Gutman <aicommander@gmail.com>, nick@shmanahar.org, cheiny@synaptics.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org



On 03/13/2017 06:15 AM, Benjamin Tissoires wrote:
> [Resending, forgot to add Jiri in CC]
>
> On Mar 13 2017 or thereabouts, Benjamin Tissoires wrote:
>> On Mar 13 2017 or thereabouts, Thorsten Leemhuis wrote:
>>> Lo! On 12.03.2017 02:55, Cameron Gutman wrote:
>>>> Beginning in 4.11-rc1, it looks like RMI4 is binding to my XPS 13 9343's
>>>> Synaptics touchpad and dropping some errors into dmesg. Here are the
>>>> messages that seem RMI-related:
>>>>
>>>> rmi4_f34 rmi4-00.fn34: rmi_f34v7_probe: Unrecognized bootloader version
>>>> rmi4_f34: probe of rmi4-00.fn34 failed with error -22
>>>> rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics, product: TM3038-001, fw id: 1832324
>>>> input: Synaptics TM3038-001 as /devices/pci0000:00/INT3433:00/i2c-7/i2c-DLL0665:01/0018:06CB:76AD.0001/input/input19
>>>> hid-rmi 0018:06CB:76AD.0001: input,hidraw0: I2C HID v1.00 Mouse [DLL0665:01 06CB:76AD] on i2c-DLL0665:01
>>> FWIW, I get this on my XPS 13 DE (9360) with 4.11-rc1:
>>>
>>> input: SynPS/2 Synaptics TouchPad as
>>> /devices/platform/i8042/serio1/input/input6
>>> rmi4_f34 rmi4-00.fn34: rmi_f34v7_probe: Unrecognized bootloader version
>>> rmi4_f34: probe of rmi4-00.fn34 failed with error -22
>>> rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics,
>>> product: TM3038-003, fw id: 2375007
>>> input: Synaptics TM3038-003 as
>>> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-8/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input20
>>> hid-rmi 0018:06CB:76AF.0001: input,hidraw0: I2C HID v1.00 Mouse
>>> [DLL075B:01 06CB:76AF] on i2c-DLL075B:01
>>>
>>>> […]
>>>> Compared to hid-multitouch, the RMI stack seems to have completely broken
>>>> palm rejection and introduced some random jumpiness during fine pointing
>>>> motions. I don't know if these issues are caused by the above errors or
>>>> are a separate issue.

The error about the bootloader version not being recognized just means 
that updating the firmware is not supported on this touchpad. It is only 
the F34 firmware update functionality which is failing to load. The palm 
rejection and jumps are not related to this error.

Looking at how hid-multitouch handles palms it looks like palms should 
not be reported as active when calling input_mt_report_slot_state(). I'm 
setting the tool type to MT_TOOL_PALM when the firmware determines that 
a contact is a palm. But, that does not seem to be sufficient enough to 
have the palms filtered out. After some quick testing it looks like the 
change below will restore palm rejection similar to that provided by 
hid-multitouch.

>>> Just to confirm: I noticed "jumpiness during fine pointing motions" as
>>> well since switching to 4.11-rc.

One of my test systems is a XPS 13 9343 and I have not really seen any 
jumpiness. But, based on the data I am seeing that if I lift my finger 
and place it again in a short period of time the first event or so will 
be at the location of the previous contact. Then it will switch over to 
the current location. When switching over to hid-multitouch I was unable 
to reproduce this behavior. This definitely could be the source of the 
jumps.

>> Thanks both of you for the reports.
>> Andrew, Jiri, I think switching everybody to rmi4-core was maybe not the
>> best move. Could we add a module parameter somewhere to force switching
>> back to hid-multitouch? (Or the other way around more likely).
>>
>> We might need to have users testing rmi4-core and report libinput bugs,
>> but introducing such regressions for everybody is IMO not the right way.

If we added a module parameter it seems like we would need to add it to 
hid-core since that is where the decision on which driver to bind to is 
made. I'm a little hesitant to apply a hopefully temporary and very 
specific parameter to hid-core. I also think it probably depends on if 
these issues end up being quick bugfixes in the RMI driver or if fixes 
are needed in libinput. Worst case, we just revert the commit 
279967a65b32 (HID: rmi: Handle all Synaptics touchpads using hid-rmi) 
and have PTP touchpads go back to hid-multitouch.c until things are 
sorted out.

>> Note that I do not see any differences besides bug fixes when switching
>> from PS/2 to RMI4-core on my Lenovo T450s, so maybe the hid-multitouch
>> capable firmware does some more filtering (the Lenovos are not using HID
>> for the touchpads).

The touchpads which work with hid-multitouch typically use a newer 
generation chip which report 2D using F12 instead of F11. SMBus 
touchpads generally use F11. This is the first wide ranging test of the 
F12 implementation for touchpads. Another recent change is the storing 
of HID attention reports in the FIFO queue. If somehow an old report in 
the FIFO is being sent as the initial event with the coordinates from 
the previous contact. But, I did not see anything after a quick look at 
the FIFO code. I'll test on a non PTP HID / I2C touchpad to try to 
narrow down if t he issue is in HID or F12.

Finally, the problem could be in the firmware. But, I have been told 
that the data sent through the PTP collection is identical to the data 
reported in the RMI registers and that no additional filtering is taking 
place.

Andrew


>>> @benjamin: Just wondering: Could that have something to do with the
>>> ps2->rmi handover? I noticed that patches to improve things in this area
>>> are still circulating, which lead me to wonder if that might have
>>> anything to do with this. But it's just a wild guess.
>> This has nothing to do. ps2->rmi is not used at all by hid-rmi as the
>> enumeration is done in the ACPI. The series you are mentioning are for
>> touchpads that do not enumerate. Once enumerated (either through PS/2 or
>> HID), the code should be the same.
>>
>> Cheers,
>> Benjamin
>>
>>>> The affected machine is an XPS 13 9343 running Fedora 25 with 4.11-rc1
>>>> and libinput 1.6.3-3.fc25 (latest in F25).
>>> Same setup here. In case it matters: I'm running Gnome-Shell in Wayland
>>> mode.
>>>
>>> Ciao, Thorsten
>>>
>>> P.S.: I fixed the model number in above quotes from Cameron to avoid
>>> confusion (he has a 9343, and not a 9443, as initially stated; see a
>>> different mail in this thread for details)
---
diff --git a/drivers/input/rmi4/rmi_2d_sensor.c 
b/drivers/input/rmi4/rmi_2d_sensor.c
index 8bb866c..8d1f295 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.c
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -80,7 +80,8 @@ void rmi_2d_sensor_abs_report(struct rmi_2d_sensor 
*sensor,
                 input_mt_slot(input, slot);

         input_mt_report_slot_state(input, obj->mt_tool,
-                                  obj->type != RMI_2D_OBJECT_NONE);
+                                  (obj->type != RMI_2D_OBJECT_NONE)
+                                  && (obj->type != RMI_2D_OBJECT_PALM));

         if (obj->type != RMI_2D_OBJECT_NONE) {
                 obj->x = sensor->tracking_pos[slot].x;

