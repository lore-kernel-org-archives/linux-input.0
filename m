From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Subject: Re: [PATCH v2] input/imx_keypad: add PM support
Date: Fri, 18 Jun 2010 19:40:04 +0200
Message-ID: <1276882804.3146.14.camel@realization>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>
	 <1276856186.3146.5.camel@realization>  <4C1B84A3.8080300@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:39352 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933853Ab0FRRkP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Jun 2010 13:40:15 -0400
Received: by wyb33 with SMTP id 33so815208wyb.19
        for <linux-input@vger.kernel.org>; Fri, 18 Jun 2010 10:40:13 -0700 (PDT)
In-Reply-To: <4C1B84A3.8080300@eukrea.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, linux-arm-kernel@lists.infradead.org

On ven, 2010-06-18 at 16:37 +0200, Eric B=C3=A9nard wrote:
> Hi Alberto,
>=20
> Le 18/06/2010 12:16, Alberto Panizzo a =C3=A9crit :
> > Ok, so with this patch the keypad cannot wake the system?
> > It is scheduled another patch?
> >
> well, actually, the keypad wakes the system, at least on my board her=
e.
>=20
> I was quite surprised to get this working this way as I would have=20
> expected disable_irq + clk_disable would prevent the keypad from bein=
g a=20
> wake source.
> Can you try on your board as this cleanup may be wrong on i.MX3 ?
>=20
> Thanks,
> Eric
Well.. it is a surprise to me too. I have to look down the documentatio=
n
ad soon I will try on the mx31pdk.
I don't wont to tell you wrong things.


--=20
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
