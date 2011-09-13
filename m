From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH 0/2] Better support old elantech v2 hardware
Date: Tue, 13 Sep 2011 19:32:15 +0800
Message-ID: <87bouoekzk.fsf@emc.com.tw>
References: <1315894549-24504-1-git-send-email-jj_ding@emc.com.tw> <4E6F3852.1030106@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:32382 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996Ab1IML3n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 07:29:43 -0400
In-Reply-To: <4E6F3852.1030106@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?=C3=89ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: linux-input@vger.kernel.org, Richard =?utf-8?Q?Sch=C3=BCtz?= <r.schtz@t-online.de>, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, 13 Sep 2011 13:02:42 +0200, =C3=89ric Piel <E.A.B.Piel@tudelft.=
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
> Thanks JJ Ding for the patches. They look good :-) I think my hardwar=
e=20

No problem ;-)

> is also 0x020800, but I'll test anyway and report back.
>=20
> Cheers,
> =C3=89ric

=C3=89ric, may I have your Reviewed-by after you test this?
Thank you very much.

jj
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
