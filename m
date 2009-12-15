From: =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Subject: Re: [RFC] HID and multitouch
Date: Tue, 15 Dec 2009 18:25:54 +0100
Message-ID: <822755D9-53E6-471B-B4FE-E4CEF060503E@enac.fr>
References: <95A5C232-DB80-4186-B473-0D2593E57691@enac.fr> <alpine.LNX.2.00.0912151500160.3755@pobox.suse.cz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:38212 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574AbZLOR0I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Dec 2009 12:26:08 -0500
In-Reply-To: <alpine.LNX.2.00.0912151500160.3755@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Rafi Rubin <rafi@seas.upenn.edu>, Peter Hutterer <peter.hutterer@who-t.net>


Le 15 d=E9c. 09 =E0 15:05, Jiri Kosina a =E9crit :
>>
>> - the one-to-one mapping between HID and evdev is stretched to its
>> limits with these devices that have several times the same group =20
>> of HID
>> fields in the same event: an event is made of fingers, each finger i=
s
>> made of an X, a Y and a few other fields. We need a mechanism to emi=
t
>> SYN_MT_REPORT between fingers.
>
> This should be rather striaghtforward, right? I don't see any =20
> principal
> issue here. If you provide such patch, I will happuly merge it.
>
> Introducing wrapper around hidinput_hid_event() which drivers for
> multitouch devices will be using should be sufficient, shouldn't it?
>

OK. As soon as I have some time (january?) I'll have a look at this.


>> - furthermore, some fingers have to be discarded because they are
>> placeholders with no valid data, and we know if to dump them only =20
>> when
>> they have been fully parsed. Therefore, we need a mechanism to cache
>> finger data until the decision is made. Currently, the caching =20
>> mechanism
>> has to be device-dependent because the fields are not exactly the =20
>> same
>> and they come in a device-dependent order.
>
> What kind of caching is required here? Is there any upper bound
> approximation on the amount of data that need to be cached?

Usually, we are speaking about x, y, w, h, id, pressure, each between =20
16 and 32 bits. If we want to perform single touch emulation (useful =20
for using the panels with current applications), some devices require =20
that we cache all fingers. In that case, multiply this by 6 to 10.

>
> Would simple infrastructure, introducing linked list of [usage, value=
]
> tuples, together with "flush()" method, that will again only call
> hidinput_hid_event multiple times, be enough to be common for all =20
> drivers
> needing this?


Er, I guess yes. Less comfortable that the current device-specific =20
struct, but probably OK.

St.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
