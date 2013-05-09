From: "Tibor Billes" <tbilles@gmx.com>
Subject: Possible regression 3.8.7 -> 3.9 with Dell touchpad
Date: Thu, 09 May 2013 22:59:58 +0200
Message-ID: <20130509205958.89890@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:51375 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752590Ab3EIVAB (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 9 May 2013 17:00:01 -0400
Received: from mailout-eu.gmx.com ([10.1.101.216]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0Ld2ys-1UAJwd3JMO-00iBvV for
 <linux-input@vger.kernel.org>; Thu, 09 May 2013 22:59:59 +0200
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

I found that after upgrading my kernel from 3.8.7 to 3.9 my touchpad on=
ly
works partly. By that I mean I can use the touchpad to move the cursor
around, but I cannot click with it by tapping. My machine is a Dell
Latitude E5530. Since it is 100% reproducible on my machine, I bisected=
 it,
and found this commit:

commit 1302bac33d9e88cd43e482191a806998f3ed43cc
Author: Kevin Cernekee <cernekee@gmail.com>
Date: =C2=A0 Wed Feb 13 22:27:08 2013 -0800

 =C2=A0 =C2=A0Input: ALPS - add support for "Rushmore" touchpads
 =C2=A0 =C2=A0
 =C2=A0 =C2=A0Rushmore touchpads are found on Dell E6230/E6430/E6530. =C2=
=A0They use the V3
 =C2=A0 =C2=A0protocol with slightly tweaked init sequences and report =
formats.
 =C2=A0 =C2=A0
 =C2=A0 =C2=A0The E7 report is 73 03 0a, and the EC report is 88 08 1d
 =C2=A0 =C2=A0
 =C2=A0 =C2=A0Credits: Emmanuel Thome reported the MT bitmap changes.
 =C2=A0 =C2=A0
 =C2=A0 =C2=A0Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
 =C2=A0 =C2=A0Tested-by: Dave Turvene <dturvene@dahetral.com>
 =C2=A0 =C2=A0Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com=
>

I did the bisection between 3.8.7 and 3.9, but also tried 3.9.1, it is =
bad
too. I also tried reverting that commit to make sure that it really is
what made my touchpad not working. The revert did fix my problem.

That's all I gathered so far, but I'd be happy to help further in any w=
ay
I can, just let me know.

Thanks,
Tibor
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
