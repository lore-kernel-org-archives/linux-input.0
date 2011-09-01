From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH v4 0/8] Input: elantech: add support for newer hardware
Date: Thu, 01 Sep 2011 09:39:40 +0800
Message-ID: <87obz53usj.fsf@emc.com.tw>
References: <1314606539-24722-1-git-send-email-jj_ding@emc.com.tw> <4E5E2EEF.8050405@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:27020 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756900Ab1IABhb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Aug 2011 21:37:31 -0400
In-Reply-To: <4E5E2EEF.8050405@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?=C3=89ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

Hi =C3=89ric,

Thnaks for the reviewing and testing.

jj

On Wed, 31 Aug 2011 14:54:07 +0200, =C3=89ric Piel <E.A.B.Piel@tudelft.=
nl> wrote:
> Op 29-08-11 10:28, JJ Ding schreef:
> > Hi Lists,
> >
> > This is a series of patches to add support for newer generations of=
 ELAN
> > touchpad.
> >
> > Patches #1~#6 are essentially fixes and cleanups that pave the way =
for
> > patch #7 and patch #8, which really adds code for v3 and v4 hardwar=
e.
> >
> > Any comments, suggestoins are welcome.
> >
> Hello,
> IMHO, this patch series is starting to look really good.
>=20
> For patches 1-7 you have my:
>=20
> Acked-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
>=20
> I've just some little comments on patch 8.
>=20
> I'll try find the time to test on my laptop (with touchpad firmware=20
> version 2) this weekend.
>=20
> Cheers,
> =C3=89ric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
