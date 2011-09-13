From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH 1/2] Input: elantech - better support all those v2 variants
Date: Tue, 13 Sep 2011 19:28:06 +0800
Message-ID: <87ehzkel6h.fsf@emc.com.tw>
References: <1315894549-24504-1-git-send-email-jj_ding@emc.com.tw> <1315894549-24504-2-git-send-email-jj_ding@emc.com.tw> <4E6F2F72.6080403@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:53416 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431Ab1IMLZf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 07:25:35 -0400
In-Reply-To: <4E6F2F72.6080403@t-online.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard =?utf-8?Q?Sch=C3=BCtz?= <r.schtz@t-online.de>
Cc: linux-input@vger.kernel.org, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>, =?utf-8?Q?=C3=89ric?= Piel <E.A.B.Piel@tudelft.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Tue, 13 Sep 2011 12:24:50 +0200, Richard Sch=C3=BCtz <r.schtz@t-onli=
ne.de> wrote:
> Am 13.09.2011 08:15, schrieb JJ Ding:
> > V2 hardware has many variants. This patch adddresses two issues:
> >
> >   - some model also has debounce packets, but with a different sign=
ature
> >     than v3. Now we just check debounce for all v2 hardware.
> >
> >   - due to different scanning methods the hardware uses, x and y ra=
nges have
> >     to be calculated differently. And for some specific versions, w=
e can just
> >     see them as custom-made, so set {x, y} the same values as Windo=
ws driver
> >     does.
> >
> > Signed-off-by: JJ Ding<jj_ding@emc.com.tw>
>=20
> Tested-by: Richard Sch=C3=BCtz <r.schtz@t-online.de>
>=20
> Works like a charm now, thanks!

Good to hear it works for you. Thanks for testing.

jj

> --=20
> Regards,
> Richard Sch=C3=BCtz
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
