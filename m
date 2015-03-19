From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] HID: sony: Enable Gasia third-party PS3 controllers
Date: Thu, 19 Mar 2015 11:26:28 +0100
Message-ID: <CANq1E4RwbngKd2fCJ-SULTiVavKBbmJYVynK+w8uq1CDyHAzLA@mail.gmail.com>
References: <20150207154859.89a7e4e3.cand@gmx.com>
	<CAN+gG=EOf4di64EpXADRsQJ7_PTeH+9G=2TFN5-5mgMmcrk4qw@mail.gmail.com>
	<20150207173133.0eda1917cbb26834f1885aa9@ao2.it>
	<20150207234801.262dbe4f.cand@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36635 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbbCSK03 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Mar 2015 06:26:29 -0400
In-Reply-To: <20150207234801.262dbe4f.cand@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lauri Kasanen <cand@gmx.com>
Cc: Antonio Ospite <ao2@ao2.it>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, AndrewD207@aol.com, Benjamin Tissoires <benjamin.tissoires@gmail.com>

Hi

On Sat, Feb 7, 2015 at 10:48 PM, Lauri Kasanen <cand@gmx.com> wrote:
> Hi,
>
> On Sat, 7 Feb 2015 17:31:33 +0100
> Antonio Ospite <ao2@ao2.it> wrote:
>> > > +#include <linux/usb/input.h>
>> >
>> > Please don't.
>> > HID should be transport agnostic, so please refrain from directly call usb.
>> >
>>
>> I agree with Benjamin here.
>>
>> > > +
>> > > +       ret = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x02),
>> > > +                               buf2, sizeof(buf2),
>> > > +                               &transfered, USB_CTRL_SET_TIMEOUT);
>> >
>> > Can't you simply use a hid_hw_output_report request instead of hard
>> > coding the device specific endpoint?
>> > And I'd also prefer it to be guarded against your specific controller.
>> >
>>
>> usb_interrupt_msg() is called in usbhid_output_report() indeed, so it
>> should be possible to use the generic HID interface.
>
> Regarding the USB. This is a comment from Andrew's patch:
>
> // doesn't work. gets sent as a SET_REPORT Request intstead of a
> // URB_INTERRUPT out. I guess usbhid->urbout is null
> //if ( hdev->hid_output_raw_report(hdev, buf2, sizeof(buf2),
>
> I took his word for it, and did not attempt it. Do you think it would
> work with the current kernel? If so, I can test later. Had quite an
> enjoyable evening playing some FF7 once I had the controller working ;)

Yes, hid_hw_request() and hid_hw_raw_request() send
SET_REPORT/GET_REPORT in the ctrl line. If you want output-reports on
the intr line, you have to use hid_hw_output_report(). So according to
your quote, hid_hw_output_report() should work.

Background: Documentation/hid/hid-transport.txt

Thanks
David
