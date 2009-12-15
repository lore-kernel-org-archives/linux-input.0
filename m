From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [RFC] HID and multitouch
Date: Tue, 15 Dec 2009 15:05:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912151500160.3755@pobox.suse.cz>
References: <95A5C232-DB80-4186-B473-0D2593E57691@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34198 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760292AbZLOOFa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2009 09:05:30 -0500
In-Reply-To: <95A5C232-DB80-4186-B473-0D2593E57691@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: linux-input@vger.kernel.org, Rafi Rubin <rafi@seas.upenn.edu>, Peter Hutterer <peter.hutterer@who-t.net>

On Sun, 6 Dec 2009, St=E9phane Chatty wrote:

> over the last few months I have been working on HID quirks for a bunc=
h=20
> of multitouch devices: NTrig, two flavours of Stantum devices, 3M, Ac=
er=20
> T230H. For each of these I have working code, which I should be able =
to=20
> submit real soon now.

Hi St=E9phane,

that's an excellent news, thanks!

> However, people are asking me questions about why a specific driver i=
s=20
> needed for each device. Answers are starting to emerge, and it looks=20
> like they might lead to some work on the Linux HID code itself:
>=20
> - the one-to-one mapping between HID and evdev is stretched to its=20
> limits with these devices that have several times the same group of H=
ID=20
> fields in the same event: an event is made of fingers, each finger is=
=20
> made of an X, a Y and a few other fields. We need a mechanism to emit=
=20
> SYN_MT_REPORT between fingers.

This should be rather striaghtforward, right? I don't see any principal=
=20
issue here. If you provide such patch, I will happuly merge it.

Introducing wrapper around hidinput_hid_event() which drivers for=20
multitouch devices will be using should be sufficient, shouldn't it?

> - furthermore, some fingers have to be discarded because they are=20
> placeholders with no valid data, and we know if to dump them only whe=
n=20
> they have been fully parsed. Therefore, we need a mechanism to cache=20
> finger data until the decision is made. Currently, the caching mechan=
ism=20
> has to be device-dependent because the fields are not exactly the sam=
e=20
> and they come in a device-dependent order.

What kind of caching is required here? Is there any upper bound=20
approximation on the amount of data that need to be cached?

Would simple infrastructure, introducing linked list of [usage, value]=20
tuples, together with "flush()" method, that will again only call=20
hidinput_hid_event multiple times, be enough to be common for all drive=
rs=20
needing this?

Thanks,

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
