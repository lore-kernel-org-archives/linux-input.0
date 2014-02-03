From: Frank Praznik <frank.praznik@gmail.com>
Subject: Re: [PATCH 0/6] HID: Add a stable method for retrieving the client
 MAC address of a HID device
Date: Mon, 3 Feb 2014 12:31:23 -0500
Message-ID: <CAH+9E3oNifQgGDOp9POpxMm2uaMo3AUdRttC7L=WtGOyU8_nBA@mail.gmail.com>
References: <1391189573-2591-1-git-send-email-frank.praznik@oh.rr.com>
	<CAN+gG=EVcVmQ8rr2YtoapfftSHaDeYnSu5rCnuZjL=S-v1xU4Q@mail.gmail.com>
	<52EC01DF.6050309@oh.rr.com>
	<CAN+gG=GxXUU2rNNg7T1o50RPzXopnnqWbhQ4+-uWN3mbLUUyDw@mail.gmail.com>
	<52ED1B8D.80208@gmail.com>
	<CAN+gG=H6A93ozP=Q52GXnEjARC1tX4s6k=Oi6MoHK7Mh6kBPiw@mail.gmail.com>
	<CANq1E4TYrwOhBd6ZVUCzuRyB_8ivaCsZVbBKz6n5hPodHjtOmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:52971 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753018AbaBCRbY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Feb 2014 12:31:24 -0500
Received: by mail-ob0-f173.google.com with SMTP id vb8so8138735obc.4
        for <linux-input@vger.kernel.org>; Mon, 03 Feb 2014 09:31:23 -0800 (PST)
In-Reply-To: <CANq1E4TYrwOhBd6ZVUCzuRyB_8ivaCsZVbBKz6n5hPodHjtOmg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Mon, Feb 3, 2014 at 11:24 AM, David Herrmann <dh.herrmann@gmail.com> wrote:
> Hi
>
> On Sat, Feb 1, 2014 at 5:28 PM, Benjamin Tissoires
> <benjamin.tissoires@gmail.com> wrote:
>> On Sat, Feb 1, 2014 at 11:06 AM, Frank Praznik <frank.praznik@gmail.com> wrote:
>>> On 1/31/2014 15:45, Benjamin Tissoires wrote:
>>>>
>>>> On Fri, Jan 31, 2014 at 3:04 PM, Frank Praznik <frank.praznik@oh.rr.com>
>>>> wrote:
>>>>>
>>>>> On 1/31/2014 14:10, Benjamin Tissoires wrote:
>>>>>>
>>>>>> Hi Frank,
>>>>>>
>>>>>> just a quick review:
>>>>>>
>>>>>> On Fri, Jan 31, 2014 at 12:32 PM, Frank Praznik
>>>>>> <frank.praznik@oh.rr.com>
>>>>>> wrote:
>>>>>>>
>>>>>>> Currently there is no reliable way for a device module or hidraw
>>>>>>> application to
>>>>>>> retrieve the client MAC address of the associated wireless device.
>>>>>>> This
>>>>>>> series
>>>>>>> of patches adds a stable way of retrieving this information.
>>>>>>
>>>>>> Well, if I look at the uevent of a Bluetooth mouse I have:
>>>>>>
>>>>>> $ cat
>>>>>>
>>>>>> /sys/devices/pci0000\:00/0000\:00\:14.0/usb3/3-2/3-2\:1.0/bluetooth/hci0/hci0\:43/0005\:046D\:B00D.001F/uevent
>>>>>> DRIVER=hid-generic
>>>>>> HID_ID=0005:0000046D:0000B00D
>>>>>> HID_NAME=Ultrathin Touch Mouse
>>>>>> HID_PHYS=00:10:60:ea:df:ae
>>>>>> HID_UNIQ=00:1f:20:96:33:47
>>>>>> MODALIAS=hid:b0005g0001v0000046Dp0000B00D
>>>>>>
>>>>>> I would say that HID_UNIQ is the client MAC address set by hidp, no?
>>>>>> So you don't need to duplicate the info by adding a new field in
>>>>>> hid_device.
>>>>>>
>>>>> In a patch I recently submitted I was using the UNIQ field for retrieving
>>>>> a
>>>>> Bluetooth device MAC address and was warned against it because "UNIQ is a
>>>>> way to provide unique identifiers for devices, but it's not guaranteed to
>>>>> stay the same".  HIDP happens to store the MAC in the UNIQ data, but
>>>>> there
>>>>> is no guarantee that it will always be there.  With these patches you can
>>>>> be
>>>>> completely sure that the data in client_addr is the client device MAC
>>>>> address.
>>>>
>>>> ok. But still, adding a transport-specific information to hid_device
>>>> is IMO a bad idea. We fought to make HID agnostic of the transport
>>>> layer enough.
>>>>
>>>> David, could you elaborate why you think that UNIQ may change in the
>>>> future regarding BT?
>>>> If the BT MAC address is the same principle of an ethernet MAC
>>>> address, UNIQ seems to fit perfectly well.
>>>>
>>>> Otherwise, you may be able to retrieve the MAC address by using the
>>>> parent of the current device.
>>>>
>>>> Cheers,
>>>> Benjamin
>>>
>>> Are you referring to using the hid_device::dev.parent pointer?  I know that
>>
>> Yes
>>
>>> hidp sets it to point to the hci_conn struct from which src address for the
>>> Bluetooth connection can be obtained, but making assumptions about an opaque
>>> pointer like that seems dangerous.  Is the parent pointer guaranteed to
>>> point to the hci_conn struct as long as the bus type is Bluetooth?
>>
>> And nope. If you use uhid, then the parent will not be a hci_conn.
>>
>> With enough guards, you should be able to use it, but it's not ideal I agree.
>> I really want to have David's opinion regarding the UNIQ field. IMO,
>> this seems to be the most transport-agnostic way of doing it.
>
> UNIQ is definitely wrong. It is used to assign a run-time *unique*
> value to the connection. So ideally it should be different if a device
> is reconnected. The PHYS field is actually used to identify a physical
> device. So please, if we're doing this, then we should do it via PHYS.
>
> I'm fine with hard-coding PHYS as bt-address for BT-HID, but please
> add a comment to hidp_setup_hid() in net/bluetooth/hidp/core.c before
> doing the snprintf() there.
>
> The reason why I disliked hard-coding this behavior is that if a
> single BT-device is connected twice to us, we usually want two
> different PHYS entries for both depending on which service this
> connection provides. However, this seems like an unlikely and
> overengineered problem so lets not do that. Furthermore, while BT-HID
> would allow such setups with some hacks, it isn't supported in a clean
> way. So yeah, I'm actually fine with using PHYS for that.
>
> Thanks
> David

PHYS should definitely be changed if this is the case because right
now it is set to the MAC of the host adapter which means that it's the
same for every Bluetooth device and connection.  I believe that the
hidraw documentation also specifies that for Bluetooth devices the
HIDIOCGRAWPHYS ioctl should return a string with the MAC address of
the associated device rather than that of the host adapter as the
current behavior does.
