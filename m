From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Tue, 13 Sep 2011 10:36:02 -0700
Message-ID: <CAF8JNhJhOwZx9M++LMk2mY16CE23Mg6jf+ckX5W3yZfwuLDQXA@mail.gmail.com>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
	<20110913080911.GA4986@polaris.bitmath.org>
	<CAGzDe_Y1=1Duzr8=eE+wBEa40cD8uJ4hnE0ZzFHaKChAUUPPXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f170.google.com ([209.85.161.170]:47120 "EHLO
	mail-gx0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755804Ab1IMRgD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 13:36:03 -0400
Received: by gxk27 with SMTP id 27so1070644gxk.1
        for <linux-input@vger.kernel.org>; Tue, 13 Sep 2011 10:36:02 -0700 (PDT)
In-Reply-To: <CAGzDe_Y1=1Duzr8=eE+wBEa40cD8uJ4hnE0ZzFHaKChAUUPPXg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>, Henrik Rydberg <rydberg@euromail.se>
Cc: Jason Gerecke <killertofu@gmail.com>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, jeffbrown@android.com

On Tue, Sep 13, 2011 at 7:13 AM, Chris Bagwell <chris@cnpbagwell.com> w=
rote:
> On Tue, Sep 13, 2011 at 3:09 AM, Henrik Rydberg <rydberg@euromail.se>=
 wrote:
>> Hi Jason,
>>
>>> Adds INPUT_PROP_POINTER or INPUT_PROP_DIRECT as necessary to the
>>> hardware supported by the Wacom driver. The DIRECT property is
>>> assigned to devices with an embedded screen (i.e. touchscreens
>>> and display tablets). The POINTER property is assigned to those
>>> without embedded screens.
>>>
>>> Signed-off-by: Jason Gerecke <killertofu@gmail.com>
>>> ---
>>
>> According to the discussion leading up to the properties interface
>> (https://lkml.org/lkml/2010/12/15/263), a tablet is a direct pointer
>> device, as opposed to a touchpad, which is an indirect pointer
>> device. The distinction determines the direction of two-finger scrol=
l,
>> for instance. The question is then what behavior should be assigned =
to
>> a large tablet without an embedded screen. It should have POINTER se=
t
>> for sure, but should it also have DIRECT set?

We have discussed and debated the above before the patch was posted.

As Ikbel pointed out, a standalone tablet can be DIRECT or INDIRECT,
depending on how it is used. So, it is more a property that is decided
by the client than by the kernel driver.

> Here are all the possible combinations based on my understanding of
> their intended usage.
>
> =A0* Touch interface without screen should have POINTER only to
> indicate pointer needed and to treat absolute coordinates as relative
> movement. =A0Relative movement is product's default behavior as
> documented in its own manual and what I think should be advertised by
> default.
> =A0* Pen interface without screen should have both POINTER and DIRECT=
 to
> indicate pointer needed and to treat absolute coordinates as absolute
> movement.

Reporting it as DIRECT indicates it can only be used as DIRECT. We
don't want client to make that assumption. User-land clients can
distinguish a touch POINTER from a pen POINTER by the tool types.

> =A0* Touch interfaces with screen should have DIRECT only to indicate=
 no
> pointer displayed and absolute coordinates as absolute movement.
> =A0* Pen interface with screen should have DIRECT only to indicate no
> pointer displayed and absolute coordinates as absolute movement.
> * A Pen+Touch touchscreen (only the wacom_w8001.c), should have DIREC=
T
> only to indicate no pointer displayed and absolute coordinates as
> absolute movement.
>
> Assuming we all agree on those combination, then in the patch the
> Graphire and Intuos tablets are missing a DIRECT, the touchscreens ar=
e
> correct, and the Bamboo's need to add DIRECT for the PEN interface
> only.

I agree with all the other assumptions except this one.

Ping
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
