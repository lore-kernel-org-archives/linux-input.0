From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] unswap the grave and 102nd keys on Apple Alu ISO keyboard
Date: Wed, 13 May 2015 10:16:36 +0900
Message-ID: <5552A5F4.2020501@daenzer.net>
References: <1430471843-3455-1-git-send-email-knasher@gmail.com>
 <alpine.LNX.2.00.1505041006330.3081@pobox.suse.cz>
 <alpine.LNX.2.00.1505041009331.3081@pobox.suse.cz>
 <alpine.LNX.2.00.1505041010480.3081@pobox.suse.cz>
 <554C262B.5090607@daenzer.net> <1431079408.1420.0@smtp.gmail.com>
 <554DC82D.1030807@daenzer.net> <1431350579.5543.0@smtp.gmail.com>
 <55514CDB.30904@daenzer.net> <1431424549.1489.0@smtp.gmail.com>
 <5551D0AC.5030506@daenzer.net> <1431428747.1489.1@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from darkcity.gna.ch ([195.226.6.51]:34855 "EHLO mail.gna.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964800AbbEMBQn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 May 2015 21:16:43 -0400
in-reply-to: <1431428747.1489.1@smtp.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Horan <knasher@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On 12.05.2015 20:05, John Horan wrote:
>=20
>> I'm using the standard US (pc105) keymap.
> That explains it then.  The pc105 keymap calls for the tilda and grav=
e
> key to be placed next to the 1.  So if I select the same layout on my
> macbook, then they end up in the correct place (according to the layo=
ut)
> on the internal keyboard.  For the external keyboard the quirk is the=
n
> mapping them down to next to the z key, which just happens to be wher=
e
> Apple puts them on their international keyboard (but not on their US
> ones).  The pc105 keyboard is actually very close to the Apple ISO
> layout, apart from some of the special keys like =C2=A3 and the place=
ment of
> tilda and grave and the inclusion of a =C2=A7=C2=B1 key next to 1.
>=20
>> I'm afraid I don't know how to sort out this mess, but I'm pretty su=
re
>> removing the ISO quirk for just one ISO keyboard is not correct.
> I'd actually argue that proves that the quirk shouldn't have been
> applied to this model of keyboard.  I guess my main point is that the=
re
> shouldn't be a discrepency between the internal and external keyboard=
s.
> If you selected pc105 on a laptop with an iso keyboard, then the tild=
a
> key should be next to 1, and if you used a uk,mac layout with an appl=
e
> iso keyboard then the tilda should be next to z.

It makes some sense, but OTOH it sounded like in console it's actually
the external keyboard which is working correctly for you.

Also, my Apple keyboard isn't connected to an Apple machine but to an H=
P
notebook. How do you suggest such a combination should be configured
without the ISO quirk?

=46inally, I still find it hard to believe that this issue would only
affect this particular Apple ISO keyboard model.


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
