From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 0/6] HID: Add a stable method for retrieving the client
 MAC address of a HID device
Date: Fri, 31 Jan 2014 15:45:42 -0500
Message-ID: <CAN+gG=GxXUU2rNNg7T1o50RPzXopnnqWbhQ4+-uWN3mbLUUyDw@mail.gmail.com>
References: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
	<CAN+gG=EVcVmQ8rr2YtoapfftSHaDeYnSu5rCnuZjL=S-v1xU4Q@mail.gmail.com>
	<52EC01DF.6050309@oh.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:35313 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932224AbaAaUpn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 15:45:43 -0500
Received: by mail-la0-f49.google.com with SMTP id y1so3862467lam.36
        for <linux-input@vger.kernel.org>; Fri, 31 Jan 2014 12:45:42 -0800 (PST)
In-Reply-To: <52EC01DF.6050309@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank Praznik <frank.praznik@oh.rr.com>
Cc: linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, David Herrmann <dh.herrmann@gmail.com>

On Fri, Jan 31, 2014 at 3:04 PM, Frank Praznik <frank.praznik@oh.rr.com> wrote:
> On 1/31/2014 14:10, Benjamin Tissoires wrote:
>>
>> Hi Frank,
>>
>> just a quick review:
>>
>> On Fri, Jan 31, 2014 at 12:32 PM, Frank Praznik <frank.praznik@oh.rr.com>
>> wrote:
>>>
>>> Currently there is no reliable way for a device module or hidraw
>>> application to
>>> retrieve the client MAC address of the associated wireless device.  This
>>> series
>>> of patches adds a stable way of retrieving this information.
>>
>> Well, if I look at the uevent of a Bluetooth mouse I have:
>>
>> $ cat
>> /sys/devices/pci0000\:00/0000\:00\:14.0/usb3/3-2/3-2\:1.0/bluetooth/hci0/hci0\:43/0005\:046D\:B00D.001F/uevent
>> DRIVER=hid-generic
>> HID_ID=0005:0000046D:0000B00D
>> HID_NAME=Ultrathin Touch Mouse
>> HID_PHYS=00:10:60:ea:df:ae
>> HID_UNIQ=00:1f:20:96:33:47
>> MODALIAS=hid:b0005g0001v0000046Dp0000B00D
>>
>> I would say that HID_UNIQ is the client MAC address set by hidp, no?
>> So you don't need to duplicate the info by adding a new field in
>> hid_device.
>>
> In a patch I recently submitted I was using the UNIQ field for retrieving a
> Bluetooth device MAC address and was warned against it because "UNIQ is a
> way to provide unique identifiers for devices, but it's not guaranteed to
> stay the same".  HIDP happens to store the MAC in the UNIQ data, but there
> is no guarantee that it will always be there.  With these patches you can be
> completely sure that the data in client_addr is the client device MAC
> address.

ok. But still, adding a transport-specific information to hid_device
is IMO a bad idea. We fought to make HID agnostic of the transport
layer enough.

David, could you elaborate why you think that UNIQ may change in the
future regarding BT?
If the BT MAC address is the same principle of an ethernet MAC
address, UNIQ seems to fit perfectly well.

Otherwise, you may be able to retrieve the MAC address by using the
parent of the current device.

Cheers,
Benjamin
