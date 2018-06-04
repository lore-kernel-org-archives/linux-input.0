From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 1/2] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
Date: Mon, 4 Jun 2018 15:18:12 +0200
Message-ID: <CAO-hwJJPGJzgX+7H1nnpd=OkLZu0q0TuKhvroJ1K3jtnv7t6dg@mail.gmail.com>
References: <20170811004500.13740-1-dmitry.torokhov@gmail.com>
 <CAO-hwJJ8E4mQqu0RYaZrmawud4wbSVE4GHEvg7oxUzEc-B5nvQ@mail.gmail.com> <20180601184330.GD222005@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180601184330.GD222005@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, Jason Gerecke <killertofu@gmail.com>, Dennis Kempin <denniskempin@google.com>, Andrew de los Reyes <adlr@google.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, Jun 1, 2018 at 8:43 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> On Fri, Jun 01, 2018 at 04:16:09PM +0200, Benjamin Tissoires wrote:
>> On Fri, Aug 11, 2017 at 2:44 AM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > According to Microsoft specification [1] for Precision Touchpads (and
>> > Touchscreens) the devices use "confidence" reports to signal accidental
>> > touches, or contacts that are "too large to be a finger". Instead of
>> > simply marking contact inactive in this case (which causes issues if
>> > contact was originally proper and we lost confidence in it later, as
>> > this results in accidental clicks, drags, etc), let's report such
>> > contacts as MT_TOOL_PALM and let userspace decide what to do.
>> > Additionally, let's report contact size for such touches as maximum
>> > allowed for major/minor, which should help userspace that is not yet
>> > aware of MT_TOOL_PALM to still perform palm rejection.
>> >
>> > An additional complication, is that some firmwares do not report
>> > non-confident touches as active. To cope with this we delay release of
>> > such contact (i.e. if contact was active we first report it as still
>> > active MT+TOOL_PALM and then synthesize the release event in a separate
>> > frame).
>>
>> I am not sure I agree with this part. The spec says that "Once a
>> device has determined that a contact is unintentional, it should clear
>> the confidence bit for that contact report and all subsequent
>> reports."
>> So in theory the spec says that if a touch has been detected as a
>> palm, the flow of events should not stop (tested on the PTP of the
>> Dell XPS 9360).
>>
>> However, I interpret a firmware that send (confidence 1, tip switch 1)
>> and then (confidence 0, tip switch 0) a simple release, and the
>> confidence bit should not be relayed.
>
> This unfortunately leads to false clicks: you start with finger, so
> confidence is 1, then you transition the same touch to palm (use your
> thumb and "roll" your hand until heel of it comes into contact with the
> screen). The firmware reports "no-confidence" and "release" in the same
> report and userspace seeing release does not pay attention to confidence
> (i.e. it does exactly "simple release" logic) and this results in UI
> interpreting this as a click. With splitting no-confidence
> (MT_TOOL_PALM) and release event into separate frames we help userspace
> to recognize that the contact should be discarded.

After further thoughts, I would consider this to be a firmware bug,
and not how the firmware is supposed to be reporting palm.
For the precision touchpads, the spec says that the device "should
clear the confidence bit for that contact report and all subsequent
reports.". And it is how the Dell device I have here reports palms.
The firmware is not supposed to cut the event stream.

There is a test for that:
https://docs.microsoft.com/en-us/previous-versions/windows/hardware/hck/dn456905%28v%3dvs.85%29
which tells me that I am right here for PTP.

The touchscreen spec is blurrier however.

>
>>
>> Do you have any precise example of reports where you need that feature?
>
> It was observed on Pixelbooks which use Wacom digitizers IIRC.

Pixelbooks + Wacom means that it was likely a touchscreen. I am right
guessing the device did not went through Microsoft certification
process?

I am in favor of splitting the patch in 2. One for the generic
processing of confidence bit, and one for this spurious release. For
the spurious release, I'm more in favor of explicitly quirking the
devices in need of such quirk.

If you agree, I'll rebase your patch on top of my series as rebasing
my series on top of yours will take more effort.

I am trying to be cautious in the generic path because I want to merge
the cleanest multitouch implementation in hid-core/hid-input, and
leave all the quirks in hid-multitouch for the devices in need.

Cheers,
Benjamin

>
> Thanks.
>
> --
> Dmitry
