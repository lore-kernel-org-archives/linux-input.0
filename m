From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in JooJoo tablet
Date: Tue, 17 Aug 2010 09:49:39 +0200
Message-ID: <BFCA5963-D589-434B-B07B-6899A794F28F@enac.fr>
References: <4C695985.5080403@bitmath.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:47048 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab0HQHtp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Aug 2010 03:49:45 -0400
In-Reply-To: <4C695985.5080403@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input <linux-input@vger.kernel.org>


Le 16 ao=FBt 10 =E0 17:30, Henrik Rydberg a =E9crit :

> St=E9phane, Jiri,
>
> Regarding the several-hid-packets-per-actual-input-packet problem, =20
> what do you
> think about constructing a special MT HID device, using raw_event? =20
> It could
> encapsulate the current protocol a bit better and use the full HID =20
> extension.
>

Hi Henrik

This sounds like as a interesting direction for building a generic =20
driver for MT devices. However, there still are device specificities =20
that we need to deal with:
  - the serial/parallel/hybrid issue, for which we have ideas but =20
still nothing firm;
  - some devices need to be set in multitouch mode; we need some =20
research to find out if this can be determined automatically from the =20
report descriptors;
  - the single touch emulation is highly device dependent. I was (and =20
still am) pretty proud of my choice of tracking the 'oldest' finger =20
on the panel: this turns multitouch panels into single touch panels =20
that are impervious to parasite touches. But the drawback is that =20
currently there is no generic method for this tracking: I used =20
whatever device-specific information I could use (order of fingers in =20
a message, tracking id, etc).

As long as these issues are here, we still need a system for =20
implementing device-specific behaviour. I must admit I was tempted to =20
keep benefitting from the blacklist in hid-core.c until they are =20
resolved.

An additional question is: how do we decide that a device is a =20
multitouch one? Do we keep a list of devices? Or do we rely on a =20
pattern found in the report descriptors? In my view it would be great =20
to have a pattern matching system for identifying classes of input =20
devices from report descriptors, but then it would reacher farther =20
than multitouch only.

Cheers,

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
