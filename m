From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH] Input: elantech - correct x, y value range for v2 hardware
Date: Wed, 17 Aug 2011 11:53:55 +0200
Message-ID: <4E4B8FB3.9090100@tudelft.nl>
References: <1313380295-26226-1-git-send-email-jj_ding@emc.com.tw> <87hb5hligi.fsf@emc.com.tw> <4E4AE637.1090000@tudelft.nl> <87aab86d3v.fsf@emc.com.tw> <20110817064336.GA29361@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:35506 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab1HQJx7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Aug 2011 05:53:59 -0400
In-Reply-To: <20110817064336.GA29361@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: JJ Ding <jj_ding@emc.com.tw>, linux-input@vger.kernel.org, Tom Lin <tom_lin@emc.com.tw>, Aaron Huang <aaron_huang@emc.com.tw>, Daniel Kurtz <djkurtz@chromium.org>

Op 17-08-11 08:43, Dmitry Torokhov schreef:
> Hi JJ,
>
>> As far as I know, this doesn't fix a bug. I just want to make sure t=
he
>> driver and what the firmware sends are consistent.
>
> As =C9ric mentioned, simply extending range to 12 bits is dangerous
> because we might cause overflows. Blindly increasing ETP_YMAX_V2 is n=
ot
> a good idea either as userspace would expect much larger device and
> reports would only cover fraction of its surface. We need to separate
> ETP_YMAX_V2 as absolute maximum from reported coordinates range, like=
 it
> is done in synaptics driver.
Hi Dmitry,
Concerning this point, I was wondering if it'd be ok to only send=20
negative values? Such as min/max are between -768 and 0. So that, if th=
e=20
hardware actually has a bigger resolution, it can go down to -4095=20
without any overflow? It sounds the simplest way to report the=20
coordinate for a device which has an opposite axis. Or is it safer to=20
stay in the positive numbers, with min/max between 3328 and 4095, and i=
n=20
case of bigger resolution the values go down to 0?

Cheers,
=C9ric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
