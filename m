From: Philipp Merkel <mail@philmerk.de>
Subject: Re: Fix for problems with eGalax/DWAV multi-touch-screen
Date: Tue, 28 Sep 2010 21:51:48 +0200
Message-ID: <1285703508.1653.24.camel@PhEeeTab>
References: <1284476919.3732.10.camel@PhEeeTab>
	 <4CA242B7.7020609@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.planet-school.de ([194.116.187.5]:59109 "EHLO
	turboconrad.planet-school.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755101Ab0I1Tvy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Sep 2010 15:51:54 -0400
In-Reply-To: <4CA242B7.7020609@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: chatty@enac.fr, linux-input@vger.kernel.org

Henrik Rydberg wrote:
> I have looked at the joojoo (0eef:720c), and constructed a driver for=
 it using
> MT slots. If would be great if it could be merged with the 0eef:480d =
in the
> hid-egalax driver, but there are some things to work out before that =
can happen.
> Here are some observations from the joojoo:
>=20
> 1) The HID report says the x/y coordinates are in the 4096 range, but=
 in
> actuality, they are 32kx32k it seems.

Thanks for testing! Okay, so the 0eef:720c also suffers from the
three-bit-shift problem my patch addresses. I think it can now be safel=
y
applied, or what do you think, St=C3=A9phane? Getting your Acked-by?

Of course, this is only an intermediate step that will solve the
problems of the 0eef:480d and correct the coordinates of the 0eef:720c,
but note solve the multitouch prolem on the latter. I would be glad to
test your driver on the 0eef:480d, Henrik, I will send you (and
St=C3=A9phane) a message off-list about that.

Best Regards
Philipp

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
