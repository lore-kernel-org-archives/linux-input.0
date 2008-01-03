From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: PATCH] adding wistron_btns support for X86_64 systems.
Date: Thu, 3 Jan 2008 11:21:55 -0500
Message-ID: <d120d5000801030821h21996040s1e1743ac8ceb2370@mail.gmail.com>
References: <200712222040.14422.carlos@strangeworlds.co.uk>
	 <477C10AD.7060303@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:15382 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599AbYACQV5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Jan 2008 11:21:57 -0500
Received: by mu-out-0910.google.com with SMTP id i10so4763167mue.5
        for <linux-input@vger.kernel.org>; Thu, 03 Jan 2008 08:21:55 -0800 (PST)
In-Reply-To: <477C10AD.7060303@yahoo.fr>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?R=E9mi_H=E9rilier?= <rherilier@yahoo.fr>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi R=E9mi,

On Jan 2, 2008 5:31 PM, R=E9mi H=E9rilier <rherilier@yahoo.fr> wrote:
> Carlos Corbacho wrote:
> > (CC'ing linux-input, as that is the relevant subsystem list for wis=
tron-btns).
> >
> > R=E9mi H=E9rilier wrote:
> >> To use my previous patch (wistron_btns support for fujitsu-siemens=
 amilo
> >> pro edition v3505) with my laptop, I need to make the wistron modu=
le
> >> compile for x86_64. It is based on Linux 2.4.24-rc4 too.
> >
> > NAK.
> >
> > You cannot make 32 bit BIOS calls in a 64 bit OS.
> >
> > This will (and does) segfault on x86-64 (tested on my Aspire 5020, =
where
> > call_bios wistron-btns just segfaults on x86-64 with this patch).
> >
> > This is a known issue, and the reason why wistron-btns (and the out=
-of-tree
> > acerhk) have not been ported to x86-64.
> >
> > -Carlos
>
> Yes, in theory, this must segfault on x86-64.
>
> In pratice, there is one laptop where it seems to works (no problem
> for 3 weeks). A good reason to find why.
>

My concern that even on that particular model this may stop wotking if
you upgrade BIOS. Otherwise the fact that it doe snot work on some
other laptop should not stop us - we using DMI matching in wistron
buttons anyway.

--=20
Dmitry
-
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
