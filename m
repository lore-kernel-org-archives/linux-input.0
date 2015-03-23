From: Borislav Petkov <bp@alien8.de>
Subject: Re: Logitech T650 is unusable since 3.19.0
Date: Mon, 23 Mar 2015 10:09:20 +0100
Message-ID: <20150323090920.GA32082@pd.tnic>
References: <CAJc7LbqPY0hcF-JJh+NUDws8UcoMRfodzZ35q34BPQ+3JAktCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:56876 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbbCWJLC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Mar 2015 05:11:02 -0400
Content-Disposition: inline
In-Reply-To: <CAJc7LbqPY0hcF-JJh+NUDws8UcoMRfodzZ35q34BPQ+3JAktCA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?0JvQtdC20LDQvdC60LjQvSDQmNCy0LDQvQ==?= <abyss.7@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

CC people.

On Mon, Mar 23, 2015 at 11:21:02AM +0300, =D0=9B=D0=B5=D0=B6=D0=B0=D0=BD=
=D0=BA=D0=B8=D0=BD =D0=98=D0=B2=D0=B0=D0=BD wrote:
> Hi,
>=20
> after update from 3.18.7 to 3.19.x my Logitech touchpad became almost
> unusable. I use OpenSUSE Thumbleweed and tried both custom and vanill=
a
> kernels. AFAIK, the problem may come with this changes:
> http://lkml.iu.edu/hypermail/linux/kernel/1412.1/03246.html
>=20
> The symptoms are as follows.
>=20
> 1. The touch density is twice reduced: I have to make longer finger
> motion for a smaller pointer movement. Possibly, it's because the KDE
> starts to detect the touchpad as touchpad - and not the mouse as it
> was before - and applies some preferences like the pointer
> acceleration, etc.
>=20
> 2. Some gestures stopped to work: 3-finger swipe up, down, left, righ=
t
> - so, there are no more "history back-forward", "SuperKey", and
> "SuperKey + d".
>=20
> 3. Multi-finger tap detection is awful: it doesn't detect 3-finger ta=
p
> in 50%, it sometimes detects 2-finger tap instead of click+drag, or
> when the second finger is slightly touching the surface.
>=20
> Can anyone make a suggestion what should I do, but to stay on an olde=
r
> kernel version?
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

--=20
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
