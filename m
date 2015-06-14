From: simon@mungewell.org
Subject: Re: [RFC] HID: hid-sony: Add basic iio-subsystem reading of SixAxis
 Accelerometers
Date: Sun, 14 Jun 2015 13:25:15 -0400
Message-ID: <d6702f5d19d2baea80132666fcf7654a.squirrel@mungewell.org>
References: <195dff9bd065db7e618280cb7c6eb5a9.squirrel@mungewell.org>
    <1434034458-1968-1-git-send-email-simon@mungewell.org>
    <557D9564.9090800@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:49148 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbbFNRZR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Jun 2015 13:25:17 -0400
In-Reply-To: <557D9564.9090800@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, Frank Praznik <frank.praznik@oh.rr.com>, linux-iio@vger.kernel.org

Thank you for your comments, I'm just getting started with IIO so it's all
good stuff...

>> +++++++++++++++++++++++++++++++++++++++++++++++++
> Hmm. This driver is already a substantial mash up of a number of different
> types of driver (as far as linux is concerned), with input, battery and
> led
> drivers.  Might be worth considering a more formal MFD approach as it'll
> break the driver up into a number of sub components that will then sit
> in the various subsystems in a cleaner fashion.
> Just a thought!

Might be, but that sounds like more work ;-) If pushing some ideas around
prompts that, it can't be a bad thing.... right?

>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
> If the scale really is 1 then don't export it.  Note the units would
> have to be in m/s^2 which seems unlikely though. I'm guessing this
> is a placeholder..

Yes place holder, different controllers (SixAxis, DS4 and PSMove) have
different values. In the far future I'd hope to use the per-device
calibration stored on the PSMove.

https://github.com/nitsch/moveonpc/wiki/Calibration-data

>> +static const struct iio_chan_spec sony_sixaxis_channels[] = {
>> +	SONY_ACC_CHANNEL(X),
>> +	SONY_ACC_CHANNEL(Y),
>> +	SONY_ACC_CHANNEL(Z),
> No gyro channels yet?
> Just to note, if the gyro frequency etc is different from the
> accelerometer
> (pretty common) then you'll want to register two IIO devices rather than
> just the one so that the control and buffers are separate.

I have a vague memory that the SixAxis has a 1-ch gyro but this is not
showing on hidraw (might be 'hidden' behind MultiTouch ID/Bug).

The DS4 has Accel/Gyros, and the PSMove has Accel/Gyro/Mag. I didn't
expose the mags over input/joystick axis as I didn't want to corrupt
stream the PSMoveAPI (it needs to be re-ordered) and it's unlikely anyone
would actually use via joystick.

The PSMove's report actually contains 2 frames assumed to be 1/2 sample
rate apart for the Accel/Gyro, but only one Mag reading.



I have further advanced the patch to include reading via buffer, but I'm
having trigger 'conceptual' problems getting my head around the HID device
issuing an interrupt when a input report is received. Looking at
iio_dummy_event and iios_sysfs for inspiration....

On the assumption that there will be multiple devices (either same type or
with different HID drivers) all trying to issue triggers, we'd need to be
a little careful.

Is there a 'short-cut' we can use if a HID device is only required to
trigger itself (and not other iio devices)? ie. not need true interrupt
system.

Simon.

