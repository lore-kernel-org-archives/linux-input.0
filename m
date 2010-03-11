From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Thu, 11 Mar 2010 10:42:27 +0100
Message-ID: <BF245800-6DFE-40EC-9815-131510849F11@enac.fr>
References: <4B75E14A.2050602@seas.upenn.edu>  <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu>  <4B760D60.6020907@seas.upenn.edu>  <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz>  <4B96B740.7020208@euromail.se> <4B96BAF1.5070209@seas.upenn.edu>  <alpine.LNX.2.00.1003092218530.17799@pobox.suse.cz>  <5423752A-3AE0-4848-9149-B0C01B0BCA39@enac.fr>  <4B96CAD4.4010407@euromail.se>  <45cc95261003091442t70d08311u13642aac7bc4f3f3@mail.gmail.com> <20100311043034.GA30166@barra.bne.redhat.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:47979 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878Ab0CKJmd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Mar 2010 04:42:33 -0500
In-Reply-To: <20100311043034.GA30166@barra.bne.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Mohamed Ikbel Boulabiar <boulabiar@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Rafi Rubin <rafi@seas.upenn.edu>, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com




Le 11 mars 10 =E0 05:30, Peter Hutterer a =E9crit :

> On Tue, Mar 09, 2010 at 11:42:34PM +0100, Mohamed Ikbel Boulabiar =20
> wrote:
>>> A hierarchy is imposing an unnecessary restriction on the graph =20
>>> of possible
>>> relations between point devices. Consider for instance the case =20
>>> of two people,
>>> each with one finger on the panel. The hierarchy says panel-=20
>>> person1-finger1 and
>>> panel-person2-finger1. Now have them move close enough for the =20
>>> fingers to touch.
>>> The hierarchy now says panel-person-(finger1, finger2). Symmetry =20
>>> breaking once more.
>>>
>>> The main point here is that however the data reaches userland, it =20
>>> will have to
>>> be processed intelligibly and collectively. The point of =20
>>> processing could be an
>>> MT X Driver, it could be some other input section, but it is has =20
>>> to be done
>>> somewhere.
>>>
>>> Henrik
>>
>>
>> The hierarchy applied on multitouch isn't the best example to prove
>> benefits of it.
>> Hierarchy is useful with some complex input devices that have many
>> axes, many buttons some accelerometers, but that are hierarchical =20
>> from
>> the source (integrality/separability ?).
>> Then providing them as hierarchy can be useful.
>
> Are we talking about real input devices here or a hypothetical device=
?
> If the former, what are examples for such an input device?

A Wacom Cintiq is made of a touch panel, a bunch of buttons and two =20
sliders. Wait, there also are the thousands of pens that Wacom =20
shipped, each with a unique ID! If I own three of them, Wacom allows =20
my app to be interested only in the events from pen number 2. So, in =20
my mind, the Cintiq's touch panel is "made" of three pens. Two levels =20
of hierarchy.

OK, I admit that there is some multitouch in this example. Let's take =20
one without multitouch. I have an RFID reader and dozens of RFID tags =20
embedded in identification badges. Say my app is only interested in =20
badge #123 entering or leaving the proximity area of my reader. It's =20
useful to consider badge #123 as a device with two events (enter/=20
leave), subdevice of the RFID system.

The left button of my mouse is a button. Why am I not allowed to =20
focus on it as a device?

Today's application programmers have to bear with a definition of =20
"device" that is centered on the hardware USB architecture that some =20
electronic company has deemed optimal for their purposes. That =20
definition has very little to do with any kind of semantic =20
equivalence between device (same behaviour, same protocol), and even =20
less to do with any kind of usage pattern. This was bearable when =20
there were only mice, keyboards, and a few exotic devices; it will =20
become more and more of a problem with ubiquitous computing on the =20
horizon.

St.


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
