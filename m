From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 4/8] HID: sony: Report DS4 motion sensors through a
 separate device
Date: Mon, 5 Dec 2016 10:44:55 +0100
Message-ID: <20161205094455.GN1280@mail.corp.redhat.com>
References: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
 <1479938833-26424-5-git-send-email-roderick@gaikai.com>
 <c7d7015a773b2199ce5187bc1a8939df.squirrel@mungewell.org>
 <CANndSK=vwg6bTL1RCCaFRYQ9aJX_kQ47g-x6jJR_hHrPLnVH+w@mail.gmail.com>
 <alpine.LNX.2.00.1611281452280.29400@cbobk.fhfr.pm>
 <CANndSKkq4WnXi7Fsm+OT0U1=1uz1ZwMNq_4ZOuuvu-uxEnhuOw@mail.gmail.com>
 <CANndSKno77dbXgop=nvbfL3ABBjB2TrHvV9BfvHTaiM+KiqH4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752425AbcLEJpB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 5 Dec 2016 04:45:01 -0500
Content-Disposition: inline
In-Reply-To: <CANndSKno77dbXgop=nvbfL3ABBjB2TrHvV9BfvHTaiM+KiqH4g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: Jiri Kosina <jikos@kernel.org>, Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Dec 02 2016 or thereabouts, Roderick Colenbrander wrote:
> On Mon, Nov 28, 2016 at 10:32 PM, Roderick Colenbrander
> <roderick@gaikai.com> wrote:
> > On Mon, Nov 28, 2016 at 5:53 AM, Jiri Kosina <jikos@kernel.org> wrote:
> >> On Wed, 23 Nov 2016, Roderick Colenbrander wrote:
> >>
> >>> > We probably all agree that sending Acc/Gyro data across the joystick
> >>> > interface is not the best thing in the world, so I would have some doubts
> >>> > about whether spinning up another separate interface is quite the 'correct
> >>> > thing' either.
> >>> >
> >>> > A while back I did some 'tinkering' on the SixAxis to see if 'we' could
> >>> > use the IIO interface to report accelerometer data.
> >>> > https://patchwork.kernel.org/patch/6589061/
> >>
> >> Roderick,
> >>
> >> would you have any input on this aspect? I haven't really been actively
> >> involved in the discussion last year, but my gut feeling is that IIO would
> >> be the best suited interface for this.
> >>
> >> Thanks,
> >>
> >> --
> >> Jiri Kosina
> >> SUSE Labs
> >>
> >
> > Hi Jiri,
> >
> > Thanks for your response as well. From a technical side IIO is
> > promising and we experimented with it a bit as well. From a more
> > practical and business side I'm not the biggest fan. Let me explain a
> > bit and work out something which would ideally work for everyone
> > involved.
> >
> > On the technical side, IIO was made for expressing many kinds of
> > sensors and our gamepads could be supported as well. The integration
> > with the HID side would be a bit tricky as the input report is shared
> > with general input data, so buffering, locks etcetera are needed, but
> > this is an implementation detail.
> >
> > The main concern for us is software support in consumer platforms,
> > which we often deal with. These open or closed platforms have good
> > infrastructure for the Linux input frameworks, adding some other
> > system while of course technically feasible is just not possible in
> > practice. There is a strong preference there for standard evdev.
> > Some platforms use IIO behind the scenes for sensors e.g. Android.
> > Taking Android as example, it seems to access most sensors through a
> > vendor specific HAL implementation, which can bubble up
> > accelerometers, gyroscopes and many other kind of sensors. We looked
> > over public code for some of these devices and the sensor list
> > reported through this HAL seems to be static just based on what is
> > built-in into a particular device. For a gamepad hot-plugging is
> > common and at least on so wouldn't work (don't think the framework
> > handles this concept yet either), while this is handled fine for
> > evdev. I see similar challenges on other platforms we may potentially
> > deal with. Desktop Linux is probably the easiest, though libraries
> > like SDL2 and others need to gain support at some point.
> >
> > I definitely see IIO as an interesting platform, but across platforms
> > the user space side is really not there even on a popular platform
> > like Android. As a company we may end up using this driver on on
> > various consumer devices (and older kernels), so I'm not a fan of IIO
> > for framework / legacy related reasons. We would like to maintain a
> > single code base, which is among the reasons we contribute to this
> > driver, wanting to avoid custom proprietary solutions, which don't
> > scale.
> >
> > I'm not sure what the best path forward is. Maybe we could consider
> > supporting both e.g. through a kernel configuration option. This could
> > be forward and backwards compatible.
> >
> > Thanks,
> >
> > --
> > Roderick Colenbrander
> > Senior Manager of Software Engineering
> > Gaikai Inc, a Sony Interactive Entertainment Company
> 
> Hi Jiri and others,
> 
> Any suggestions on how to move forward?

Hi Roderick,

>From a personal perspective I must confess I dislike IIO too. I don't
like the way it was introduced and took over the existing subsystems to
replace existing sensors. It's clear there was caveats with the input
subsystem, but I was not so pleased with the fact that they wrote an
entirely new sysfs just for that. Not to mention that I don't think the
sysfs approach is the best way to handle input data.
On the other hand, IIO allows to set hysteresis and filters on the input
data, so this makes interesting for global system events and power
consumption.

In your case, I think using IIO is just non sense. The accelerometers
found on the DS4 are meant to be used as a stream of data, which is not
what IIO was made for. Plus, if you start exporting accelerometers as
IIO, how will the DE differentiate between the DS4 accelerometer and the
integrated one.

Anyway, that's just my personal opinion that might not matters much if
Dmitry and Jiri want to get rid of accelerometers from the input
subsystem. But I'd say your case should be still considered as an input
node, not as an IIO sensor.

Cheers,
Benjamin


