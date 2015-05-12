From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] unswap the grave and 102nd keys on Apple Alu ISO keyboard
Date: Tue, 12 May 2015 09:44:11 +0900
Message-ID: <55514CDB.30904@daenzer.net>
References: <1430471843-3455-1-git-send-email-knasher@gmail.com>
 <alpine.LNX.2.00.1505041006330.3081@pobox.suse.cz>
 <alpine.LNX.2.00.1505041009331.3081@pobox.suse.cz>
 <alpine.LNX.2.00.1505041010480.3081@pobox.suse.cz>
 <554C262B.5090607@daenzer.net> <1431079408.1420.0@smtp.gmail.com>
 <554DC82D.1030807@daenzer.net> <1431350579.5543.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from darkcity.gna.ch ([195.226.6.51]:33889 "EHLO mail.gna.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750882AbbELAoY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 May 2015 20:44:24 -0400
in-reply-to: <1431350579.5543.0@smtp.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Horan <knasher@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org


[ Please keep the Cc list intact ]

On 11.05.2015 22:22, John Horan wrote:
>> What's the output of "xprop -root | grep XKB" for you?
> _XKB_RULES_NAMES(STRING) =3D "evdev", "pc104", "gb,us", "mac,",
> "compose:rctrl"=20

I wonder if the reversed behaviour in X is due to the "mac," (variant?)=
=2E
Which keyboard model did you choose in the system / X keyboard
configuration?


>> What's the behaviour for you in console?
> I'm using the American keymap in the console, so it prints backslash
> when I press the grave key on the internal keyboard, but the external
> keyboard is still swapped in relation to it (and actually outputs gra=
ve). =20

So it sounds like the ISO quirk is working correctly for the external
keyboard, and there's actually a problem with the internal keyboard.


>> That assumes the ISO quirk is active for the internal keyboard as
>> well. Have you double-checked that?
> Yeah, and again just to be sure. =20

How did you check?


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
