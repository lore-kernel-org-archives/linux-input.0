From: Ludovic Desroches <ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH 12/14] iio: adc: at91-sama5d2_adc: support for position
 and pressure channels
Date: Mon, 8 Jan 2018 15:12:52 +0100
Message-ID: <20180108141252.GC2425@rfolt0960.corp.atmel.com>
References: <1513955241-10985-1-git-send-email-eugen.hristev@microchip.com>
 <1513955241-10985-13-git-send-email-eugen.hristev@microchip.com>
 <20171229170236.06bf6394@archlinux>
 <25045512-f372-3f25-e84f-ed809db9dde3@microchip.com>
 <20180106150537.684345f3@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180106150537.684345f3@archlinux>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>, nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, ludovic.desroches-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Jonathan, Eugen,

On Sat, Jan 06, 2018 at 03:05:37PM +0000, Jonathan Cameron wrote:
> On Thu, 4 Jan 2018 17:17:54 +0200
> Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org> wrote:
> 
> > On 29.12.2017 19:02, Jonathan Cameron wrote:
> > > On Fri, 22 Dec 2017 17:07:19 +0200
> > > Eugen Hristev <eugen.hristev-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org> wrote:
> > >   
> > >> The ADC IP supports position and pressure measurements for a touchpad
> > >> connected on channels 0,1,2,3 for a 4-wire touchscreen with pressure
> > >> measurement support.
> > >> Using the inkern API, a driver can request a trigger and read the
> > >> channel values from the ADC.
> > >> The implementation provides a trigger named "touch" which can be
> > >> connected to a consumer driver.
> > >> Once a driver connects and attaches a pollfunc to this trigger, the
> > >> configure trigger callback is called, and then the ADC driver will
> > >> initialize pad measurement.
> > >> First step is to enable touchscreen 4wire support and enable
> > >> pen detect IRQ.
> > >> Once a pen is detected, a periodic trigger is setup to trigger every
> > >> 2 ms (e.g.) and sample the resistive touchscreen values. The trigger poll
> > >> is called, and the consumer driver is then woke up, and it can read the
> > >> respective channels for the values : X, and Y for position and pressure
> > >> channel.
> > >> Because only one trigger can be active in hardware in the same time,
> > >> while touching the pad, the ADC will block any attempt to use the
> > >> triggered buffer. Same, conversions using the software trigger are also
> > >> impossible (since the periodic trigger is setup).
> > >> If some driver wants to attach while the trigger is in use, it will
> > >> also fail.
> > >> Once the pen is not detected anymore, the trigger is free for use (hardware
> > >> or software trigger, with or without DMA).
> > >> Channels 0,1,2 and 3 are unavailable if a touchscreen is enabled.
> > >>
> > >> Some parts of this patch are based on initial original work by
> > >> Mohamed Jamsheeth Hajanajubudeen and Bandaru Venkateswara Swamy
> > >>  
> > > OK, so comments inline.
> > > 
> > > What I'm missing currently though is an explanation of why the slightly
> > > more standard arrangement of using a callback buffer doesn't work here.
> > > The only addition I think you need to do that is to allow a consumer to
> > > request a particular trigger.  I also think some of the other provisions
> > > could be handled using standard features and slightly reducing the flexibility.
> > > I don't know for example if it's useful to allow other channels to be
> > > read when touch is not in progress or not.
> > > 
> > > So restrictions:
> > > 
> > > 1. Touch screen channels can only be read when touch is enabled.
> > >   - use the available_scan_masks to control this. Or the callback that lets
> > >     you do the same dynamically.
> > > 2. You need to push these channels to your consumer driver.
> > >   - register a callback buffer rather than jumping through the hoops to
> > >     insert your own pollfunc.  That will call a function in your
> > >     consumer, providing the data from the 3 channels directly.
> > > 3. You need to make sure it is using the right driver.  For that you
> > >     will I think need a new interface.
> > > 
> > > Various other comments inline. I may well be missing something as this is
> > > a fair bit of complex code to read - if so then next version should have
> > > a clear cover letter describing why this more standard approach can't be
> > > used.  
> > 
> > Hello Jonathan and thanks for the review of my patch series,
> > 
> > before starting and working over the required modifications and 
> > suggestions that you sent me, I want to be a little more explicit about 
> > the design of my implementation.
> > Hope this will clarify some things, and maybe I can as well understand 
> > better what you have in mind to support this feature set.
> > 
> > Why have I picked a pollfunction: We discussed a while back on the 
> > mailing list that you do not have an inkern mechanism to expose the 
> > triggers to other drivers, and that it may be a good idea to have it for 
> > such kind of actually multi function device, instead of having a MFD 
> > driver, an ADC driver, and an Input driver, all sharing the same 
> > register map, the same IRQ , etc, with some kind of synchronization to 
> > avoid stepping on each other for the hardware resource.
> 
> No disagreement with that principle.
> 
> > So I considered to expose the trigger by attaching and detaching 
> > pollfunctions to it. Which is the main thing what we use a trigger for.
> 
> Hmm. It's definitely one approach. But we do already have other drivers
> where the trigger is controlled by a consumer and to my mind that
> is a cleaner approach as it doesn't short cut the equivalent of
> doing it from userspace.
> 
> drivers/iio/potentiostat/lmp91000.c does something similar though
> for a rather different use. You need your consumer interface
> to get the handle to the trigger in this case
> (the lmp91000 is actually providing the trigger rather than
> consuming it).
> 
> 
> > 
> > So, what I had in mind, was to create a consumer driver that will 
> > request triggers from the IIO device just like other drivers request 
> > channels (part which is already done in IIO).
> > In order to do this I had to somehow wake up the consumer driver when 
> > new data was available from the touchscreen. So, having the IRQ only in 
> > the ADC device, and then on Pen detect and No pen detect just start or 
> > stop the periodic trigger, which needs to be polled. The magic part is 
> > that the consumer driver has a poll function already attached to this 
> > trigger, so the poll function is just called every time we have new 
> > data. The poll function is attached as an irq handler, and then we can 
> > reuse all the read_raw data by using a scheduled work from the consumer 
> > driver, to read the channels.
> 
> If you had done this via a callback buffer the only difference is that
> the pollfunc would have been a standard one pulling the relevant channels
> and passing them on down to the buffer interface which could then decide
> what to do with them.
> 
> > To do this, the ADC registers a special trigger named "touch trigger" 
> > which is never enabled by the ADC driver. Instead, when a pollfunc is 
> > attached to it, the attach function will also configure it with enabled 
> > state.
> 
> Whilst it might not make sense to enable it in the touch screen driver
> I'm not sure there is strictly any reason to prevent it being so used.
> 
> > In the ADC, this means to start the touchscreen functionality. If 
> > the touch is requested, it will standby and wait for pen detect IRQ.
> > Once we have pen detect, we can use a periodic trigger to sample the 
> > touch data, and poll the "touch" trigger. The consumer driver will wake 
> > up and schedule a work , that will use the standard read raw interface 
> > (inkern) that will read three virtual channels (position + pressure). 
> > They are not actual hardware channels, as the touch information is being 
> > received on channels 0,1,2,3, but reading these virtual channels will 
> > read from different registers inside the ADC IP ( x position, y 
> > position, pressure), do some computations on the data, and feed the 
> > consumer with the values , hiding the behind the scenes hardware 
> > specific calculations.
> 
> I wouldn't worry about whether they are real channels or not. This
> is really similar to a differential ADC (some of those do the differential
> digitally). Light sensors often have a number of 'real' channels used
> to derive (via hideous non linear calculations) the illuminance as
> it's hard to build a light sensor with the same sensitivity as the human
> eye.  We have worse 'non real' channels as well such as activity channels
> on some the accelerometers that report if it thinks you are walking /
> running etc.
>  
> > After trigger is polled , the ADC will resume normal functionality, and 
> > the consumer driver will continue to sleep.
> 
> So this is where I'm unsure.  Do you actually have a usecase where it
> makes the sense to read from the ADC only when there is no touch?  Any
> system doing that has an obvious denial of service attack - touch the
> screen.
> 

You're right. We have an issue in this case due to the hardware. Using
touchscreen has side effects on other channels. We can use only one
trigger for all the channels. The situation would have been better with
a trigger dedicated to the touchscreen.

At the moment, we have not really stated about the exclusive use or not
of the touchscreen. We suppose we can get some customers wanting to use
both touchscreen and ADC. Eugen tried to deal with this case but, as you
noticed, it can lead to DoS.

> > We need to have a periodic trigger to sample the data because the actual 
> > analog to digital conversion inside the IP block needs to be triggered. 
> > The touchscreen data measurements cannot happen in hardware without 
> > being triggered. If I try with a hrtimer to get a periodic IRQ to just 
> > read the data, it will never be ready. The datasheet states that the 
> > touchscreen measurements "will be attached to the conversion sequence". 
> > So the periodic trigger is forcing a conversion sequence. This could be 
> > done with a software trigger as well, but why the hassle to start it 
> > every 2 milliseconds (or other time interval), if we can do it by 
> > periodic trigger ?
> 
> Ah, one reason here would be to allow separate consumers to use the
> device. In that case you'd run with a periodic trigger all the time
> and have two buffers attached, the buffer_cb that is feeding your
> touchscreen and another buffer to deal with the other channels
> (presumably the standard one an IIO device has when using buffered
> interfaces).

The issue is that we are sharing the periodic trigger so we have to use
the same period for both usage.

Regards

Ludovic

> 
> The buffer demux would ensure the data from the right channels
> ends up in the right place.  It makes it look to the buffer
> consumer like it is the only thing using / controlling the data
> flow.
> 
> > Once we get the No pen IRQ, we stop the periodic trigger and it can be 
> > used in another purpose (software or external as of now in the driver, 
> > in the future we can add PWM trigger and Timer trigger)
> 
> This case isn't really useful though as any other use is denied
> access when touch occurs.
> 
> I'll summarise what I think would work for this below.
> 
> > 
> > In short, the ADC in Sama5D2 also supports touchscreen, and in 
> > touchscreen mode , 4 of the channels are being used for this purpose. 
> > This however, doesn't stop the ADC to use the other channels . The 
> > hardware has 12 total single channels and they can be paired to have 6 
> > more differential channels. The only thing that is blocked is the 
> > trigger, but only if the pen is touching (when we start the periodic 
> > trigger to sample the touchscreen). If the pen is not touching, an 
> > external trigger or software trigger can be used without any issues (so 
> > why limit the functionality, if this is available from hardware ?). 
> > Because of the reason I discussed above (touchscreen sequence must be 
> > triggered), we cannot use another trigger in the same time.
> > 
> > 
> > I see your idea with the callback buffer and it's worth exploring. 
> > Mainly this series was to actually show you what I had in mind about 
> > supporting the resistive touchscreen, and to give you some actually 
> > working code/patch, so we can discuss based on real implementation, not 
> > just suppositions.
> 
> That side of things is fine.
> 
> > 
> > You are right in many of the other comments that you said, and I will 
> > come up with a v2 to this series. For now, I need to know if this is a 
> > good or right direction in which I am going, or I should try to change 
> > all the mechanism to callback buffer ? Or maybe I am totally in a bad 
> > direction ?
> > The requirements are that the consumer driver needs to be somehow woke 
> > up for every new touch data available, and report to the input 
> > subsystem. As it was done before, the at91 old driver, just creates and 
> > registers an input device by itself, and then reports the position and 
> > touches. I was thinking that with this trigger consumer implementation, 
> > things can be better in terms of subsystem separation and support.
> > 
> > Thanks again and let me know of your thoughts,
> > 
> > Eugen
> 
> So a couple of things come to mind on how I'd structure this.
> So what we have (very briefly)
> 
> No touch screen case:
> * Generic ADC using all sorts of different triggers
> 
> Touch screen only case:
> * Interrupt to indicate pen on / off
> * A need to do a periodic trigger of the device but only
> useful when touch is in progress.
> 
> Touch screen and other users:
> * Interrupt to indicate pen on / off
> * Periodic trigger needed for touchscreen when touch in progress.
> * Do not have denial of service on other channels.
> 
> First two cases are easy enough by having a magic trigger, third
> case is harder.
> If we have the touchscreen then I would drop support for direct access to
> to ADC channels whilst it's in use (so no sysfs - or emulate it if you
> really want it by stashing results from scans done when touch is in
> progress).
> 
> Have your touch screen channels just as normal additional channels,
> but only via the buffered interface (no _RAW attribute).
> If someone sets up to read them via buffered interface with
> a different trigger I think they'll get values - whether they
> are right is dependent (if I understand correctly) on whether
> there is a touch in progress.  So no harm done and it'll make
> the logic simpler.
> 
> The moment touch is opened and acquires the IIO channels
> fix the trigger (may need new interface) to the periodic one
> that you were enabling and disabling on touch.
> Things get dicey if there is an existing user so you may
> have to do it on driver probe rather than open of the input
> device if we effectively want touch to have the highest
> priority use of the ADC.
> 
> If other channels are enabled for buffered mode then note
> this in the driver and have the periodic trigger on all the
> time (to ensure they keep getting read)  This will pass
> garbage to your touch screen driver, but it'll remove it due
> to the pressure value being too low so no harm there.
> 
> Normal path will work for non touch channels (and in theory
> the touch ones if they are turned on) via IIO buffer
> interface.  It'll be restricted in form due to the needs of
> the touch driver, but better than nothing and should cover
> most usecases.
> 
> Now the interrupt on / off on touch bit becomes an optimization
> in the case of only the buffer_cb being attached.
> 
> I think that fits cleanly in the current IIO framework and
> looks more similar to our existing provider consumer approaches.
> 
> Still needs the hooks to get hold of the trigger though so
> as to be able to tell the ADC which one to use. So rather
> than being a trigger consumer interface, it's more of a trigger
> configuration interface..  Exact term doesn't matter though.
> 
> Jonathan
> 
> > 
> > 
> > 
> > [...]
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> > the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
