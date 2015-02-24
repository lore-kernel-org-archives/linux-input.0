From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: NULL pointer dereference in i2c-hid
Date: Mon, 23 Feb 2015 16:30:04 -0800
Message-ID: <54EBC60C.4060102@synaptics.com>
References: <31518562.V5Oyo0POsI@xps13> <1940829.tOcs3CnnyV@xps13> <54B07250.5030803@synaptics.com> <1969849.Ad3QL9IzvX@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:26948 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751925AbbBXAdC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Feb 2015 19:33:02 -0500
In-Reply-To: <1969849.Ad3QL9IzvX@xps13>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@redhat.com, jkosina@suse.cz

On 02/22/2015 01:37 PM, Gabriele Mazzotta wrote:
> On Friday 09 January 2015 16:29:04 Andrew Duggan wrote:
>> On 01/09/2015 12:04 AM, Gabriele Mazzotta wrote:
>>> On Thursday 08 January 2015 15:58:54 Andrew Duggan wrote:
>>>> On 12/24/2014 03:53 PM, Gabriele Mazzotta wrote:
>>>> [...snip...]
>>>>>>>> Also, if you can get the firmware id from your touchpad that would also
>>>>>>>> be useful.
>>>>>>>>
>>>>>>>> $ sudo ./rmihidtool -f /dev/hidraw0
>>>>>>> firmware id: 1522295
>>>>>> Thanks, I will see if I can get any additional information on this.
>>>>>>
>>>>>> Andrew
>>>>> Hi,
>>>>>
>>>>> I think I found the source of the problem.
>>>>>
>>>>> $ ./rmihidtool /dev/hidraw1 -r 0x50 1
>>>>> 0x01  #PalmDetect Interrupt Enable, right?
>>>> Yes, 0x50 does appear to be the address of the palm detect interrupt
>>>> enable register.
>>>>> $ ./rmihidtool /dev/hidraw1 -w 0x50 0  #Disable PalmDetect Interrupt
>>>>>
>>>>> It makes more sense now that widths greater than 12 trigger the bug.
>>>> That is weird behavior and I haven't seen anything like that before. I
>>>> will file a bug to see if firmware has any idea why this is happening.
>>> According to the RMI4 specification, gesture interrupts are cleared
>>> only once specific flag registers, F11_2D_Data8 and F11_2D_Data9, are
>>> read. So I tried to read those register and found that the following
>>> command stops the events:
>> It is unusual to see firmware gestures enabled for HID/I2C touchpads. In
>> fact none of the touchpads I have have that functionality enabled, which
>> is why I haven't been able to test. On HID touchpads there is a layer in
>> the firmware which reads the RMI registers and packs them into the HID
>> attention report. My guess is that the HID layer is not reading
>> F11_2D_Data8 or 9 causing it to assert indefinitely. Since this isn't a
>> common firmware configuration that is probably why this hasn't been
>> observed before.
>>
>>> $ rmihidtool /dev/hidraw1 -r 0x24 1  # I was looking for F11_2D_Data8
>>>
>>> I'm not sure I got the right address as reading any register close to
>>> 0x24 (such as 0x25, 0x26) has the same effect. I would have expected
>>> this to happen only reading one specific register.
>> With this firmware, F11_2D_Data8 should be at 0x3A. It's 2 bytes for
>> finger state + 5 bytes per finger * 5 fingers for abs data  + 2 bytes
>> per finger * 5 fingers for rel data. I'm not sure why reading 0x24 would
>> stop the reports though.
>>
>>> I also honestly don't know why palms are detected when the width is at
>>> least 12, PalmDetectThreshold is 0 and so the palm detection should
>>> be inhibited.
>>>
>> This seems to be set in the firmware config. It looks like
>> PalmDetectThreshold is only used when the reporting mode is 001. The
>> default reporting mode looks like it is 000.
> Hi Andrew,
>
> is there any plan on implementing a function to write registers? This
> would allow me to easily disable the PalmDetect Interrupt when the driver
> is loaded without relying on external tools. Reading F11_2D_Data8
> continuously seems unnecessary.

Writes are not that complicated. We just haven't had a need to do them 
in the driver yet which is why there isn't a write function implemented 
already. After thinking about this again I think you are right and 
disabling the palm detect interrupt in the driver makes sense. Its easy 
enough to see if the firmware has palm detect enabled and simply disable it.

>
> Not totally related. Is there any use for the dribble interrupts? I'm
> wondering if they could be disabled by default. I'm my case these
> interrupts go on for about a second, making the I2C host controller
> generate a lot of interrupts. A quick tap for example make INT33C3
> generate more than 5000 interrupts when dribbling is enabled and less
> than 200 interrupts when disabled. The difference is not really
> insignificant, so if they have no real use, I'd disable them by default
> in order to save some power.

Good point, I believe on Linux the input subsystem is filtering out all 
of the duplicate reports and they aren't going to userspace. Which does 
make them pointless on Linux.

Both of these changes are pretty straightforward, especially once a 
write function is implemented, so I think I can have some patches ready 
at some point this week.

Andrew
> Regards,
> Gabriele

