From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Q] max11801 licensing terms
Date: Wed, 17 Aug 2011 10:45:10 -0700
Message-ID: <20110817174510.GF4877@core.coreip.homeip.net>
References: <201108171431.26470.brian.foster@maxim-ic.com>
 <CACrgxGB0RaxhbPfU34L3b-1vPEDYf5M7Z8q2HKoKEQ8YcuFCsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:34900 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab1HQRpQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 13:45:16 -0400
Received: by iye16 with SMTP id 16so2296425iye.1
        for <linux-input@vger.kernel.org>; Wed, 17 Aug 2011 10:45:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACrgxGB0RaxhbPfU34L3b-1vPEDYf5M7Z8q2HKoKEQ8YcuFCsw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Jiejing.Zhang " <kzjeef@gmail.com>
Cc: Brian Foster <brian.foster@maxim-ic.com>, Zhang Jiejing <jiejing.zhang@freescale.com>, Joonyoung Shim <jy0922.shim@samsung.com>, linux-input@vger.kernel.org, Jean-Marc Simohand <JeanMarc.Simohand@maxim-ic.com>

On Wed, Aug 17, 2011 at 09:24:32PM +0800, Jiejing.Zhang  wrote:
> Hi Brian Foster,
>=20
> >     * Based on mcs5000_ts.c
> I have referenced mcs5000_ts.c source code when writing this driver,
> but I don't think it's a big deal, I really reference lots of files.
>=20
> > =C2=A0What does =E2=80=9Ceither version 2 of the License.=E2=80=9D =
mean?
> > =C2=A0Either GPLv2 or what?
>=20
> Yes, I think it means GPLv2, I'm not really not very care about these
> license, just copy other files under driver/input/ directory.

mcs5000_ts.c (and m97xx-core.c it was derived from) are GPLv2 or later
so max11801_ts.c shoudl folow the same licensing terms, but it seems th=
e
statement was truncated.

Jiejing, could you please send me a patch restoring the proper wording
so there won't be any confusion in the future?

Thanks!

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
