From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH] Input: elantech - correct x, y value range for v2 hardware
Date: Tue, 16 Aug 2011 23:50:47 +0200
Message-ID: <4E4AE637.1090000@tudelft.nl>
References: <1313380295-26226-1-git-send-email-jj_ding@emc.com.tw> <87hb5hligi.fsf@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:41107 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145Ab1HPVuw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2011 17:50:52 -0400
In-Reply-To: <87hb5hligi.fsf@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>, Daniel Kurtz <djkurtz@chromium.org>

On 16-08-11 13:11, JJ Ding wrote:
> Hi Dmitry,
>
> What do you think about this patch?
> This is really a simple correction, I am wondering if it's OK to push
> this to 3.1?
Hi JJ Ding,
The merge window of 3.1 is already closed, so only patches which fix=20
bugs are accepted. Is there any hardware already available for which=20
this patch solves a bug? That would be a great incentive to push it :-)

=C9ric

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
