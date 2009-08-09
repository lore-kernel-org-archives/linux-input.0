From: david@hardeman.nu
Subject: [patch 0/2] Winbond IR Driver - v2
Date: Sun, 09 Aug 2009 11:56:45 +0200
Message-ID: <20090809095645.198777507@hardeman.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:59825 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbZHIJ5q (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 9 Aug 2009 05:57:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org, jbarnes@virtuousgeek.org, akpm@linux-foundation.org, bjorn.helgaas@hp.com, randy.dunlap@oracle.com, david@hardeman.nu

Here's a new patch set which should replace all the patches currently i=
n the
-mm tree for the winbond cir driver. The new series incorporate feedbac=
k from
Bjorn Helgaas (convert the driver from ACPI to PNP) and Randy Dunlap (K=
config
fixes).

The IR decoding can still be improved but the driver works for in daily=
 use
decoding RC6 commands, so I believe it is ready to go upstream.

--=20
David H=C3=A4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
