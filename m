From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 2/2] Input: add motion-tracking ABS_* bits and docs
Date: Tue, 8 Nov 2016 16:44:22 +1000
Message-ID: <20161108064422.GA5855@jelly.local>
References: <1475019532-16876-1-git-send-email-roderick@gaikai.com>
 <1475019532-16876-3-git-send-email-roderick@gaikai.com>
 <CAKdAkRTLX3Mvzygnhx3FGYdbpuwu6snOd0TJcO_zY=uHn=msKQ@mail.gmail.com>
 <CANndSKkXNHcToiEg9PTv-SrLNpvDjP8YzZe-azDAs3Ap8b8qNg@mail.gmail.com>
 <20160929072525.GK19261@mail.corp.redhat.com>
 <CANndSK=YAqXcwhjk8Lz-r7Hbykc_bwB4sLsiqRZMvTZVi6zRWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:47054 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752798AbcKHGoi (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2016 01:44:38 -0500
Content-Disposition: inline
In-Reply-To: <CANndSK=YAqXcwhjk8Lz-r7Hbykc_bwB4sLsiqRZMvTZVi6zRWg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>, Input Tools <input-tools@lists.freedesktop.org>, Roderick Colenbrander <roderick.colenbrander@sony.com>, Jonathan Cameron <jic23@kernel.org>, Nathaniel Lewis <nlewis@gaikai.com>

On Mon, Nov 07, 2016 at 07:24:15PM -0800, Roderick Colenbrander wrote:
> On Thu, Sep 29, 2016 at 12:25 AM, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > On Sep 28 2016 or thereabouts, Roderick Colenbrander wrote:
> > > On Wed, Sep 28, 2016 at 10:39 AM, Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > >
> > > > On Tue, Sep 27, 2016 at 4:38 PM, Roderick Colenbrander
> > > > <roderick@gaikai.com> wrote:
> > > > > From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> > > > >
> > > > > This patch introduces new axes for acceleration and angular velocity.
> > > > > David Herrmann's work served as a base, but we extended the specification
> > > > > with various changes inspired by real devices and challenges we see
> > > > > when doing motion tracking.
> > > > >
> > > > > - Changed unit of acceleration to G instead of m/s^2. We felt that m/s^2
> > > > >   is not the appropriate unit to return, because accelerometers are most
> > > > >   often calibrated based on gravity. They return values in multiples of
> > > > >   G and since we don't know the device location on earth, we should not
> > > > >   blindly multiply by '9.8' for accuracy reasons. Such conversion is left
> > > > >   to userspace.
> > > > > - Resolution field is used for acceleration and gyro to report precision.
> > > > >   The previous spec, specified to map 1 unit to e.g. 0.001 deg/s or 0.001 m/s^2.
> > > > >   This is of course simpler for applications, but unit definition is a bit
> > > > >   arbitrary. Previous axes definitions used the resolution field, which
> > > > >   felt more consistent.
> > > > > - Added section on timestamps, which are important for accurate motion
> > > > >   tracking purposes. The use of MSC_TIMESTAMP was recommended in this
> > > > >   situation to get access to the hardware timestamp if available.
> > > > > - Changed motion axes to be defined as a right-handed coordinate system.
> > > > >   Due to this change the gyro vectors are now defined as counter-clockwise.
> > > > >   The overall changes makes the definitions consistent with computer graphics.
> > > > >
> > > > > [PATCH 4/4] Input: add motion-tracking ABS_* bits and docs
> > > > > David Herrmann <dh.herrmann@gmail.com>
> > > > > Tue Dec 17 07:48:54 PST 2013
> > > > >
> > > > > Motion sensors are getting quite common in mobile devices. To avoid
> > > > > returning accelerometer data via ABS_X/Y/Z and irritating the Xorg
> > > > > mouse-driver, this adds separate ABS_* bits for that.
> > > >
> > > > We have IIO for motions sensors that are not strictly human input
> > > > devices; I believe there is also IIO->input bridge where generic IIO
> > > > sensors could be mapped to input device if they are supposed to be
> > > > used as such in given product.
> > > >
> > >
> > > If we decide to move forward in the direction proposed by this patch,
> > > the spec could be updated
> > > to limit the scope a bit or to make it wider.
> > >
> > >
> > > > >
> > > > > This is needed if gaming devices want to report their normal data plus
> > > > > accelerometer/gyro data. Usually, ABS_X/Y are already used by analog
> > > > > sticks, so need separate definitions, anyway.
> > > >
> > > > I am not sure if this direction is sustainable. We can't keep adding
> > > > more and more ABS axes every time we add another control to something
> > > > that is basically a composite device. What if you add another stick?
> > > > Magnetometer? Some other sensor?
> > > >
> > > > I think the only reasonable way it to come up with a notion of
> > > > "composite" input device consisting of several event nodes and have
> > > > userspace "assemble" it all together.
> > > >
> > >
> > > In our case we are interested in the motion functionality for some devices
> > > with drivers already in the kernel, which we want to extend over time with
> > > improved capabilities.
> > >
> > > I understand your concerns about the scalability of ABS axes in general.
> > > If someone were to come up with some crazy flight simulator joystick with many
> > > weird axes, do you then add an ABS_X2, ABS_X3 etcetera? Similar what if
> > > a controller for whatever reasons shipped with multiple gyroscopes,
> > > accelerometers,
> > > magnetic sensor, heartrate sensors etcetera?
> > >
> > > A composite device would on the other hand be more of a pain for the different
> > > userland APIs ranging from libinput, SDL2, Android and other embedded
> > > platforms. It
> >
> > That's already what we are doing for Wacom tablets (and some other
> > devices) both in the kernel and in libinput. Wacom digitizers are
> > exposed through 3 different device on average, one for the pen, one for
> > the touch and one for the buttons on the pad. Libinput then relies on
> > the notion of device group (a udev property) which can be tweaked when
> > the heuristic fails (through libwacom mainly).
> >
> > Basically, libinput is not much of an issue, especially because we
> > ignore accel, gyro, and other weird axis, and because we already know
> > how to group composite devices.
> >
> > For the others, yes, it'll be a pain. But only if there is an actual need of
> > grouping. If the sensors are the ones of the phone itself, having one or
> > several input nodes doesn't hurt that much. If the sensors are coming
> > from gamepads, then yes, there is a need for grouping, but hopefully the
> > device path should provide some good heuristic.
> >
> 
> How are you currently ignoring accel, gyro and others axes? The main
> concern I have is how to express the axes and how does userspace
> detect these?

libinput supports traditional input devices only, so we can simply ignore
anything that looks like an accelerometer, i.e. INPUT_PROP_ACCELEROMETER.
it's that easy ;)
 
> One of the examples I saw is the Wii driver, which supports accel,
> gyro and others. It exposes both accel and gyro data through
> ABS_RX/_RY/_RZ and adds "Accelerometer" or "Motion Plus" to the name.
> In my opinion, applications shouldn't rely on string parsing for this
> stuff. Not sure if I agree with using axes which were originally
> intended for rotational exes for acceleration instead of just
> ABS_X/_Y/_Z, though for gyro they would make sense.
> 
> On the other hand Wacom sets 'INPUT_PROP_ACCELEROMETER' and reports
> acceleration data through ABS_X/_Y/_Z. This feels more reasonable to
> me as originally ABS_X/_Y/_Z where meant for horizontal displacements.
> 
> There are probably some other examples as well. I'm trying to figure
> what direction would make sense moving forward. I'm starting to accept
> the need for composite devices. Questions:
> - What axes to use for accel? Should this be X/Y/Z or RX/RY/RZ, as I
> showed there is no real standard.

please use x/y/z with the INPUT_PROP_ACCELEROMETER. See the doc for that
property in Documentation/input/event-codes.txt 
The rx/ry/rz are historical baggage, let's not use that for new
implementations.

> - What axes to use for gyro? I think we would need an additional
> INPUT_PROP_GYROSCOPE.

I'd probably go for INPUT_PROP_ACCELEROMETER with rx/ry/rz set and
documenting it as such, but not 100% sure here.

> For any of these axes should there be some sort of standard on
> increments per unit. Originally ABS_X apparently was in units/mm and
> ABS_RX in units/radian. Though most of the time actual units are
> unknown... but it is also a pain for applications to know about every
> device.

fwiw, ABS_X is still interpreted as units/mm for all flat devices. I'd
consider anything else a bug.

Cheers,
   Peter

> > > would be quite an extensive change. How would they even do the
> > > stitching? You could
> > > handle this through sysfs (not my favorite way) or maybe have a notion
> > > of a 'master'
> > > device being the current event node and some way to enumerate 'sensor'
> > > nodes or something.
> >
> > A simple udev property solves most of the grouping issues (based on the
> > sysfs path mostly).
> >
> > The thing is currently, we are aware that the situation is not
> > satisfying, and we are seeing the limit of the ABS axis declarations. We
> > can find solutions (or workarounds) that works well enough, and adding
> > ABS_MAX2 might not be the best solution long term: especially because of
> > the slotted protocol inside ABS that messes things quite a bit.
> >
> > If we were to expand to ABS_MAX2, in order to avoid conflicts with the
> > slotted protocol, we would need to reserve quite a few axis after
> > ABS_MAX for this purpose. But we can't say how many will be required.
> >
> > Cheers,
> > Benjamin
> >
