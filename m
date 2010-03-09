From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 9 Mar 2010 23:54:13 +0100
Message-ID: <C129AE12-1BC7-42F5-9C61-883075F03E36@enac.fr>
References: <4B75E14A.2050602@seas.upenn.edu>  <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu>  <4B760D60.6020907@seas.upenn.edu>  <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz>  <4B96B740.7020208@euromail.se> <4B96BAF1.5070209@seas.upenn.edu>  <alpine.LNX.2.00.1003092218530.17799@pobox.suse.cz>  <5423752A-3AE0-4848-9149-B0C01B0BCA39@enac.fr> <20100309222731.GA29517@core.coreip.homeip.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:39335 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab0CIWyR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 17:54:17 -0500
In-Reply-To: <20100309222731.GA29517@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Rafi Rubin <rafi@seas.upenn.edu>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org


Le 9 mars 10 =E0 23:27, Dmitry Torokhov a =E9crit :
>> With this regard, I am a big fan of the idea of having hierarchical
>> devices, just like with have hierarchical file systems. Each finger
>> on the dual-touch panel would be a device, child of the panel
>> device. Each would be equivalent to a mouse, and voila, the symmetry
>> is restored. Conceptually, saying (panel/finger1, any event) or
>> (panel, finger1 events) are equivalent; but in the first case the
>> routing is done by the OS and in the second case it has to be done
>> by the app, which breaks reusability. There are other interesting
>> perspectives, but I don't want to get carried away too much.
>
> Theoretically it is nice but it practice the cases are differemt: wit=
h
> mice you are dealing with 2 separate devices whereas with touchscreen
> there is one and it is mater of interpretation whether 2 touches =20
> should
> be taken as independent events or a complex gestures.

Yes, but the whole point is that relying on the apps for the =20
interpretation is not always the right approach. In my "two users" =20
scenario, say one is using OpenOffice and the other is using a =20
browser. There's no reason why OpenOffice and the browser should =20
bother with multitouch. It is rather up to the OS (not necessarily =20
the kernel, probably rather X) to provide for the appropriate =20
configuration choice.

In other words: seen from inside the apps, the difference between =20
having one hardware device (the touchscreen) vs two hardware devices =20
(two mice) just does not make any sense :-)

Another example: NTrig's panel has two sensors, one that detects a =20
pen and on that detects fingers; they have chosen to multiplex the =20
two sensors through one USB interface; but is it one device or two =20
devices? As a programmer I don't know and I should not care. =20
Hierarchical devices would be a way for me to forget about this =20
irrelevant issue. Leave it to the OS and the user to choose which is =20
the right configuration.

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
