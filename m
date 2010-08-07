From: Alan Ott <alan@signal11.us>
Subject: Fwd: Re: Hidraw changes from 10.04 to 10.10
Date: Sat, 07 Aug 2010 16:58:21 -0400
Message-ID: <4C5DC8ED.4010804@signal11.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:52253 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752792Ab0HGU6X (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 7 Aug 2010 16:58:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 78AAD10428C
	for <linux-input@vger.kernel.org>; Sat,  7 Aug 2010 16:58:22 -0400 (EDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Bill Good <bgood@velocity.net>, Jiri Kosina <jkosina@suse.cz>, Antonio Ospite <ospite@studenti.unina.it>

Hello,

Bill Good contacted me with an issue about hidraw. I'm forwarding it to 
this list.

Alan.

On 08/07/2010 04:18 PM, Bill Good wrote:
> On 08/07/2010 03:56 PM, Alan Ott wrote:
>> On 08/07/2010 03:54 PM, Alan Ott wrote:
>>> On 08/07/2010 03:27 PM, Bill Good wrote:
>>>> On 08/06/2010 11:19 PM, Alan Ott wrote:
>>>>> On 08/06/2010 09:24 PM, Bill Good wrote:
>>>>>> I do not mean to offend but you are the author of a change in hidraw
>>>>>> that might be a problem that I am seeing.
>>>>>>
>>>>>> I write plugins for X-Plane for Saitek panels. I was doing some 
>>>>>> testing
>>>>>> on Maverick Meerkat have found a problem and not sure where to 
>>>>>> file the bug.
>>>>>>
>>>>>> On the Saitek radio panel it has 4 five digit displays. I have 
>>>>>> included
>>>>>> my test program and what I am seeing on the displays on 10.04 and 
>>>>>> 10.10.
>>>>>>
>>>>>> What has appeared to change is the first char of the array is not
>>>>>> displayed in 10.04. It has to be the correct number or I will get a
>>>>>> broken pipe error.
>>>>>>
>>>>>> Now on 10.10 it is displayed and works the same as it has to be a 
>>>>>> 1 for
>>>>>> my radio panel, any other number will give broken pipe error.
>>>>>>
>>>>>> Not sure what changed but am looking for a solution.
>>>>>>
>>>>>> int main (void) {
>>>>>>    unsigned char buf[3];
>>>>>>    int nr;
>>>>>>    int nw;
>>>>>>    int pos;
>>>>>>    int fd = -1;
>>>>>>    struct hidraw_devinfo dinfo;
>>>>>>    if ((fd = open("/dev/saitekradiopanel5", O_RDWR))<   0) {
>>>>>>      perror("hidraw open");
>>>>>>      exit(1);
>>>>>>    }
>>>>>>    char wbuf[21] = {1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 1, 2, 3, 
>>>>>> 4, 5, 6, 7, 8, 9};
>>>>>>    nw=write(fd, wbuf, sizeof(wbuf));
>>>>>>    if ( nw<   0 )
>>>>>>      { perror("write(stdout)"); exit(1); }
>>>>>>      if ( nw != 21 ) {
>>>>>>        fprintf(stderr, "Unsupported report length %d."
>>>>>>               " Wrong hidraw device or kernel<2.6.26 ?\n", nw);
>>>>>>        exit(1);
>>>>>>      }
>>>>>>    close(fd);
>>>>>>    exit(0);
>>>>>> }
>>>>>>
>>>>>>
>>>>>>
>>>>>> ******************************************************************
>>>>>> ******************   Display Info 10.04    ***********************
>>>>>>
>>>>>> 01234 56789
>>>>>> 01234 56789
>>>>>>
>>>>>> ******************************************************************
>>>>>>
>>>>>> ******************************************************************
>>>>>> ******************   Display Info 10.10    ***********************
>>>>>>
>>>>>> 10123 45678
>>>>>> 90123 45678
>>>>>>
>>>>>> ******************************************************************
>>>>>
>>>>> Hi Bill,
>>>>>
>>>>> What kernel versions are you using (10.04 and 10.10) (uname -a)?
>>>>>
>>>>> I assume you are talking about this patch:
>>>>>     http://lkml.org/lkml/2010/6/30/198
>>>>>
>>>>> I assume your device uses the control endpoint for output 
>>>>> transfers (ie: it does not have an Interrupt OUT endpoint).
>>>>>
>>>>> It looks like your device is using the entire output transfer and 
>>>>> not skipping the report ID as it should. My understanding is that 
>>>>> previous versions of the kernel had a bug in this respect, which 
>>>>> is why I made the patch linked above. From the data you have 
>>>>> provided, it appears that your device relied on this bug.
>>>>>
>>>>> The method used in the new kernels (and apparently Ubuntu 10.10), 
>>>>> is consistent with the way Windows and Mac OS send data to HID 
>>>>> devices.
>>>>>
>>>>> The fact that this is a commercial product though, makes me wonder 
>>>>> about my understanding of the USB spec, and about the validity of 
>>>>> this patch. (Jiri, any insight here?)
>>>>>
>>>>> Can you send me the device descriptor for the device you are 
>>>>> controlling?
>>>>>
>>>>> Can I forward your email to the linux-input and linux-kernel 
>>>>> mailing lists?
>>>>>
>>>>> Please let me know if one or more of my assumptions is incorrect.
>>>>>
>>>>> Alan.
>>>>>
>>>>>
>>>>>
>>>> Here is the info you requested and you can forward this email 
>>>> anywhere it will help in resolving this.
>>>>

[snip descriptor. updated one is below]

>>>>
>>>> bill@bill-1004-32:~$ uname -a
>>>> Linux bill-1004-32 2.6.32-24-generic-pae #39-Ubuntu SMP Wed Jul 28 
>>>> 07:39:26 UTC 201bill@billsim-
>>>>
>>>> ******************************************************************************************************* 
>>>>
>>>>
>>>> bill@billsim-1010-32:~/HIDTesting/HidRaw$ uname -a
>>>> Linux billsim-1010-32 2.6.35-14-generic-pae #19-Ubuntu SMP Mon Aug 
>>>> 2 03:24:07 UTC 2010 i686 GNU/Linux
>>>
> bill@billsim-1010-32:~$ sudo lsusb -v -d 06a3:0d05
>
> Bus 001 Device 029: ID 06a3:0d05 Saitek PLC
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x06a3 Saitek PLC
>   idProduct          0x0d05
>   bcdDevice            1.80
>   iManufacturer           1 Saitek
>   iProduct                2 Pro Flight Radio Panel
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           34
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0x80
>       (Bus Powered)
>     MaxPower              220mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           1
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      0 No Subclass
>       bInterfaceProtocol      0 None
>       iInterface              0
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.00
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      63
>           Report Descriptor: (length is 63)
>             Item(Global): Usage Page, data= [ 0x01 ] 1
>                             Generic Desktop Controls
>             Item(Local ): Usage, data= [ 0x00 ] 0
>                             Undefined
>             Item(Main  ): Collection, data= [ 0x01 ] 1
>                             Application
>             Item(Global): Usage Page, data= [ 0x09 ] 9
>                             Buttons
>             Item(Local ): Usage Minimum, data= [ 0x01 ] 1
>                             Button 1 (Primary)
>             Item(Local ): Usage Maximum, data= [ 0x18 ] 24
>                             (null)
>             Item(Global): Logical Minimum, data= [ 0x00 ] 0
>             Item(Global): Logical Maximum, data= [ 0x01 ] 1
>             Item(Global): Report Size, data= [ 0x01 ] 1
>             Item(Global): Report Count, data= [ 0x18 ] 24
>             Item(Main  ): Input, data= [ 0x02 ] 2
>                             Data Variable Absolute No_Wrap Linear
>                             Preferred_State No_Null_Position 
> Non_Volatile Bitfield
>             Item(Global): Usage Page, data= [ 0x01 0x00 ] 1
>                             Generic Desktop Controls
>             Item(Local ): Usage Minimum, data= [ 0x01 ] 1
>                             Pointer
>             Item(Local ): Usage Maximum, data= [ 0x14 ] 20
>                             (null)
>             Item(Global): Logical Minimum, data= [ 0x00 ] 0
>             Item(Global): Logical Maximum, data= [ 0xff 0x00 ] 255
>             Item(Global): Report Size, data= [ 0x08 ] 8
>             Item(Global): Report Count, data= [ 0x14 ] 20
>             Item(Main  ): Feature, data= [ 0x02 ] 2
>                             Data Variable Absolute No_Wrap Linear
>                             Preferred_State No_Null_Position 
> Non_Volatile Bitfield
>             Item(Global): Usage Page, data= [ 0x09 ] 9
>                             Buttons
>             Item(Local ): Usage Minimum, data= [ 0x01 ] 1
>                             Button 1 (Primary)
>             Item(Local ): Usage Maximum, data= [ 0x0e ] 14
>                             (null)
>             Item(Global): Logical Minimum, data= [ 0x00 ] 0
>             Item(Global): Logical Maximum, data= [ 0x01 ] 1
>             Item(Global): Report Size, data= [ 0x01 ] 1
>             Item(Global): Report Count, data= [ 0x0e ] 14
>             Item(Main  ): Feature, data= [ 0x02 ] 2
>                             Data Variable Absolute No_Wrap Linear
>                             Preferred_State No_Null_Position 
> Non_Volatile Bitfield
>             Item(Global): Report Size, data= [ 0x02 ] 2
>             Item(Global): Report Count, data= [ 0x01 ] 1
>             Item(Main  ): Feature, data= [ 0x01 ] 1
>                             Constant Array Absolute No_Wrap Linear
>                             Preferred_State No_Null_Position 
> Non_Volatile Bitfield
>             Item(Main  ): End Collection, data=none
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0008  1x 8 bytes
>         bInterval              10
> Device Status:     0x0000
>   (Bus Powered)
>
> Bill
>


