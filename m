From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: wistron_btns-add-support-for-x86_64-systems.patch in -mm
Date: Sun, 6 Jan 2008 00:28:26 +0000
Message-ID: <200801060028.27102.carlos@strangeworlds.co.uk>
References: <20071223144756.GA4827@basil.nowhere.org> <477FC3C6.8070607@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:53345 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbYAFA2b (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Jan 2008 19:28:31 -0500
In-Reply-To: <477FC3C6.8070607@yahoo.fr>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?q?R=E9mi_H=E9rilier?= <rherilier@yahoo.fr>
Cc: Andi Kleen <andi@firstfloor.org>, akpm@osdl.org, linux-kernel@vger.kernel.org, dtor@mail.ru, linux-input@vger.kernel.org

On Saturday 05 January 2008 17:52:06 R=E9mi H=E9rilier wrote:
> What about finding what does this BIOS function and writing
> an equivalent in C? There would be no BIOS call anymore and
> this module could be used in the x86-64 port.
>
> But, is it a sane solution?

The problem is that the BIOS call would be unique to each supported mac=
hine as=20
in which memory addresses, EC registers etc get touched and with what v=
alues.=20
You would end up needing to reimplement this on a case-by-case basis. T=
his=20
was an idea that was considered by acerhk, but they considered it far t=
oo=20
much work and completely impractical.

=46or at least all modern Acer laptops, this direct BIOS calling is com=
pletely=20
deprecated, in favour of ACPI-WMI (which in turn, on those systems, usu=
ally=20
either triggers SMI traps or touches EC registers, and is 32/ 64 bit=20
agnostic), so the question for those laptops is becoming more and more=20
irrelevant (and modern Acer laptops of the last four years, at least, d=
on't=20
have problems with missing keycodes that require us to poll).

=46or Fujitsu-Siemens laptops, I did come across someone who was lookin=
g into=20
poking at ACPI to generate keypresses for the keys that don't generate=20
standard keycodes[1], as a 32/ 64 bit agnostic solution (since most Fuj=
itsu=20
Siemens laptops don't support the required BIOS call from long mode, an=
d also=20
still don't produce standard keycodes on certain button presses).

-Carlos

[1] http://code.google.com/p/fscamiloa16xx/
--=20
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
