From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 0/2] Better support old elantech v2 hardware
Date: Fri, 16 Sep 2011 16:21:10 +0200
Message-ID: <4E735B56.40400@tudelft.nl>
References: <1315894549-24504-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:33252 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab1IPOVO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Sep 2011 10:21:14 -0400
In-Reply-To: <1315894549-24504-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, =?UTF-8?B?UmljaGFyZCBTY2jDvHR6?= <r.schtz@t-online.de>, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>

Op 13-09-11 08:15, JJ Ding schreef:
> Hi everyone,
>
> Thanks to Richard Sch=C3=BCtz's bug report, I did some more research =
on elantech
> v2 hardware. I asked our Windows driver team and firmware team about =
the
> _ancient histroy_ of the dark old days ;-) These two patches are the =
results.
>
> Hopefully with these 2 we can support v2 hardware as good as Windows =
does.
>
> I can only get two old v2 (fw: 0x020800, 0x040201) to test. Those who=
 have a elantech v2
> hardware please do test, thank you very much.
Hello,
I've tested these patches on my hardware with version 0x020801.=20
Everything looks fine.


Reviewed-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>

Cheers,
=C3=89ric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
