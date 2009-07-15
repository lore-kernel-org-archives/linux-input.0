From: Subrata Modak <subrata@linux.vnet.ibm.com>
Subject: [PATCH 04/06] Fix compilation warning for drivers/input/touchscreen/htcpen.c
Date: Wed, 15 Jul 2009 07:50:08 +0530
Message-ID: <20090715022005.4244.67703.sendpatchset@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:42660 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbZGOCUV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2009 22:20:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pau Oliva Fora <pof@eslack.org>, linux-input@vger.kernel.org
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, David Howells <dhowells@redhat.com>, Subrata Modak <subrata@linux.vnet.ibm.com>, Balbir Singh <balbir@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>

gcc 4.4.1 generates the following build warning on i386:

CC drivers/input/touchscreen/htcpen.o
drivers/input/touchscreen/htcpen.c:50: warning: =E2=80=98pnp_ids=E2=80=99=
 defined but not used

=46ix this by removing the static keyword when you are actually
exporting that structure.

Signed-off-by: Subrata Modak<subrata@linux.vnet.ibm.com>,
---

--- a/drivers/input/touchscreen/htcpen.c	2009-05-20 10:40:54.000000000 =
+0530
+++ b/drivers/input/touchscreen/htcpen.c	2009-07-15 06:15:34.000000000 =
+0530
@@ -47,7 +47,7 @@ static int invert_y;
 module_param(invert_y, bool, 0644);
 MODULE_PARM_DESC(invert_y, "If set, Y axis is inverted");
=20
-static struct pnp_device_id pnp_ids[] =3D {
+struct pnp_device_id pnp_ids[] =3D {
 	{ .id =3D "PNP0cc0" },
 	{ .id =3D "" }
 };

---
Regards--
Subrata

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
