From: =?ISO-8859-1?Q?R=E9mi_H=E9rilier?= <rherilier@yahoo.fr>
Subject: Re: PATCH] adding wistron_btns support for X86_64 systems.
Date: Wed, 02 Jan 2008 23:31:09 +0100
Message-ID: <477C10AD.7060303@yahoo.fr>
References: <200712222040.14422.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp102.plus.mail.mud.yahoo.com ([68.142.206.235]:42686 "HELO
	smtp102.plus.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753110AbYACAhg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Jan 2008 19:37:36 -0500
In-Reply-To: <200712222040.14422.carlos@strangeworlds.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-kernel@vger.kernel.org, dtor@mail.ru, linux-input@vger.kernel.org

Carlos Corbacho wrote:
> (CC'ing linux-input, as that is the relevant subsystem list for wistr=
on-btns).
>=20
> R=E9mi H=E9rilier wrote:
>> To use my previous patch (wistron_btns support for fujitsu-siemens a=
milo
>> pro edition v3505) with my laptop, I need to make the wistron module
>> compile for x86_64. It is based on Linux 2.4.24-rc4 too.
>=20
> NAK.
>=20
> You cannot make 32 bit BIOS calls in a 64 bit OS.
>=20
> This will (and does) segfault on x86-64 (tested on my Aspire 5020, wh=
ere =20
> call_bios wistron-btns just segfaults on x86-64 with this patch).
>=20
> This is a known issue, and the reason why wistron-btns (and the out-o=
f-tree=20
> acerhk) have not been ported to x86-64.
>=20
> -Carlos

Yes, in theory, this must segfault on x86-64.

In pratice, there is one laptop where it seems to works (no problem
for 3 weeks). A good reason to find why.


Best regards

Remi Herilier
-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
