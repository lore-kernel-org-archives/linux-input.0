From: Alexandre <amergnat@baylibre.com>
Subject: Re: [PATCH 3/3] iio: Add PAT9125 optical tracker sensor
Date: Tue, 16 Apr 2019 14:54:05 +0200
Message-ID: <79862457-ac69-06bd-17e3-571fc763534b@baylibre.com>
References: <1554456870-8104-1-git-send-email-amergnat@baylibre.com>
 <1554456870-8104-4-git-send-email-amergnat@baylibre.com>
 <20190407112024.6297cbfa@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190407112024.6297cbfa@archlinux>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hello Jonathan,

On 4/7/19 12:20, Jonathan Cameron wrote:
> Hi Alexandre,
>
> So I have no problem with this as an IIO driver, but for devices that
> are somewhat 'on the edge' I always like to get a clear answer to the
> question: Why not input?
>
> I would also argue that, to actually be 'useful' we would typically need
> some representation of the 'mechanicals' that are providing the motion
> being measured.  Looking at the datasheet this includes, rotating shafts
> (side or end on), disk edges and flat surface tracking (mouse like).
>
> That's easy enough to do with the iio in kernel consumer interface. These
> are similar to when we handle analog electronic front ends.
>
> I you can, please describe what it is being used for in your application
> as that may give us somewhere to start!
>
> + CC Dmitry and linux-input.

I developed this driver to detect the board movement which can't be 
detected by accelerometer (very slow motion). I admit this use case can 
be handled by an input, and I'm agree with you, PAT9125 driver could be 
an input. But, like you said, this chip is able to track different kind 
of motion, and additionally have an interrupt GPIO, so using it like 
input limit the driver potential. This chip is designed to work in 
industrial measurement or embedded systems, and the IIO API match with 
these environments, so it's the best way to exploit the entire potential 
of this chip.

As I understand (from 
https://www.kernel.org/doc/html/v4.12/input/event-codes.html#mice ), 
mouse driver must report values when the device move. This feature 
souldn't be mandatory for an optical tracker driver, specially for cases 
where user prefers to use buffer or poll only when he need data.

> If 1 or 2, I would suggest that you provide absolute position to
> Linux.  So add the value to a software counter and provide that.
> 32 bits should be plenty of resolution for that.
I can't provide absolute position, only relative. Do you mean using 
input driver to do that ? If not, how is built the position data?

> Silly question for you.  What happens if you set the delta values to 0?
> Do we get an interrupt which is effectively data ready?
> If we do, you might want to think about a scheme where that is an option.
> As things currently stand we have a confusing interface where changing this
> threshold effects the buffered data output.   That should only be the
> case if this interface is for a trigger, not an event.

I'm not sure to understand your question. Is it possible to read delta_x 
and delta_y = 0 in special/corner case because internal value continue 
to be updated after toggled motion_detect pin (used for IRQ) until 
values registers are read and then motion_detect pin is released:

  * Chip move (i.e. +2 on X axis and 0 on Y axis)
  * Motion_detect IRQ trigger and internal reg value is updated (i.e.
    delta_x = 2 and delta_y = 0)
  * GPIO IRQ handled but read_value isn't executed yet (timing reason)
  * Chip move back to it origin point (i.e. -2 on X axis and 0 on Y axis)
  * Motion_detect IRQ still low because it hasn't been reset by read
    value and internal reg value is updated (i.e. delta_x = 0 and
    delta_y = 0)
  * Read_value is executed, we get delta values = 0.

> If it is actually not possible to report the two channels separately
> then don't report them at all except via the buffered interface and
> set the available scan masks so that both are on.
I found a way to keep the consistency between delta x and delta y 
(without losing data). The first part is to reset a value only when user 
read it (also when it's buffered). The second part is to add the new 
value to the old value. With these two mechanism, X and Y will always be 
consistent:

  * as possible during a move.
  * perfectly when move is finished.


Regards,

Alexandre
