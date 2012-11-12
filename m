From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: microsoft, do not use compound literal
Date: Mon, 12 Nov 2012 13:15:08 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1211121314270.27271@pobox.suse.cz>
References: <1352711769-28911-1-git-send-email-jslaby@suse.cz> <CAMuHMdUEW9K6cfpcUNphte_VzBCL_Oa_od3892DQ3QbX5xMMnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32817 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab2KLMPM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Nov 2012 07:15:12 -0500
In-Reply-To: <CAMuHMdUEW9K6cfpcUNphte_VzBCL_Oa_od3892DQ3QbX5xMMnA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com

On Mon, 12 Nov 2012, Geert Uytterhoeven wrote:

> On Mon, Nov 12, 2012 at 10:16 AM, Jiri Slaby <jslaby@suse.cz> wrote:
> > In patch "HID: microsoft: fix invalid rdesc for 3k kbd" I fixed
> > support for MS 3k keyboards. However the added check using memcmp a=
nd
> > a compound statement breaks build on architectures where memcmp is =
a
> > macro with parameters. The error looks there like (m68k-linux-gnu-g=
cc
> > 4.1.2):
> > hid-microsoft.c:51:18: error: macro "memcmp" passed 6 arguments, bu=
t takes just 3
> > hid-microsoft.c: In function =E2=80=98ms_report_fixup=E2=80=99:
> > drivers/hid/hid-microsoft.c:50: error: =E2=80=98memcmp=E2=80=99 und=
eclared (first use in this function)
> > hid-microsoft.c:50: error: (Each undeclared identifier is reported =
only once
> > /hid-microsoft.c:50: error: for each function it appears in.)
>=20
> The above 3 lines were actually from a build with a different config
> --- which I didn't
> notice at that time --- where <linux/string.h> was not indirectly inc=
luded.

Still the patch needs string.h include addition, otherwise you still ar=
e=20
able to come up with m68k config that doesn't build, do I understand it=
=20
correctly?

Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
