From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 9 Mar 2010 23:03:07 +0100
Message-ID: <5423752A-3AE0-4848-9149-B0C01B0BCA39@enac.fr>
References: <4B75E14A.2050602@seas.upenn.edu>  <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu>  <4B760D60.6020907@seas.upenn.edu>  <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz>  <4B96B740.7020208@euromail.se> <4B96BAF1.5070209@seas.upenn.edu> <alpine.LNX.2.00.1003092218530.17799@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:41052 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754051Ab0CIWDO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 17:03:14 -0500
In-Reply-To: <alpine.LNX.2.00.1003092218530.17799@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Rafi Rubin <rafi@seas.upenn.edu>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com


Le 9 mars 10 =E0 22:19, Jiri Kosina a =E9crit :

> On Tue, 9 Mar 2010, Rafi Rubin wrote:
>
>> Since you're considering protocol clarification, what's your =20
>> opinion on
>> splitting the multi-touch and single touch (possibly emulated) to
>> separate input devices?
>
> What would be the advantages?

One would be separation of concerns. If I'm interested in single =20
touch events, I'd be better off with no "multitouch noise". If I'm =20
interested in low level events, I'd be better off without the =20
interference created by all sorts of "clever" event emulation in =20
drivers. An easy way to do this is to have a different input node for =20
each protocol.

Dmitry has already replied to this that if protocols are independent =20
there is no problem with multiplexing them on the same node (I'm =20
rephrasing heavily, here). Still, with multiplexing things are a bit =20
less clear for programmers; this is not a clean object interface =20
protocol to say the least ;-) And sometimes there even are =20
interferences between protocols...


On another note, having multiple input nodes is a relevant question =20
when dealing with multitouch anyway. Let me take an example: consider =20
two users, each interacting with their own application in its own =20
window but on the same display. Now, consider these two input =20
possibilities: either each has their own mouse, or they both use the =20
same dual-touch panel. In the first case, each app can open its own =20
input node; in the second, they need to share the same device and =20
perform some filtering to extract the events they want (user1 or =20
user2). The symmetry breaking between the two situations is not =20
satisfactory: you need to change the code in the apps.

With this regard, I am a big fan of the idea of having hierarchical =20
devices, just like with have hierarchical file systems. Each finger =20
on the dual-touch panel would be a device, child of the panel device. =20
Each would be equivalent to a mouse, and voila, the symmetry is =20
restored. Conceptually, saying (panel/finger1, any event) or (panel, =20
finger1 events) are equivalent; but in the first case the routing is =20
done by the OS and in the second case it has to be done by the app, =20
which breaks reusability. There are other interesting perspectives, =20
but I don't want to get carried away too much.

St.



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
