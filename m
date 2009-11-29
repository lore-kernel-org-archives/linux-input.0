From: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Subject: Re: [PATCH] Input: usbtouchscreen - add support for ET&T TC5UH
	touchscreen controller
Date: Sun, 29 Nov 2009 11:53:57 +0100
Message-ID: <20091129105357.GA31105@ibawizard.net>
References: <1259405677-9416-1-git-send-email-ynezz@true.cz> <20091129053020.GT6936@core.coreip.homeip.net>
Reply-To: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:50195 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbZK2LBY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2009 06:01:24 -0500
Content-Disposition: inline
In-Reply-To: <20091129053020.GT6936@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>, linux-input@vger.kernel.org, Jiri Kosina <jikos@novell.com>

Dmitry Torokhov <dmitry.torokhov@gmail.com> [2009-11-28 21:30:21]:

> Hi Petr,

Hi Dmitry,

> On Sat, Nov 28, 2009 at 11:54:37AM +0100, Petr =A9tetiar wrote:
> > This patch adds support for the ET&T TC5UH 5-wire USB touchscreen c=
ontroller.
> > More info at http://www.etandt.com.tw/board_solution.html
>=20
> Hmm, this looks like Panjit protocol, just report size is different, =
5
> vs. 8...

Yes, 5 vs 8 is only difference.

> The link abouve mentions HID compliance? Does it not wok properly wit=
h
> HID driver? Do we need to blacklist it in HID?

No, it doesn't work with HID. Maybe they claim HID compliance, but you =
need
some binary drivers to make it work anyway. I asked them for protocol
specification and they sent me just single PDF page with description of=
 that
simple 5 byte stream protocol. I wasn't unsure so I asked Jikos (Jiri K=
osina)
on IRC where should this stuff go and he told me, that it should be pla=
ced in
usbtouchscreen.

Thanks.

-- ynezz
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
