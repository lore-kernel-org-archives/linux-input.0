From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: schedule corgi_ssp and corgi_ts to be removed
Date: Tue, 9 Feb 2010 01:09:19 -0800
Message-ID: <20100209090918.GA12642@core.coreip.homeip.net>
References: <f17812d71002041645n15e502a3sccc76fc3f2e75c76@mail.gmail.com>
 <20100208180625.GB1469@ucw.cz>
 <f17812d71002081715w485b33bbx3f67afb86c6d8ee1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f202.google.com ([209.85.216.202]:54315 "EHLO
	mail-px0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab0BIJJY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Feb 2010 04:09:24 -0500
Received: by pxi40 with SMTP id 40so7202184pxi.21
        for <linux-input@vger.kernel.org>; Tue, 09 Feb 2010 01:09:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <f17812d71002081715w485b33bbx3f67afb86c6d8ee1@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

On Tue, Feb 09, 2010 at 09:15:38AM +0800, Eric Miao wrote:
> On Tue, Feb 9, 2010 at 2:06 AM, Pavel Machek <pavel@ucw.cz> wrote:
> > On Thu 2010-02-04 16:45:41, Eric Miao wrote:
> >> commit 31cec413e534520111716802833675f53ac99b0b
> >> Author: Eric Miao <eric.y.miao@gmail.com>
> >> Date: =A0 Thu Feb 4 16:41:28 2010 -0800
> >>
> >> =A0 =A0 input: schedule corgi_ssp and corgi_ts to be removed
> >>
> >> =A0 =A0 Cc: Richard Purdie <rpurdie@rpsys.net>
> >> =A0 =A0 Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> >
> > ACK.
> >
>=20
> Thanks, guys.
>=20
> Dmitry, I'm hoping these two patches will go through your tree please=
?

I have it in next, do you want it in .33 instead?

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
