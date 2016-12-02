From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH 4/8] HID: sony: Report DS4 motion sensors through a
 separate device
Date: Fri, 2 Dec 2016 14:11:00 -0800
Message-ID: <CANndSKno77dbXgop=nvbfL3ABBjB2TrHvV9BfvHTaiM+KiqH4g@mail.gmail.com>
References: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
 <1479938833-26424-5-git-send-email-roderick@gaikai.com> <c7d7015a773b2199ce5187bc1a8939df.squirrel@mungewell.org>
 <CANndSK=vwg6bTL1RCCaFRYQ9aJX_kQ47g-x6jJR_hHrPLnVH+w@mail.gmail.com>
 <alpine.LNX.2.00.1611281452280.29400@cbobk.fhfr.pm> <CANndSKkq4WnXi7Fsm+OT0U1=1uz1ZwMNq_4ZOuuvu-uxEnhuOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:34226 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbcLBWjx (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Dec 2016 17:39:53 -0500
Received: by mail-ua0-f181.google.com with SMTP id 51so296000491uai.1
        for <linux-input@vger.kernel.org>; Fri, 02 Dec 2016 14:39:53 -0800 (PST)
In-Reply-To: <CANndSKkq4WnXi7Fsm+OT0U1=1uz1ZwMNq_4ZOuuvu-uxEnhuOw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Mon, Nov 28, 2016 at 10:32 PM, Roderick Colenbrander
<roderick@gaikai.com> wrote:
> On Mon, Nov 28, 2016 at 5:53 AM, Jiri Kosina <jikos@kernel.org> wrote:
>> On Wed, 23 Nov 2016, Roderick Colenbrander wrote:
>>
>>> > We probably all agree that sending Acc/Gyro data across the joystick
>>> > interface is not the best thing in the world, so I would have some doubts
>>> > about whether spinning up another separate interface is quite the 'correct
>>> > thing' either.
>>> >
>>> > A while back I did some 'tinkering' on the SixAxis to see if 'we' could
>>> > use the IIO interface to report accelerometer data.
>>> > https://patchwork.kernel.org/patch/6589061/
>>
>> Roderick,
>>
>> would you have any input on this aspect? I haven't really been actively
>> involved in the discussion last year, but my gut feeling is that IIO would
>> be the best suited interface for this.
>>
>> Thanks,
>>
>> --
>> Jiri Kosina
>> SUSE Labs
>>
>
> Hi Jiri,
>
> Thanks for your response as well. From a technical side IIO is
> promising and we experimented with it a bit as well. From a more
> practical and business side I'm not the biggest fan. Let me explain a
> bit and work out something which would ideally work for everyone
> involved.
>
> On the technical side, IIO was made for expressing many kinds of
> sensors and our gamepads could be supported as well. The integration
> with the HID side would be a bit tricky as the input report is shared
> with general input data, so buffering, locks etcetera are needed, but
> this is an implementation detail.
>
> The main concern for us is software support in consumer platforms,
> which we often deal with. These open or closed platforms have good
> infrastructure for the Linux input frameworks, adding some other
> system while of course technically feasible is just not possible in
> practice. There is a strong preference there for standard evdev.
> Some platforms use IIO behind the scenes for sensors e.g. Android.
> Taking Android as example, it seems to access most sensors through a
> vendor specific HAL implementation, which can bubble up
> accelerometers, gyroscopes and many other kind of sensors. We looked
> over public code for some of these devices and the sensor list
> reported through this HAL seems to be static just based on what is
> built-in into a particular device. For a gamepad hot-plugging is
> common and at least on so wouldn't work (don't think the framework
> handles this concept yet either), while this is handled fine for
> evdev. I see similar challenges on other platforms we may potentially
> deal with. Desktop Linux is probably the easiest, though libraries
> like SDL2 and others need to gain support at some point.
>
> I definitely see IIO as an interesting platform, but across platforms
> the user space side is really not there even on a popular platform
> like Android. As a company we may end up using this driver on on
> various consumer devices (and older kernels), so I'm not a fan of IIO
> for framework / legacy related reasons. We would like to maintain a
> single code base, which is among the reasons we contribute to this
> driver, wanting to avoid custom proprietary solutions, which don't
> scale.
>
> I'm not sure what the best path forward is. Maybe we could consider
> supporting both e.g. through a kernel configuration option. This could
> be forward and backwards compatible.
>
> Thanks,
>
> --
> Roderick Colenbrander
> Senior Manager of Software Engineering
> Gaikai Inc, a Sony Interactive Entertainment Company

Hi Jiri and others,

Any suggestions on how to move forward?

Thanks,
Roderick
