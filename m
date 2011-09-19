From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH 0/2] Better support old elantech v2 hardware
Date: Mon, 19 Sep 2011 12:54:49 +0800
Message-ID: <87pqixku7a.fsf@emc.com.tw>
References: <1315894549-24504-1-git-send-email-jj_ding@emc.com.tw> <4E735B56.40400@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:50202 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab1ISEwL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Sep 2011 00:52:11 -0400
In-Reply-To: <4E735B56.40400@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?=C3=89ric?= Piel <E.A.B.Piel@tudelft.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Richard =?utf-8?Q?Sch=C3=BCtz?= <r.schtz@t-online.de>, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>

On Fri, 16 Sep 2011 16:21:10 +0200, =C3=89ric Piel <E.A.B.Piel@tudelft.=
nl> wrote:
> Op 13-09-11 08:15, JJ Ding schreef:
> > Hi everyone,
> >
> > Thanks to Richard Sch=C3=BCtz's bug report, I did some more researc=
h on elantech
> > v2 hardware. I asked our Windows driver team and firmware team abou=
t the
> > _ancient histroy_ of the dark old days ;-) These two patches are th=
e results.
> >
> > Hopefully with these 2 we can support v2 hardware as good as Window=
s does.
> >
> > I can only get two old v2 (fw: 0x020800, 0x040201) to test. Those w=
ho have a elantech v2
> > hardware please do test, thank you very much.
> Hello,
> I've tested these patches on my hardware with version 0x020801.=20
> Everything looks fine.
>=20
>=20
> Reviewed-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
>=20
> Cheers,
> =C3=89ric

Thank you, =C3=89ric, for testing and reviewing.

jj
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
