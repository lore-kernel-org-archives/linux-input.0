From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [git pull] Input updates for 2.6.34-rc0
Date: Tue, 9 Mar 2010 13:21:22 -0500
Message-ID: <8bd0f97a1003091021u717fb87jf3e32c7258ee4011@mail.gmail.com>
References: <20100301080342.GH765@core.coreip.homeip.net> <8bd0f97a1003090644p19fb7dacqe1f2fb3adee3fa7a@mail.gmail.com>
	<20100309175107.GB23378@core.coreip.homeip.net> <8bd0f97a1003090958i741f4ffm3528450e89089e9@mail.gmail.com>
	<4B9690F8.1080804@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f189.google.com ([209.85.211.189]:61861 "EHLO
	mail-yw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab0CISVn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 13:21:43 -0500
In-Reply-To: <4B9690F8.1080804@cam.ac.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Robin Getz <rgetz@blackfin.uclinux.org>

On Tue, Mar 9, 2010 at 13:18, Jonathan Cameron wrote:
> On 03/09/10 17:58, Mike Frysinger wrote:
>> On Tue, Mar 9, 2010 at 12:51, Dmitry Torokhov wrote:
>>> On Tue, Mar 09, 2010 at 09:44:08AM -0500, Mike Frysinger wrote:
>>>> On Mon, Mar 1, 2010 at 03:03, Dmitry Torokhov wrote:
>>>>> Hi Linus,
>>>>>
>>>>> Please pull from:
>>>>>
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0git://git.kernel.org/pub/scm/linux/ker=
nel/git/dtor/input.git for-linus
>>>>> or
>>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0master.kernel.org:/pub/scm/linux/kerne=
l/git/dtor/input.git for-linus
>>>>>
>>>>> to receive first round of updates for the input subsystem.
>>>>
>>>> i'm trying to figure out what the problem is with the ADXL34x and
>>>> AD714x drivers you seem to have accepted (at least, you didnt say
>>>> there was anything left for us to do). =C2=A0i would have expected=
 them to
>>>> be in 2.6.33/2.6.34 already, but it seems they arent moving now. =C2=
=A0so
>>>> what's up ?
>>>
>>> I am still spooked by the fact that this is an accelerometer and do=
es
>>> not have to be an input device but maybe used for different purpose=
s as
>>> well.
>>
>> the AD714x is not an accelerometer, it's a capacitance touch sensor
>>
>> i understand the ADXL34x is a bit wonky, but what else would you
>> propose ? =C2=A0or just leave the driver in limbo forever until peop=
le
>> forget about it ?
>
> Perhaps whilst this remains in debate it might merge under misc, or
> even staging temporarily. =C2=A0That would avoid setting a precedent =
for
> putting them in input. =C2=A0I personally agree with Dmitry's wish to
> avoid feature drift in input, but then we don't have anything else re=
ady
> for the big time. =C2=A0Under staging the entire TODO list would be a=
long
> lines of awaiting a suitable framework... =C2=A0This is effectively w=
hat
> is going to happen to the various Ambient Light sensor drivers for
> pretty much the same reason (see responses to our recent pull request=
).
>
> We certainly want to be careful not to loose good drivers like this
> and also to make them available to those who wish to use them.

i dont have any problems with where exactly the driver gets merged, or
if we have a goal we're working towards (in terms of a "better"
place).  but drivers sitting in perpetual limbo sucks.
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
