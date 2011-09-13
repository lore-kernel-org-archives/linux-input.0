From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Tue, 13 Sep 2011 15:54:54 -0500
Message-ID: <CAGzDe_b6kRc0p6sYiAJ0MkaJtHARN44AcoCG-N=xjLQtp8XA8w@mail.gmail.com>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
	<20110913080911.GA4986@polaris.bitmath.org>
	<CAGzDe_Y1=1Duzr8=eE+wBEa40cD8uJ4hnE0ZzFHaKChAUUPPXg@mail.gmail.com>
	<CAF8JNhJhOwZx9M++LMk2mY16CE23Mg6jf+ckX5W3yZfwuLDQXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f170.google.com ([209.85.161.170]:48327 "EHLO
	mail-gx0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932567Ab1IMUyz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 16:54:55 -0400
Received: by gxk27 with SMTP id 27so1314271gxk.1
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2011 13:54:55 -0700 (PDT)
In-Reply-To: <CAF8JNhJhOwZx9M++LMk2mY16CE23Mg6jf+ckX5W3yZfwuLDQXA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, jeffbrown@android.com

On Tue, Sep 13, 2011 at 12:36 PM, Ping Cheng <pinglinux@gmail.com> wrot=
e:
> On Tue, Sep 13, 2011 at 7:13 AM, Chris Bagwell <chris@cnpbagwell.com>=
 wrote:
>> On Tue, Sep 13, 2011 at 3:09 AM, Henrik Rydberg <rydberg@euromail.se=
> wrote:
>>> Hi Jason,
>>>
>>>> Adds INPUT_PROP_POINTER or INPUT_PROP_DIRECT as necessary to the
>>>> hardware supported by the Wacom driver. The DIRECT property is
>>>> assigned to devices with an embedded screen (i.e. touchscreens
>>>> and display tablets). The POINTER property is assigned to those
>>>> without embedded screens.
>>>>
>>>> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
>>>> ---
>>>
>>> According to the discussion leading up to the properties interface
>>> (https://lkml.org/lkml/2010/12/15/263), a tablet is a direct pointe=
r
>>> device, as opposed to a touchpad, which is an indirect pointer
>>> device. The distinction determines the direction of two-finger scro=
ll,
>>> for instance. The question is then what behavior should be assigned=
 to
>>> a large tablet without an embedded screen. It should have POINTER s=
et
>>> for sure, but should it also have DIRECT set?
>
> We have discussed and debated the above before the patch was posted.
>
> As Ikbel pointed out, a standalone tablet can be DIRECT or INDIRECT,
> depending on how it is used. So, it is more a property that is decide=
d
> by the client than by the kernel driver.

I've a couple questions that would help me decide how things should be =
declared.

Can DIRECT be translated to mean treat coordinates as absolute
coordinates mapped to screen?  Or is it meant to be reserved only for
the more specific touchscreen-like application were the touch is laid
directly on top of the object being manipulated (or picture is
overlaid the touch for projector case)?

If some company shipped a touchpad+projector, would that ideally
declare DIRECT and not declare POINTER since user is directly touching
objects and the display of a pointer would serve no purpose?

What I'm getting at with the second question is if user pairs up a
touch tablet/touchpad with a projector then declaring even POINTER may
be just as wrong as not declaring DIRECT.

I don't think we can every get custom HW applications declared
correctly, so do we punish all cases and not declare anything?

>
>> Here are all the possible combinations based on my understanding of
>> their intended usage.
>>
>> =A0* Touch interface without screen should have POINTER only to
>> indicate pointer needed and to treat absolute coordinates as relativ=
e
>> movement. =A0Relative movement is product's default behavior as
>> documented in its own manual and what I think should be advertised b=
y
>> default.
>> =A0* Pen interface without screen should have both POINTER and DIREC=
T to
>> indicate pointer needed and to treat absolute coordinates as absolut=
e
>> movement.
>
> Reporting it as DIRECT indicates it can only be used as DIRECT. We
> don't want client to make that assumption. User-land clients can
> distinguish a touch POINTER from a pen POINTER by the tool types.

I see your logic now and patch does follow that logic.

I can actually buy into that although it seems to make the need for
both POINTER and DIRECT redundant. Touchscreen =3D DIRECT while Tablet
(pen, touch, or both) =3D POINTER.  No overlap.

If we do allow DIRECT on tablets then I do see now it becomes a
relaxed DIRECT since application will most likely still offer
switching pens to relative mode.

Chris

>
>> =A0* Touch interfaces with screen should have DIRECT only to indicat=
e no
>> pointer displayed and absolute coordinates as absolute movement.
>> =A0* Pen interface with screen should have DIRECT only to indicate n=
o
>> pointer displayed and absolute coordinates as absolute movement.
>> * A Pen+Touch touchscreen (only the wacom_w8001.c), should have DIRE=
CT
>> only to indicate no pointer displayed and absolute coordinates as
>> absolute movement.
>>
>> Assuming we all agree on those combination, then in the patch the
>> Graphire and Intuos tablets are missing a DIRECT, the touchscreens a=
re
>> correct, and the Bamboo's need to add DIRECT for the PEN interface
>> only.
>
> I agree with all the other assumptions except this one.
>
> Ping
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
