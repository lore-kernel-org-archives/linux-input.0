From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: [PATCH] Input: elantech - correct x, y value range for v2 hardware
Date: Wed, 17 Aug 2011 09:28:04 +0800
Message-ID: <87aab86d3v.fsf@emc.com.tw>
References: <1313380295-26226-1-git-send-email-jj_ding@emc.com.tw> <87hb5hligi.fsf@emc.com.tw> <4E4AE637.1090000@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:19919 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862Ab1HQBZx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2011 21:25:53 -0400
In-Reply-To: <4E4AE637.1090000@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?Q?=C3=89ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>, Daniel Kurtz <djkurtz@chromium.org>

Hi =C3=89ric,

Thanks for the reply.

On Tue, 16 Aug 2011 23:50:47 +0200, =C3=89ric Piel <E.A.B.Piel@tudelft.=
nl> wrote:
> On 16-08-11 13:11, JJ Ding wrote:
> > Hi Dmitry,
> >
> > What do you think about this patch?
> > This is really a simple correction, I am wondering if it's OK to pu=
sh
> > this to 3.1?
> Hi JJ Ding,
> The merge window of 3.1 is already closed, so only patches which fix=20
> bugs are accepted. Is there any hardware already available for which=20
> this patch solves a bug? That would be a great incentive to push it
> > :-)
As far as I know, this doesn't fix a bug. I just want to make sure the
driver and what the firmware sends are consistent.

Thank you for telling me this. I will try this again with newer hardwar=
e
support patches, aiming for 3.2 inclusion.

jj

> =C3=89ric
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
