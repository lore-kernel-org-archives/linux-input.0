From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] elantech: Report tool width when it is known
Date: Wed, 5 May 2010 09:39:51 -0700
Message-ID: <20100505163951.GB7337@core.coreip.homeip.net>
References: <4BE16121.8040000@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:43785 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932922Ab0EEQkB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 12:40:01 -0400
Received: by wwb13 with SMTP id 13so8083wwb.19
        for <linux-input@vger.kernel.org>; Wed, 05 May 2010 09:39:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4BE16121.8040000@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Wed, May 05, 2010 at 02:14:25PM +0200, =C9ric Piel wrote:
> >From observation of the values sent from the hardware version 2, it
> seems that the first four bits of byte 1 represents the width. So we =
can
> report it as well. Observed values on my hardware were always between=
 1
> and 12, so let's use this for min and max.
>=20

I think we shoudl have threshold for the firmware version when we start
reporting the width.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
