From: =?utf-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>
Subject: [patch 0/2] Winbond IR Driver - v2
Date: Tue, 11 Aug 2009 18:26:14 +0200
Message-ID: <20090811162614.757030930@hardeman.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:56002 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbZHKQ2y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 11 Aug 2009 12:28:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: jbarnes@virtuousgeek.org, akpm@linux-foundation.org, bjorn.helgaas@hp.com, linux-input@vger.kernel.org

Here's a new patch set which should replace all the patches currently i=
n the
-mm tree for the winbond cir driver. The new series incorporate feedbac=
k from
Bjorn Helgaas (convert the driver from ACPI to PNP) and Randy Dunlap (K=
config
fixes).

This set fixes the comments Bjorn Helgaas had on the previous set (wron=
g Kconfig
depends).

The IR decoding can still be improved but the driver works for in daily=
 use
decoding RC6 commands, so I believe it is ready to go upstream.=20

--=20
David H=C3=A4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
