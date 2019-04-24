From: Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH 3/3] iio: Add PAT9125 optical tracker sensor
Date: Wed, 24 Apr 2019 13:10:09 +0100
Message-ID: <20190424131009.00000d36@huawei.com>
References: <1554456870-8104-1-git-send-email-amergnat@baylibre.com>
        <1554456870-8104-4-git-send-email-amergnat@baylibre.com>
        <20190407112024.6297cbfa@archlinux>
        <f8ffca5b-09a8-cad7-4561-bf1263388228@baylibre.com>
        <20190422094236.537e3a01@archlinux>
        <327a56e4-66d8-859c-7f35-458b533ac72f@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <327a56e4-66d8-859c-7f35-458b533ac72f@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre <amergnat@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, robh+dt@kernel.org, mark.rutland@arm.com, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, baylibre-upstreaming@groups.io, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 23 Apr 2019 10:57:40 +0200
Alexandre <amergnat@baylibre.com> wrote:

Hi Alexandre,

> Hi Jonathan,
> 
> On 4/22/19 10:42, Jonathan Cameron wrote:
> > On Tue, 16 Apr 2019 14:49:19 +0200
> > Alexandre <amergnat@baylibre.com> wrote:
> >  
> >> Hello Jonathan,
> >>
> >> On 4/7/19 12:20, Jonathan Cameron wrote:  
> >>> Hi Alexandre,
> >>>
> >>> So I have no problem with this as an IIO driver, but for devices that
> >>> are somewhat 'on the edge' I always like to get a clear answer to the
> >>> question: Why not input?
> >>>
> >>> I would also argue that, to actually be 'useful' we would typically need
> >>> some representation of the 'mechanicals' that are providing the motion
> >>> being measured.  Looking at the datasheet this includes, rotating shafts
> >>> (side or end on), disk edges and flat surface tracking (mouse like).
> >>>
> >>> That's easy enough to do with the iio in kernel consumer interface. These
> >>> are similar to when we handle analog electronic front ends.
> >>>
> >>> I you can, please describe what it is being used for in your application
> >>> as that may give us somewhere to start!
> >>>
> >>> + CC Dmitry and linux-input.  
> >> I developed this driver to detect the board movement which can't be
> >> detected by accelerometer (very slow motion). I admit this use case can
> >> be handled by an input, and I'm agree with you, PAT9125 driver could be
> >> an input. But, like you said, this chip is able to track different kind
> >> of motion, and additionally have an interrupt GPIO, so using it like
> >> input limit the driver potential. This chip is designed to work in
> >> industrial measurement or embedded systems, and the IIO API match with
> >> these environments, so it's the best way to exploit the entire potential
> >> of this chip.
> >>
> >> As I understand (from
> >> https://www.kernel.org/doc/html/v4.12/input/event-codes.html#mice ),
> >> mouse driver must report values when the device move. This feature
> >> souldn't be mandatory for an optical tracker driver, specially for cases
> >> where user prefers to use buffer or poll only when he need data.
> >>  
> >>> If 1 or 2, I would suggest that you provide absolute position to
> >>> Linux.  So add the value to a software counter and provide that.
> >>> 32 bits should be plenty of resolution for that.  
> >> I can't provide absolute position, only relative. Do you mean using
> >> input driver to do that ? If not, how is built the position data?  
> > Sorry, I should have been clearer on this.
> > I mean absolute relative to the start point.  So on startup you assume
> > absolute position is 0 and go from there.  What I can't work out is
> > if the device does internal tracking, or whether each time you read
> > it effectively resets it's internal counters to 0 so the next measurement
> > is relative to the previous one.  
> Each time you read that reset internal counters to 0.
> >>> Silly question for you.  What happens if you set the delta values to 0?
> >>> Do we get an interrupt which is effectively data ready?
> >>> If we do, you might want to think about a scheme where that is an option.
> >>> As things currently stand we have a confusing interface where changing this
> >>> threshold effects the buffered data output.   That should only be the
> >>> case if this interface is for a trigger, not an event.  
> >> I'm not sure to understand your question. Is it possible to read delta_x
> >> and delta_y = 0 in special/corner case because internal value continue
> >> to be updated after toggled motion_detect pin (used for IRQ) until
> >> values registers are read and then motion_detect pin is released:
> >>
> >>    * Chip move (i.e. +2 on X axis and 0 on Y axis)
> >>    * Motion_detect IRQ trigger and internal reg value is updated (i.e.
> >>      delta_x = 2 and delta_y = 0.
> >>    * GPIO IRQ handled but read_value isn't executed yet (timing reason)
> >>    * Chip move back to it origin point (i.e. -2 on X axis and 0 on Y axis)
> >>    * Motion_detect IRQ still low because it hasn't been reset by read
> >>      value and internal reg value is updated (i.e. delta_x = 0 and
> >>      delta_y = 0)
> >>    * Read_value is executed, we get delta values = 0.  
> > Again, I was unclear.  Is it possible to set the device to interrupt
> > every time it evaluates whether motion has occured? Not only when it
> > concludes that there has been some motion.  That would allow the interrupt
> > to be used as a signal that the device has taken a measurement (data
> > ready signal in other sensors).
> >  
> I don't know, the datasheet don't describe the role of each bit in 
> registers and I don't found documentation which provide that. I had to 
> do research on example code to retrieve some bits, but got nothing on 
> motion detection pin configuration.

That kind of rules out reporting this as a speed as we can't guarantee
when the last read occurred. Oh well, was a bit optimistic!

> 
> >>> If it is actually not possible to report the two channels separately
> >>> then don't report them at all except via the buffered interface and
> >>> set the available scan masks so that both are on.  
> >> I found a way to keep the consistency between delta x and delta y
> >> (without losing data). The first part is to reset a value only when user
> >> read it (also when it's buffered). The second part is to add the new
> >> value to the old value. With these two mechanism, X and Y will always be
> >> consistent:
> >>
> >>    * as possible during a move.
> >>    * perfectly when move is finished.  
> > Ah. This adding old value to a new value point is what I was getting
> > at (I think) with 'absolute' position above.
> >
> > In industrial control for example you have absolute position by using
> > limit switches to set your baseline.  Measurement devices are then
> > capable of either reporting relative position, which is the movement
> > since the last reading was taken, or 'absolute' position which is
> > referenced to some known point.  It was this form of absolute position
> > that I was suggesting you use.  If you use such a system without a
> > limit switch it is normally called unreference motion.  You can do
> > it but then the 0 is where ever your device was at power on.
> > For some systems it doesn't actually matter (conveyor belts for
> > instance where the positions you care about are between things
> > on the belt, not the position of the belt itself).  
> 
> Ok, I decided to return delta between last read/buffering to stay closer 
> to the hardware mechanism and still coherent with "IIO_CHAN_INFO_RAW". 
> If user want absolute position, he can make an addition of all received 
> value in user space, and that allow him to reset/replace the initial 
> position when he want it.
Hmm. Unfortunately this doesn't really map to the expectations of
userspace in IIO.  This particular option is neither position nor speed,
but rather a delta position.  For that we don't really have a current
representation.  There is also not guarantee that you don't have multiple
concurrent readers.  If that happens you will get a delta against something
unknown.

I think you need to do the addition in kernel to be able to provide
userspace with something consistent.

Jonathan
> 
> > Thanks,
> >
> > Jonathan
> >  
> >>
> >> Regards,
> >>
> >> Alexandre
> >>  
> 
> Thanks for your comments,
> 
> Alexandre
> 
