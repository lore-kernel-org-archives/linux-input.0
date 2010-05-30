From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [NEEDS TEST][PATCH] elantech: discard the first 2 positions
 reports for some firmwares
Date: Sun, 30 May 2010 14:11:54 -0400
Message-ID: <1275243114.6666.50.camel@mini>
References: <4C02B18D.3050003@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:51871 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111Ab0E3SMB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 30 May 2010 14:12:01 -0400
In-Reply-To: <4C02B18D.3050003@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sun, 2010-05-30 at 20:42 +0200, =C3=89ric Piel wrote:
> According to the Dell/Ubuntu driver, what was previously observed as =
"jumpy cursor"
> corresponds to the hardware sending incorrect data for the first two =
reports of a=20
> one touch finger. So let's use the same workaround as in the other dr=
iver. Also,
> detect another firmware version with the same behaviour, as in the ot=
her driver.

I can't find this code in any of the Ubuntu released kernels. Where did
you find this patch?

Thanks,

-- Chase

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
