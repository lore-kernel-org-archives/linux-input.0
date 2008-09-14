From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: __initdata and struct dmi_system_id?
Date: Sun, 14 Sep 2008 08:33:16 -0300
Message-ID: <20080914113316.GA27289@khazad-dum.debian.net>
References: <48C0C786.5020809@freemail.hu> <48CCBD83.1030001@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:46302 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752544AbYINLdY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Sep 2008 07:33:24 -0400
Content-Disposition: inline
In-Reply-To: <48CCBD83.1030001@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, Helge Deller <deller@gmx.de>, linux-input@vger.kernel.org

On Sun, 14 Sep 2008, N=E9meth M=E1rton wrote:
> The other interesting question on this topic is that what about the
> error message strings which are used as parameter of the printk() cal=
ls.
> Those strings are combined together for a function which is marked wi=
th
> __init and the functions which are normal functions. The strings whic=
h
> are only used by the functions marked with __init could be freed, but
> the strings of the normal functions shouldn't be.

Yeah, if we could get them all in a init.rodata section, we could just =
throw
them away along with the init section afterwards...

I do think I have seen a patch about init.rodata in LKML not too long a=
go,
though.

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
