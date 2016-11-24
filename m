From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH 4/8] HID: sony: Report DS4 motion sensors through a
 separate device
Date: Wed, 23 Nov 2016 20:44:18 -0800
Message-ID: <CANndSK=vwg6bTL1RCCaFRYQ9aJX_kQ47g-x6jJR_hHrPLnVH+w@mail.gmail.com>
References: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
 <1479938833-26424-5-git-send-email-roderick@gaikai.com> <c7d7015a773b2199ce5187bc1a8939df.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ua0-f182.google.com ([209.85.217.182]:35363 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756084AbcKXEoU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Nov 2016 23:44:20 -0500
Received: by mail-ua0-f182.google.com with SMTP id 12so35800087uas.2
        for <linux-input@vger.kernel.org>; Wed, 23 Nov 2016 20:44:19 -0800 (PST)
In-Reply-To: <c7d7015a773b2199ce5187bc1a8939df.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Wed, Nov 23, 2016 at 3:17 PM, Simon Wood <simon@mungewell.org> wrote:
>
> On Wed, November 23, 2016 3:07 pm, Roderick Colenbrander wrote:
> > From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> >
> >
> > The DS4 motion sensors are currently mapped by the hid-core driver
> > to non-existing axes in between ABS_MISC and ABS_MT_SLOT, because the
> > device already exhausted ABS_X-ABS_RZ. For a part the mapping by hid-core
> > is accomplished by a fixup in hid-sony as the motion axes actually use
> > vendor specific usage pages.
>
> We probably all agree that sending Acc/Gyro data across the joystick
> interface is not the best thing in the world, so I would have some doubts
> about whether spinning up another separate interface is quite the 'correct
> thing' either.
>
> A while back I did some 'tinkering' on the SixAxis to see if 'we' could
> use the IIO interface to report accelerometer data.
> https://patchwork.kernel.org/patch/6589061/
>
> I think that the timestamps are critical to get correct interpretation of
> the data, and note that PS Move and PS VR both return multiple sets of
> acc/gyro data in a single HID report.

Timestamps are important. The last patch in this series reported them
through MSC_TIMESTAMP, which felt like a reasonable approach.

I'm not sure about the specifics of the other devices you mention. My
bet based on experience is that if there are multiple data points for
a given axis or touch point in a HID report (e.g. because the internal
device polling rate is high), there are likely multiple timestamps as
well. Multiple input_sync and multiple MSC_TIMESTAMPS could be an
option, similar like what was done for touch.

> >
> > This patch makes the DS4 use a separate input device for the motion
> > sensors and reports acceleration data through ABS_X-ABS_Z and gyroscope
> > data through ABS_RX-ABS_RZ. In addition it extends the event spec to allow
> > gyroscope data through ABS_RX-ABS_RZ when INPUT_PROP_ACCELEROMETER is set.
> > This change was suggested by
> > Peter Hutterer during a discussion on linux-input.
>
> Do you have a link?

There was a longer discussion when we tried to revive evdev patches on
adding additional ABS axes. This was kind of the last in that thread
in which we also discussed Wacom / Wii which are already handling some
of the stuff kind of.

https://lkml.org/lkml/2016/11/8/95

> Also, can you confirm whether this change would break '/dev/hidrawX', I
> know a number of projects that read that directly to do their thing.

We made the HID descriptor towards the end of report 17 look closely
like how the original report 1 looks like. To be honest as I mentioned
in 0/8, I'm not sure if we should even fixup the HID descriptors. For
example I'm aware of various cross platform projects (open and closed)
dealing with these devices and they are now seeing inconsistent views
between Windows, Linux and OSX, causing headaches. Some parse the
vendor specific bits as intended for example.

> Thanks,
> Simon.
>



-- 
Roderick Colenbrander
Senior Manager of Software Engineering
Gaikai, a Sony Interactive Entertainment Company
roderick@gaikai.com
