From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH 0/2] Better support old elantech v2 hardware
Date: Fri, 16 Sep 2011 16:56:05 +0800
Message-ID: <87sjnw6f2y.fsf@emc.com.tw>
References: <1315894549-24504-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:56840 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754007Ab1IPIxb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 04:53:31 -0400
In-Reply-To: <1315894549-24504-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Richard =?utf-8?Q?Sch=C3=BCtz?= <r.schtz@t-online.de>, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>, =?utf-8?Q?=C3=89ric?= Piel <E.A.B.Piel@tudelft.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, 13 Sep 2011 14:15:47 +0800, JJ Ding <jj_ding@emc.com.tw> wrote:
> Hi everyone,
>=20
> Thanks to Richard Sch=C3=BCtz's bug report, I did some more research =
on elantech
> v2 hardware. I asked our Windows driver team and firmware team about =
the
> _ancient histroy_ of the dark old days ;-) These two patches are the =
results.
>=20
> Hopefully with these 2 we can support v2 hardware as good as Windows =
does.
>=20
> I can only get two old v2 (fw: 0x020800, 0x040201) to test. Those who=
 have a elantech v2
> hardware please do test, thank you very much.

I just found an old v2 with firmware version 0x140200 to test, and it
worked well.

Dmitry, do you have any comment on these two changes? Do these two
patches seem OK for your -next tree?

Thank you,
jj

> Note:
> These 2 patches are on top of my previous v5 series.
>=20
> JJ Ding (2):
>   Input: elantech - better support all those v2 variants
>   Input: elantech - remove module parameter force_elantech
>=20
>  drivers/input/mouse/elantech.c |   58 +++++++++++++++++++++++++++++-=
---------
>  drivers/input/mouse/elantech.h |    1 +
>  2 files changed, 44 insertions(+), 15 deletions(-)
>=20
> --=20
> 1.7.4.1
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
