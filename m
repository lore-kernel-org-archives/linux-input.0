From: "FIXED-TERM Rempel Oleksij (CM/ESO3)"
	<fixed-term.Oleksij.Rempel@de.bosch.com>
Subject: AW: [PATCH v3 0/4] zForce upstreaming
Date: Fri, 10 Jun 2016 07:43:43 +0000
Message-ID: <d0168a6a18874defb6dbb5e71c3baa77@FE-MBX1024.de.bosch.com>
References: <1462357481-16258-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:13207 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbcFJHnr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jun 2016 03:43:47 -0400
In-Reply-To: <1462357481-16258-1-git-send-email-dirk.behme@de.bosch.com>
Content-Language: de-DE
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Behme Dirk (CM/ESO2)" <Dirk.Behme@de.bosch.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>

ping

Mit freundlichen Gr=FC=DFen / Best regards

Oleksij Rempel
CM/ESO3 =20

Tel. +49(5121)49-0=20


-----Urspr=FCngliche Nachricht-----
Von: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.k=
ernel.org] Im Auftrag von Dirk Behme
Gesendet: Mittwoch, 4. Mai 2016 12:25
An: linux-input@vger.kernel.org; Dmitry Torokhov <dmitry.torokhov@gmail=
=2Ecom>; Henrik Rydberg <rydberg@bitmath.org>; Javier Martinez Canillas=
 <javier@osg.samsung.com>
Cc: Oleksij Rempel <linux@rempel-privat.de>
Betreff: [PATCH v3 0/4] zForce upstreaming

=46rom: Oleksij Rempel <linux@rempel-privat.de>

Changelog:
v2
 - rename scan-freq-idle and scan-freq-finger
   to scan-idle-hz and scan-active-hz.
 - rebase with already acked "Input: zforce_ts: Fix dual touch recognit=
ion"
   from previous patchset.

v3
 - rename touch-size-min to touch-size-min-mm
 - fix typo
 - replace "zforce_ts: Reject open if initialization not finished" patc=
h.
   Instead of reject open event, we will call zforce_start() from zforc=
e_boot().

Knut Wohlrab (2):
  Input: zforce_ts: Add device tree support for scanning frequency
  Input: zforce_ts: Add support for minimum touch size limit

Marcel Grosshans (1):
  Input: zforce_ts: Reinitialize touch controller when  BOOT_COMPLETE
    received

Oleksij Rempel (1):
  Input: zforce_ts: allow open even if initialisation is not completed

 .../bindings/input/touchscreen/zforce_ts.txt       |   6 +
 drivers/input/touchscreen/zforce_ts.c              | 174 +++++++++++++=
+++++---
 include/linux/platform_data/zforce_ts.h            |   3 +
 3 files changed, 157 insertions(+), 26 deletions(-)

--
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in the body of a message to majordomo@vger.kernel.org More majordomo in=
fo at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
