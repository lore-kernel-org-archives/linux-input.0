From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Event types
Date: Tue, 21 Sep 2010 09:46:47 -0700
Message-ID: <20100921164647.GA8866@core.coreip.homeip.net>
References: <4C964A30.1060801@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47407 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757980Ab0IUQqy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Sep 2010 12:46:54 -0400
Received: by pzk34 with SMTP id 34so1487493pzk.19
        for <linux-input@vger.kernel.org>; Tue, 21 Sep 2010 09:46:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C964A30.1060801@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, Sep 19, 2010 at 06:36:48PM +0100, Jonathan Cameron wrote:
> Hi All,
> 
> We are in the process of cleaning up the event subsystem of IIO.
> As some devices will be used via an input bridge, it makes sense
> to pin down what they would be translated to in input. Note our
> 'readings' that will map to events in input are handled via a
> different patch. There are plenty of drivers to suggest what those
> should map to. We can basically pretend these devices are joysticks
> with several xyz controllers.
> 
> For the sort of direct 'input' types of events - double tap etc
> we can just copy existing drivers.
> 
> Much more common for us though are controllable threshold events.
> In IIO the associated control attributes are named:
> 
> Like <channel>_<limit>_<dir>_<attr>, where
>  <channel>: name of the channel, i.e. accel_x0
>  <limit>:   thresh, mag, roc
>  <dir>:     rising, falling
>  <attr>:    en, value, period, mean_period 
> 
> So taking a typical device (adis16400) we have the following
> actual events
> 
> in_supply_thresh_rising
> in_supply_thresh_falling
> in_supply_roc_rising
> in_supply_roc_falling
> 
> accel_[x|y|z]_thresh_rising
> accel_[x|y|z]_thresh_falling
> accel_[x|y|z]_roc_rising
> accel_[x|y|z]_roc_falling
> 
> gyro_[x|y|z]_thresh_rising
> gyro_[x|y|z]_thresh_falling
> gyro_[x|y|z]_roc_rising
> gyro_[x|y|z]_roc_falling
> 
> magn_[x|y|z]_thresh_rising
> magn_[x|y|z]_thresh_falling
> magn_[x|y|z]_roc_rising
> magn_[x|y|z]_roc_falling
> 
> temp_thresh_rising
> temp_thresh_falling
> temp_roc_rising
> temp_roc_falling
> 
> in0_thresh_rising
> in0_thresh_falling
> in0_roc_rising
> in0_roc_falling
> 
> The _mag_ events are for devices (often accelerometers) which provide an
> interrupt based on the magnitude not the signed value of the relevant channel.
> 
> Note a typical event only has a value attached to it in the sense that we know
> what barrier is crossed.
> 
> So what would such general events map to?  I suppose in some senses they are EV_KEYs
> but which keys?  The only example I have seen is the adxl34x. That uses btn_touch for
> tap events and pdata to specify keys for freefall, orientation and activity.
> 
> In our case I guess the mapping can be provided to the userspace bridge daemon to
> translate all these events into 'magic' keys. Is this the best plan?
> A few clearly don't conventionally make much sense in input (temperature and supply
> voltages would be unusual human interfaces!).

I think that some of the events do map to key action (taps,
orientation). This should preferrably be configurable (so it looks like
we need to plumb EVIOC{S|G}KEYCODE through uinput driver).

Others, such as free fall and activity, are probably not really "keys".
I'd expect such events be handled by an application completely
uninterested in other types of keys and other input events, for example
application that tries to park hard drive in case of fall.

Unfortunately drivers authors at the moment do not have better interface
available and thus try to fit it all into input.

-- 
Dmitry
