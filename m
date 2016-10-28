From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH] Input: mt: only perform pointer emulation on drivers
 desiring this functionality
Date: Thu, 27 Oct 2016 17:10:20 -0700
Message-ID: <CANndSK=B6+B2MOAodi4EkgpD_UFcoXbRP5G9L8k+cuok0h=Wow@mail.gmail.com>
References: <1477603873-9143-1-git-send-email-roderick@gaikai.com>
 <20161027231942.GB12312@dtor-ws> <CANndSKmxgUM-u+jZF611Ko5supENX95-JR2xKp++3YPGZHAJtw@mail.gmail.com>
 <20161027235406.GE12312@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:35802 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936469AbcJ1AKW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Oct 2016 20:10:22 -0400
Received: by mail-ua0-f172.google.com with SMTP id 12so42297000uas.2
        for <linux-input@vger.kernel.org>; Thu, 27 Oct 2016 17:10:21 -0700 (PDT)
In-Reply-To: <20161027235406.GE12312@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Thu, Oct 27, 2016 at 4:54 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Thu, Oct 27, 2016 at 04:46:01PM -0700, Roderick Colenbrander wrote:
>> On Thu, Oct 27, 2016 at 4:19 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Thu, Oct 27, 2016 at 02:31:13PM -0700, Roderick Colenbrander wrote:
>> >> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
>> >>
>> >> The input-mt driver pointer emulation from 'input_mt_sync_frame' regardless
>> >> of the flags passed in to 'input_mt_init_slots' by device drivers.
>> >
>> > Right, because needing single-touch (pointer) emulation is not property
>> > of device or driver but rather consumer. If we get to the point where
>> > everything is ready to accept multi-touch (are we there yet) then we can
>> > stop doing pointer emulation altogether.
>> >
>> >>
>> >> Pointer emulation is undesired on drivers, which didn't request this
>> >> capability like the hid-sony driver for the Dualshock 4. This gamepad already
>> >> reports ABS_X / ABS_Y for gamepad stick purposes. Pointer emulation would
>> >> inject touchpad values into these sticks, which is undesired.
>> >
>> > The driver should not be re-purposing events like that.
>> > ABS_MT_POSITION_X and ABS_X should match.
>> >
>> > Why doesn't driver follow Documentation/input/gamepad.txt?
>> >
>>
>> The original hid-sony code and the multitouch handling code for the Dualshock 4
>> were written by the community. We are stepping in to make the hid-sony driver
>> properly handle the Dualshock 4.
>> The driver doesn't fully follow the gamepad spec yet, which we will
>> try to improve. At
>> least the left analog stick is reported as ABS_X and ABS_Y already,
>> but the buttons
>> are inconsistent and right stick is wrong as well.
>> While it would be great to conform to the spec, the conflict with
>> multitouch would still
>> exist as the Dualshock 4 has both analog sticks and a multitouch touchpad.
>>
>> Disabling the pointer emulation feature avoids the conflict. This
>> issue was only exposed
>> recently by adding of the input_mt_sync_frame call as recommended by Benjamin as
>> part of some improvements we did for touchpad handling in hid-sony.
>
> As I mentioned, ABS_MT_POSITION_X and ABS_X should represent the same
> data, so the driver's use of them for different sub-devices is not
> correct. Maybe the multitouch "touchpad" should be reported as
> completely separate input device and userspace should "stitch" it back
> into composite device.
>
> In any case, as I mentioned above, the pointer emulation is requirement
> of client and thus this patch is not appropriate.
>
> Thanks.
>
> --
> Dmitry

Thanks for your reply. I guess the only option then is to create an
actual sub device. I suppose
we are not the first input driver exposing sub devices. Are there good
example drivers you can
recommend (or drivers to avoid glancing at)?

The only concern I have is the stitching together in user space, which
not kinds of platforms
or userland libraries are handling. The only way is to inspect sysfs
and try to tie things together.
It would be nice if there was some better way. From memory Video4Linux
exposed various
APIs to locate subdevices from the 'master' device.

Thanks,
Roderick
