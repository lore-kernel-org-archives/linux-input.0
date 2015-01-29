From: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Subject: input: elantech.c: adding comment lines for Fujitsu notebooks
Date: Thu, 29 Jan 2015 13:20:43 +0100
Message-ID: <54CA259B.8050602@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:9719 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbbA2MUq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 07:20:46 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, dmitry.torokhov@gmail.com, "ulrik.debie-os@e2big.org" <ulrik.debie-os@e2big.org>

Ulrik asked me to add some comment lines for the patch I submitted on J=
anuary 27.

Signed-off-by: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
---

diff -uNr old/drivers/input/mouse/elantech.c new/drivers/input/mouse/el=
antech.c
--- old/drivers/input/mouse/elantech.c	2015-01-29 13:10:04.628549594 +0=
100
+++ new/drivers/input/mouse/elantech.c	2015-01-29 13:12:38.574624972 +0=
100
@@ -1097,6 +1097,8 @@
  * Asus UX31               0x361f00        20, 15, 0e      clickpad
  * Asus UX32VD             0x361f02        00, 15, 0e      clickpad
  * Avatar AVIU-145A2       0x361f00        ?               clickpad
+ * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw button=
s
+ * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw button=
s
  * Fujitsu H730            0x570f00        c0, 14, 0c      3 hw button=
s (**)
  * Gigabyte U2442          0x450f01        58, 17, 0c      2 hw button=
s
  * Lenovo L430             0x350f02        b9, 15, 0c      2 hw button=
s (*)

--=20
Dipl.-Inf. (FH) Rainer Koenig
Project Manager Linux Clients
Dept. PDG WPS R&D SW OSE

=46ujitsu Technology Solutions
B=C3=BCrgermeister-Ullrich-Str. 100
86199 Augsburg
Germany

Telephone: +49-821-804-3321
Telefax:   +49-821-804-2131
Mail:      mailto:Rainer.Koenig@ts.fujitsu.com

Internet         ts.fujtsu.com
Company Details  ts.fujitsu.com/imprint.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
