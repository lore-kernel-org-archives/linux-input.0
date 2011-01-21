From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: EVIOC mechanism for MT slots
Date: Fri, 21 Jan 2011 08:58:08 +0100
Message-ID: <AANLkTinDoDm=XqEveR0j9z9bxdPdNtT4JzuXcVrYxAxK@mail.gmail.com>
References: <4D38A4B7.7060901@seas.upenn.edu>
	<AANLkTi=mwmpV-db5evGsWe3eyNJER5DOH3V326Jf74us@mail.gmail.com>
	<AANLkTikksBMW0vcmJOGg8=VPWS3FB6HQQL46R7VotyON@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37417 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265Ab1AUH6J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jan 2011 02:58:09 -0500
Received: by wwa36 with SMTP id 36so1582908wwa.1
        for <linux-input@vger.kernel.org>; Thu, 20 Jan 2011 23:58:08 -0800 (PST)
In-Reply-To: <AANLkTikksBMW0vcmJOGg8=VPWS3FB6HQQL46R7VotyON@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Bagwell <chris@cnpbagwell.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Rafi Rubin <rafi@seas.upenn.edu>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input <linux-input@vger.kernel.org>, Stephane Chatty <chatty@lii-enac.fr>, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <tissoire@cena.fr>, Peter Hutterer <peter.hutterer@who-t.net>, "X.Org Devel List" <xorg-devel@lists.freedesktop.org>

Hi,

if the TrackingID is stable during the touch, the MT_SLOT is stable
*between* the touches:

if you put one finger on the surface, you get the slot 0. Then you
release. Then you touch one finger again, and protocol B does not send
the slot value.

This is really problematic when launching applications that rely on
evdev to work:
you click with the mouse emulation on your icon to launch the program
(one finger), and you start using your application with one finger
only (opening of a file for instance) -> you are in an unstable case
as the app does not know the slot state until you put another finger
on the screen.

So I'm in favor of applying this patch Henrik submitted last May.

Cheers,
Benjamin

On Fri, Jan 21, 2011 at 04:57, Chris Bagwell <chris@cnpbagwell.com> wro=
te:
> On Thu, Jan 20, 2011 at 7:45 PM, Ping Cheng <pinglinux@gmail.com> wro=
te:
>> Hi Dmitry,
>>
>> Rafi's request is a good use case for the "input: mt: Add EVIOC
>> mechanism for MT slots" patchset that Henrik submitted last May. Fro=
m
>> the MT X driver experience we had in the last few months, retrieving
>> all active contacts, especially in the case when different tool type=
s
>> are supported on the same logical port, is necessary to initialize t=
he
>> tools properly.
>>
>> Can you consider to merge the patchset into 2.6.38?
>>
>> Thank you.
>>
>> Ping
>
> Agree. =A0Although X/Y will change often, the tracking ID is stable. =
=A0So
> during start up of applications it would be really useful to query
> pre-existing ABS_MT_TRACKING_ID so that user doesn't have to lift
> object/hand/whatever before application starts working.
>
> Chris
>
>>
>> -------- Original Message --------
>> Subject: =A0 =A0 =A0 =A0Re: [PATCH 0/2] input: mt: Add EVIOC mechani=
sm for MT slots
>> Date: =A0 Thu, 27 May 2010 16:12:20 -0700
>> From: =A0 Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> To: =A0 =A0 Ping Cheng <pinglinux@gmail.com>
>> CC: =A0 =A0 Henrik Rydberg <rydberg@euromail.se>, Andrew Morton
>> <akpm@linux-foundation.org>, linux-input@vger.kernel.org,
>> linux-kernel@vger.kernel.org, Mika Kuoppala <mika.kuoppala@nokia.com=
>,
>> Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires
>> <tissoire@cena.fr>, Stephane Chatty <chatty@enac.fr>, Rafi Rubin
>> <rafi@seas.upenn.edu>, Michael Poole <mdpoole@troilus.org>
>>
>>
>> On Thursday, May 27, 2010 03:59:37 pm Ping Cheng wrote:
>>
>> =A0 =A0 On Thu, May 27, 2010 at 12:03 AM, Dmitry Torokhov
>>
>> =A0 =A0 <dmitry.torokhov@gmail.com> =A0wrote:
>> =A0 =A0 > =A0On Wed, May 26, 2010 at 08:59:35AM -0700, Ping Cheng wr=
ote:
>> =A0 =A0 >> =A0On Tue, May 25, 2010 at 1:23 PM, Dmitry Torokhov
>> =A0 =A0 >>
>> =A0 =A0 >> =A0<dmitry.torokhov@gmail.com> =A0wrote:
>> =A0 =A0 >> =A0> =A0On Tue, May 25, 2010 at 09:52:29PM +0200, Henrik =
Rydberg wrote:
>> =A0 =A0 >> =A0>> =A0Dmitry Torokhov wrote:
>> =A0 =A0 >> =A0>> =A0> =A0Hi Henrik,
>> =A0 =A0 >> =A0>> =A0>
>> =A0 =A0 >> =A0>> =A0> =A0On Tue, May 25, 2010 at 01:52:57PM +0200, H=
enrik Rydberg wrote:
>> =A0 =A0 >> =A0>> =A0>> =A0These patches are in response to the discu=
ssion about
>> input state
>> =A0 =A0 >> =A0>> =A0>> =A0retrieval.
>> =A0 =A0 >> =A0>> =A0>>
>> =A0 =A0 >> =A0>> =A0>> =A0The current EVIOCGABS method does not work=
 with MT
>> slots. =A0These
>> =A0 =A0 >> =A0>> =A0>> =A0patches provides a mechanism where a slot =
is first
>> selected via a
>> =A0 =A0 >> =A0>> =A0>> =A0call to EVIOCSABS, after which the corresp=
onding MT
>> events can be
>> =A0 =A0 >> =A0>> =A0>> =A0extracted with calls to EVIOCGABS.
>> =A0 =A0 >> =A0>> =A0>>
>> =A0 =A0 >> =A0>> =A0>> =A0The symmetric operation, to set the MT sta=
te via
>> EVIOCSABS, seems
>> =A0 =A0 >> =A0>> =A0>> =A0to violate input data integrity, and is th=
erefore not
>> =A0 =A0 >> =A0>> =A0>> =A0implemented.
>> =A0 =A0 >> =A0>> =A0>
>> =A0 =A0 >> =A0>> =A0> =A0This looks sane, however the question remai=
ns - is
>> there any users
>> =A0 =A0 >> =A0>> =A0> =A0for this data? Like I mentioned, I can see =
the need to
>> fetch state
>> =A0 =A0 >> =A0>> =A0> =A0of switches and ranges of absolute axis, an=
d even non-multitouch
>> =A0 =A0 >> =A0>> =A0> =A0ABS values (due to the fact that some input=
 devices,
>> like sliders,
>> =A0 =A0 >> =A0>> =A0> =A0may stay in a certain position for long per=
iods of time), but I
>> =A0 =A0 >> =A0>> =A0> =A0expect multitouch data to be "refreshed" ve=
ry quickly.
>> =A0 =A0 >> =A0>> =A0>
>> =A0 =A0 >> =A0>> =A0> =A0Thanks.
>> =A0 =A0 >> =A0>>
>> =A0 =A0 >> =A0>> =A0There were some voices addressing this issue, an=
d the patches are
>> =A0 =A0 >> =A0>> =A0here, available for whomever to pick up. Drop th=
em if you wish, I
>> =A0 =A0 >> =A0>> =A0will not send them anew.
>> =A0 =A0 >> =A0>
>> =A0 =A0 >> =A0> =A0I'll save them in my queue but will hold off appl=
ying until I hear
>> =A0 =A0 >> =A0> =A0userspace folks requesting such functionality.
>> =A0 =A0 >>
>> =A0 =A0 >> =A0Hi Dmitry,
>> =A0 =A0 >>
>> =A0 =A0 >> =A0You do have a valid point - the (x,y) from a touch obj=
ect would most
>> =A0 =A0 >> =A0likely change all the time. Even if the object itself =
is in a steady
>> =A0 =A0 >> =A0state on the digitizer, i.e., without any intentional =
movement, the
>> =A0 =A0 >> =A0electronic noise would most likely lead to some (x,y) =
changes. So, the
>> =A0 =A0 >> =A0chance that we need to retrieve (x,y) is rare.
>> =A0 =A0 >>
>> =A0 =A0 >> =A0However, it is possibe that when X driver starts, an o=
bject was
>> =A0 =A0 >> =A0already on the digitizer. And the digitizer is of such=
 a high quality
>> =A0 =A0 >>
>> =A0 =A0 >> =A0:), it filtered all the noises so we can not locate th=
e touch without
>> =A0 =A0 >>
>> =A0 =A0 >> =A0a EVIOCGABS call.
>> =A0 =A0 >>
>> =A0 =A0 >> =A0Plus, from a pure coding/development point of view, it=
 is not a bad
>> =A0 =A0 >> =A0practice to provide the equivalent features for _MT_ s=
upport as we did
>> =A0 =A0 >> =A0for the existing input devices. At least, it doesn't h=
urt to make the
>> =A0 =A0 >> =A0support consistent across devices/tools (considering t=
ouch as a new
>> =A0 =A0 >> =A0input device/tool).
>> =A0 =A0 >
>> =A0 =A0 > =A0Ping,
>> =A0 =A0 >
>> =A0 =A0 > =A0I did not say that there was a problem with the patch, =
I agree with it.
>> =A0 =A0 > =A0However if no one using this - why should we bother? Wi=
ll _you_ utilize
>> =A0 =A0 > =A0this functionality in Wacom X driver? If so let me know=
 and I will merge
>> =A0 =A0 > =A0it.
>>
>> =A0 =A0 tbh, I can not say that I will need it in my X driver for su=
re. But I
>> =A0 =A0 vote for it to be merged.
>>
>>
>> Well, at this point I am in "no users - no functionality" mode, so I=
 will
>> only count votes of users :P
>>
>> --
>> Dmitry
>>
>> On Thu, Jan 20, 2011 at 1:10 PM, Rafi Rubin <rafi@seas.upenn.edu> wr=
ote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> We've come across a little problem with filtered MT events. =A0It s=
eems there
>>> isn't a mechanism to request the full state. =A0If a program opens =
a device
>>> there's no way it can see static objects.
>>>
>>> Consider for example a board game. =A0If the user puts the pieces o=
n a MT surface
>>> before starting the application, those pieces will not register and=
 the state of
>>> the game will be incorrect.
>>>
>>> If there's opposition to this request, I suggest settling the dispu=
te with a
>>> game of MT battleship :-)
>>>
>>> Rafi
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-inpu=
t" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
