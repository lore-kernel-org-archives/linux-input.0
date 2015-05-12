From: John Horan <knasher@gmail.com>
Subject: Re: [PATCH] unswap the grave and 102nd keys on Apple Alu ISO
 keyboard
Date: Tue, 12 May 2015 12:05:47 +0100
Message-ID: <1431428747.1489.1@smtp.gmail.com>
References: <1430471843-3455-1-git-send-email-knasher@gmail.com>
	<alpine.LNX.2.00.1505041006330.3081@pobox.suse.cz>
	<alpine.LNX.2.00.1505041009331.3081@pobox.suse.cz>
	<alpine.LNX.2.00.1505041010480.3081@pobox.suse.cz>
	<554C262B.5090607@daenzer.net> <1431079408.1420.0@smtp.gmail.com>
	<554DC82D.1030807@daenzer.net> <1431350579.5543.0@smtp.gmail.com>
	<55514CDB.30904@daenzer.net> <1431424549.1489.0@smtp.gmail.com>
	<5551D0AC.5030506@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:35902 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932251AbbELLFt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 May 2015 07:05:49 -0400
Received: by wggj6 with SMTP id j6so4962217wgg.3
        for <linux-input@vger.kernel.org>; Tue, 12 May 2015 04:05:48 -0700 (PDT)
In-Reply-To: <5551D0AC.5030506@daenzer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michel =?iso-8859-1?q?D=E4nzer?= <michel@daenzer.net>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org


> I'm using the standard US (pc105) keymap.
That explains it then.  The pc105 keymap calls for the tilda and grave=20
key to be placed next to the 1.  So if I select the same layout on my=20
macbook, then they end up in the correct place (according to the=20
layout) on the internal keyboard.  For the external keyboard the quirk=20
is then mapping them down to next to the z key, which just happens to=20
be where Apple puts them on their international keyboard (but not on=20
their US ones).  The pc105 keyboard is actually very close to the Apple=
=20
ISO layout, apart from some of the special keys like =C2=A3 and the=20
placement of tilda and grave and the inclusion of a =C2=A7=C2=B1 key ne=
xt to 1.

> I'm afraid I don't know how to sort out this mess, but I'm pretty sur=
e
> removing the ISO quirk for just one ISO keyboard is not correct.
I'd actually argue that proves that the quirk shouldn't have been=20
applied to this model of keyboard.  I guess my main point is that there=
=20
shouldn't be a discrepency between the internal and external keyboards.=
=20
 If you selected pc105 on a laptop with an iso keyboard, then the tilda=
=20
key should be next to 1, and if you used a uk,mac layout with an apple=20
iso keyboard then the tilda should be next to z.

-John

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
