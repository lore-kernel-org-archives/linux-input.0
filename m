From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v3] input/uinput: add UI_GET_SYSNAME ioctl to retrieve the
 sysfs path
Date: Mon, 20 Jan 2014 17:17:08 -0500
Message-ID: <CAN+gG=EPXLR5H_h0UgaMOmAbwAivxCohtg3Gocws5fJucz4+eg@mail.gmail.com>
References: <1389985971-541-1-git-send-email-benjamin.tissoires@redhat.com>
	<20140120215313.GB4270@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140120215313.GB4270@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 20, 2014 at 4:53 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Benjamin,
>
> On Fri, Jan 17, 2014 at 02:12:51PM -0500, Benjamin Tissoires wrote:
>> Evemu [1] uses uinput to replay devices traces it has recorded. However,
>> the way evemu uses uinput is slightly different from how uinput is
>> supposed to be used.
>> Evemu relies on libevdev, which creates the device node through uinput.
>> It then injects events through the input device node directly (and it
>> completely skips the uinput node).
>>
>> Currently, libevdev relies on an heuristic to guess which input node was
>> created. The problem is that is heuristic is subjected to races between
>> different uinput devices or even with physical devices. Having a way
>> to retrieve the sysfs path allows us to find the event node without
>> having to rely on this heuristic.
>
> I have been thinking about it and I think that providing tight coupling
> between uinput and resulting event device is wrong thing to do. We do
> allow sending input events through uinput interface and I think evemu
> should be using it, instead of going halfway through uinput and halfway
> though evdev. Replaying though uinput would actually be more correct as
> it would involve the same code paths throgugh input core as with using
> real devices (see input_event() vs. input_inject_event() that is used by
> input handlers).
>

Yes, I am perfectly aware of the fact that evemu is not using uinput
in the way it is intended to be.
I agree that it should be using the uinput node to inject events but
this means that only the process which has created the virtual device
can access it. It seems weird, I know, but the typical use of evemu is
the following:
- in a first terminal: $> sudo evemu-device mydevice.desc
- In a second: $> sudo evemu-play /dev/input/event12 < mydevice.events

It looks weird here, but it allows to inject different events
recording for the same virtual device node. Using the uinput node to
inject events will force us to change the user "interface" and rely on
pipes to get the same separation of describe/inject.
Note that I am modifying evemu-play to be able to also create the
virtual device, so I am not entirely convinced about this argument
(but we have users).

The other use case I should have mentioned in the commit message is
that we extensively rely on evemu for the xorg-integration-tests (and
the upcoming wayland test suite if I am not wrong).
The tests are fully automatized, and we need to know which input node
has just been created to record the correct one and test against it.


Ok, I am stopping here because Peter already answered about this in his mail :)

Cheers,
Benjamin
