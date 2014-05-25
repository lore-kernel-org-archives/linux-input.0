From: Prajosh Premdas <premdas.prajosh@gmail.com>
Subject: Re: Additional driver for USB touch support
Date: Sun, 25 May 2014 23:14:13 +0200
Message-ID: <CAAFf3B-L-L2Ou9==5AK5P_Qx+10dUjVVJYrQH+mxgOMR+uaseA@mail.gmail.com>
References: <CAAFf3B-1-G9e8+2Ci1MWf2OJfXCWk38e50nOA3piTpAQLM-J7g@mail.gmail.com>
	<CAN+gG=HA1Y-aJbt+RHYfoWJfPeypduCaCE5NKNLJJBhtMa4C6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:60686 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbaEYVOO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 25 May 2014 17:14:14 -0400
Received: by mail-ve0-f173.google.com with SMTP id pa12so8509859veb.32
        for <linux-input@vger.kernel.org>; Sun, 25 May 2014 14:14:13 -0700 (PDT)
In-Reply-To: <CAN+gG=HA1Y-aJbt+RHYfoWJfPeypduCaCE5NKNLJJBhtMa4C6g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: daniel.ritz@gmx.ch, linux-input <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

Hi Benjamin

Thanks for the suggestion. I have a slight probem.

I am able to send the commands on the control endpoint 0. But i get
the response on the interrupt endpoint which is also used by the touch
interface. And response data starts with 06 which had been used to
differenciate the touch data with 01 i.e. Report ID (I know this is a
stupid design but cant change for this is a legacy system).

Since a report ID with 06 is not mentioned in the Report descriptor
this message is not forwarded to the driver even as raw data. I am
able to read the touch data which uses the correct Report ID but not
this data. If i change the report ID to 01 I get teh data but I cannot
do this in the final system as this breaks our tools in Windows. Is
there any solution to get this data up?



On Fri, May 23, 2014 at 2:51 PM, Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
> Hi Prajosh,
>
> On Fri, May 23, 2014 at 6:55 AM, Prajosh Premdas
> <premdas.prajosh@gmail.com> wrote:
>> Hi
>>
>> I have some USB based touch controllers. These controllers are working
>> well using the hid_multitouch driver.
>>
>> I would also like to add some additional protocol support for
>> diagnostics and re calibration. I am using the touch interface for the
>> same, whereby the control endpoint is used to send the request and
>> digitizer end point is used to get the response. (it is a legacy
>> design so i cannot change it)
>>
>> My plan is to add the additional driver support to this file
>> drivers/input/touchscreen/usbtouchscreen.c and disable the default
>> support for the hid_multitouch by making an entry in the hid-blacklist
>> array in this file drivers/hid/usbhid/hid-quirks.c
>
> 2 things:
> - adding the device to hid-blacklist either in hid-quirks or
> hid-core.c will not help, the device will still be bound to the HID
> subsystem, and the usb driver will not be able to catch it. If you
> were to go to this road, you would have to add the VID/PID to
> hid-ignore in hid-core.c
> - I don't think it is a good idea to move from hid-multitouch to
> usbtouchscreen: as far as I know, this driver only support single
> touch devices, and it will be a burden to implement the multitouch
> part
>
>>
>> Is there a better idea than this?
>
> If you need to talk to the device through the control endpoint and get
> the responses through the interrupt endpoint, hidraw seems to be
> perfect for your case:
> you can either use the ioctl HIDIOCSFEATURE or directly write on the
> hidraw node to send reports, and reading back to the node will give
> you the interrupts. Bonus point, you are enterily in userspace, so no
> risk of crashing your kernel. Then, you just set up an udev rule if
> you need the commands to be launched at plug.
>
> You can find an example in samples/hidraw/hid-example.c in the kernel tree.
>
> Cheers,
> Benjamin



-- 
Regards,

Prajosh Premdas
