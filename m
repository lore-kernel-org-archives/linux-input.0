From: =?UTF-8?Q?Mantas_Mikul=c4=97nas?= <grawity@gmail.com>
Subject: Re: Synaptics RMI4 touchpad regression in 4.11-rc1
Date: Mon, 20 Nov 2017 16:03:49 +0200
Message-ID: <ce04a518-f00c-a3a1-6693-45f67e355146@gmail.com>
References: <20170313131537.GI4378@mail.corp.redhat.com>
 <07543e67-efef-a764-02e6-d81d30b89a1c@synaptics.com>
 <03d8e6ac-1ba4-36a6-cc07-0c07e61f754f@gmail.com>
 <86d9e1c0-8e2b-acdd-64a1-774fc7a4d778@synaptics.com>
 <CAN+gG=Eak7oCXPiwR+NPT12pcx45qeYojemxauepdyyFgdShEA@mail.gmail.com>
 <4685193c-1512-44ad-bfde-1455becb9db4@synaptics.com>
 <20170320050009.GA20783@jelly>
 <f23fbe37-d611-163f-9f1b-79771cbfa368@synaptics.com>
 <20170329085006.GK4009@mail.corp.redhat.com>
 <0711305d-28d8-c51b-16cb-f389f1a4610d@synaptics.com>
 <20170331085751.GF22683@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170331085751.GF22683@mail.corp.redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 2017-03-31 11:57, Benjamin Tissoires wrote:
> On Mar 29 2017 or thereabouts, Andrew Duggan wrote:
>>
>>
>> On 03/29/2017 01:50 AM, Benjamin Tissoires wrote:
>>> On Mar 28 2017 or thereabouts, Andrew Duggan wrote:
>>>> On 03/19/2017 10:00 PM, Peter Hutterer wrote:
>>>>> On Fri, Mar 17, 2017 at 12:23:36PM -0700, Andrew Duggan wrote:
>>>>>> On 03/17/2017 09:57 AM, Benjamin Tissoires wrote:
>>>>>>> On Wed, Mar 15, 2017 at 2:19 AM, Andrew Duggan<aduggan@synaptics.com>  wrote:
>>>>>>>> On 03/13/2017 10:10 PM, Cameron Gutman wrote:
>>>>>>>>> On 03/13/2017 06:35 PM, Andrew Duggan wrote:
>>>>>>>>>> On 03/13/2017 06:15 AM, Benjamin Tissoires wrote:
>>>>>>>>>>> [Resending, forgot to add Jiri in CC]
>>>>>>>>>>>
>>>>>>>>>>> On Mar 13 2017 or thereabouts, Benjamin Tissoires wrote:
>>>>>>>>>>>> On Mar 13 2017 or thereabouts, Thorsten Leemhuis wrote:
>>>>>>>>>>>>> Lo! On 12.03.2017 02:55, Cameron Gutman wrote:
>>>>>>>>>>>>>> Beginning in 4.11-rc1, it looks like RMI4 is binding to my XPS 13
>>>>>>>>>>>>>> 9343's
>>>>>>>>>>>>>> Synaptics touchpad and dropping some errors into dmesg. Here are the
>>>>>>>>>>>>>> messages that seem RMI-related:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> rmi4_f34 rmi4-00.fn34: rmi_f34v7_probe: Unrecognized bootloader
>>>>>>>>>>>>>> version
>>>>>>>>>>>>>> rmi4_f34: probe of rmi4-00.fn34 failed with error -22
>>>>>>>>>>>>>> rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics,
>>>>>>>>>>>>>> product: TM3038-001, fw id: 1832324
>>>>>>>>>>>>>> input: Synaptics TM3038-001 as
>>>>>>>>>>>>>> /devices/pci0000:00/INT3433:00/i2c-7/i2c-DLL0665:01/0018:06CB:76AD.0001/input/input19
>>>>>>>>>>>>>> hid-rmi 0018:06CB:76AD.0001: input,hidraw0: I2C HID v1.00 Mouse
>>>>>>>>>>>>>> [DLL0665:01 06CB:76AD] on i2c-DLL0665:01
>>>>>>>>>>>>> FWIW, I get this on my XPS 13 DE (9360) with 4.11-rc1:
>>>>>>>>>>>>>
>>>>>>>>>>>>> input: SynPS/2 Synaptics TouchPad as
>>>>>>>>>>>>> /devices/platform/i8042/serio1/input/input6
>>>>>>>>>>>>> rmi4_f34 rmi4-00.fn34: rmi_f34v7_probe: Unrecognized bootloader
>>>>>>>>>>>>> version
>>>>>>>>>>>>> rmi4_f34: probe of rmi4-00.fn34 failed with error -22
>>>>>>>>>>>>> rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer: Synaptics,
>>>>>>>>>>>>> product: TM3038-003, fw id: 2375007
>>>>>>>>>>>>> input: Synaptics TM3038-003 as
>>>>>>>>>>>>>
>>>>>>>>>>>>> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-8/i2c-DLL075B:01/0018:06CB:76AF.0001/input/input20
>>>>>>>>>>>>> hid-rmi 0018:06CB:76AF.0001: input,hidraw0: I2C HID v1.00 Mouse
>>>>>>>>>>>>> [DLL075B:01 06CB:76AF] on i2c-DLL075B:01
>>>>>>>>>>>>>
>>>>>>>>>>>>>> […]
>>>>>>>>>>>>>> Compared to hid-multitouch, the RMI stack seems to have completely
>>>>>>>>>>>>>> broken
>>>>>>>>>>>>>> palm rejection and introduced some random jumpiness during fine
>>>>>>>>>>>>>> pointing
>>>>>>>>>>>>>> motions. I don't know if these issues are caused by the above errors
>>>>>>>>>>>>>> or
>>>>>>>>>>>>>> are a separate issue.
>>>>>>>>>> The error about the bootloader version not being recognized just means
>>>>>>>>>> that updating the firmware is not supported on this touchpad. It is only the
>>>>>>>>>> F34 firmware update functionality which is failing to load. The palm
>>>>>>>>>> rejection and jumps are not related to this error.
>>>>>>>>>>
>>>>>>>>> Maybe that code path should be changed to not make as much noise when it
>>>>>>>>> runs
>>>>>>>>> on known unsupported hardware. Something like the attached patch?
>>>>>>>>>
>>>>>>>>>> Looking at how hid-multitouch handles palms it looks like palms should
>>>>>>>>>> not be reported as active when calling input_mt_report_slot_state(). I'm
>>>>>>>>>> setting the tool type to MT_TOOL_PALM when the firmware determines that a
>>>>>>>>>> contact is a palm. But, that does not seem to be sufficient enough to have
>>>>>>>>>> the palms filtered out. After some quick testing it looks like the change
>>>>>>>>>> below will restore palm rejection similar to that provided by
>>>>>>>>>> hid-multitouch.
>>>>>>>>>>
>>>>>>>>> It looks like your email client ate the tabs, but if I apply the change
>>>>>>>>> myself it seems to fix the palm rejection regression for me.
>>>>>>>>>
>>>>>>>>> Tested-by: Cameron Gutman<aicommander@gmail.com>
>>>>>>>> Sorry, I was short on time and just copied the diff into the email. I'll
>>>>>>>> submit a proper patch soon with your tested-by included. Thanks for testing.
>>>>>>>>
>>>>>>>>
>>>>>>> I just pointed out this patch (well the actual submission) to Jason
>>>>>>> (Cc-ed). Given that there is no proper handling of MT_TOOL_PALM yet in
>>>>>>> userspace, I thought it was the easiest way.
>>>>>>> However, it seems that this doesn't enhance the jumps and just make it worse.
>>>>>> I was assuming that the jumps and palm rejection where two separate issues.
>>>>>> But, the palm rejection patch makes things worse?
>>>>>>
>>>>>>> Is there anything we can do to fix it (besides temporary disabling the
>>>>>>> automatic loading of hid-rmi)?
>>>>>> I do not have a fix for the jumps yet. My next step is to file a bug against
>>>>>> libinput or the kernel. I used evemu-record to capture a log with jumps, but
>>>>>> when I play it back with a different userspace input stack with an older
>>>>>> version of libinput I do not see the jumps. I see the jumps on Fedora 25
>>>>>> with libinput 1.6.3 vs Ubuntu 16.10 with libinput 1.4.3 with X). Or at least
>>>>>> the jumps are not as significant. But, its possible there is an issue with
>>>>>> how the events are being reported which is incorrect and confusing libinput.
>>>>>> The X and Y coordinates being reported by the firmware seem correct and I
>>>>>> haven't found a problem yet. I thought a bug would be a better place to
>>>>>> collect evemu-record logs and compare.
>>>>> fwiw, there's a fairly easy way to quickly check libinput for changes and
>>>>> that's by having the gtk3-headers installed at configure time and then
>>>>> running sudo ./tools/event-gui to visualize the movement (Esc quits)
>>>>>
>>>>> That tool uses libinput data directly to draw pointer motion etc, so it's a
>>>>> way to quickly bisect to where changes happen. Without anything else to go
>>>>> on, I'd say it's the new touchpad acceleration code from libinput 1.5 - the
>>>>> max accel factor has changed so depending on the speed of the jumps, you can
>>>>> now get stronger pointer movement.
>>>>>
>>>>> Cheers,
>>>>>      Peter
>>>> I have been looking into this on and off and I found a couple things, but
>>>> nothing conclusive yet. I think Peter is right that versions of libinput 1.5
>>>> and later do make the jump more pronounced. But, the new acceleration code
>>>> my simply be amplifying the jumps. I went ahead and filed a libinput bug
>>>> since the jumps are more significant in newer versions of libinput and I
>>>> attached some evemu-record logs.
>>>>
>>>> https://bugs.freedesktop.org/show_bug.cgi?id=100436
>>>>
>>>> I also spent time looking into the kernel drivers to see if they were
>>>> causing or contributing to the jumps. One of the things that I tried was
>>>> calling rmi_irq_fn() from a workqueue instead of calling
>>>> generic_handle_irq(). Originally, we were using a workqueue before interrupt
>>>> handling was added to the rmi core. I also tried moving the call to
>>>> generic_handle_irq() to a workqueue. In both cases the jumps seemed to
>>>> disappear or at least be reduced. I looked through the irq handling code and
>>>> I did not see anything which should cause an issue. The only difference
>>>> between irq thread and the workqueue that I could think of is that the irq
>>>> thread runs at a higher priority. But, I didn't really see much of a
>>>> difference between the timing of the events in the evemu-record logs.
>>> Despite libinput having issues has reported by Peter, I wonder if the
>>> priority of the IRQ thread isn't the one interfering with the data here.
>>> In the workqueue version, the processing of the events didn't interfere
>>> with the retrieval of the I2C values. But with the IRQ thread, we might
>>> be delaying the retrieval of the values, and we might not be reading the
>>> correct value at the right time (oversimplifying it, but I think you get
>>> the gist of it). The 2 IRQ threads from I2C to read the data and the
>>> other one from RMI4 might simply be interfering.
>>>
>>> I am sure you have something equivalent in your tree, but could you
>>> confirm that the following patch removes the jumps?
>>
>> Yes, this patch does remove the jumps. My version just restored the old
>> functionality which was to call rmi_process_interrupts from a workqueue
>> inside hid-rmi. Your patch seems more complete.
>>
>> I did look to see if I could find something in the threaded IRQ code which
>> would confirm that there was some interference going on. But, I didn't find
>> anything. I also see jumps with USB devices and since USB devices do not use
>> threaded IRQs that did not seem to be the source. Looking at the call stack
>> in which rmi_input_event() gets called they seem quite different between USB
>> and I2C.
>>
>> I also tried calling generic_handle_irq() from a workqueue and that also
>> seemed to remove the jumps. That led me to look into if there were any side
>> affects from calling local_irq_save / restore or generic_handle_irq() from
>> inside the IRQ thread or IRQ handler. But, I could not find anything which
>> would indicate that doing this was unsafe.
>>
>> This is what I tried:
>> https://github.com/aduggan/linux/commit/d484e423e7375f1a6564f735f44a1246f6c0ee84
> 
> Thanks. Your patch looks smaller than mine :)
> 
> Jiri, Dmitry, which patch would you prefer having upstream?
> 
> Andrew's patch is smaller but requires a workqueue in hid-rmi, which
> then reinject the IRQ in RMI4. Mine has the workqueue in RMI4 and
> ditches the IRQ in hid-rmi all together (so no need to call
> local_irq_save() anymore).
> 
>>
>>> ---
>>>
>>>  From b60c0b4f145e171e55ffd861a852a49f5104d59f Mon Sep 17 00:00:00 2001
>>> From: Benjamin Tissoires<benjamin.tissoires@redhat.com>
>>> Date: Wed, 29 Mar 2017 10:41:34 +0200
>>> Subject: [PATCH] Input: rmi4 - remove the need for artificial IRQ in case of
>>>   HID
>>>
>>> The IRQ from rmi4 may interfere with the one we currently use on i2c-hid.
>>> Given that there is already a need for an external API from rmi4 to
>>> forward the attention data, we can, in this particular case rely on a
>>> separate workqueue to prevent cursor jumps.
>>>
>>> Signed-off-by: Benjamin Tissoires<benjamin.tissoires@redhat.com>
>>
>> Tested-by: Andrew Duggan <aduggan@synaptics.com>
> 
> Great :)

Hi,

Just checking – have any of these fixes been merged so far? I'm trying
out 4.14.0 right now, and while the jumps aren't as severe as before,
they still happen frequently enough that I'll be returning to 4.9-LTS
once again...

(Or is this something that libinput is supposed to deal with?)

-- 
Mantas Mikulėnas
