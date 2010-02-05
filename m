From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: schedule corgi_ssp and corgi_ts to be removed
Date: Fri, 5 Feb 2010 03:04:23 -0800
Message-ID: <f17812d71002050304u2c216455g4a5d4a908b2c9609@mail.gmail.com>
References: <f17812d71002041645n15e502a3sccc76fc3f2e75c76@mail.gmail.com>
	<4B6BF488.3070107@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:57276 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab0BELEo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Feb 2010 06:04:44 -0500
Received: by pzk27 with SMTP id 27so4011507pzk.33
        for <linux-input@vger.kernel.org>; Fri, 05 Feb 2010 03:04:43 -0800 (PST)
In-Reply-To: <4B6BF488.3070107@ru.mvista.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

>>
>
> =C2=A0Some grammar nitpicking...
>

Grrr.... anyone has a good recommendation of English training institute
for me? :-)

Patch updated as below:

=46rom 31cec413e534520111716802833675f53ac99b0b Mon Sep 17 00:00:00 200=
1
=46rom: Eric Miao <eric.y.miao@gmail.com>
Date: Thu, 4 Feb 2010 16:41:28 -0800
Subject: [PATCH 13/13] input: schedule corgi_ssp and corgi_ts to be rem=
oved

Cc: Richard Purdie <rpurdie@rpsys.net>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 Documentation/feature-removal-schedule.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt
b/Documentation/feature-removal-schedule.txt
index 5860583..e16529e 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -554,3 +554,15 @@ Why:	We now have a generic GPIO based matrix
keyboard driver that
 	and so are difficult to maintain.
 Who:	Eric Miao <eric.y.miao@gmail.com>

+----------------------------
+
+What:	corgi_ssp and corgi_ts driver
+When:	2.6.35
+Files:	arch/arm/mach-pxa/corgi_ssp.c, drivers/input/touchscreen/corgi_=
ts.c
+Why:	The corgi touchscreen is now deprecated in favour of the generic
+	ads7846.c driver. The noise reduction technique used in corgi_ts.c
+	that's to wait til vsync before ADC sampling is also integrated into
+	ads7846 driver now. Provided that the original driver is not generic
+	and difficult to maintain, it will be removed later.
+Who:	Eric Miao <eric.y.miao@gmail.com>
+
--=20
1.6.3.3
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
