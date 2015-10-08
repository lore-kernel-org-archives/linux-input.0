From: Andrew Duggan <aduggan@synaptics.com>
Subject: Re: [PATCH v2] HID: multitouch: Fetch feature reports on demand for
 Win8 devices
Date: Wed, 7 Oct 2015 18:12:42 -0700
Message-ID: <5615C30A.5060503@synaptics.com>
References: <alpine.LNX.2.00.1510061606440.2758@pobox.suse.cz>
 <1444221223-33481-1-git-send-email-mika.westerberg@linux.intel.com>
 <20151007133409.GA25728@mail.corp.redhat.com>
 <20151007155620.GB118995@ubuntu-hedt>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:5852 "EHLO
	us-mx1.synaptics.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751304AbbJHBMo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Oct 2015 21:12:44 -0400
In-Reply-To: <20151007155620.GB118995@ubuntu-hedt>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Seth Forshee <seth.forshee@canonical.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org



On 10/07/2015 08:56 AM, Seth Forshee wrote:
> On Wed, Oct 07, 2015 at 09:34:10AM -0400, Benjamin Tissoires wrote:
>> [sorry for the late answer Jiri, I was on vacations last week]
>>
>> On Oct 07 2015 or thereabouts, Mika Westerberg wrote:
>>> Some newer Intel Skylake based Dell laptops with Win8 precision touchpad
>>> fail when initial feature reports are fetched from it. Below is an example
>>> output with some additional debug included:
>>>
>>>   i2c_hid i2c-DLL0704:01: Fetching the HID descriptor
>>>   i2c_hid i2c-DLL0704:01: __i2c_hid_command: cmd=20 00
>>>   i2c_hid i2c-DLL0704:01: HID Descriptor: 1e 00 00 01 99 02 21 00 24 ...
>>>   ...
>>>   i2c_hid i2c-DLL0704:01: i2c_hid_get_report
>>>   i2c_hid i2c-DLL0704:01: __i2c_hid_command: cmd=22 00 38 02 23 00
>>>   i2c_hid i2c-DLL0704:01: report (len=4): 04 00 08 05
>>>   i2c_hid i2c-DLL0704:01: report id 13
>>>   i2c_hid i2c-DLL0704:01: i2c_hid_get_report
>>>   i2c_hid i2c-DLL0704:01: __i2c_hid_command: cmd=22 00 3d 02 23 00
>>>   i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>>>   i2c_hid i2c-DLL0704:01: report id 7
>>>   i2c_hid i2c-DLL0704:01: i2c_hid_get_report
>>>   i2c_hid i2c-DLL0704:01: __i2c_hid_command: cmd=22 00 37 02 23 00
>>>   i2c_hid i2c-DLL0704:01: report (len=259): 03 01 07 fc 28 fe 84 40 ...
>>>   i2c_hid i2c-DLL0704:01: report id 4
>>>   i2c_hid i2c-DLL0704:01: i2c_hid_get_report
>>>   i2c_hid i2c-DLL0704:01: __i2c_hid_command: cmd=22 00 34 02 23 00
>>>
>>> We manage to fetch few reports but then the touchpad dies:
>>>
>>>   i2c_designware i2c_designware.1: i2c_dw_handle_tx_abort: lost arbitration
>>>   i2c_hid i2c-DLL0704:01: failed to retrieve report from device.
>>>
>>> it eventually pulls the whole I2C bus low:
>>>
>>>   i2c_designware i2c_designware.1: controller timed out
>>>   i2c_hid i2c-DLL0704:01: failed to set a report to device.
>>>
>>> Fix this by preventing initial feature report retrieval for Win8 devices.
>>> Instead we fetch reports as needed in mt_feature_mapping(). This prevents
>>> fetching reports which might cause problems with the device in question.
>>>
>>> Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
>>> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>> ---
>>> Added check for MT_CLS_WIN_8 so that the fix is only done for real Win8
>>> devices.
>> I think we are good now. I would just like to have Seth or Andrew giving
>> a tested-by for Windows precision touchpads that can be found on the Dell
>> laptops.
>>
>> If the buttonpad property is set correctly, this is:
>> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> This is working fine on my XPS 13 9343.
>
> Tested-by: Seth Forshee <seth.forshee@canonical.com>
I can confirm that it is working on the Dell XPS 13 and the buttonpad 
property is set correctly. However, I also tried it on an older non 
production precision touchpad and it didn't work. It reports that it 
fails to fetch feature 8 and then doesn't report any input. I'm 
concerned that some of the early PTPs in some Dell and Acer systems 
might not work with this change. I'll test this tomorrow on a few more 
systems to see if the problem is isolated to just this one non 
production touchpad.

[ 2969.222125] usb 1-1: New USB device found, idVendor=06cb, idProduct=2393
[ 2969.222128] usb 1-1: New USB device strings: Mfr=0, Product=2, 
SerialNumber=0
[ 2969.222130] usb 1-1: Product: Synaptics T Pad V 01.31
[ 2974.223578] hid-multitouch 0003:06CB:2393.0008: failed to fetch feature 8
[ 2979.226037] hid-multitouch 0003:06CB:2393.0008: failed to fetch feature 8
[ 2979.226137] input: Synaptics T Pad V 01.31 UNKNOWN as 
/devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.0/0003:06CB:2393.0008/input/input34
[ 2979.226431] hid-multitouch 0003:06CB:2393.0008: 
input,hiddev0,hidraw2: USB HID v1.11 Mouse [Synaptics T Pad V 01.31] on 
usb-0000:00:14.0-1/input0

Feature 8 looks like this:
   FEATURE(8)[FEATURE]
     Field(0)
       Application(Digitizers.TouchPad)
       Usage(2)
         Digitizers.ContactMaximumNumber
         Digitizers.ButtonType
       Logical Minimum(0)
       Logical Maximum(15)
       Physical Minimum(0)
       Physical Maximum(65535)
       Unit Exponent(-4)
       Unit(SI Linear : Seconds)
       Report Size(4)
       Report Count(2)
       Report Offset(0)
       Flags( Variable Absolute )

Andrew
