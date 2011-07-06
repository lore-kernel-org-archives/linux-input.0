From: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH 01/11] misc: inv_mpu primary header file and README file.
Date: Wed, 06 Jul 2011 10:07:44 +0100
Message-ID: <4E1425E0.2070408@cam.ac.uk>
References: <1309486707-1658-1-git-send-email-nroyer@invensense.com>	<4E0D8E94.5030604@cam.ac.uk>	<4d61a92a11e5d83a1cb0094441ae5f5e@mail.gmail.com>	<4E105284.7030209@cam.ac.uk> <20110704091658.0d4c8e3f@bob.linux.org.uk> <c2189246a279a0e5a1b8599edc94a79a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c2189246a279a0e5a1b8599edc94a79a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nathan Royer <nroyer-ktqnL0SqcGIj5TC/SZClsA@public.gmane.org>
Cc: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Hudson <chudson-F13P06p9YvzQT0dZR+AlfA@public.gmane.org>, eric.andersson-TStm8jYLEPpl57MIdRCFDg@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "Hennerich, Michael" <Michael.Hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>, Manuel Stahl <manuel.stahl-GeUHRtUQU7nSyEMIgutvibNAH6kLmebB@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 07/06/11 02:49, Nathan Royer wrote:
>>>> accel/bma150.c
>>> An input driver exists for that one. (cc'd Eric)
>>
>> [Two input drivers - bma023 which I posted covers it too ;)]
>>
>>>> # sensors - compass
>>>> compass/ak8975.c
>>
>> We have a driver for this (I posted a while back)
>>
>>>> compass/ak8972.c
>>
>>>> compass/ami30x.c
>>
>> AMI304 is identical to the AK8974 which we already have - Gram Hsieh
>> posted patches for this a while ago
> 
> It seems that some sensors are in input and but that most are in iio.
> Obviously I don't want to dissent with both and put ours in misc, so how
> do we make this better? 
Definitely not misc - we don't want to end up with drivers in there purely
because they might fit in two other places!
> Should we work on cleaning this up.  If so should
> we start moving the drivers that are in input to iio.
Will cause all sorts of userspace issues.  a) iio is still in staging
and for good reason.  I really ought to update our todo list!
b) We don't have a transparent way to provide input interfaces for iio
devices - so that will mean mass abi breakge.  There have been some
discussions about how to do this (see Mark Brown's suggestions a month
or so ago), be it for very different reason.

Anyhow, I'm personally in favour of the current divide:
Basically if it's for human input (primarily) it goes in input (decision
on that is Dmitry's). Otherwise, IIO is happy to take drivers that don't
fit elsewhere (we deliberately have very wide scope).
> 
> If this is the right thing to do, I could start working on merging the
> current mpu3050 input interface and our misc interface to the iio
> interface.  I'm still trying to wrap my head around the iio framework, but
> I think one of the things I need is a uinput like interface for iio
> (perhaps it exists, I just haven't figured it out yet).
Nope. Not previously had a use case.
Unlike input we don't have a whole host of userspace code that is expecting to
receive data in a particular format so we don't have the standard use
case for uinput  (cc'd Manuel and Michael who have done a lot more on the userspace
end of IIO than I have + linux-iio for everyone else).  We do have a prototype
uinput based bridge to push event into input.  It is only intended for those rare
cases where someone really wants to use a 1000 dolar IMU as a mouse. Not relevant
here though.

> If the DMP is
err, DMP?
> used, a buffer for the FIFO data would be created, and user space would be
> responsible to push the sensor data back to iio after sensor fusion and
> calibration.  Without the DMP, each sensor driver would act independently
> providing their own raw data.

Strangely enough, your need to push data back is not dissimilar to what we have
discussed in the past for DACs. Right now we only have a slow and simple interface
for DACs, mainly because doing anything clever requires some fairly nasty additions
to the host bus drivers and no one has had the time.  Michael has almost
certainly thought more on this than I ever have!
> 
> We still need a way to read and write registers and DMP memory during
> runtime from user space.
I guess the DMP is the on device processor? So what you write varies a lot
with what firmware is loaded?

So let me just check I understand the data flow here.

Example

Magnetometer -> kernel -> userspace interface -> hideously complex algorithm ->
kernel -> mpu -> mpu fusion algorithm in relevant firmware -> userspace ?

So how do we know the mpu wants data?  Obvious options that might be the case
a) on chip fifo with flow control.
b) interrupt to request data?
c) Always feed latest value and it runs unsynchronised.

Do we actually have that hideously complex algorithm in userspace element
or did I invent that part?  If not, we might want to use some in kernel
hooks to pass the data back bypassing userspace entirely.

Jonathan 
