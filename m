From: Bill Good <bgood@velocity.net>
Subject: Re: Fwd: Re: Hidraw changes from 10.04 to 10.10
Date: Sat, 07 Aug 2010 20:26:49 -0400
Message-ID: <4C5DF9C9.8070701@velocity.net>
References: <4C5DC8ED.4010804@signal11.us> <4C5DE7B5.9090305@signal11.us>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000107070807080604010509"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail01.velocity.net ([66.211.211.55]:45611 "EHLO
	mail01.velocity.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595Ab0HHAgz (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Aug 2010 20:36:55 -0400
In-Reply-To: <4C5DE7B5.9090305@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Antonio Ospite <ospite@studenti.unina.it>

This is a multi-part message in MIME format.
--------------000107070807080604010509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



On 08/07/2010 07:09 PM, Alan Ott wrote:
> On 08/07/2010 04:58 PM, Alan Ott wrote:
>> Hello,
>>
>> Bill Good contacted me with an issue about hidraw. I'm forwarding it 
>> to this list.
>>
>> Alan.
>>
>> On 08/07/2010 04:18 PM, Bill Good wrote:
>>> On 08/07/2010 03:56 PM, Alan Ott wrote:
>>>> On 08/07/2010 03:54 PM, Alan Ott wrote:
>>>>> On 08/07/2010 03:27 PM, Bill Good wrote:
>>>>>> On 08/06/2010 11:19 PM, Alan Ott wrote:
>>>>>>> On 08/06/2010 09:24 PM, Bill Good wrote:
>>>>>>>> I do not mean to offend but you are the author of a change in 
>>>>>>>> hidraw
>>>>>>>> that might be a problem that I am seeing.
>>>>>>>>
>>>>>>>> I write plugins for X-Plane for Saitek panels. I was doing some 
>>>>>>>> testing
>>>>>>>> on Maverick Meerkat have found a problem and not sure where to 
>>>>>>>> file the bug.
>>>>>>>>
>>>>>>>> On the Saitek radio panel it has 4 five digit displays. I have 
>>>>>>>> included
>>>>>>>> my test program and what I am seeing on the displays on 10.04 
>>>>>>>> and 10.10.
>>>>>>>>
>>>>>>>> What has appeared to change is the first char of the array is not
>>>>>>>> displayed in 10.04. It has to be the correct number or I will 
>>>>>>>> get a
>>>>>>>> broken pipe error.
>>>>>>>>
>>>>>>>> Now on 10.10 it is displayed and works the same as it has to be 
>>>>>>>> a 1 for
>>>>>>>> my radio panel, any other number will give broken pipe error.
>>>>>>>>
>>>>>>>> Not sure what changed but am looking for a solution.
>>>>>>>>
>>>>>>>> int main (void) {
>>>>>>>>    unsigned char buf[3];
>>>>>>>>    int nr;
>>>>>>>>    int nw;
>>>>>>>>    int pos;
>>>>>>>>    int fd = -1;
>>>>>>>>    struct hidraw_devinfo dinfo;
>>>>>>>>    if ((fd = open("/dev/saitekradiopanel5", O_RDWR))<   0) {
>>>>>>>>      perror("hidraw open");
>>>>>>>>      exit(1);
>>>>>>>>    }
>>>>>>>>    char wbuf[21] = {1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 
>>>>>>>> 3, 4, 5, 6, 7, 8, 9};
>>>>>>>>    nw=write(fd, wbuf, sizeof(wbuf));
>>>>>>>>    if ( nw<   0 )
>>>>>>>>      { perror("write(stdout)"); exit(1); }
>>>>>>>>      if ( nw != 21 ) {
>>>>>>>>        fprintf(stderr, "Unsupported report length %d."
>>>>>>>>               " Wrong hidraw device or kernel<2.6.26 ?\n", nw);
>>>>>>>>        exit(1);
>>>>>>>>      }
>>>>>>>>    close(fd);
>>>>>>>>    exit(0);
>>>>>>>> }
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> ******************************************************************
>>>>>>>> ******************   Display Info 10.04    ***********************
>>>>>>>>
>>>>>>>> 01234 56789
>>>>>>>> 01234 56789
>>>>>>>>
>>>>>>>> ******************************************************************
>>>>>>>>
>>>>>>>> ******************************************************************
>>>>>>>> ******************   Display Info 10.10    ***********************
>>>>>>>>
>>>>>>>> 10123 45678
>>>>>>>> 90123 45678
>>>>>>>>
>>>>>>>> ******************************************************************
>>>>>>>
>>>>>>> Hi Bill,
>>>>>>>
>>>>>>> What kernel versions are you using (10.04 and 10.10) (uname -a)?
>>>>>>>
>>>>>>> I assume you are talking about this patch:
>>>>>>>     http://lkml.org/lkml/2010/6/30/198
>>>>>>>
>>>>>>> I assume your device uses the control endpoint for output 
>>>>>>> transfers (ie: it does not have an Interrupt OUT endpoint).
>>>>>>>
>>>>>>> It looks like your device is using the entire output transfer 
>>>>>>> and not skipping the report ID as it should. My understanding is 
>>>>>>> that previous versions of the kernel had a bug in this respect, 
>>>>>>> which is why I made the patch linked above. From the data you 
>>>>>>> have provided, it appears that your device relied on this bug.
>>>>>>>
>>>>>>> The method used in the new kernels (and apparently Ubuntu 
>>>>>>> 10.10), is consistent with the way Windows and Mac OS send data 
>>>>>>> to HID devices.
>>>>>>>
>>>>>>> The fact that this is a commercial product though, makes me 
>>>>>>> wonder about my understanding of the USB spec, and about the 
>>>>>>> validity of this patch. (Jiri, any insight here?)
>>>>>>>
>>>>>>> Can you send me the device descriptor for the device you are 
>>>>>>> controlling?
>>>>>>>
>>>>>>> Can I forward your email to the linux-input and linux-kernel 
>>>>>>> mailing lists?
>>>>>>>
>>>>>>> Please let me know if one or more of my assumptions is incorrect.
>>>>>>>
>>>>>>> Alan.
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>> Here is the info you requested and you can forward this email 
>>>>>> anywhere it will help in resolving this.
>>>>>>
>>
>> [snip descriptor. updated one is below]
>>
>>>>>>
>>>>>> bill@bill-1004-32:~$ uname -a
>>>>>> Linux bill-1004-32 2.6.32-24-generic-pae #39-Ubuntu SMP Wed Jul 
>>>>>> 28 07:39:26 UTC 201bill@billsim-
>>>>>>
>>>>>> ******************************************************************************************************* 
>>>>>>
>>>>>>
>>>>>> bill@billsim-1010-32:~/HIDTesting/HidRaw$ uname -a
>>>>>> Linux billsim-1010-32 2.6.35-14-generic-pae #19-Ubuntu SMP Mon 
>>>>>> Aug 2 03:24:07 UTC 2010 i686 GNU/Linux
>>>>>
>>> bill@billsim-1010-32:~$ sudo lsusb -v -d 06a3:0d05
>>>
>>> Bus 001 Device 029: ID 06a3:0d05 Saitek PLC
>>> Device Descriptor:
>>>   bLength                18
>>>   bDescriptorType         1
>>>   bcdUSB               1.00
>>>   bDeviceClass            0 (Defined at Interface level)
>>>   bDeviceSubClass         0
>>>   bDeviceProtocol         0
>>>   bMaxPacketSize0         8
>>>   idVendor           0x06a3 Saitek PLC
>>>   idProduct          0x0d05
>>>   bcdDevice            1.80
>>>   iManufacturer           1 Saitek
>>>   iProduct                2 Pro Flight Radio Panel
>>>   iSerial                 0
>>>   bNumConfigurations      1
>>>   Configuration Descriptor:
>>>     bLength                 9
>>>     bDescriptorType         2
>>>     wTotalLength           34
>>>     bNumInterfaces          1
>>>     bConfigurationValue     1
>>>     iConfiguration          0
>>>     bmAttributes         0x80
>>>       (Bus Powered)
>>>     MaxPower              220mA
>>>     Interface Descriptor:
>>>       bLength                 9
>>>       bDescriptorType         4
>>>       bInterfaceNumber        0
>>>       bAlternateSetting       0
>>>       bNumEndpoints           1
>>>       bInterfaceClass         3 Human Interface Device
>>>       bInterfaceSubClass      0 No Subclass
>>>       bInterfaceProtocol      0 None
>>>       iInterface              0
>>>         HID Device Descriptor:
>>>           bLength                 9
>>>           bDescriptorType        33
>>>           bcdHID               1.00
>>>           bCountryCode            0 Not supported
>>>           bNumDescriptors         1
>>>           bDescriptorType        34 Report
>>>           wDescriptorLength      63
>>>           Report Descriptor: (length is 63)
>>>             Item(Global): Usage Page, data= [ 0x01 ] 1
>>>                             Generic Desktop Controls
>>>             Item(Local ): Usage, data= [ 0x00 ] 0
>>>                             Undefined
>>>             Item(Main  ): Collection, data= [ 0x01 ] 1
>>>                             Application
>>>             Item(Global): Usage Page, data= [ 0x09 ] 9
>>>                             Buttons
>>>             Item(Local ): Usage Minimum, data= [ 0x01 ] 1
>>>                             Button 1 (Primary)
>>>             Item(Local ): Usage Maximum, data= [ 0x18 ] 24
>>>                             (null)
>>>             Item(Global): Logical Minimum, data= [ 0x00 ] 0
>>>             Item(Global): Logical Maximum, data= [ 0x01 ] 1
>>>             Item(Global): Report Size, data= [ 0x01 ] 1
>>>             Item(Global): Report Count, data= [ 0x18 ] 24
>>>             Item(Main  ): Input, data= [ 0x02 ] 2
>>>                             Data Variable Absolute No_Wrap Linear
>>>                             Preferred_State No_Null_Position 
>>> Non_Volatile Bitfield
>>>             Item(Global): Usage Page, data= [ 0x01 0x00 ] 1
>>>                             Generic Desktop Controls
>>>             Item(Local ): Usage Minimum, data= [ 0x01 ] 1
>>>                             Pointer
>>>             Item(Local ): Usage Maximum, data= [ 0x14 ] 20
>>>                             (null)
>>>             Item(Global): Logical Minimum, data= [ 0x00 ] 0
>>>             Item(Global): Logical Maximum, data= [ 0xff 0x00 ] 255
>>>             Item(Global): Report Size, data= [ 0x08 ] 8
>>>             Item(Global): Report Count, data= [ 0x14 ] 20
>>>             Item(Main  ): Feature, data= [ 0x02 ] 2
>>>                             Data Variable Absolute No_Wrap Linear
>>>                             Preferred_State No_Null_Position 
>>> Non_Volatile Bitfield
>>>             Item(Global): Usage Page, data= [ 0x09 ] 9
>>>                             Buttons
>>>             Item(Local ): Usage Minimum, data= [ 0x01 ] 1
>>>                             Button 1 (Primary)
>>>             Item(Local ): Usage Maximum, data= [ 0x0e ] 14
>>>                             (null)
>>>             Item(Global): Logical Minimum, data= [ 0x00 ] 0
>>>             Item(Global): Logical Maximum, data= [ 0x01 ] 1
>>>             Item(Global): Report Size, data= [ 0x01 ] 1
>>>             Item(Global): Report Count, data= [ 0x0e ] 14
>>>             Item(Main  ): Feature, data= [ 0x02 ] 2
>>>                             Data Variable Absolute No_Wrap Linear
>>>                             Preferred_State No_Null_Position 
>>> Non_Volatile Bitfield
>>>             Item(Global): Report Size, data= [ 0x02 ] 2
>>>             Item(Global): Report Count, data= [ 0x01 ] 1
>>>             Item(Main  ): Feature, data= [ 0x01 ] 1
>>>                             Constant Array Absolute No_Wrap Linear
>>>                             Preferred_State No_Null_Position 
>>> Non_Volatile Bitfield
>>>             Item(Main  ): End Collection, data=none
>>>       Endpoint Descriptor:
>>>         bLength                 7
>>>         bDescriptorType         5
>>>         bEndpointAddress     0x81  EP 1 IN
>>>         bmAttributes            3
>>>           Transfer Type            Interrupt
>>>           Synch Type               None
>>>           Usage Type               Data
>>>         wMaxPacketSize     0x0008  1x 8 bytes
>>>         bInterval              10
>>> Device Status:     0x0000
>>>   (Bus Powered)
>>>
>
> Bill,
>
> There's some odd stuff about this. The first is, the descriptor above 
> doesn't specify any output reports at all, only input and feature 
> reports. (write() on a hidraw device sends an output report.) Second, 
> there are no Report ID fields, meaning you shouldn't send any report 
> number at all (ie: you should be sending zero for the first byte). (I 
> know you already tried setting the first byte to 0 based on our other 
> emails, and that's where you got the broken pipe error). Third, I ran 
> this with my programmable USB device here that I use for testing in 
> several different configurations, most notably with numbered reports 
> and without, and tried setting the first byte of the output report to 
> 0 and 1 in both configurations. I tried this on a 2.6.35 development 
> kernel, on Ubuntu 10.04 (2.6.32), and on Ubuntu 10.10 alpha 1 
> (2.6.35-14). On Ubuntu 10.10 alpha (and my dev kernel), The report ID 
> is sent to the device as part of the payload if it is not zero. This 
> is as designed, and is different than in 10.04. I didn't get a broken 
> pipe error. (The only time I get a broken pipe is if I leave my USB 
> device stopped in the firmware debugger).
>
> Have you tried this in Windows? What happens there? The write() 
> function in hidraw now (on Ubuntu 10.04) works just the same as 
> WriteFile() on a HID device in Windows. In other words, it sends the 
> Report ID as part of the payload on transfers over the control endpoint.
>
> (If you don't have a Windows implementation, I'd suggest trying my 
> hidapi available at http://github.com/signal11/hidapi. Grab the latest 
> from git, as it has quite a bit more than the releases).
>
> Does anyone else see something I'm missing on this?
>
> Alan.
>
>
>
First of all thank you for looking into this. I am only doing 
development on Linux so will look at your hidapi.

Besides the radio panel my plugin is also for the multi panel and the 
switch panel. On the multi panel the first byte must be a 3 and on the 
switch it must be a 1 just like the radio panel. If this is not true I 
get the broken pipe error.

I will include the HID Report Descriptors for all three panels to see if 
any better clues show up. Something that I did see is the last Feature, 
data of each match the number that I need to use to not get the  broken 
pipe error. I wish I understood more about this but just looking for a 
pattern as to where the number needed is coming from.

Thanks Bill

--------------000107070807080604010509
Content-Type: application/x-gzip;
 name="HIDReportDescriptors.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="HIDReportDescriptors.tar.gz"

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
--------------000107070807080604010509--
