From: Sundar <sunder.svit@gmail.com>
Subject: Re: [linux-pm] [RFC] input: syfs switches for SKE keypad
Date: Wed, 13 Oct 2010 22:55:51 +0530
Message-ID: <AANLkTi=ouKDuPgUgLOwfBPhWKM=RCoh8hb0tY3h53i2r@mail.gmail.com>
References: <20101013095737.GI6424@rakim.wolfsonmicro.main>
	<Pine.LNX.4.44L0.1010131007310.2311-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:59518 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744Ab0JMRZx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Oct 2010 13:25:53 -0400
Received: by ywi6 with SMTP id 6so1625227ywi.19
        for <linux-input@vger.kernel.org>; Wed, 13 Oct 2010 10:25:53 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1010131007310.2311-100000@iolanthe.rowland.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>

On Wed, Oct 13, 2010 at 7:40 PM, Alan Stern <stern@rowland.harvard.edu>=
 wrote:
>
> Absolutely. =A0Another point worth mentioning is that a device in
> runtime-suspend can be resumed at any time, for a variety of reasons
> unconnected with anything the user does. =A0While it is back at full
> power, there is nothing to stop it from generating events.
>

Well, so are you still aligned that we can support low power or enable/=
disable
switches for devices via the standard PM helpers; even if it is the "ac=
celerated
suspend" way ( if Rafael thinks otherwise)

Cheers!
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
