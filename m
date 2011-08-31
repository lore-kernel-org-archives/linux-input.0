From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH v4 0/8] Input: elantech: add support for newer hardware
Date: Wed, 31 Aug 2011 14:54:07 +0200
Message-ID: <4E5E2EEF.8050405@tudelft.nl>
References: <1314606539-24722-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:59480 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab1HaMyL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 31 Aug 2011 08:54:11 -0400
In-Reply-To: <1314606539-24722-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

Op 29-08-11 10:28, JJ Ding schreef:
> Hi Lists,
>
> This is a series of patches to add support for newer generations of E=
LAN
> touchpad.
>
> Patches #1~#6 are essentially fixes and cleanups that pave the way fo=
r
> patch #7 and patch #8, which really adds code for v3 and v4 hardware.
>
> Any comments, suggestoins are welcome.
>
Hello,
IMHO, this patch series is starting to look really good.

=46or patches 1-7 you have my:

Acked-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>

I've just some little comments on patch 8.

I'll try find the time to test on my laptop (with touchpad firmware=20
version 2) this weekend.

Cheers,
=C3=89ric
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
