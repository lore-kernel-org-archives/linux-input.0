From: =?ISO-8859-15?Q?Richard_Sch=FCtz?= <r.schtz@t-online.de>
Subject: Re: [PATCH 1/2] Input: elantech - better support all those v2 variants
Date: Tue, 13 Sep 2011 12:24:50 +0200
Message-ID: <4E6F2F72.6080403@t-online.de>
References: <1315894549-24504-1-git-send-email-jj_ding@emc.com.tw> <1315894549-24504-2-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout03.t-online.de ([194.25.134.81]:49942 "EHLO
	mailout03.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab1IMKZK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Sep 2011 06:25:10 -0400
In-Reply-To: <1315894549-24504-2-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>, =?ISO-8859-15?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Am 13.09.2011 08:15, schrieb JJ Ding:
> V2 hardware has many variants. This patch adddresses two issues:
>
>   - some model also has debounce packets, but with a different signat=
ure
>     than v3. Now we just check debounce for all v2 hardware.
>
>   - due to different scanning methods the hardware uses, x and y rang=
es have
>     to be calculated differently. And for some specific versions, we =
can just
>     see them as custom-made, so set {x, y} the same values as Windows=
 driver
>     does.
>
> Signed-off-by: JJ Ding<jj_ding@emc.com.tw>

Tested-by: Richard Sch=FCtz <r.schtz@t-online.de>

Works like a charm now, thanks!

--=20
Regards,
Richard Sch=FCtz
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
