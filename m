From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH v2] Input: synaptics - use firmware data for Cr-48
Date: Fri, 20 Jul 2012 17:03:48 +0800
Message-ID: <CAGS+omBmkdrpLds4xE==BNp1yctOmA1xj-p2s4S8Bvh7Q=ixxw@mail.gmail.com>
References: <1342606923-9997-1-git-send-email-cywang@chromium.org>
 <5006D86C.7030208@canonical.com> <CAM2ehZbftDja6CBGjhL3Jp+30DtYJj+8_4e=_wWcj3pCDGD7AA@mail.gmail.com>
 <500832D7.4040805@canonical.com> <CAGS+omA-PwoM=U3xP_Gtadaow9SGt555NPWor_-HuvVE8-R3MQ@mail.gmail.com>
 <50084529.2030001@canonical.com> <20120719184419.GA3626@polaris.bitmath.org>
 <CAM2ehZaLeJsxCOkqLv9jSko9y3Awix1jjobfTo5WQj8rcrYquA@mail.gmail.com> <20120720072510.GA986@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:57753 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181Ab2GTJEJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jul 2012 05:04:09 -0400
Received: by qcro28 with SMTP id o28so2215774qcr.19
        for <linux-input@vger.kernel.org>; Fri, 20 Jul 2012 02:04:09 -0700 (PDT)
In-Reply-To: <20120720072510.GA986@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: =?UTF-8?B?Q2h1bmctWWloIFdhbmcgKOeOi+W0h+aHvyk=?= <cywang@google.com>, Chase Douglas <chase.douglas@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, JJ Ding <dgdunix@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jul 20, 2012 at 3:25 PM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> On Fri, Jul 20, 2012 at 11:14:25AM +0800, Chung-Yih Wang (=E7=8E=8B=E5=
=B4=87=E6=87=BF) wrote:
>> From our experiments, the assumption of "the slowest corner is the
>> stationary finger" is not always true. That is the major reason we w=
ant to
>> report the firmware data instead of semi-mt.
>
> Oh, but that was precisely the point; the reason it does not hold tru=
e
> is due to sensor and discretization errors. If we can improve upon
> this situation, we get a better model of reality.
>
>> The problem here will be how
>> to remove the pulling effect, we measured the pulling effect before =
and can
>> not get a good result as there could be IIR in firmware as well. It =
seems
>> not an easy job to remove the pulling effect cleanly.
>
> Probably a simple filter will work. If the bounding box is moving too
> fast for the tracked point to stay in the right corner, the solution
> is to use a smaller time step. In practise, keeping the tracked point
> as a state in the driver, and updating the bounding box using box ->
> (1 - m) box + m box_new. If the tracked point is in the right corner,
> let m =3D 1. If not, choose a smaller m.
>
>> > > * Add a new device property (INVALID_Y_AXIS_CROSSING?) that
>> > > describes the exact behavior of this device. I would be ok with =
this
>> > > if everyone else is, but only because proper clickpad behavior
>> > > (which I consider very importand) is broken without this knowled=
ge.
>> >
>> Sounds good to me(but I would rather to have INVALID_CROSSING instea=
d,
>> depending on the relative finger positions,  it could still have wro=
ng
>> tracking either in X or Y axis crossing)
>
> Propagating information about various sensor defects to userspace
> sounds horrid to me. The sooner we can forget about these devices, th=
e
> better.

Not providing the userspace driver with enough information to give
users the best experience possible sounds horrid to me.  It turns out
that using a bounding box with fixed "[(min_x, min_y), (max_x,
max_y)]", and no per-finger pressure information, instead of the
coordinates and pressures provided by the firmware, is throwing away
useful data that could be used by the userspace driver.

What we would like is a way to tell userspace what the firmware
originally intended, but with a caveat that the firmware can't be 100%
trusted.  And, since this is for a relatively small class of hardware,
to do it in a way that doesn't consume precious resources, like
additional input properties.

>
>> > > * Leave the device as SEMI_MT, but provide the real locations, a=
nd
>> > > allow userspace to determine the device vendor/model/etc. If
>> > > userspace knows that a specific device behaves in a specific way=
, it
>> > > can do its own quirking handling. Given the specificity of this
>> > > behavior to only some devices of one brand, this would be my
>> > > suggested resolution to the issue.
>> >

This is essentially what this patch does.  It sets the SEMI_MT flag to
indicate that the kernel data cannot be totally trusted, and then
provides real MT-B (including per-finger pressures), instead of a
fixed bounding box.  It leaves it to userspace to treat the two slots
worth of coordinates as a bounding box or as actual fingers using its
own heuristics.  By limiting to only one hardware type (using DMI),
any breakage caused by this alternative use of the SEMI_MT flag is
limited.

Hopefully it is clear what we are trying to accomplish.  I don't see
how we can make a bounding box, even an improved bounding box, work.
Perhaps Henrik has a really good idea, but I haven't been able to
figure out what he is suggesting.

Thank you for the nice discussion and alternative suggestions about
better ways of doing this!

-Daniel

>>
>> A bit confused here, do you mean we report the real locations instea=
d of
>> bounding box the current driver have? I am not quite sure if this wi=
ll
>> affect other existing works in userspace for this semi-mt driver.
>
> I am not entirely opposed to this solution, but I would much rather
> see an attempt to improve the bounding box in the driver, since such =
a
> solution could be useful for other devices as well.
>
> Thanks,
> Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
