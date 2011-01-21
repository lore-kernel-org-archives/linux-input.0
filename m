From: Alan Ott <alan@signal11.us>
Subject: Re: [PATCH 0/1] HID: Report Descriptor in Sysfs
Date: Fri, 21 Jan 2011 09:52:27 -0500
Message-ID: <4D399DAB.3080808@signal11.us>
References: <1295590785-7101-1-git-send-email-alan@signal11.us> <alpine.LNX.2.00.1101211054210.5725@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1101211054210.5725@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 01/21/2011 04:59 AM, Jiri Kosina wrote:
> On Fri, 21 Jan 2011, Alan Ott wrote:
>
>    
>> So I'd like to have access to the HID report descriptor in a sysfs entry, so
>> I can read it without opening the device.  hid-core seemed like the place to
>> put it.
>>
>> Using the /sys/class links, for hidraw devices, this puts a new file,
>> report_descriptor in the directory:
>> 	/sys/class/hidraw/hidraw0/device/
>>
>> For my USB device (for example), the new file is in:
>> 	/sys/bus/usb/devices/1-5.3:1.0/0003:046D:C216.0001/
>>
>> For my Bluetooth device, the new file is in:
>> 	/sys/class/bluetooth/hci0/hci0:11/0005:054C:0268.0002/
>>
>> I'm not super confident that these file locations are the best place, but I
>> made a best guess so that it could be discussed.  The current location is
>> where the hid-core stuff lives.  Is there a reason these directories are
>> named bus:vendor:product:id (instead of hid-core or something similar)?  Is
>> there a better way to do this?
>>      
> the report descriptor is provided through debugfs HID interface already.
> Do you feel like that's not enough?
>    

Hi Jiri,

Maybe it is. To be honest I didn't check debugfs. I have two concerns 
about it:
1. Is it wise for userspace programs to rely on:
     a. debugfs being mounted,
     b. its mount point, or
     c. the location or contents of any file in debugfs?
2. /sys/kernel/debug/0003:046D:C216.0002/rdesc is mode 0400 on my system 
(root-only read). Is there a reason it's so restrictive, or could it be 
changed to 0444?

Alan.
