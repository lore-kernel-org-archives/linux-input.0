From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] unswap the grave and 102nd keys on Apple Alu ISO keyboard
Date: Sat, 9 May 2015 17:41:17 +0900
Message-ID: <554DC82D.1030807@daenzer.net>
References: <1430471843-3455-1-git-send-email-knasher@gmail.com>
 <alpine.LNX.2.00.1505041006330.3081@pobox.suse.cz>
 <alpine.LNX.2.00.1505041009331.3081@pobox.suse.cz>
 <alpine.LNX.2.00.1505041010480.3081@pobox.suse.cz>
 <554C262B.5090607@daenzer.net> <1431079408.1420.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from darkcity.gna.ch ([195.226.6.51]:60845 "EHLO mail.gna.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751842AbbEIIl0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 9 May 2015 04:41:26 -0400
in-reply-to: <1431079408.1420.0@smtp.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Horan <knasher@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On 08.05.2015 19:03, John Horan wrote:
>=20
> I have an Apple aluminum keyboard with the same usb product id,
> connected to an apple laptop, also with an ISO keyboard.  According t=
o
> xev the key with ` printed on it on the external keyboard produces
> keycode 49 (which matches to =C2=A7) while the internal keyboard prod=
uces 94
> (which is mapped to `), while the key with =C2=A7 produces the opposi=
te.

What's the output of "xprop -root | grep XKB" for you?

What's the behaviour for you in console?


> Obiviously just disabling the quirk isn't an option for me, as that
> would just flip the mapping of the two keys.

That assumes the ISO quirk is active for the internal keyboard as well.
Have you double-checked that?


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
