From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Wed, 13 Oct 2010 13:37:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010131335580.2311-100000@iolanthe.rowland.org>
References: <AANLkTi=ouKDuPgUgLOwfBPhWKM=RCoh8hb0tY3h53i2r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56457 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751440Ab0JMRhz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 13:37:55 -0400
In-Reply-To: <AANLkTi=ouKDuPgUgLOwfBPhWKM=RCoh8hb0tY3h53i2r@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar <sunder.svit@gmail.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>

On Wed, 13 Oct 2010, Sundar wrote:

> On Wed, Oct 13, 2010 at 7:40 PM, Alan Stern <stern@rowland.harvard.ed=
u> wrote:
> >
> > Absolutely. =A0Another point worth mentioning is that a device in
> > runtime-suspend can be resumed at any time, for a variety of reason=
s
> > unconnected with anything the user does. =A0While it is back at ful=
l
> > power, there is nothing to stop it from generating events.
> >
>=20
> Well, so are you still aligned that we can support low power or enabl=
e/disable
> switches for devices via the standard PM helpers; even if it is the "=
accelerated
> suspend" way ( if Rafael thinks otherwise)

Sorry, I don't quite understand your question.  I think it would be
okay to add an interface for userspace to cut short a runtime-suspend
delay, but I don't think anything more is needed.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
