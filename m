From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] hid-ntrig.c Multitouch cleanup and fix
Date: Tue, 9 Mar 2010 14:27:31 -0800
Message-ID: <20100309222731.GA29517@core.coreip.homeip.net>
References: <4B75E14A.2050602@seas.upenn.edu>
 <1266027185-5311-1-git-send-email-rafi@seas.upenn.edu>
 <4B760D60.6020907@seas.upenn.edu>
 <alpine.LNX.2.00.1002161349470.30967@pobox.suse.cz>
 <4B96B740.7020208@euromail.se>
 <4B96BAF1.5070209@seas.upenn.edu>
 <alpine.LNX.2.00.1003092218530.17799@pobox.suse.cz>
 <5423752A-3AE0-4848-9149-B0C01B0BCA39@enac.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:44000 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755001Ab0CIW1l (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 17:27:41 -0500
Received: by fxm5 with SMTP id 5so1958131fxm.29
        for <linux-input@vger.kernel.org>; Tue, 09 Mar 2010 14:27:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5423752A-3AE0-4848-9149-B0C01B0BCA39@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?St=E9phane?= Chatty <chatty@enac.fr>
Cc: Jiri Kosina <jkosina@suse.cz>, Rafi Rubin <rafi@seas.upenn.edu>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On Tue, Mar 09, 2010 at 11:03:07PM +0100, St=E9phane Chatty wrote:
>=20
> Le 9 mars 10 =E0 22:19, Jiri Kosina a =E9crit :
>=20
> >On Tue, 9 Mar 2010, Rafi Rubin wrote:
> >
> >>Since you're considering protocol clarification, what's your
> >>opinion on
> >>splitting the multi-touch and single touch (possibly emulated) to
> >>separate input devices?
> >
> >What would be the advantages?
>=20
> One would be separation of concerns. If I'm interested in single
> touch events, I'd be better off with no "multitouch noise". If I'm
> interested in low level events, I'd be better off without the
> interference created by all sorts of "clever" event emulation in
> drivers. An easy way to do this is to have a different input node
> for each protocol.
>=20
> Dmitry has already replied to this that if protocols are independent
> there is no problem with multiplexing them on the same node (I'm
> rephrasing heavily, here). Still, with multiplexing things are a bit
> less clear for programmers; this is not a clean object interface
> protocol to say the least ;-) And sometimes there even are
> interferences between protocols...

One of the main problems with splitting data into several input devices
is that it is still the same physical device, but now is potentially
handled by 2 separate drivers (unless we manage to fold entire
userspaceinto a single driver which I doubt its a good idea - I think
synaptics/evdev split worked well for non-multitouch devices) causing
double events to be reported to userspace. It is /dev/input/mice all
over again.

>=20
>=20
> On another note, having multiple input nodes is a relevant question
> when dealing with multitouch anyway. Let me take an example:
> consider two users, each interacting with their own application in
> its own window but on the same display. Now, consider these two
> input possibilities: either each has their own mouse, or they both
> use the same dual-touch panel. In the first case, each app can open
> its own input node; in the second, they need to share the same
> device and perform some filtering to extract the events they want
> (user1 or user2). The symmetry breaking between the two situations
> is not satisfactory: you need to change the code in the apps.
>=20
> With this regard, I am a big fan of the idea of having hierarchical
> devices, just like with have hierarchical file systems. Each finger
> on the dual-touch panel would be a device, child of the panel
> device. Each would be equivalent to a mouse, and voila, the symmetry
> is restored. Conceptually, saying (panel/finger1, any event) or
> (panel, finger1 events) are equivalent; but in the first case the
> routing is done by the OS and in the second case it has to be done
> by the app, which breaks reusability. There are other interesting
> perspectives, but I don't want to get carried away too much.

Theoretically it is nice but it practice the cases are differemt: with
mice you are dealing with 2 separate devices whereas with touchscreen
there is one and it is mater of interpretation whether 2 touches should
be taken as independent events or a complex gestures.


--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
