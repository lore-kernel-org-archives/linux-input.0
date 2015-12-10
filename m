From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Patch-V2 1/6] INPUT: xpad: Add minimal support for Logitech G920 Wheel
Date: Wed, 9 Dec 2015 17:23:02 -0800
Message-ID: <CAKdAkRTaTA8KFQripYP0ZcFb+5G7OC_Ecnhrwum4L9hsQ-PVxg@mail.gmail.com>
References: <1447345535-2912-1-git-send-email-simon@mungewell.org>
	<1447345535-2912-2-git-send-email-simon@mungewell.org>
	<alpine.LNX.2.00.1511191449130.20111@pobox.suse.cz>
	<20151119183106.GC24773@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151119183106.GC24773@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Simon Wood <simon@mungewell.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Edwin <Edwin@velds.nl>, =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 19, 2015 at 10:31 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Nov 19, 2015 at 02:50:51PM +0100, Jiri Kosina wrote:
>> On Thu, 12 Nov 2015, Simon Wood wrote:
>>
>> > When plugged in the Logitech G920 wheel starts with USBID 046d:c261
>> > and behaviors as a vendor specific class. If a 'magic' byte sequence
>> > is sent the wheel will detach and reconnect as a HID device with the
>> > USBID 046d:c262.
>> >
>> > Signed-off-by: Simon Wood <simon@mungewell.org>
>>
>> Adding Dmitry to CC.
>>
>> Dmitry, I am planning to take this through my tree together with the rest
>> of the actual HID support for that device if you Ack this.
>
> Hmm, I have an incoming series for xbox that night clash with this... If
> you'll put it in a clean branch off 4.3 I'd pull it and then get more
> changes on top.
>
> Can we also change the subject as it is not about adding a minimal
> support. Something like "Input: xpad - switch Logitech G920 Wheel into
> HID mode"
>
> Otherwise:
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hmm, looking sat this some more why are we waiting to switch device
mode until after userspace opens input device instead of when we are
executing driver probe()?

Thanks.

-- 
Dmitry
