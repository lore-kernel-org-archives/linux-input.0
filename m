From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: PATCH] adding wistron_btns support for X86_64 systems.
Date: Sat, 22 Dec 2007 20:40:13 +0000
Message-ID: <200712222040.14422.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:38047 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbXLVUmA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Dec 2007 15:42:00 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?q?R=E9mi_H=E9rilier?= <rherilier@yahoo.fr>
Cc: linux-kernel@vger.kernel.org, dtor@mail.ru, linux-input@vger.kernel.org

(CC'ing linux-input, as that is the relevant subsystem list for wistron=
-btns).

R=E9mi H=E9rilier wrote:
> To use my previous patch (wistron_btns support for fujitsu-siemens am=
ilo
> pro edition v3505) with my laptop, I need to make the wistron module
> compile for x86_64. It is based on Linux 2.4.24-rc4 too.

NAK.

You cannot make 32 bit BIOS calls in a 64 bit OS.

This will (and does) segfault on x86-64 (tested on my Aspire 5020, wher=
e =20
call_bios wistron-btns just segfaults on x86-64 with this patch).

This is a known issue, and the reason why wistron-btns (and the out-of-=
tree=20
acerhk) have not been ported to x86-64.

-Carlos
--=20
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
