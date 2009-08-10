From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: ads7846: clean up, fix pressure reporting
Date: Mon, 10 Aug 2009 22:10:48 +0100
Message-ID: <1249938648.22268.190.camel@dax.rpnet.com>
References: <20090807180941.GF1728@ucw.cz>
	 <1249813293.4334.24.camel@utx.utx.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753925AbZHJVMs@vger.kernel.org>
In-Reply-To: <1249813293.4334.24.camel@utx.utx.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Stanislav Brabec <utx@penguin.cz>
Cc: Pavel Machek <pavel@ucw.cz>, dtor@mail.ru, linux-input@vger.kernel.org, lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>, Dirk@Opfer-Online.de, arminlitzel@web.de, Cyril Hrubis <metan@ucw.cz>, thommycheck@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, dbaryshkov@gmail.com, omegamoon@gmail.com, eric.miao@marvell.com
List-Id: linux-input@vger.kernel.org

On Sun, 2009-08-09 at 12:21 +0200, Stanislav Brabec wrote:
> Pavel Machek wrote:
> > Fix pressure reporting, and clean up debug prints.
>=20
> Thanks.
>=20
> I see much bigger problem with both the old driver and the new ads784=
6
> driver (2.6.30): They are very noisy on my spitz. When you tap to one
> place, keep stylus pressed and just read values, you get 20-200 pixel=
s
> long pointer motion trip each second.
>=20
> According to Cyril Hrubi=C5=A1, it is caused by the electrical noise =
that
> originates in the LCD display. The driver needs to read data
> synchronously with the LCD refresh. He already made the fix for colli=
e
> several years ago.

This is what I've been led to believe as well. There was code in the ol=
d
driver to try and avoid this by only taking touchscreen readings when
the LCD wasn't electrically active but it sounds like this has become
broken :(.

Cheers,

Richard


--=20
Richard Purdie
Intel Open Source Technology Centre
