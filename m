From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [Patch-V2 1/6] INPUT: xpad: Add minimal support for Logitech G920 Wheel
Date: Sun, 13 Dec 2015 13:50:40 +0100
Message-ID: <CADbOyBSQgoLg6qiW+5y1BGNhsh=kPwUo_FvjJ=8DfazJ5O4SQw@mail.gmail.com>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org>
	<1447345535-2912-2-git-send-email-simon@mungewell.org>
	<alpine.LNX.2.00.1511191449130.20111@pobox.suse.cz>
	<20151119183106.GC24773@dtor-ws>
	<CAKdAkRTaTA8KFQripYP0ZcFb+5G7OC_Ecnhrwum4L9hsQ-PVxg@mail.gmail.com>
	<CAKdAkRRBtVfTss9AV+DgTtCXf8PVks5pCB4VnR5sQvgW=S3HyA@mail.gmail.com>
	<20151210170853.GC16026@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:33919 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbbLMMul (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Dec 2015 07:50:41 -0500
In-Reply-To: <20151210170853.GC16026@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Simon Wood <simon@mungewell.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Edwin <Edwin@velds.nl>, =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>

On Thu, Dec 10, 2015 at 6:08 PM, Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
> On Dec 09 2015 or thereabouts, Dmitry Torokhov wrote:
>> On Wed, Dec 9, 2015 at 5:23 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Thu, Nov 19, 2015 at 10:31 AM, Dmitry Torokhov
>> > <dmitry.torokhov@gmail.com> wrote:
>> >> On Thu, Nov 19, 2015 at 02:50:51PM +0100, Jiri Kosina wrote:
>> >>> On Thu, 12 Nov 2015, Simon Wood wrote:
>> >>>
>> >>> > When plugged in the Logitech G920 wheel starts with USBID 046d:c261
>> >>> > and behaviors as a vendor specific class. If a 'magic' byte sequence
>> >>> > is sent the wheel will detach and reconnect as a HID device with the
>> >>> > USBID 046d:c262.
>> >>> >
>> >>> > Signed-off-by: Simon Wood <simon@mungewell.org>
>> >>>
>> >>> Adding Dmitry to CC.
>> >>>
>> >>> Dmitry, I am planning to take this through my tree together with the rest
>> >>> of the actual HID support for that device if you Ack this.
>> >>
>> >> Hmm, I have an incoming series for xbox that night clash with this... If
>> >> you'll put it in a clean branch off 4.3 I'd pull it and then get more
>> >> changes on top.
>> >>
>> >> Can we also change the subject as it is not about adding a minimal
>> >> support. Something like "Input: xpad - switch Logitech G920 Wheel into
>> >> HID mode"
>> >>
>> >> Otherwise:
>> >>
>> >> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> >
>> > Hmm, looking sat this some more why are we waiting to switch device
>> > mode until after userspace opens input device instead of when we are
>> > executing driver probe()?
>> >
>>
>> Actually, thinking about it even more, why do we want to have this in
>> xpad.c? Have HID module handle both IDs and switch to HID mode if we
>> want HID to handle this device. I think we should revert/drop this
>> patch.
>>
>
> Hi Dmitry,
>
> IIRC, last time I saw an XBox-like controller, it doesn't register as a
> HID device at all. SO I think It will be hard to switch it into the HID
> mode from HID directly.
> Simon, can you confirm that the device does not contains any references
> to HID while in the XBox mode (lsusb -v should give enough information).

This is probably not relevant anymore, but here is the "sudo lsusb -v"
output of my G920 in XBox mode:

Bus 001 Device 121: ID 046d:c261 Logitech, Inc.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass       255 Vendor Specific Subclass
  bDeviceProtocol       255 Vendor Specific Protocol
  bMaxPacketSize0        64
  idVendor           0x046d Logitech, Inc.
  idProduct          0xc261
  bcdDevice           96.01
  iManufacturer           1 Logitech
  iProduct                2 G920 Driving Force Racing Wheel for Xbox One
  iSerial                 3 000072fb6b3b9f58
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass     71
      bInterfaceProtocol    208
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               4
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               4
Device Status:     0x0002
  (Bus Powered)
  Remote Wakeup Enabled
