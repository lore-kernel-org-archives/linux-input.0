From: Michael Wright <michaelwr@android.com>
Subject: Re: [PATCH] HID: add new gamepad LED constants
Date: Mon, 15 Sep 2014 16:41:42 -0700
Message-ID: <CAON4U=NqrMK=baJBLGWY=-+jwDdAE==LRDHU35Rya6GhdnrsQA@mail.gmail.com>
References: <1410750811-11156-1-git-send-email-michaelwr@google.com>
	<CANq1E4RY8cF1de4_rdS3Whjrf0bboYMtii4_nYNM2mEJuAKMfQ@mail.gmail.com>
	<CAON4U=OTzqOYDCeT-rFM8trvD80_kQxirZ+Yu5nOjc84v15XLA@mail.gmail.com>
	<20140915215728.GB13468@core.coreip.homeip.net>
	<CANq1E4TK1=mD0Xh5KuydoONqiex79HggvoM9XRhorogmxqBqhw@mail.gmail.com>
	<20140915225809.GA31798@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:36861 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007AbaIOXlo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Sep 2014 19:41:44 -0400
Received: by mail-la0-f53.google.com with SMTP id ge10so5834093lab.12
        for <linux-input@vger.kernel.org>; Mon, 15 Sep 2014 16:41:43 -0700 (PDT)
In-Reply-To: <20140915225809.GA31798@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Michael Wright <michaelwr@google.com>, Jiri Kosina <jkosina@suse.cz>

> LEDs should be controlled via LED subsystem. The fact that they happen
> to be located on a given device does not mean they belong to input
> subsystem. The same as LEds on network card are not part of network stack,
> etc.

I think the fundamental difference for me is that the primary input
standard does
have a specification for how to interact with LEDs, and right now the LED
subsystem has no knowledge of HID whatsoever.

Even if I did add the plumbing for HID over into the LED subsystem, is there an
easy way to correlate input devices and their LEDs from userspace?


On Mon, Sep 15, 2014 at 3:58 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi David,
>
> On Tue, Sep 16, 2014 at 12:15:08AM +0200, David Herrmann wrote:
>> Hi
>>
>> On Mon, Sep 15, 2014 at 11:57 PM, Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>> > On Mon, Sep 15, 2014 at 11:03:47AM -0700, Michael Wright wrote:
>> >> > Why not introduce all 8 player LEDs as described in the document? You
>> >> > should be safe increasing LED_MAX to 0x1f.
>> >>
>> >> Wasn't sure if it was safe to bump it since it could potentially break apps
>> >> until they recompile against the new API.
>> >
>> > I'd rather we did not add any new input LED definitions but rather
>> > looked into switching to LED subsystem, at least for new LEDs.
>>
>> Why?
>
> Because we have a proper subsystem that represents LEDs.
>
>> The LED subsystem lacks any unprivileged API to control LEDs.
>
> As far as I can see it is the same as for input devices. You just need
> to make sure the device owner can access needed attributes, such as
> brightness.
>
>> There's no cdev to control write-access to the LED API. /sys has never
>> been intended as unprivileged API
>
> chmod/chown works just fine on sysfs attributes.
>
>> so I'd really prefer if we add
>> proper input codes to control those. At least I cannot see the
>> advantage of the led subsystem over input EV_LED codes. Care to
>> elaborate?
>>
>
> LEDs should be controlled via LED subsystem. The fact that they happen
> to be located on a given device does not mean they belong to input
> subsystem. The same as LEds on network card are not part of network stack,
> etc.
>
> Thanks.
>
> --
> Dmitry



-- 
Michael Wright
Android Frameworks
