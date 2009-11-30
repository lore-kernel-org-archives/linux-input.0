From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: usbtouchscreen - add support for ET&T TC5UH
	touchscreen controller
Date: Mon, 30 Nov 2009 00:10:12 -0800
Message-ID: <20091130081011.GB10295@core.coreip.homeip.net>
References: <1259405677-9416-1-git-send-email-ynezz@true.cz> <20091129053020.GT6936@core.coreip.homeip.net> <20091129113659.GB31105@ibawizard.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f188.google.com ([209.85.216.188]:38638 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891AbZK3IKK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2009 03:10:10 -0500
Received: by pxi26 with SMTP id 26so2401898pxi.21
        for <linux-input@vger.kernel.org>; Mon, 30 Nov 2009 00:10:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091129113659.GB31105@ibawizard.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@novell.com>

On Sun, Nov 29, 2009 at 12:36:59PM +0100, Petr =C5=A0tetiar wrote:
> Dmitry Torokhov <dmitry.torokhov@gmail.com> [2009-11-28 21:30:21]:
>=20
> > The link abouve mentions HID compliance? Does it not wok properly w=
ith
> > HID driver? Do we need to blacklist it in HID?
>=20
> Thinking about it again, we maybe need to blacklist it in HID, becaus=
e it
> can be picked up by hidraw driver.
>=20

OK, I applied th epatch to the 'next' branch, please send the blacklist
patch to Jiri.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
