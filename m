From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] unswap the grave and 102nd keys on Apple Alu ISO keyboard
Date: Tue, 12 May 2015 19:06:36 +0900
Message-ID: <5551D0AC.5030506@daenzer.net>
References: <1430471843-3455-1-git-send-email-knasher@gmail.com>
 <alpine.LNX.2.00.1505041006330.3081@pobox.suse.cz>
 <alpine.LNX.2.00.1505041009331.3081@pobox.suse.cz>
 <alpine.LNX.2.00.1505041010480.3081@pobox.suse.cz>
 <554C262B.5090607@daenzer.net> <1431079408.1420.0@smtp.gmail.com>
 <554DC82D.1030807@daenzer.net> <1431350579.5543.0@smtp.gmail.com>
 <55514CDB.30904@daenzer.net> <1431424549.1489.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from darkcity.gna.ch ([195.226.6.51]:34553 "EHLO mail.gna.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750865AbbELKGn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 May 2015 06:06:43 -0400
in-reply-to: <1431424549.1489.0@smtp.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Horan <knasher@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On 12.05.2015 18:55, John Horan wrote:
>=20
>> [ Please keep the Cc list intact ]
> Appologies, and thanks for spotting that.
>> I wonder if the reversed behaviour in X is due to the "mac,"
>> (variant?). Which keyboard model did you choose in the system / X
>> keyboard configuration?=20
> I'm using the English(UK,Macintosh) keymap. (and yes mac is the varia=
nt)
>  Apart from the two keys covered by the quirk, every other key matche=
s
> exactly to what is printed on the keys.  Which keymap are you using?

I'm using the standard US (pc105) keymap.


>>         What's the behaviour for you in console?=20
>>
>>     I'm using the American keymap in the console, so it prints
>>     backslash when I press the grave key on the internal keyboard, b=
ut
>>     the external keyboard is still swapped in relation to it (and
>>     actually outputs grave).=20
>>
>> So it sounds like the ISO quirk is working correctly for the externa=
l
>> keyboard, and there's actually a problem with the internal keyboard.
> Actually I was mistaken there, I'm using the UK layout in the VC (I
> actually did try a mac-uk there before, but it was unusable, so I've
> left it as uk).  Which is why I still think the problem lies with the
> external rather than internal keyboard, as the uk key layout would
> normally put the grave (paired with |) up next to the 1, which is wha=
t
> it does on the internal keyboard, which is then swapped down next to =
the
> z key on the external, and that just happens to be where apple puts t=
he
> grave key.
>>
>>         That assumes the ISO quirk is active for the internal keyboa=
rd
>>         as well. Have you double-checked that?=20
>>
>>     Yeah, and again just to be sure.=20
>>
>> How did you check?
> As you did, I disabled the quirk by echoing 0 into
> /sys/module/hid_apple/parameters/iso_layout.  And that had an effect =
on
> both keyboards, rather than just the external.

I'm afraid I don't know how to sort out this mess, but I'm pretty sure
removing the ISO quirk for just one ISO keyboard is not correct.


--=20
Earthling Michel D=C3=A4nzer               |               http://www.a=
md.com
Libre software enthusiast             |             Mesa and X develope=
r
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
