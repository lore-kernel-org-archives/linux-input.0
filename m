From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: usbtouchscreen - add support for ET&T TC4UM
 touchscreen controller
Date: Mon, 28 Jun 2010 09:46:03 -0700
Message-ID: <20100628164603.GC11670@core.coreip.homeip.net>
References: <20100603075720.GQ26052@ibawizard.net>
 <1276242054-11127-1-git-send-email-ynezz@true.cz>
 <20100628091959.GH15039@ibawizard.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:52500 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab0F1QqJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jun 2010 12:46:09 -0400
Received: by pxi8 with SMTP id 8so1885562pxi.19
        for <linux-input@vger.kernel.org>; Mon, 28 Jun 2010 09:46:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100628091959.GH15039@ibawizard.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@novell.com>

On Mon, Jun 28, 2010 at 11:19:59AM +0200, Petr =C5=A0tetiar wrote:
> Petr =C5=A0tetiar <ynezz@true.cz> [2010-06-11 09:40:53]:
>=20
> > This patch adds support for the ET&T TC4UM 4-wire USB touchscreen c=
ontroller
> > and tries to reuse the bits for TC5UH controller in kernel already.=
 Data
> > interface is same.
> >=20
> > Tested-by: Roger Pueyo Centelles <rogerpueyo@rogerpueyo.com>
> > Signed-off-by: Petr =C5=A0tetiar <ynezz@true.cz>
> > ---
>=20
> Hi Dmitry,
>=20
> you're probably overloaded, so just a small ping :-) Thanks.
>=20

Hi Petr,

Applied to 'next' branch (for .36). But I was wondering - could you
please try the runtime PM patches to usebtouchscreen posted by Oliver
Neukum on the linux-input list? I'd really like to apply them but
I'd like to have them tested first.

Thank you!

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
