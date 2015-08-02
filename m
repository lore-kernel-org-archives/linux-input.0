From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 05/15] drivers: input: Drop unlikely before
 IS_ERR(_OR_NULL)
Date: Sun, 2 Aug 2015 17:43:52 +0200
Message-ID: <20150802154352.GA28860@amd>
References: <cover.1438331416.git.viresh.kumar@linaro.org>
 <20150731165841.GD5613@dtor-ws>
 <20150801112251.GK899@linux>
 <201508011344.59372@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54562 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbbHBPny (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Aug 2015 11:43:54 -0400
Content-Disposition: inline
In-Reply-To: <201508011344.59372@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, akpm@linux-foundation.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Masaki Ota <masaki.ota@jp.alps.com>

On Sat 2015-08-01 13:44:59, Pali Roh=E1r wrote:
> On Saturday 01 August 2015 13:22:51 Viresh Kumar wrote:
> > On 31-07-15, 09:58, Dmitry Torokhov wrote:
> > > On Fri, Jul 31, 2015 at 02:08:25PM +0530, Viresh Kumar wrote:
> > > > IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag an=
d
> > > > there is no need to do that again from its callers. Drop it.
> > >=20
> > > I'd rather keep it as it documents the expected behavior and doub=
le
> > > unlikely should work just fine.
> >=20
> > TBH, I don't really agree that it is there for documentation. The
> > only purpose of such compiler flags is to try make code more
> > efficient.
> >=20
> > Anyway, I got to this series as someone asked me to fix this for on=
e
> > of my patches which used unlikely(IS_ERR_OR_NULL()). And so I
> > thought about fixing all sites that are doing double unlikely (that
> > shouldn't hurt for sure).
> >=20
> > I will leave it to you.
>=20
> I think that unlikely() macro here make code more readable. Yes, it i=
s=20
> also for compiler optimization, but also for me it looks like Clean C=
ode=20
> pattern <https://de.wikipedia.org/wiki/Clean_Code> -- is not it?

People know that errors are unlikely, no need to tell them. I'd remove
it.
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
