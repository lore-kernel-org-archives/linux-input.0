From: Roderick Colenbrander <roderick@gaikai.com>
Subject: Re: [PATCH 1/2] HID: sony: Adjust value range for motion sensors
Date: Thu, 6 Oct 2016 09:20:27 -0700
Message-ID: <CANndSKmi6aKq6h=VhHW45kLkb1DLKXJOxFuW5fH9i-4Ek1mGKA@mail.gmail.com>
References: <6BB4B6CF-1DB7-4F90-8D7F-558407E57203@gmail.com>
 <AB243ECF-9931-4C76-9E54-A9D15E06C3F4@gmail.com> <dfff4e665925857655866517466a7000.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35073 "EHLO
        mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753148AbcJFQU3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Oct 2016 12:20:29 -0400
Received: by mail-vk0-f52.google.com with SMTP id 192so22529046vkl.2
        for <linux-input@vger.kernel.org>; Thu, 06 Oct 2016 09:20:28 -0700 (PDT)
In-Reply-To: <dfff4e665925857655866517466a7000.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, Frank Praznik <frank.praznik@gmail.com>

On Thu, Oct 6, 2016 at 8:16 AM, Simon Wood <simon@mungewell.org> wrote:
> On Thu, October 6, 2016 8:27 am, Frank Praznik wrote:
>>
>
>>> The motion sensor values are 16-bit, so make the value range match.
>>> It is hard to reach the upper values, but they can be reached. At
>>> least the current accelerometer value of 8192 is very easy to pass.
>>>
>>>
>>
>> Are the gyro values intended to be scaled in any way?  The current
>> min/max values were based on the observed maximum extents of the
>> controller at rest.  With this change the controller at rest will never
>> appear to be turned more than 22.5 degrees in any direction to an
>> application which assumes that the logical extents represent the device
>> at 90 degrees.
>
> Don't forget that the _gyro_ values are a 'rate of turn' ie. 'degrees per
> second'.
>
> Since we're asking questions, I'd love to know more about the time
> stamping of the accel/gyro data as this could improve AHRS/Kalman
> performance significantly.
>
> In the Move we get two sets of accel/gyro data, what's that about?
> Simon
>

The 8192 value range was for the accelerometer, not the gyroscope. The
accelerometer returns force or acceleration, while the gyro as Simon
said gives degrees per second.

I understand why someone at first glance would think it was a gyro,
because it kind of gives an angle. What you see is just the constant
offset from the force of gravity. When you rotate the device, it will
just move to another axes. If you were to do some vector math, the
combined vector should stay constant for slow movements (the
gravitation offset should then be dominant over the dynamic data). You
could use this to basically calibrate the device, if you normalize to
this constant offset.

If you really want to measure orientation, you need to look at the
gyro which is the first 3 axes. However you need to integrate the
values over time to get an angle. You could for example rotate the
device, while collection values to get a sense of the value range. The
total sum would equal 360 degrees. Again this is a kind of userspace
type of calibration.

There is a proper way to calibrate the device, but I can't share any
on that right now. It needs more work to get additional sensor axes in
evdev. It needs more than 16-bit precision (due to precision reasons
related to multiplication and adding of an offset).

I can't say anything about Move, because I'm not familiar with it and
can't disclose anything. I would say pay close attention to the report
data, what you want to know is probably hidden in there.
