From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH v5 0/8] Input: elantech: add support for newer hardware
Date: Mon, 12 Sep 2011 10:44:20 +0200
Message-ID: <4E6DC664.7090909@tudelft.nl>
References: <1315189007-2179-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:42773 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab1ILIoV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Sep 2011 04:44:21 -0400
In-Reply-To: <1315189007-2179-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

Op 05-09-11 04:16, JJ Ding schreef:
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
> Please take a look at patch #8, which adds support for the latest tou=
chpads from ELAN.
> It is a true multi-touch capable touchpad that can track up to 5 fing=
ers.
> Support is implemented using MT-B protocol. I used synaptics and mult=
itouch X
> driver to test this driver, both worked fine.
>
Hello,
I've tested this series (plus the patch for debounce packet on v2) on m=
y=20
old v2 hardware, and it worked fine :-)

=C3=89ric

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
