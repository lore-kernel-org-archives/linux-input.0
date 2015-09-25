From: Mike Mestnik <cheako-2RaclcuBPGKiK054olCwYw@public.gmane.org>
Subject: Re: [PATCH] Asus T300CHI.
Date: Fri, 25 Sep 2015 11:40:13 -0500
Message-ID: <CAF8px55s9Gk-DS9HB1ERQ8ZXD7o-OL00Meq5T65yoCO0_mskAA@mail.gmail.com>
References: <CAF8px547WhBsfmV8K8OLbqTbADWbu0sD1jUjrGEPHVZfEzrP6w@mail.gmail.com>
	<CAEnQRZAX1=Y4SaOrpfbWRLR1kYmNKJjeKKouS6pkeb2BBDzr-g@mail.gmail.com>
	<CAF8px56ehuZxcP9EJ3d+M68CdYJKdkiaRs_g1+S8euiFKA5pkA@mail.gmail.com>
	<55FF0433.6050900@kernel.org>
	<1442788960.1030.11.camel@hadess.net>
	<20150921142604.GA12821@localhost>
	<56005E7A.9060304@kernel.org>
	<20150924155704.GA6388@localhost>
	<1443190753.3825.5.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443190753.3825.5.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, Daniel Baluta <daniel.baluta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Fri, Sep 25, 2015 at 9:19 AM, Srinivas Pandruvada
<srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> On Thu, 2015-09-24 at 10:57 -0500, Mike Mestnik wrote:
>> On Mon, Sep 21, 2015 at 2:46 PM, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> wrote:
>> > On 21/09/15 15:26, Mike Mestnik wrote:
>> > > On Sep 20, 2015 5:42 PM, "Bastien Nocera" <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
>> > > wrote:
>> > > >
>> > > > On Sun, 2015-09-20 at 20:08 +0100, Jonathan Cameron wrote:
>> > > > > On 19/09/15 20:03, Mike Mestnik wrote:
>> > > > > > On Sat, Sep 19, 2015 at 1:48 PM, Daniel Baluta <
>> > > > > > daniel.baluta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > > > > > > On Fri, Sep 18, 2015 at 12:07 AM, Mike Mestnik <
>> > > > > > > cheako-2RaclcuBPGKiK054olCwYw@public.gmane.org> wrote:
>> > > > > > > > Hello,
>> > > > > > > >   I'm looking to know the result of adding ACPI support
>> > > > > > > > for a
>> > > > > > > > new
>> > > > > > > > tablet, the existing support shouldn't work because of
>> > > > > > > > a
>> > > > > > > > misplaced
>> > > > > > > > __init that causes the function to be removed prior to
>> > > > > > > > being
>> > > > > > > > called.
>> > > > > > >
>> > > > > > > Are you sure about this? It seems that the existing
>> > > > > > > support
>> > > > > > > doesn't work
>> > > > > > > because you have different product ids.
>> > > > > > >
>> > > > > > The driver worked much better prior to me adding the
>> > > > > > product ids.
>> > > > > >  The
>> > > > > > sensors were exposed to sysfs and all the data they
>> > > > > > collected
>> > > > > > seemed
>> > > > > > correct to me.  The big issue is that there is no software,
>> > > > > > even
>> > > > > > iio-sensor-proxy didn't know how to access the data.
>> > > > > Cc'd Bastien Nocera.
>> > > >
>> > > > iio-sensor-proxy not finding the sensor, and with it working
>> > > > otherwise,
>> > > > would be an iio-sensor-proxy bug. I have one of those already
>> > > > for the
>> > > > accelerometer in the WinBook TW100 that I haven't had time to
>> > > > root down
>> > > > though. See:
>> > > > https://github.com/hadess/iio-sensor-proxy/issues/39
>> > > >
>> > > > The main problem being that sensor types are already hard to
>> > > > detect,
>> > > > and the iio subsystem doesn't make it any easier to check
>> > > > whether
>> > > > there's buffered output available, or the application needs to
>> > > > poll.
>> > I dispute this one.  It's not exactly hard to check for the buffer
>> > directory in sysfs and to evaluate if there is a trigger provided
>> > by
>> > the device (again a simple directory presence check).
>> > It gets harder if there is more than one trigger provided, but
>> > inherently
>> > there isn't much we can do to suggest the best one.  If there are
>> > two
>> > then there are two usecases that demand different choices.
>> >
>> > > >
>> > > > If anyone wants to fix that in the kernel, that would certainly
>> > > > make my
>> > > > life easier.
>> > > >
>> > > I only kind of understand the reasoning for iio, but for the case
>> > > of
>> > > devices used for instructing application behaviour I can't help
>> > > but think
>> > > this would be better served using/extending input events.
>> > Indeed, the IIO side of things is about providing generic support
>> > for lots of use cases whereas in your case you are looking at
>> > something
>> > which is naturally quite specific.
>> >
>> I just found a copy of this driver in the input tree:
>> drivers/input/misc/mpu3050.c
> This was done in 2011 time frame, when IIO was still in staging, I
> guess.
> Using input driver is not good idea as we need some special sysfs
> entries for control.
It has a configurable trigger and several power levels depending on
the events needing to be generated.

> There was some proposal for IIO input driver bridge.
>
Testing for this driver isn't as promising as the iio.  I'm getting a
better feel for talking to this device and implementing the hardware
side of a driver.  Though I've no direction for implementing the
userspace api, see below.

> Thanks,
> Srinivas
>
>> Perhaps "indexing" drivers by userspace API is the wrong approach as
>> it's logical that a device my be accessible from userspace via
>> multiple APIs and applicable for lots of reasons.  Splinting drivers
>> into directories because of how userspace communicates with the
>> driver
>> is just asking for duplication or problems with bringing in the
>> appropriate code.
>>
>> > >
>> > > That would seam to cover the above issues, in exchange for having
>> > > to add
>> > > support for a few new tricks.
>> > >
>> > > 1. An axis where max and min are actually one 'step' apart.
>> > > 2. Double axis for xyz, 6 instead of 3.  Perhaps this can be
>> > > handled with
>> > > extra event nodes, but then there may be sync issues.
>>
>> At first glance it seems that these are still outstanding, needing a
>> proposed userspace API.
