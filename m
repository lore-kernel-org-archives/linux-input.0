From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH 1/3] Input: Add new property INPUT_PROP_COMPOSITE
Date: Wed, 23 Aug 2017 15:54:36 +1000
Message-ID: <20170823055436.GA23448@jelly>
References: <20170818020156.23390-1-roderick@gaikai.com>
 <20170818020156.23390-2-roderick@gaikai.com>
 <20170818032454.GA1254@jelly>
 <1DD62093774CEE42AFC16E785A1088049D819097@USCULXMSG08.am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:23214 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbdHWF4u (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Aug 2017 01:56:50 -0400
Content-Disposition: inline
In-Reply-To: <1DD62093774CEE42AFC16E785A1088049D819097@USCULXMSG08.am.sony.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Colenbrander, Roelof" <Roderick.Colenbrander@sony.com>
Cc: "roderick@gaikai.com" <roderick@gaikai.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>

On Tue, Aug 22, 2017 at 11:34:17PM +0000, Colenbrander, Roelof wrote:
> On 08/17/2017 08:25 PM, Peter Hutterer wrote:
> > On Thu, Aug 17, 2017 at 07:01:54PM -0700, Roderick Colenbrander wrote:
> >> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> >>
> >> This new property can be set on subdevices part of a composite
> >> input device. The purpose of the constant is to notify other
> >> kernel components (e.g. joydev) and user space that a device is
> >> a composite device.
> >>
> >> Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
> >> ---
> >>   Documentation/input/event-codes.rst    | 12 ++++++++++++
> >>   include/uapi/linux/input-event-codes.h |  1 +
> >>   2 files changed, 13 insertions(+)
> >>
> >> diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
> >> index a8c0873..d56a32e 100644
> >> --- a/Documentation/input/event-codes.rst
> >> +++ b/Documentation/input/event-codes.rst
> >> @@ -356,6 +356,18 @@ can report through the rotational axes (absolute and/or relative rx, ry, rz).
> >>   All other axes retain their meaning. A device must not mix
> >>   regular directional axes and accelerometer axes on the same event node.
> >>   
> >> +INPUT_PROP_COMPOSITE
> >> +--------------------
> >> +
> >> +The functionality of some advanced input devices is exposed through several
> >> +event devices. For example a gamepad with motion sensors could be exposed as
> >> +a gamepad device with axes / buttons and a separate motion sensor device.
> >> +
> >> +The INPUT_PROP_COMPOSITE flag is set on all sub devices making up a larger
> >> +composite device. This flag allows user space applications in addition to
> >> +other kernel drivers (e.g. joydev) to easily determine whether a device
> >> +is part of a composite device.
> > 
> > honestly, I would love for this to be paired with an ioctl that can give me
> > the sysnames of the other devices. Or (probably safer) just a unique
> > number/string that all composite devices share.
> 
> I agree enumerating composite devices is a pain, which requires looping 
> over all evdev nodes and attempting to stitch them together based on 
> ioctl return info or by manually scanning sysfs. On a sidenote, the 
> process of finding sysfs node for a device as this often needed too for 
> e.g. LEDs and device specific options is tricky too and could use 
> improvements.
> 
> I'm trying to envision how a new ioctl for composite device enumeration 
> would work. Even right now there are already fun race conditions as the 
> composite devices come up in different order just, because they 
> completed initialization at slightly different times.
> 
> Maybe there would be some 'evdev device group' concept with each evdev 
> node storing this unique id. This would map to a unique location in 
> sysfs, which contains the list of devices? The ioctl would just be used 
> to query this id?

I think realistically the device group approach is the only one not prone to
race conditions. It can also easily be added to the udev properties so it's
accessible from userspace. I don't think a sysfs location to have a list of
device is feasable, it's a lot easier to just export this and let the
client cobble it back together.

As soon as you try to provide a list, you're likely running into similar
race conditions.

> > That way I can reassemble this in userspace. We already do something like
> > this for the libinput device groups and I think just having the input
> > property isn't quite enough. We can already guess a lot of this from the
> > PHYS attributes but there are several devices where having this filled by
> > the kernel is going to be useful. Wacom devices for example where the pen
> > and touch device don't share the same pid.
> 
> I'm not too familiar with the Wacom devices, the composite device show 
> up as different devices on a bus (e.g. USB / Bluetooth / ..) or is there 
> a single physical device, but the driver somehow exposes different sub 
> devices through some vendor specific method?

it's one big physical device, but internally it's two devices (touch and
the tablet), and the tablet is usually on two evdev nodes (pen and pad).
On some devices the touch has a different pid.

right now libinput creates a device group based on the PHYS string we get
back with minor modifications. That usually contains the pid/vid but we have
libwacom, so we can modify the pid for the tablet device to match the touch
and everything is some value of happy again.

it's a fairly simple approach, see the mirror here:
https://github.com/wayland-project/libinput/blob/master/udev/libinput-device-group.c

> > Right now, it's a bit too simple - all this flag gives me is the
> > notification that I have to start looking for other devices. Works fine with
> > one composited device connected, but once you look at more than that it
> > doesn't seem to be overly useful.
> 
> I understand a more sophisticated solution is desired and we don't help 
> creating that. For us the original problem was that we expose dualshock 
> 3 / 4 subdevices in recent kernels for which the subdevices got picked 
> up by joydev. We proposed code to limit accelerometer devices, but 
> during review it was felt that the code didn't narrow it down enough. We 
> felt joydev would cause issues for users and then recently we had this 
> reddit thread 
> (https://www.reddit.com/r/linux_gaming/comments/6rxhj8/what_happened_with_the_dualshock_4_and_the_new/) 
> with complaining users (SDL2 we took care of last year, but they still 
> haven't released 2.0.6 yet). Since 4.13 or 4.14 will be used in a lot of 
> upcoming distributions, we like to consider at least getting this 
> initial part in, if it is considered to be a stepping stone towards the 
> full solution of adding an ioctl as well.

well, the thing is, if we add something like EVIOCGGROUP, then we don't need
an additional property. So I'm not sure we should double up here.

Cheers,
   Peter

> >> +
> >>   Guidelines
> >>   ==========
> >>   
> >> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> >> index 1798910..da3fa83 100644
> >> --- a/include/uapi/linux/input-event-codes.h
> >> +++ b/include/uapi/linux/input-event-codes.h
> >> @@ -26,6 +26,7 @@
> >>   #define INPUT_PROP_TOPBUTTONPAD		0x04	/* softbuttons at top of pad */
> >>   #define INPUT_PROP_POINTING_STICK	0x05	/* is a pointing stick */
> >>   #define INPUT_PROP_ACCELEROMETER	0x06	/* has accelerometer */
> >> +#define INPUT_PROP_COMPOSITE		0x07	/* is part of a composite device */
> >>   
> >>   #define INPUT_PROP_MAX			0x1f
> >>   #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)
> >> -- 
> >> 2.9.4
> > 
> > 
> 
> 
