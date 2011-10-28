From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Add support for Macbook Pro 8 keyboards and sort
 entries.
Date: Fri, 28 Oct 2011 17:44:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1110281743510.3541@pobox.suse.cz>
References: <20111022120426.GA2281@polaris.bitmath.org> <1319312346-2676-1-git-send-email-gokcen@pardus.org.tr> <4EAA39FA.8040006@pardus.org.tr> <20111028130137.GA3487@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:47569 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755983Ab1J1Pon (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Oct 2011 11:44:43 -0400
In-Reply-To: <20111028130137.GA3487@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: =?ISO-8859-15?Q?G=F6k=E7en_Eraslan?= <gokcen@pardus.org.tr>, linux-input@vger.kernel.org

On Fri, 28 Oct 2011, Henrik Rydberg wrote:

> > > This patch adds keyboard support for Macbook Pro 8 models which h=
as
> > > WELLSPRING5A model name and 0x0252, 0x0253 and 0x0254 USB IDs. Tr=
ackpad
> > > support for those models are added to bcm5974 in
> > > c331eb580a0a7906c0cdb8dbae3cfe99e3c0e555.
> > >=20
> >=20
> > Any feedback on that?
>=20
> My bad, it seems you did addressed the problem, but the problem was
> not your patch to begin with. Looking good now, thank you.
>=20
>     Acked-by: Henrik Rydberg <rydberg@euromail.se>

Thanks, I have now applied the patch.

G=F6k=E7en, please don't forget to CC me on any patches against HID, it=
=20
increases my reaction latency.

Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
