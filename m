From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Multikey autorepetition
Date: Mon, 26 Jul 2010 01:59:06 -0700
Message-ID: <20100726085905.GC27151@core.coreip.homeip.net>
References: <E1Od5v6-0004iL-00.aeforeve-mail-ru@f207.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59268 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab0GZI7K (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Jul 2010 04:59:10 -0400
Received: by pwi5 with SMTP id 5so4329621pwi.19
        for <linux-input@vger.kernel.org>; Mon, 26 Jul 2010 01:59:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1Od5v6-0004iL-00.aeforeve-mail-ru@f207.mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?0JDQvdGC0L7QvSDQldGA0L7RhNC10LXQstGB0LrQuNC5?= <aeforeve@mail.ru>
Cc: linux-input@vger.kernel.org

Hi Anton,

On Sun, Jul 25, 2010 at 10:27:28PM +0400, =D0=90=D0=BD=D1=82=D0=BE=D0=BD=
 =D0=95=D1=80=D0=BE=D1=84=D0=B5=D0=B5=D0=B2=D1=81=D0=BA=D0=B8=D0=B9 wro=
te:
> sory for my english
>=20
> Multikey autorepetition in linux and x-win
>=20
> Has decided to write for this purpose - that most to understand -
> whether is it in linux a defect or and has been conceived
>=20
> The basic question in that is that if to press 2 keys - why one
> repeats only?

The kernel supports single-key software repetition so unless the device
itself does autorepeat then only the last key will be automatically
repeated.

I believe most of the hardware that has autorepeat capabilities
does it for the last pressed key as well.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
