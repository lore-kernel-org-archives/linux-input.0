From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Patch-V2 1/6] INPUT: xpad: Add minimal support for Logitech G920 Wheel
Date: Thu, 10 Dec 2015 10:40:58 -0800
Message-ID: <CAKdAkRSBTBTW8ma79hh+0sr4izJ70SnvUb1gmPFy3MoVWYaUbA@mail.gmail.com>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org>
	<1447345535-2912-2-git-send-email-simon@mungewell.org>
	<alpine.LNX.2.00.1511191449130.20111@pobox.suse.cz>
	<20151119183106.GC24773@dtor-ws>
	<CAKdAkRTaTA8KFQripYP0ZcFb+5G7OC_Ecnhrwum4L9hsQ-PVxg@mail.gmail.com>
	<CAKdAkRRBtVfTss9AV+DgTtCXf8PVks5pCB4VnR5sQvgW=S3HyA@mail.gmail.com>
	<20151210170853.GC16026@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151210170853.GC16026@mail.corp.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Simon Wood <simon@mungewell.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Edwin <Edwin@velds.nl>, =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>
List-Id: linux-input@vger.kernel.org

On Thu, Dec 10, 2015 at 9:08 AM, Benjamin Tissoires
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

Hi Benjamin,

>
> IIRC, last time I saw an XBox-like controller, it doesn't register as a
> HID device at all. SO I think It will be hard to switch it into the HID
> mode from HID directly.
> Simon, can you confirm that the device does not contains any references
> to HID while in the XBox mode (lsusb -v should give enough information).
>
> Switching the device during probe in xpad.c makes a lot of sense
> however.

It makes as much sense doing it in xpad as doing it from a random USB
network driver. I mean the only reason we are doing it from xpad is
because of name and the fat that it has usb_driver structure. Nobody
stops you from creating a tiny USB stub driver in hid portion that
would probe the "non-hid" device and switch it over to hid.

Thanks.

-- 
Dmitry
