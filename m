From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Disable input device
Date: Sat, 6 Dec 2014 13:47:08 +0100
Message-ID: <20141206124708.GA17289@amd>
References: <201411291824.03996@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48445 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaLFMrK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Dec 2014 07:47:10 -0500
Content-Disposition: inline
In-Reply-To: <201411291824.03996@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

On Sat 2014-11-29 18:24:03, Pali Roh=E1r wrote:
> Hello,
>=20
> there is request to introduce some option (via sysfs) to disable=20
> one input device. Originally it was for tsc2005 touchscreen found=20
> on Nokia N900 cellphone. Use case is to completely disable=20
> touchscreen when phone is in pocket or when screen is locked via=20
> slide switch (to prevent random clicks).
>=20
> But it would be better to have disable option for all input=20
> devices. Sometimes input device is not use and only consume=20
> power. Another case is when input device (e.g. keyboard or=20
> touchpad) is integrated into machine (e.g. on laptops) and user=20
> does not want to use it (so make sure that kernel does not send=20
> events to userspace).
>=20
> I would like to ask, how to solve it?
>=20
> What do you think about adding new sysfs file "disable" (accept=20
> values 1 or 0) for every input device? With "1" it cause that=20
> kernel will drop all events from specific input device and if=20
> driver provide some function is can be called (e.g. for power=20
> management or disabling device at hardware level).

That makes sense to me. Dmitry, would such interface be acceptable?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
