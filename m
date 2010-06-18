From: Alan Ott <alan@signal11.us>
Subject: Re: [PATCH] HID: Documentation for hidraw
Date: Fri, 18 Jun 2010 10:45:22 -0400
Message-ID: <4C1B8682.7050901@signal11.us>
References: <1276832283-12084-1-git-send-email-alan@signal11.us> <alpine.LNX.2.00.1006181353120.13809@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1006181353120.13809@pobox.suse.cz>
Sender: linux-doc-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>
List-Id: linux-input@vger.kernel.org

On 06/18/2010 07:59 AM, Jiri Kosina wrote:
>> Documenation for the hidraw driver.
>>      
> Thanks a lot for writing this up, Alan. It's something that has been
> lingering on my TODO for just too long, it's great that someone finally
> got fed up with it and wrote it :)
>
>    
I wouldn't say I was fed up :)
>>   I'm sure someone here will have a better idea where
>>   to put this than the root of Documentation/. I didn't see a better place, as
>>   hidraw is used for both Bluetooth and USB.
>>      
> Either Documentation/input comes to mind, or we could even establish
> Documentation/hid directory as well.
>
>    
Antonio suggested the same, putting hidraw.txt and hiddev.txt into a new 
Documentation/hid/ directory. I'll do this for the next rev unless I 
hear otherwise.

>>   Documentation/hidraw.txt |  283 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 283 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/hidraw.txt
>>
>> diff --git a/Documentation/hidraw.txt b/Documentation/hidraw.txt
>> new file mode 100644
>> index 0000000..7153a06
>> --- /dev/null
>> +++ b/Documentation/hidraw.txt
>> @@ -0,0 +1,283 @@
>> +      HIDRAW - Raw Access to USB and Bluetooth Human Interface Devices
>> +     ==================================================================
>> +
>> +The hidraw driver provides a raw interface to USB and Bluetooth Human
>> +Interface Devices (HIDs).  It differs from hiddev in that reports sent and
>> +received are not parsed by the HID parser, but are sent to and received from
>> +the device unmodified.
>>      
> The important point behind hidraw (compared to hiddev), always has been
> that it's in fact completely independent on underlying hardware transport
> protocol. Currently there are no other implementations of HID than the
> ones using Bluetooth or USB, but there is no general obstacle to using
> hidraw once any vendor comes with HID-over-FibreChannel :) for example.
>
> This basic principle might be worth mentioning as well.
>
>    
I'll make sure to put that in.

>> +Hidraw should be used if the userspace application knows exactly how to
>> +communicate with the hardware device, and is able to construct the HID
>> +reports manually.  This is often the case when making userspace drivers for
>> +custom HID devices.
>> +
>> +Hidraw is also useful for communicating with non-conformant HID devices
>> +which send and receive data in a way that is inconsistent with their report
>> +descriptors.  Because hiddev parses reports which are sent and received
>> +through it and checks them against the device's report descriptor, such
>> +communication with these non-conformant devices is impossible using hiddev.
>>      
> hidraw is just one of the alternatives here of course. Writing in-kernel
> driver also can be done to overcome these obstacles.
>
>    
Also true. I'll add it.

Thanks,

Alan.


