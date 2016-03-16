From: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Subject: Re: Handling of non-positional data through evdev
Date: Wed, 16 Mar 2016 23:51:48 +0100
Message-ID: <CAM4jgCo4DTBU8W4DM3cE=yNhcPidufrURXbBtAzt-KM=CTQPZg@mail.gmail.com>
References: <CAEc3jaB2KOUoymz3BL6Bc7_vv3bTHadBqGM9YLHyt_GeVkOtng@mail.gmail.com>
	<1458082753.4785.27.camel@hadess.net>
	<CAEc3jaA_EnhbNChXAStdqDik9YMfWYXzfHQbOgEb=TXmuNR_5w@mail.gmail.com>
	<1458141032.29084.0.camel@hadess.net>
	<CANq1E4TCTzZomCCWeSqsfmLM93ZVBwASgdy48bprddOtmBwhRg@mail.gmail.com>
	<CAM4jgCp-rGVEhWns4=k0HFRfZrY-kOmcWG5Z8GXJ3Ucb8eQx4g@mail.gmail.com>
	<CAEc3jaAxP=RnVD2ZjJN3XBZENWOh+Vy51YL4BKjcNQbwg8K8Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:34235 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966205AbcCPWwB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2016 18:52:01 -0400
Received: by mail-io0-f176.google.com with SMTP id m184so77958554iof.1
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2016 15:51:48 -0700 (PDT)
In-Reply-To: <CAEc3jaAxP=RnVD2ZjJN3XBZENWOh+Vy51YL4BKjcNQbwg8K8Rg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Bastien Nocera <hadess@hadess.net>, linux-input <linux-input@vger.kernel.org>

2016-03-16 21:32 GMT+01:00 Roderick Colenbrander <thunderbird2k@gmail.c=
om>:
> On Wed, Mar 16, 2016 at 12:09 PM, Cl=C3=A9ment VUCHENER
> <clement.vuchener@gmail.com> wrote:
>> 2016-03-16 16:26 GMT+01:00 David Herrmann <dh.herrmann@gmail.com>:
>>
>> Hi.
>>
>> I am writing a user-space driver for the steam controller and I was
>> wondering how that would fit. The steam controller reports its
>> absolute gyro data as a quaternion instead of three angles. Although=
,
>> in the case of the steam controller, this data is meant to emulate
>> other kind of devices from the driver, if applications started to us=
e
>> such an interface, it would be nice that the steam controller suppor=
ts
>> it.
>>
>>>
>>> Thanks
>>> David
>
> I haven't with the SteamController yet. Based on iFixit it has a
> 3-axis gyro and 3-axis accelerometer. I guess the microcontroller
> could be doing the quaternion calculations. Are you sure it is gyro
> data and not maybe orientation data derived from gyro + accel? Try
> spinning it around an axis and integrate the output in a script
> (provided you knew the resolution in units per deg/s or rad/s).

Yes, it is derived from gyro + accel. I did not read David's
documentation correctly and I thought that ABS_GYRO_* was the absolute
position (in rad or deg) but it is the speed (in deg/s). The speed
data is also sent in the report although the quaternion is easier to
use thanks to the calibration and integration done on the hardware.

>
> Some devices may use 1D or 2D sensors, so if for those just ABS_GYRO_=
X
> / _Y for them, for a 4th dimension _W would make sense I guess.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
