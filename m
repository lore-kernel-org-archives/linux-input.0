From: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: __initdata and struct dmi_system_id?
Date: Sun, 14 Sep 2008 18:26:52 +0200
Message-ID: <48CD3B4C.8010106@freemail.hu>
References: <48C0C786.5020809@freemail.hu> <48CCBD83.1030001@freemail.hu> <20080914113316.GA27289@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail01d.mail.t-online.hu ([84.2.42.6]:64012 "EHLO
	mail01d.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbYINQ06 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Sep 2008 12:26:58 -0400
In-Reply-To: <20080914113316.GA27289@khazad-dum.debian.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Helge Deller <deller@gmx.de>, Jan Beulich <jbeulich@novell.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Henrique de Moraes Holschuh wrote:
> On Sun, 14 Sep 2008, N=E9meth M=E1rton wrote:
>> The other interesting question on this topic is that what about the
>> error message strings which are used as parameter of the printk() ca=
lls.
>> Those strings are combined together for a function which is marked w=
ith
>> __init and the functions which are normal functions. The strings whi=
ch
>> are only used by the functions marked with __init could be freed, bu=
t
>> the strings of the normal functions shouldn't be.
>=20
> Yeah, if we could get them all in a init.rodata section, we could jus=
t throw
> them away along with the init section afterwards...
>=20
> I do think I have seen a patch about init.rodata in LKML not too long=
 ago,
> though.

Do you mean this one?

Date: Fri, 05 Sep 2008 13:03:17 +0100
=46rom: Jan Beulich <jbeulich@novell.com>
Subject: [PATCH] .init.rodata and modpost adjustments
http://lkml.org/lkml/2008/9/5/126

Regards,

	M=E1rton N=E9meth
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
