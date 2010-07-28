From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: Multikey autorepetition
Date: Wed, 28 Jul 2010 16:10:03 +1000
Message-ID: <20100728061003.GB17057@quokka.bne.redhat.com>
References: <E1Od5v6-0004iL-00.aeforeve-mail-ru@f207.mail.ru>
 <20100726085905.GC27151@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:57013 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab0G1Gjo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jul 2010 02:39:44 -0400
Content-Disposition: inline
In-Reply-To: <20100726085905.GC27151@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?utf-8?B?0JDQvdGC0L7QvSDQldGA0L7RhNC10LXQstGB0LrQuNC5?= <aeforeve@mail.ru>, linux-input@vger.kernel.org

On Mon, Jul 26, 2010 at 01:59:06AM -0700, Dmitry Torokhov wrote:
> Hi Anton,
>=20
> On Sun, Jul 25, 2010 at 10:27:28PM +0400, =D0=90=D0=BD=D1=82=D0=BE=D0=
=BD =D0=95=D1=80=D0=BE=D1=84=D0=B5=D0=B5=D0=B2=D1=81=D0=BA=D0=B8=D0=B9 =
wrote:
> > sory for my english
> >=20
> > Multikey autorepetition in linux and x-win
> >=20
> > Has decided to write for this purpose - that most to understand -
> > whether is it in linux a defect or and has been conceived
> >=20
> > The basic question in that is that if to press 2 keys - why one
> > repeats only?
>=20
> The kernel supports single-key software repetition so unless the devi=
ce
> itself does autorepeat then only the last key will be automatically
> repeated.
>=20
> I believe most of the hardware that has autorepeat capabilities
> does it for the last pressed key as well.

same for the X server, we ignore hardware/kernel autorepeat completely =
these
days and only do software repeat. In doing so, we only repeat one key a=
t at
time though.
=20
Cheers,
  Peter
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
