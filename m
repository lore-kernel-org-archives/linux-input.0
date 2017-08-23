From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH v2 0/3] Input/HID: joydev fixes for motion sensors
Date: Wed, 23 Aug 2017 16:57:12 -0700
Message-ID: <CANndSK=mBvBekPTGnKBzMcg7xw5X5bLpNioTZSLFgsEeU6+KeA@mail.gmail.com>
References: <20170818020156.23390-1-roderick@gaikai.com> <1503479092.24498.18.camel@hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35869 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbdHWX5N (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Aug 2017 19:57:13 -0400
Received: by mail-oi0-f50.google.com with SMTP id g131so15925561oic.3
        for <linux-input@vger.kernel.org>; Wed, 23 Aug 2017 16:57:13 -0700 (PDT)
In-Reply-To: <1503479092.24498.18.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Wed, Aug 23, 2017 at 2:04 AM, Bastien Nocera <hadess@hadess.net> wrote:
> On Thu, 2017-08-17 at 19:01 -0700, Roderick Colenbrander wrote:
>> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
>>
>> Hi,
>>
>> Some weeks ago we submitted an earlier version of this patch set,
>> which attempted to blacklist dualshock 3 / 4 motion sensor devices
>> from joydev. The motion sensor devices got picked up since the hid-
>> sony
>> driver in recent months split the motion sensors of in separate
>> devices.
>>
>> The earlier version of this patch set, added a filter to joydev to
>> ignore devices which have INPUT_PROP_ACCELEROMETER set. Dmitry
>> pointed
>> out that often you could use a motion sensor device as a joystick. He
>> felt the issue is with composite devices.
>>
>> The discussion didn't result in a conclusion. This patch set only
>> filters out motion sensors if they are part of a composite device.
>> Since there is no way during driver initialization to determine
>> whether we are dealing with a composite device, we introduce a new
>> property INPUT_PROP_COMPOSITE to determine this.
>
> Would have a way to know how many pieces make up that composite device
> be useful?

Yes that would be quite useful, see the discussion with Peter in '1/3'
where he is proposing an ioctl as well.

>
>> I think having such
>> flag is beneficial for userspace as well, since applications now get
>> a hint
>> that a device is part of a composite device without having to infer
>> this from a EVIOCGPHYS / EVIOCGUINIQ match across devices.
>
> Not that much, udev already does all that for user-space.

We deal a lot with platforms on which we don't have udev and could see
using this. Also applications like Wine directly read evdev or
libraries like SDL2 it can be helpful maybe.

>
>> Hopefully this patches will be accepted for 4.14, but maybe earlier
>> if
>> still possible as the next wave of distributions will likely be on
>> 4.13
>> with more users dealing with this issue.
>
> I'm not sure I fully understand the problem you're trying to solve.
>
> Is it "old software which relies on joydev is too basic to allow
> selecting the correct joystick device"? Or "some system components are
> picking up the joypad's accelerometer like it inferred the screen's
> positioning"?
>

The problem is more like the first. Joydev is too basic to allow
applications to determine they are dealing with a motion sensor device
(axes are just numbers from its perspective). Due to recent hid-sony
restructure, its motion sensors are now picked up by joydev as it
passes joydev its heuristics.

We felt that no motion sensors should probably get picked up by the
legacy joydev interface as it caused issues for legacy applications
(and users reported issues to me). Originally we proposed filtering in
joydev based on just 'INPUT_PROP_ACCELEROMETER' as it has similar
filters to filter out touchpad device and others. Discussion on that
patch led to the composite device discussion as Dmitry felt that the
ability to use a standalone motion sensor device as a joystick could
potentially make sense.
