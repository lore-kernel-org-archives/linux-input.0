From: Roderick Colenbrander <thunderbird2k@gmail.com>
Subject: Re: Handling of non-positional data through evdev
Date: Wed, 16 Mar 2016 13:32:44 -0700
Message-ID: <CAEc3jaAxP=RnVD2ZjJN3XBZENWOh+Vy51YL4BKjcNQbwg8K8Rg@mail.gmail.com>
References: <CAEc3jaB2KOUoymz3BL6Bc7_vv3bTHadBqGM9YLHyt_GeVkOtng@mail.gmail.com>
	<1458082753.4785.27.camel@hadess.net>
	<CAEc3jaA_EnhbNChXAStdqDik9YMfWYXzfHQbOgEb=TXmuNR_5w@mail.gmail.com>
	<1458141032.29084.0.camel@hadess.net>
	<CANq1E4TCTzZomCCWeSqsfmLM93ZVBwASgdy48bprddOtmBwhRg@mail.gmail.com>
	<CAM4jgCp-rGVEhWns4=k0HFRfZrY-kOmcWG5Z8GXJ3Ucb8eQx4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34818 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbcCPUcp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2016 16:32:45 -0400
Received: by mail-pf0-f169.google.com with SMTP id n5so88407982pfn.2
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2016 13:32:45 -0700 (PDT)
In-Reply-To: <CAM4jgCp-rGVEhWns4=k0HFRfZrY-kOmcWG5Z8GXJ3Ucb8eQx4g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?Cl=C3=A9ment_VUCHENER?= <clement.vuchener@gmail.com>
Cc: David Herrmann <dh.herrmann@gmail.com>, Bastien Nocera <hadess@hadess.net>, linux-input <linux-input@vger.kernel.org>

On Wed, Mar 16, 2016 at 12:09 PM, Cl=C3=A9ment VUCHENER
<clement.vuchener@gmail.com> wrote:
> 2016-03-16 16:26 GMT+01:00 David Herrmann <dh.herrmann@gmail.com>:
>> Hi
>>
>> On Wed, Mar 16, 2016 at 4:10 PM, Bastien Nocera <hadess@hadess.net> =
wrote:
>>> On Tue, 2016-03-15 at 17:17 -0700, Roderick Colenbrander wrote:
>>>> Hi Bastien,
>>>>
>>>> Thanks for providing this suggestion. I can see this approach work
>>>> for
>>>> situations like screen rotation on tablets. The device I'm involve=
d
>>>> with is an input device, which needs a high poll rate for
>>>> acceleration
>>>> / velocity and needs to be paired with the button / axes data. Evd=
ev
>>>> would be most appropriate.
>>>
>>> So more like a Wiimote than a builtin sensor. What will consume eve=
nts
>>> in user-space? A specialised application?
>>
>> I really think evdev is the right place to put any of those devices.
>> The real problem is that the current set of ABS types is very limite=
d
>> and strongly overloaded. We didn't do this for other types, but
>> somehow ABS turned out that way.
>>
>> In general, Dmitry was ok with introducing new ABS types, properly
>> representing those types. I sent an RFC some years ago, which also
>> introduces gyro and accelerometer types (see patch #4):
>>
>> https://lists.freedesktop.org/archives/input-tools/2013-December/000=
612.html
>>
>> The problem is, however, that the current ABS_* namespace is
>> exhausted. That is, we have to introduce some new way to add new ABS
>> types (the series introduced ABS2 for that). No-one continued that
>> effort so far, so we are stuck with the current ABS types. Feel free
>> to pick this up. It might be a lengthy effort, though. You might be
>> better off doing it the wiimote way: pick you ABS types and make
>> user-space recognize them depending on the device name/etc.
>
> Hi.
>
> I am writing a user-space driver for the steam controller and I was
> wondering how that would fit. The steam controller reports its
> absolute gyro data as a quaternion instead of three angles. Although,
> in the case of the steam controller, this data is meant to emulate
> other kind of devices from the driver, if applications started to use
> such an interface, it would be nice that the steam controller support=
s
> it.
>
>>
>> Thanks
>> David

I haven't with the SteamController yet. Based on iFixit it has a
3-axis gyro and 3-axis accelerometer. I guess the microcontroller
could be doing the quaternion calculations. Are you sure it is gyro
data and not maybe orientation data derived from gyro + accel? Try
spinning it around an axis and integrate the output in a script
(provided you knew the resolution in units per deg/s or rad/s).

Some devices may use 1D or 2D sensors, so if for those just ABS_GYRO_X
/ _Y for them, for a 4th dimension _W would make sense I guess.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
