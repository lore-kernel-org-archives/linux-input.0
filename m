From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: __initdata and struct dmi_system_id?
Date: Sun, 14 Sep 2008 15:38:29 -0300
Message-ID: <20080914183829.GB18150@khazad-dum.debian.net>
References: <48C0C786.5020809@freemail.hu> <48CCBD83.1030001@freemail.hu> <20080914113316.GA27289@khazad-dum.debian.net> <48CD3B4C.8010106@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:32803 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753849AbYINTAz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Sep 2008 15:00:55 -0400
Content-Disposition: inline
In-Reply-To: <48CD3B4C.8010106@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: Helge Deller <deller@gmx.de>, Jan Beulich <jbeulich@novell.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Sun, 14 Sep 2008, N=E9meth M=E1rton wrote:
> Henrique de Moraes Holschuh wrote:
> > On Sun, 14 Sep 2008, N=E9meth M=E1rton wrote:
> >> The other interesting question on this topic is that what about th=
e
> >> error message strings which are used as parameter of the printk() =
calls.
> >> Those strings are combined together for a function which is marked=
 with
> >> __init and the functions which are normal functions. The strings w=
hich
> >> are only used by the functions marked with __init could be freed, =
but
> >> the strings of the normal functions shouldn't be.
> >=20
> > Yeah, if we could get them all in a init.rodata section, we could j=
ust throw
> > them away along with the init section afterwards...
> >=20
> > I do think I have seen a patch about init.rodata in LKML not too lo=
ng ago,
> > though.
>=20
> Do you mean this one?

Yeah.  I don't know if it does (or is related to) what you want, though=
=2E

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
